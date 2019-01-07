From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: Minor
	refactoring" to the asoc tree
Date: Mon,  7 Jan 2019 12:30:51 +0000 (GMT)
Message-ID: <20190107123051.F08781127490@debutante.sirena.org.uk>
References: <20190103134535.13861-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D2C7267BC6
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:30:52 +0100 (CET)
In-Reply-To: <20190103134535.13861-5-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_es8316: Minor refactoring

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

>From 86909c8f77c5eda17a9b5dc954849e25df1ffe0f Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 3 Jan 2019 14:45:29 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Minor refactoring

Some minor refactoring:
1) Group the code setting the card dev and prive pointers together with
   registering the card
2) Properly put the comment about registering the card at the place where
   we actually register the card and add a new comment for getting the clk
3) Add a struct device *dev helper variable (this will be used more in
   follow up commits)
4) Reword error message to have the same "foo failed: %d" wording as others

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 5d8ecc100766..e29f00560b00 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -237,17 +237,18 @@ static char codec_name[SND_ACPI_I2C_ID_LEN];
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
 	struct byt_cht_es8316_private *priv;
+	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
 	int i;
 	int ret = 0;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	mach = (&pdev->dev)->platform_data;
+	mach = dev->platform_data;
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_cht_es8316_dais); i++) {
 		if (!strcmp(byt_cht_es8316_dais[i].codec_name,
@@ -265,26 +266,25 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		byt_cht_es8316_dais[dai_index].codec_name = codec_name;
 	}
 
-	/* register the soc card */
-	byt_cht_es8316_card.dev = &pdev->dev;
-	snd_soc_card_set_drvdata(&byt_cht_es8316_card, priv);
-
-	priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	/* get the clock */
+	priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
 	if (IS_ERR(priv->mclk)) {
 		ret = PTR_ERR(priv->mclk);
-		dev_err(&pdev->dev,
-			"Failed to get MCLK from pmc_plt_clk_3: %d\n",
-			ret);
+		dev_err(dev, "clk_get pmc_plt_clk_3 failed: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, &byt_cht_es8316_card);
+	/* register the soc card */
+	byt_cht_es8316_card.dev = dev;
+	snd_soc_card_set_drvdata(&byt_cht_es8316_card, priv);
+
+	ret = devm_snd_soc_register_card(dev, &byt_cht_es8316_card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed %d\n", ret);
+		dev_err(dev, "snd_soc_register_card failed: %d\n", ret);
 		return ret;
 	}
 	platform_set_drvdata(pdev, &byt_cht_es8316_card);
-	return ret;
+	return 0;
 }
 
 static struct platform_driver snd_byt_cht_es8316_mc_driver = {
-- 
2.20.1
