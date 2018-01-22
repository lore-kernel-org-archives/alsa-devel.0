From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sam9x5_wm8731: Drop 'ASoC' prefix from
	error messages" to the asoc tree
Date: Mon, 22 Jan 2018 12:26:20 +0000
Message-ID: <E1edbB6-0004Zt-8R@debutante>
References: <20180115075321.GC10762@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EB4BF266B67
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 13:26:29 +0100 (CET)
In-Reply-To: <20180115075321.GC10762@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sam9x5_wm8731: Drop 'ASoC' prefix from error messages

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2efb8a8f11ba92971551189da91ece8b5040e461 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 15 Jan 2018 08:53:21 +0100
Subject: [PATCH] ASoC: sam9x5_wm8731: Drop 'ASoC' prefix from error messages

dev_err already provides messages with prefix, so drop 'ASoC'
prefix.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
