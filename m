From: o-takashi@sakamocchi.jp
Subject: [PATCH 1/2] Add amdtp_stream_running() and amdtp_stream_pcm_running()
Date: Sun,  2 Jun 2013 00:25:36 +0900
Message-ID: <1370100337-22463-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1370100337-22463-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370100337-22463-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: perex@perex.cz, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

According to MMA/AMEI RP-027, PCM and MIDI streams are multiplexed in the same
AMDTP stream. To support this, modules need to distinguish whether they are
running or not in the same AMDTP stream.

This patch add helper function to do it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c |   14 ++++++++------
 sound/firewire/amdtp.h |   22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 136087b..a042fe1 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -63,6 +63,8 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	tasklet_init(&s->period_tasklet, pcm_period_tasklet, (unsigned long)s);
 	s->packet_index = 0;
 
+	s->pcm = NULL;
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -73,7 +75,7 @@ EXPORT_SYMBOL(amdtp_stream_init);
  */
 void amdtp_stream_destroy(struct amdtp_stream *s)
 {
-	WARN_ON(!IS_ERR(s->context));
+	WARN_ON(amdtp_stream_running(s));
 	mutex_destroy(&s->mutex);
 	fw_unit_put(s->unit);
 }
@@ -103,7 +105,7 @@ void amdtp_stream_set_rate(struct amdtp_stream *s, unsigned int rate)
 	};
 	unsigned int sfc;
 
-	if (WARN_ON(!IS_ERR(s->context)))
+	if (WARN_ON(amdtp_stream_running(s)))
 		return;
 
 	for (sfc = 0; sfc < ARRAY_SIZE(rate_info); ++sfc)
@@ -170,7 +172,7 @@ static void amdtp_read_s32(struct amdtp_stream *s,
 void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 				 snd_pcm_format_t format)
 {
-	if (WARN_ON(!IS_ERR(s->context)))
+	if (WARN_ON(amdtp_stream_running(s)))
 		return;
 
 	switch (format) {
@@ -717,7 +719,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	mutex_lock(&s->mutex);
 
-	if (WARN_ON(!IS_ERR(s->context) ||
+	if (WARN_ON(amdtp_stream_running(s) ||
 		    (!s->pcm_channels && !s->midi_ports))) {
 		err = -EBADFD;
 		goto err_unlock;
@@ -752,7 +754,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 					FW_ISO_CONTEXT_TRANSMIT,
 					channel, speed, 4,
 					out_packet_callback, s);
-	if (IS_ERR(s->context)) {
+	if (!amdtp_stream_running(s)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
 			dev_err(&s->unit->device,
@@ -834,7 +836,7 @@ void amdtp_stream_stop(struct amdtp_stream *s)
 {
 	mutex_lock(&s->mutex);
 
-	if (IS_ERR(s->context)) {
+	if (!amdtp_stream_running(s)) {
 		mutex_unlock(&s->mutex);
 		return;
 	}
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index f3b9403..056f84a 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -122,6 +122,17 @@ static inline void amdtp_stream_set_midi(struct amdtp_stream *s,
 }
 
 /**
+ * amdtp_stream_running - check stream is running or not
+ * @s: the AMDTP stream
+ *
+ * If this function returns true, the stream is running.
+ */
+static inline bool amdtp_stream_running(struct amdtp_stream *s)
+{
+	return !IS_ERR(s->context);
+}
+
+/**
  * amdtp_streaming_error - check for streaming error
  * @s: the AMDTP stream
  *
@@ -134,6 +145,17 @@ static inline bool amdtp_streaming_error(struct amdtp_stream *s)
 }
 
 /**
+ * amdtp_stream_pcm_running - check PCM stream is running or not
+ * @s: the AMDTP stream
+ *
+ * If this function returns true, PCM stream in the stream is running.
+ */
+static inline bool amdtp_stream_pcm_running(struct amdtp_stream *s)
+{
+	return !IS_ERR_OR_NULL(s->pcm);
+}
+
+/**
  * amdtp_stream_pcm_trigger - start/stop playback from a PCM device
  * @s: the AMDTP stream
  * @pcm: the PCM device to be started, or %NULL to stop the current device
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
