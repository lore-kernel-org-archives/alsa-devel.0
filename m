From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2] ASoC: compress: Fix compress device direction check
Date: Thu,  7 Jan 2016 21:48:14 +0530
Message-ID: <1452183494-1957-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The detection of direction for compress was only taking into account codec
capabilities and not CPU ones. Fix this by checking the CPU side capabilities
as well

Cc: <stable@vger.kernel.org>
Tested-by: Ashish Panwar <ashish.panwar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
v2: fix xor check

 sound/soc/soc-compress.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 12a9820feac1..bb82bb966000 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -630,6 +630,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	struct snd_pcm *be_pcm;
 	char new_name[64];
 	int ret = 0, direction = 0;
+	int playback = 0, capture = 0;
 
 	if (rtd->num_codecs > 1) {
 		dev_err(rtd->card->dev, "Multicodec not supported for compressed stream\n");
@@ -641,11 +642,27 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			rtd->dai_link->stream_name, codec_dai->name, num);
 
 	if (codec_dai->driver->playback.channels_min)
+		playback = 1;
+	if (codec_dai->driver->capture.channels_min)
+		capture = 1;
+
+	capture = capture && cpu_dai->driver->capture.channels_min;
+	playback = playback && cpu_dai->driver->playback.channels_min;
+
+	/*
+	 * Compress devices are unidirectional so only one of the directions
+	 * should be set, check for that (xor)
+	 */
+	if (playback + capture != 1) {
+		dev_err(rtd->card->dev, "Invalid direction for compress P %d, C %d\n",
+				playback, capture);
+		return -EINVAL;
+	}
+
+	if(playback)
 		direction = SND_COMPRESS_PLAYBACK;
-	else if (codec_dai->driver->capture.channels_min)
-		direction = SND_COMPRESS_CAPTURE;
 	else
-		return -EINVAL;
+		direction = SND_COMPRESS_CAPTURE;
 
 	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
 	if (compr == NULL) {
-- 
1.9.1
