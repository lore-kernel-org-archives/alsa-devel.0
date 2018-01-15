From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/5] ASoC: sam9x5_wm8731: Drop 'ASoC' prefix
 from error messages
Date: Mon, 15 Jan 2018 08:53:21 +0100
Message-ID: <20180115075321.GC10762@lenoch>
References: <20180115075213.GA10762@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E4F4267409
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 08:53:22 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990488AbeAOHxWARJdu (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Mon, 15 Jan 2018 08:53:22 +0100
Content-Disposition: inline
In-Reply-To: <20180115075213.GA10762@lenoch>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

dev_err already provides messages with prefix, so drop 'ASoC'
prefix.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/atmel/sam9x5_wm8731.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index ccdf547f4d8c..e6c303ab869d 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -49,13 +49,13 @@ static int sam9x5_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 	struct device *dev = rtd->dev;
 	int ret;
 
-	dev_dbg(dev, "ASoC: %s called\n", __func__);
+	dev_dbg(dev, "%s called\n", __func__);
 
 	/* set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
 				     MCLK_RATE, SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		dev_err(dev, "ASoC: Failed to set WM8731 SYSCLK: %d\n", ret);
+		dev_err(dev, "Failed to set WM8731 SYSCLK: %d\n", ret);
 		return ret;
 	}
 
@@ -146,8 +146,7 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 
 	ret = atmel_ssc_set_audio(priv->ssc_id);
 	if (ret != 0) {
-		dev_err(&pdev->dev,
-			"ASoC: Failed to set SSC %d for audio: %d\n",
+		dev_err(&pdev->dev, "Failed to set SSC %d for audio: %d\n",
 			ret, priv->ssc_id);
 		goto out;
 	}
@@ -157,12 +156,11 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"ASoC: Platform device allocation failed\n");
+		dev_err(&pdev->dev, "Platform device allocation failed\n");
 		goto out_put_audio;
 	}
 
-	dev_dbg(&pdev->dev, "ASoC: %s ok\n", __func__);
+	dev_dbg(&pdev->dev, "%s ok\n", __func__);
 
 	return ret;
 
-- 
2.15.1
