From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/7] ALSA: line6: Remove snd_line6_ prefix of
	pcm property fields
Date: Wed, 28 Jan 2015 17:41:29 +0100
Message-ID: <1422463289-19135-8-git-send-email-tiwai@suse.de>
References: <1422463289-19135-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 45254264FEB
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:41:37 +0100 (CET)
In-Reply-To: <1422463289-19135-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

It's just superfluous and doesn't give any better readability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  |  5 ++---
 sound/usb/line6/pcm.h      |  4 ++--
 sound/usb/line6/playback.c | 11 +++++------
 sound/usb/line6/pod.c      |  6 +++---
 sound/usb/line6/podhd.c    |  6 +++---
 sound/usb/line6/toneport.c |  6 +++---
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 4183c5f5edc2..f518fbbe88de 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -216,12 +216,11 @@ static int snd_line6_capture_open(struct snd_pcm_substream *substream)
 
 	err = snd_pcm_hw_constraint_ratdens(runtime, 0,
 					    SNDRV_PCM_HW_PARAM_RATE,
-					    (&line6pcm->
-					     properties->snd_line6_rates));
+					    &line6pcm->properties->rates);
 	if (err < 0)
 		return err;
 
-	runtime->hw = line6pcm->properties->snd_line6_capture_hw;
+	runtime->hw = line6pcm->properties->capture_hw;
 	return 0;
 }
 
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 3a3cfba40ec7..508410adbd51 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -83,8 +83,8 @@ enum {
 };
 
 struct line6_pcm_properties {
-	struct snd_pcm_hardware snd_line6_playback_hw, snd_line6_capture_hw;
-	struct snd_pcm_hw_constraint_ratdens snd_line6_rates;
+	struct snd_pcm_hardware playback_hw, capture_hw;
+	struct snd_pcm_hw_constraint_ratdens rates;
 	int bytes_per_frame;
 };
 
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 5858f5f18e11..de3024ab4d32 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -148,10 +148,10 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	int ret;
 	const int bytes_per_frame = line6pcm->properties->bytes_per_frame;
 	const int frame_increment =
-	    line6pcm->properties->snd_line6_rates.rats[0].num_min;
+		line6pcm->properties->rates.rats[0].num_min;
 	const int frame_factor =
-	    line6pcm->properties->snd_line6_rates.rats[0].den *
-	    (USB_INTERVALS_PER_SECOND / LINE6_ISO_INTERVAL);
+		line6pcm->properties->rates.rats[0].den *
+		(USB_INTERVALS_PER_SECOND / LINE6_ISO_INTERVAL);
 	struct urb *urb_out;
 
 	index =
@@ -370,12 +370,11 @@ static int snd_line6_playback_open(struct snd_pcm_substream *substream)
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
 
 	err = snd_pcm_hw_constraint_ratdens(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-					    (&line6pcm->
-					     properties->snd_line6_rates));
+					    &line6pcm->properties->rates);
 	if (err < 0)
 		return err;
 
-	runtime->hw = line6pcm->properties->snd_line6_playback_hw;
+	runtime->hw = line6pcm->properties->playback_hw;
 	return 0;
 }
 
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 3f7ff661b3dd..61aadd7d4b7f 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -129,7 +129,7 @@ static struct snd_ratden pod_ratden = {
 };
 
 static struct line6_pcm_properties pod_pcm_properties = {
-	.snd_line6_playback_hw = {
+	.playback_hw = {
 				  .info = (SNDRV_PCM_INFO_MMAP |
 					   SNDRV_PCM_INFO_INTERLEAVED |
 					   SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -147,7 +147,7 @@ static struct line6_pcm_properties pod_pcm_properties = {
 				  .period_bytes_max = 8192,
 				  .periods_min = 1,
 				  .periods_max = 1024},
-	.snd_line6_capture_hw = {
+	.capture_hw = {
 				 .info = (SNDRV_PCM_INFO_MMAP |
 					  SNDRV_PCM_INFO_INTERLEAVED |
 					  SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -164,7 +164,7 @@ static struct line6_pcm_properties pod_pcm_properties = {
 				 .period_bytes_max = 8192,
 				 .periods_min = 1,
 				 .periods_max = 1024},
-	.snd_line6_rates = {
+	.rates = {
 			    .nrats = 1,
 			    .rats = &pod_ratden},
 	.bytes_per_frame = POD_BYTES_PER_FRAME
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 4ebe6ef43073..9c3c7441fd11 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -35,7 +35,7 @@ static struct snd_ratden podhd_ratden = {
 };
 
 static struct line6_pcm_properties podhd_pcm_properties = {
-	.snd_line6_playback_hw = {
+	.playback_hw = {
 				  .info = (SNDRV_PCM_INFO_MMAP |
 					   SNDRV_PCM_INFO_INTERLEAVED |
 					   SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -53,7 +53,7 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 				  .period_bytes_max = 8192,
 				  .periods_min = 1,
 				  .periods_max = 1024},
-	.snd_line6_capture_hw = {
+	.capture_hw = {
 				 .info = (SNDRV_PCM_INFO_MMAP |
 					  SNDRV_PCM_INFO_INTERLEAVED |
 					  SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -70,7 +70,7 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 				 .period_bytes_max = 8192,
 				 .periods_min = 1,
 				 .periods_max = 1024},
-	.snd_line6_rates = {
+	.rates = {
 			    .nrats = 1,
 			    .rats = &podhd_ratden},
 	.bytes_per_frame = PODHD_BYTES_PER_FRAME
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index cffcd7f83bfd..b107cf481819 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -76,7 +76,7 @@ static struct snd_ratden toneport_ratden = {
 };
 
 static struct line6_pcm_properties toneport_pcm_properties = {
-	.snd_line6_playback_hw = {
+	.playback_hw = {
 				  .info = (SNDRV_PCM_INFO_MMAP |
 					   SNDRV_PCM_INFO_INTERLEAVED |
 					   SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -94,7 +94,7 @@ static struct line6_pcm_properties toneport_pcm_properties = {
 				  .period_bytes_max = 8192,
 				  .periods_min = 1,
 				  .periods_max = 1024},
-	.snd_line6_capture_hw = {
+	.capture_hw = {
 				 .info = (SNDRV_PCM_INFO_MMAP |
 					  SNDRV_PCM_INFO_INTERLEAVED |
 					  SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -111,7 +111,7 @@ static struct line6_pcm_properties toneport_pcm_properties = {
 				 .period_bytes_max = 8192,
 				 .periods_min = 1,
 				 .periods_max = 1024},
-	.snd_line6_rates = {
+	.rates = {
 			    .nrats = 1,
 			    .rats = &toneport_ratden},
 	.bytes_per_frame = 4
-- 
2.2.2
