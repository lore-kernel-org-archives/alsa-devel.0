From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: omap-twl4030: Use
	snd_soc_runtime_set_dai_fmt()
Date: Tue,  6 Jan 2015 15:17:21 +0100
Message-ID: <1420553842-17335-2-git-send-email-lars@metafoo.de>
References: <1420553842-17335-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-112.synserver.de (smtp-out-112.synserver.de
 [212.40.185.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BD83260A56
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 15:17:28 +0100 (CET)
In-Reply-To: <1420553842-17335-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_runtime_set_dai_fmt() to configure the format for the DAI link
rather than configuring each DAI individually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/omap-twl4030.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 5e551c7..fb1f6bb 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -53,11 +53,7 @@ static int omap_twl4030_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_card *card = rtd->card;
 	unsigned int fmt;
-	int ret;
 
 	switch (params_channels(params)) {
 	case 2: /* Stereo I2S mode */
@@ -74,21 +70,7 @@ static int omap_twl4030_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0) {
-		dev_err(card->dev, "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
-	if (ret < 0) {
-		dev_err(card->dev, "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
-	return 0;
+	return snd_soc_runtime_set_dai_fmt(rtd, fmt);
 }
 
 static struct snd_soc_ops omap_twl4030_ops = {
-- 
1.8.0
