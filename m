From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/5] ASoC: sam9g20_wm8731: use dev_*() logging
	functions
Date: Mon, 15 Jan 2018 08:52:54 +0100
Message-ID: <20180115075254.GB10762@lenoch>
References: <20180115075213.GA10762@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id AE30426731C
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 08:52:55 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990477AbeAOHwz3H3hu (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Mon, 15 Jan 2018 08:52:55 +0100
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

Use dev_*() logging functions instead of plain printk and as
messages are now properly prefixed drop 'ASoC' prefix as well.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
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
