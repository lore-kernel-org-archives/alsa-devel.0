From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v4 04/12] ALSA: line6: Allow different channel
	numbers for in/out
Date: Sun, 18 Sep 2016 20:59:24 +0200
Message-ID: <1474225172-32081-5-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474225172-32081-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BDA2D26155B
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 21:00:48 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id w84so4549266wmg.0
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 12:00:48 -0700 (PDT)
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

Changes bytes_per_frame to bytes_per_channel.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/capture.c  |  8 ++++++--
 sound/usb/line6/driver.h   |  2 +-
 sound/usb/line6/pcm.h      |  2 +-
 sound/usb/line6/playback.c | 14 +++++++++++---
 sound/usb/line6/pod.c      |  3 +--
 sound/usb/line6/podhd.c    |  4 +---
 sound/usb/line6/toneport.c |  2 +-
 7 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 73cea26..7959aaa 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -90,7 +90,9 @@ void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf, int fsize)
 	struct snd_pcm_substream *substream =
 	    get_substream(line6pcm, SNDRV_PCM_STREAM_CAPTURE);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	const int bytes_per_frame = line6pcm->properties->bytes_per_frame;
+	const int bytes_per_frame =
+		line6pcm->properties->bytes_per_channel *
+		line6pcm->properties->capture_hw.channels_max;
 	int frames = fsize / bytes_per_frame;
 
 	if (runtime == NULL)
@@ -191,7 +193,9 @@ static void audio_in_callback(struct urb *urb)
 		 */
 
 		line6pcm->prev_fbuf = fbuf;
-		line6pcm->prev_fsize = fsize;
+		line6pcm->prev_fsize = fsize /
+			(line6pcm->properties->bytes_per_channel *
+			line6pcm->properties->capture_hw.channels_max);
 
 		if (!test_bit(LINE6_STREAM_IMPULSE, &line6pcm->in.running) &&
 		    test_bit(LINE6_STREAM_PCM, &line6pcm->in.running) &&
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index a55eb88..2d32139 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -31,7 +31,7 @@
 #define LINE6_FALLBACK_MAXPACKETSIZE 16
 
 #define LINE6_TIMEOUT 1
-#define LINE6_BUFSIZE_LISTEN 32
+#define LINE6_BUFSIZE_LISTEN 64
 #define LINE6_MESSAGE_MAXLEN 256
 
 /*
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index f408d15..58d36f9 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -83,7 +83,7 @@ enum {
 struct line6_pcm_properties {
 	struct snd_pcm_hardware playback_hw, capture_hw;
 	struct snd_pcm_hw_constraint_ratdens rates;
-	int bytes_per_frame;
+	int bytes_per_channel;
 };
 
 struct line6_pcm_stream {
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 7b2644f..bc5799c 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -146,7 +146,9 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	int index;
 	int i, urb_size, urb_frames;
 	int ret;
-	const int bytes_per_frame = line6pcm->properties->bytes_per_frame;
+	const int bytes_per_frame =
+		line6pcm->properties->bytes_per_channel *
+		line6pcm->properties->playback_hw.channels_max;
 	const int frame_increment =
 		line6pcm->properties->rates.rats[0].num_min;
 	const int frame_factor =
@@ -165,6 +167,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	urb_out = line6pcm->out.urbs[index];
 	urb_size = 0;
 
+	/* TODO: this may not work for LINE6_ISO_PACKETS != 1 */
 	for (i = 0; i < LINE6_ISO_PACKETS; ++i) {
 		/* compute frame size for given sampling rate */
 		int fsize = 0;
@@ -178,9 +181,11 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 			line6pcm->out.count += frame_increment;
 			n = line6pcm->out.count / frame_factor;
 			line6pcm->out.count -= n * frame_factor;
-			fsize = n * bytes_per_frame;
+			fsize = n;
 		}
 
+		fsize *= bytes_per_frame;
+
 		fout->offset = urb_size;
 		fout->length = fsize;
 		urb_size += fsize;
@@ -305,6 +310,9 @@ static void audio_out_callback(struct urb *urb)
 	struct snd_line6_pcm *line6pcm = (struct snd_line6_pcm *)urb->context;
 	struct snd_pcm_substream *substream =
 	    get_substream(line6pcm, SNDRV_PCM_STREAM_PLAYBACK);
+	const int bytes_per_frame =
+		line6pcm->properties->bytes_per_channel *
+		line6pcm->properties->playback_hw.channels_max;
 
 #if USE_CLEAR_BUFFER_WORKAROUND
 	memset(urb->transfer_buffer, 0, urb->transfer_buffer_length);
@@ -329,7 +337,7 @@ static void audio_out_callback(struct urb *urb)
 		struct snd_pcm_runtime *runtime = substream->runtime;
 
 		line6pcm->out.pos_done +=
-		    length / line6pcm->properties->bytes_per_frame;
+		    length / bytes_per_frame;
 
 		if (line6pcm->out.pos_done >= runtime->buffer_size)
 			line6pcm->out.pos_done -= runtime->buffer_size;
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 45dd348..36e7274 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -83,7 +83,6 @@ struct usb_line6_pod {
 };
 
 #define POD_SYSEX_CODE 3
-#define POD_BYTES_PER_FRAME 6	/* 24bit audio (stereo) */
 
 /* *INDENT-OFF* */
 
@@ -167,7 +166,7 @@ static struct line6_pcm_properties pod_pcm_properties = {
 	.rates = {
 			    .nrats = 1,
 			    .rats = &pod_ratden},
-	.bytes_per_frame = POD_BYTES_PER_FRAME
+	.bytes_per_channel = 3 /* SNDRV_PCM_FMTBIT_S24_3LE */
 };
 
 static const char pod_version_header[] = {
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 63dcaef..4fc4789 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -25,8 +25,6 @@ enum {
 	LINE6_PODHD500_1,
 };
 
-#define PODHD_BYTES_PER_FRAME 6	/* 24bit audio (stereo) */
-
 static struct snd_ratden podhd_ratden = {
 	.num_min = 48000,
 	.num_max = 48000,
@@ -73,7 +71,7 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 	.rates = {
 			    .nrats = 1,
 			    .rats = &podhd_ratden},
-	.bytes_per_frame = PODHD_BYTES_PER_FRAME
+	.bytes_per_channel = 3 /* 24bit audio (stereo) */
 };
 
 /*
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 6d4c50c..da76e03 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -114,7 +114,7 @@ static struct line6_pcm_properties toneport_pcm_properties = {
 	.rates = {
 			    .nrats = 1,
 			    .rats = &toneport_ratden},
-	.bytes_per_frame = 4
+	.bytes_per_channel = 2
 };
 
 static const struct {
-- 
1.9.1
