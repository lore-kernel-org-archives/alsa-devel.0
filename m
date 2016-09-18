From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v4 05/12] ALSA: line6: Add
	LINE6_CAP_IN_NEEDS_OUT, a void playback stream during capture
Date: Sun, 18 Sep 2016 20:59:25 +0200
Message-ID: <1474225172-32081-6-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474225172-32081-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 43CCE2614A0
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 21:00:50 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id b184so11711143wma.3
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 12:00:50 -0700 (PDT)
In-Reply-To: <1474225172-32081-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

E.g. POD X3 seems to require playback data to be sent to it to generate
capture data. Otherwise the device stalls and doesn't send any more capture
data until it's reset.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/capture.c  |  5 +++++
 sound/usb/line6/driver.h   |  4 +++-
 sound/usb/line6/pcm.c      | 31 ++++++++++++++++++++++++-------
 sound/usb/line6/pcm.h      |  4 +++-
 sound/usb/line6/toneport.c |  4 ++--
 5 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 7959aaa..bf159c4 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -232,6 +232,8 @@ static int snd_line6_capture_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
+	line6_pcm_acquire(line6pcm, LINE6_STREAM_CAPTURE_HELPER, false);
+
 	runtime->hw = line6pcm->properties->capture_hw;
 	return 0;
 }
@@ -239,6 +241,9 @@ static int snd_line6_capture_open(struct snd_pcm_substream *substream)
 /* close capture callback */
 static int snd_line6_capture_close(struct snd_pcm_substream *substream)
 {
+	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
+
+	line6_pcm_release(line6pcm, LINE6_STREAM_CAPTURE_HELPER);
 	return 0;
 }
 
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 2d32139..0bcab38 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -100,8 +100,10 @@ enum {
 	LINE6_CAP_CONTROL =	1 << 0,
 	/* device supports PCM input/output via USB */
 	LINE6_CAP_PCM =		1 << 1,
-	/* device support hardware monitoring */
+	/* device supports hardware monitoring */
 	LINE6_CAP_HWMON =	1 << 2,
+	/* device requires output data when input is read */
+	LINE6_CAP_IN_NEEDS_OUT = 1 << 3,
 };
 
 /*
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 31b68fa..f0f3ff5 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -52,7 +52,7 @@ static int snd_line6_impulse_volume_put(struct snd_kcontrol *kcontrol,
 
 	line6pcm->impulse_volume = value;
 	if (value > 0) {
-		err = line6_pcm_acquire(line6pcm, LINE6_STREAM_IMPULSE);
+		err = line6_pcm_acquire(line6pcm, LINE6_STREAM_IMPULSE, true);
 		if (err < 0) {
 			line6pcm->impulse_volume = 0;
 			return err;
@@ -242,6 +242,14 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
 		case SNDRV_PCM_TRIGGER_RESUME:
+			if (s->stream == SNDRV_PCM_STREAM_CAPTURE &&
+				(line6pcm->line6->properties->capabilities &
+					LINE6_CAP_IN_NEEDS_OUT)) {
+				err = line6_stream_start(line6pcm, SNDRV_PCM_STREAM_PLAYBACK,
+						 LINE6_STREAM_CAPTURE_HELPER);
+				if (err < 0)
+					return err;
+			}
 			err = line6_stream_start(line6pcm, s->stream,
 						 LINE6_STREAM_PCM);
 			if (err < 0)
@@ -250,6 +258,12 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 
 		case SNDRV_PCM_TRIGGER_STOP:
 		case SNDRV_PCM_TRIGGER_SUSPEND:
+			if (s->stream == SNDRV_PCM_STREAM_CAPTURE &&
+				(line6pcm->line6->properties->capabilities &
+					LINE6_CAP_IN_NEEDS_OUT)) {
+				line6_stream_stop(line6pcm, SNDRV_PCM_STREAM_PLAYBACK,
+					  LINE6_STREAM_CAPTURE_HELPER);
+			}
 			line6_stream_stop(line6pcm, s->stream,
 					  LINE6_STREAM_PCM);
 			break;
@@ -283,14 +297,15 @@ snd_pcm_uframes_t snd_line6_pointer(struct snd_pcm_substream *substream)
 	return pstr->pos_done;
 }
 
-/* Acquire and start duplex streams:
+/* Acquire and optionally start duplex streams:
  * type is either LINE6_STREAM_IMPULSE or LINE6_STREAM_MONITOR
  */
-int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type)
+int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type, bool start)
 {
 	struct line6_pcm_stream *pstr;
 	int ret = 0, dir;
 
+	/* TODO: We should assert SNDRV_PCM_STREAM_PLAYBACK/CAPTURE == 0/1 */
 	mutex_lock(&line6pcm->state_mutex);
 	for (dir = 0; dir < 2; dir++) {
 		pstr = get_stream(line6pcm, dir);
@@ -300,10 +315,12 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type)
 		if (!pstr->running)
 			line6_wait_clear_audio_urbs(line6pcm, pstr);
 	}
-	for (dir = 0; dir < 2; dir++) {
-		ret = line6_stream_start(line6pcm, dir, type);
-		if (ret < 0)
-			goto error;
+	if (start) {
+		for (dir = 0; dir < 2; dir++) {
+			ret = line6_stream_start(line6pcm, dir, type);
+			if (ret < 0)
+				goto error;
+		}
 	}
  error:
 	mutex_unlock(&line6pcm->state_mutex);
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 58d36f9..5f796ef8 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -72,6 +72,7 @@ enum {
 	LINE6_STREAM_PCM,
 	LINE6_STREAM_MONITOR,
 	LINE6_STREAM_IMPULSE,
+	LINE6_STREAM_CAPTURE_HELPER,
 };
 
 /* misc bit flags for PCM operation */
@@ -190,7 +191,8 @@ extern int snd_line6_hw_params(struct snd_pcm_substream *substream,
 extern int snd_line6_hw_free(struct snd_pcm_substream *substream);
 extern snd_pcm_uframes_t snd_line6_pointer(struct snd_pcm_substream *substream);
 extern void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm);
-extern int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type);
+extern int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type,
+			       bool start);
 extern void line6_pcm_release(struct snd_line6_pcm *line6pcm, int type);
 
 #endif
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index da76e03..8e22f43 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -177,7 +177,7 @@ static int snd_toneport_monitor_put(struct snd_kcontrol *kcontrol,
 	line6pcm->volume_monitor = ucontrol->value.integer.value[0];
 
 	if (line6pcm->volume_monitor > 0) {
-		err = line6_pcm_acquire(line6pcm, LINE6_STREAM_MONITOR);
+		err = line6_pcm_acquire(line6pcm, LINE6_STREAM_MONITOR, true);
 		if (err < 0) {
 			line6pcm->volume_monitor = 0;
 			line6_pcm_release(line6pcm, LINE6_STREAM_MONITOR);
@@ -246,7 +246,7 @@ static void toneport_start_pcm(unsigned long arg)
 	struct usb_line6_toneport *toneport = (struct usb_line6_toneport *)arg;
 	struct usb_line6 *line6 = &toneport->line6;
 
-	line6_pcm_acquire(line6->line6pcm, LINE6_STREAM_MONITOR);
+	line6_pcm_acquire(line6->line6pcm, LINE6_STREAM_MONITOR, true);
 }
 
 /* control definition */
-- 
1.9.1
