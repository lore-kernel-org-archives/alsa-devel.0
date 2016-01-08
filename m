From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Fix compress device direction check" to the asoc tree
Date: Fri, 08 Jan 2016 13:44:38 +0000
Message-ID: <E1aHXLK-0003CS-Jm@debutante>
References: <1452183494-1957-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1452183494-1957-1-git-send-email-vinod.koul@intel.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, Ashish Panwar <ashish.panwar@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Fix compress device direction check

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a1068045883ed4a18363a4ebad0c3d55e473b716 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 7 Jan 2016 21:48:14 +0530
Subject: [PATCH] ASoC: compress: Fix compress device direction check

The detection of direction for compress was only taking into account codec
capabilities and not CPU ones. Fix this by checking the CPU side capabilities
as well

Cc: <stable@vger.kernel.org>
Tested-by: Ashish Panwar <ashish.panwar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
2.7.0.rc3
