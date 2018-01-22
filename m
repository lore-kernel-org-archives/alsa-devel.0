From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sam9g20_wm8731: use dev_*() logging
	functions" to the asoc tree
Date: Mon, 22 Jan 2018 12:26:23 +0000
Message-ID: <E1edbB9-0004aq-S7@debutante>
References: <20180115075254.GB10762@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A7F126732C
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 13:26:35 +0100 (CET)
In-Reply-To: <20180115075254.GB10762@lenoch>
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

   ASoC: sam9g20_wm8731: use dev_*() logging functions

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

>From edefc8f387a86c2db943db6accd1cd23be2b64a9 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 15 Jan 2018 08:52:54 +0100
Subject: [PATCH] ASoC: sam9g20_wm8731: use dev_*() logging functions

Use dev_*() logging functions instead of plain printk and as
messages are now properly prefixed drop 'ASoC' prefix as well.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/sam9g20_wm8731.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index d7469cdd90dc..98f93e79c654 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -110,16 +110,15 @@ static const struct snd_soc_dapm_route intercon[] = {
 static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct device *dev = rtd->dev;
 	int ret;
 
-	printk(KERN_DEBUG
-			"at91sam9g20ek_wm8731 "
-			": at91sam9g20ek_wm8731_init() called\n");
+	dev_dbg(dev, "%s called\n", __func__);
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_MCLK,
-		MCLK_RATE, SND_SOC_CLOCK_IN);
+				     MCLK_RATE, SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		printk(KERN_ERR "Failed to set WM8731 SYSCLK: %d\n", ret);
+		dev_err(dev, "Failed to set WM8731 SYSCLK: %d\n", ret);
 		return ret;
 	}
 
@@ -179,21 +178,21 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	 */
 	mclk = clk_get(NULL, "pck0");
 	if (IS_ERR(mclk)) {
-		printk(KERN_ERR "ASoC: Failed to get MCLK\n");
+		dev_err(&pdev->dev, "Failed to get MCLK\n");
 		ret = PTR_ERR(mclk);
 		goto err;
 	}
 
 	pllb = clk_get(NULL, "pllb");
 	if (IS_ERR(pllb)) {
-		printk(KERN_ERR "ASoC: Failed to get PLLB\n");
+		dev_err(&pdev->dev, "Failed to get PLLB\n");
 		ret = PTR_ERR(pllb);
 		goto err_mclk;
 	}
 	ret = clk_set_parent(mclk, pllb);
 	clk_put(pllb);
 	if (ret != 0) {
-		printk(KERN_ERR "ASoC: Failed to set MCLK parent\n");
+		dev_err(&pdev->dev, "Failed to set MCLK parent\n");
 		goto err_mclk;
 	}
 
@@ -236,7 +235,7 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
-		printk(KERN_ERR "ASoC: snd_soc_register_card() failed\n");
+		dev_err(&pdev->dev, "snd_soc_register_card() failed\n");
 	}
 
 	return ret;
-- 
2.15.1
