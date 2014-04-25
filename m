From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/49] firewire-lib/dice/speakers: Add common PCM constraints
	for AMDTP streams
Date: Fri, 25 Apr 2014 22:44:52 +0900
Message-ID: <1398433530-13136-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds common PCM constraints according to current firewire-lib
implementation.

1.Maximum width for each sample is limited by 24.
AM824 in IEC 61883-6 can deliver 24bit data.

2. Minimum time for period is 5msec.
Apply the old value. For shorter latency, further works are needed.

3. In blocking mode, frames per period/buffer is aligned to 32.
Each packet can include some frames depending on its sampling rate. In
blocking mode, the number equals to SYT_INTERVAL. Currently firewire-lib
can schedule snd_pcm_period_elapsed() for each packet. So, for accurate
PCM interrupt, the number of frames per period/buffer should be aligned
to SYT_INTERVAL.
Currently firewire-lib is lack of better rules to achieve this. So LCM of
each value of SYT_INTERVALs (=32) is applied. This can be improved for
further work.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/amdtp.h    |  3 +++
 sound/firewire/dice.c     | 17 +-------------
 sound/firewire/speakers.c |  8 +------
 4 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 3475b76..ac8c358 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
 #include "amdtp.h"
 
@@ -105,6 +106,61 @@ const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT] = {
 EXPORT_SYMBOL(amdtp_syt_intervals);
 
 /**
+ * amdtp_stream_add_pcm_hw_constraints - add hw constraints for PCM substream
+ * @s:		the AMDTP stream, which must be initialized.
+ * @runtime:	the PCM substream runtime
+ */
+int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
+					struct snd_pcm_runtime *runtime)
+{
+	int err;
+
+	/* AM824 in IEC 61883-6 can deliver 24bit data */
+	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * Currently firewire-lib processes 16 packets in one software
+	 * interrupt callback. This equals to 2msec but actually the
+	 * interval of the interrupts has a jitter.
+	 * Additionally, even if adding a constraint to fit period size to
+	 * 2msec, actual calculated frames per period doesn't equal to 2msec,
+	 * depending on sampling rate.
+	 * Anyway, the interval to call snd_pcm_period_elapsed() cannot 2msec.
+	 * Here let us use 5msec for safe period interrupt.
+	 */
+	err = snd_pcm_hw_constraint_minmax(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+					   5000, UINT_MAX);
+	if (err < 0)
+		goto end;
+
+	/* Non-Blocking stream has no more constraints */
+	if (!(s->flags & CIP_BLOCKING))
+		goto end;
+
+	/*
+	 * One AMDTP packet can include some frames. In blocking mode, the
+	 * number equals to SYT_INTERVAL. So the number is 8, 16 or 32,
+	 * depending on its sampling rate. For accurate period interrupt, it's
+	 * preferrable to aligh period/buffer sizes to current SYT_INTERVAL.
+	 *
+	 * TODO: These constraints can be improved with propper rules.
+	 * Currently apply LCM of SYT_INTEVALs.
+	 */
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 32);
+	if (err < 0)
+		goto end;
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 32);
+end:
+	return err;
+}
+EXPORT_SYMBOL(amdtp_stream_add_pcm_hw_constraints);
+
+/**
  * amdtp_stream_set_parameters - set stream parameters
  * @s: the AMDTP stream to configure
  * @rate: the sample rate
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index db60425..d6bb7eb 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -64,6 +64,7 @@ enum cip_sfc {
 struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
+struct snd_pcm_runtime;
 struct snd_rawmidi_substream;
 
 enum amdtp_stream_direction {
@@ -130,6 +131,8 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed);
 void amdtp_stream_update(struct amdtp_stream *s);
 void amdtp_stream_stop(struct amdtp_stream *s);
 
+int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
+					struct snd_pcm_runtime *runtime);
 void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 				 snd_pcm_format_t format);
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index cd4c6b6..a9a30c0 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -420,22 +420,7 @@ static int dice_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto err_lock;
 
-	err = snd_pcm_hw_constraint_step(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 32);
-	if (err < 0)
-		goto err_lock;
-	err = snd_pcm_hw_constraint_step(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 32);
-	if (err < 0)
-		goto err_lock;
-
-	err = snd_pcm_hw_constraint_minmax(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-					   5000, UINT_MAX);
-	if (err < 0)
-		goto err_lock;
-
-	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	err = amdtp_stream_add_pcm_hw_constraints(&dice->stream, runtime);
 	if (err < 0)
 		goto err_lock;
 
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index c07e7cd..3427527 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -167,13 +167,7 @@ static int fwspk_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	err = snd_pcm_hw_constraint_minmax(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-					   5000, UINT_MAX);
-	if (err < 0)
-		return err;
-
-	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	err = amdtp_stream_add_pcm_hw_constraints(fwspk->stream, runtime);
 	if (err < 0)
 		return err;
 
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
