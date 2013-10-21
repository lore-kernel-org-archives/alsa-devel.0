From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [09/29] ALSA: firewire: introduce amdtp_out_stream_running()
Date: Mon, 21 Oct 2013 21:25:50 +0200
Message-ID: <52657FBE.7090906@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Introduce the helper function amdtp_out_stream_running().  This makes
many checks in amdtp.c clearer and frees the device drivers from having
to track this with a separate variable.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/amdtp.c    |   10 +++++-----
 sound/firewire/amdtp.h    |    6 ++++++
 sound/firewire/dice.c     |   17 +++++------------
 sound/firewire/speakers.c |    8 ++------
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index efb2e29..d56b8e7 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL(amdtp_out_stream_init);
  */
 void amdtp_out_stream_destroy(struct amdtp_out_stream *s)
 {
-	WARN_ON(!IS_ERR(s->context));
+	WARN_ON(amdtp_out_stream_running(s));
 	mutex_destroy(&s->mutex);
 	fw_unit_put(s->unit);
 }
@@ -89,7 +89,7 @@ void amdtp_out_stream_set_rate(struct amdtp_out_stream *s, unsigned int rate)
 	};
 	unsigned int sfc;

-	if (WARN_ON(!IS_ERR(s->context)))
+	if (WARN_ON(amdtp_out_stream_running(s)))
 		return;

 	for (sfc = 0; sfc < ARRAY_SIZE(rate_info); ++sfc)
@@ -145,7 +145,7 @@ static void amdtp_write_s32(struct amdtp_out_stream *s,
 void amdtp_out_stream_set_pcm_format(struct amdtp_out_stream *s,
 				     snd_pcm_format_t format)
 {
-	if (WARN_ON(!IS_ERR(s->context)))
+	if (WARN_ON(amdtp_out_stream_running(s)))
 		return;

 	switch (format) {
@@ -481,7 +481,7 @@ int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)

 	mutex_lock(&s->mutex);

-	if (WARN_ON(!IS_ERR(s->context) ||
+	if (WARN_ON(amdtp_out_stream_running(s) ||
 		    (!s->pcm_channels && !s->midi_ports))) {
 		err = -EBADFD;
 		goto err_unlock;
@@ -577,7 +577,7 @@ void amdtp_out_stream_stop(struct amdtp_out_stream *s)
 {
 	mutex_lock(&s->mutex);

-	if (IS_ERR(s->context)) {
+	if (!amdtp_out_stream_running(s)) {
 		mutex_unlock(&s->mutex);
 		return;
 	}
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index fd4ce30..28b1bf5 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -1,6 +1,7 @@
 #ifndef SOUND_FIREWIRE_AMDTP_H_INCLUDED
 #define SOUND_FIREWIRE_AMDTP_H_INCLUDED

+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include "packets-buffer.h"
@@ -92,6 +93,11 @@ void amdtp_out_stream_pcm_prepare(struct amdtp_out_stream *s);
 unsigned long amdtp_out_stream_pcm_pointer(struct amdtp_out_stream *s);
 void amdtp_out_stream_pcm_abort(struct amdtp_out_stream *s);

+static inline bool amdtp_out_stream_running(struct amdtp_out_stream *s)
+{
+	return !IS_ERR(s->context);
+}
+
 /**
  * amdtp_out_stream_set_pcm - configure format of PCM samples
  * @s: the AMDTP output stream to be configured
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index ef04089..3591aeb 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -246,7 +246,6 @@ struct dice {
 	int dev_lock_count; /* > 0 driver, < 0 userspace */
 	bool dev_lock_changed;
 	bool global_enabled;
-	bool stream_running;
 	wait_queue_head_t hwdep_wait;
 	u32 notification_bits;
 	struct snd_pcm_substream *pcm;
@@ -654,7 +653,7 @@ static int dice_stream_start_packets(struct dice *dice)
 {
 	int err;

-	if (dice->stream_running)
+	if (amdtp_out_stream_running(&dice->stream))
 		return 0;

 	err = amdtp_out_stream_start(&dice->stream, dice->resources.channel,
@@ -668,8 +667,6 @@ static int dice_stream_start_packets(struct dice *dice)
 		return err;
 	}

-	dice->stream_running = true;
-
 	return 0;
 }

@@ -712,14 +709,10 @@ error:

 static void dice_stream_stop_packets(struct dice *dice)
 {
-	if (!dice->stream_running)
-		return;
-
-	dice_enable_clear(dice);
-
-	amdtp_out_stream_stop(&dice->stream);
-
-	dice->stream_running = false;
+	if (amdtp_out_stream_running(&dice->stream)) {
+		dice_enable_clear(dice);
+		amdtp_out_stream_stop(&dice->stream);
+	}
 }

 static void dice_stream_stop(struct dice *dice)
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 2c63865..0ac5630 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -53,7 +53,6 @@ struct fwspk {
 	struct mutex mutex;
 	struct cmp_connection connection;
 	struct amdtp_out_stream stream;
-	bool stream_running;
 	bool mute;
 	s16 volume[6];
 	s16 volume_min;
@@ -189,10 +188,9 @@ static int fwspk_close(struct snd_pcm_substream *substream)

 static void fwspk_stop_stream(struct fwspk *fwspk)
 {
-	if (fwspk->stream_running) {
+	if (amdtp_out_stream_running(&fwspk->stream)) {
 		amdtp_out_stream_stop(&fwspk->stream);
 		cmp_connection_break(&fwspk->connection);
-		fwspk->stream_running = false;
 	}
 }

@@ -286,7 +284,7 @@ static int fwspk_prepare(struct snd_pcm_substream *substream)
 	if (amdtp_out_streaming_error(&fwspk->stream))
 		fwspk_stop_stream(fwspk);

-	if (!fwspk->stream_running) {
+	if (!amdtp_out_stream_running(&fwspk->stream)) {
 		err = cmp_connection_establish(&fwspk->connection,
 			amdtp_out_stream_get_max_payload(&fwspk->stream));
 		if (err < 0)
@@ -297,8 +295,6 @@ static int fwspk_prepare(struct snd_pcm_substream *substream)
 					fwspk->connection.speed);
 		if (err < 0)
 			goto err_connection;
-
-		fwspk->stream_running = true;
 	}

 	mutex_unlock(&fwspk->mutex);

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
