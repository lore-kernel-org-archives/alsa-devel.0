From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_max98090_ti: Enable
	codec clock once and keep it enabled" to the asoc tree
Date: Wed,  3 Apr 2019 05:41:18 +0100 (BST)
Message-ID: <20190403044118.4270F440082@finisterre.ee.mobilebroadband>
References: <20190402102049.27975-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DCD2F8068A
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 06:41:23 +0200 (CEST)
In-Reply-To: <20190402102049.27975-4-hdegoede@redhat.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mogens Jensen <mogens-jensen@protonmail.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Dean Wallace <duffydack73@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_max98090_ti: Enable codec clock once and keep it enabled

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

>From 4bcdec39c454c4e8f9512115bdcc3efec1ba5f55 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 2 Apr 2019 12:20:49 +0200
Subject: [PATCH] ASoC: Intel: cht_bsw_max98090_ti: Enable codec clock once and
 keep it enabled

Users have been seeing sound stability issues with max98090 codecs since:
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")

At first that commit broke sound for Chromebook Swanky and Clapper models,
the problem was that the machine-driver has been controlling the wrong
clock on those models since support for them was added. This was hidden by
clk-pmc-atom.c keeping the actual clk on unconditionally.

With the machine-driver controlling the proper clock, sound works again
but we are seeing bug reports describing it as: low volume,
"sounds like played at 10x speed" and instable.

When these issues are hit the following message is seen in dmesg:
"max98090 i2c-193C9890:00: PLL unlocked".

Attempts have been made to fix this by inserting a delay between enabling
the clk and enabling and checking the pll, but this has not helped.

It seems that at least on boards which use pmc_plt_clk_0 as clock,
if we ever disable the clk, the pll looses its lock and after that we get
various issues.

This commit fixes this by enabling the clock once at probe time on
these boards. In essence this restores the old behavior of clk-pmc-atom.c
always keeping the clk on on these boards.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reported-by: Mogens Jensen <mogens-jensen@protonmail.com>
Reported-by: Dean Wallace <duffydack73@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 47 +++++++++++++++++---
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 3263b0495853..c0e0844f75b9 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -43,6 +43,7 @@ struct cht_mc_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
 	bool ts3a227e_present;
+	int quirks;
 };
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
@@ -54,6 +55,10 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 	int ret;
 
+	/* See the comment in snd_cht_mc_probe() */
+	if (ctx->quirks & QUIRK_PMC_PLT_CLK_0)
+		return 0;
+
 	codec_dai = snd_soc_card_get_codec_dai(card, CHT_CODEC_DAI);
 	if (!codec_dai) {
 		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
@@ -223,6 +228,10 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 			"jack detection gpios not added, error %d\n", ret);
 	}
 
+	/* See the comment in snd_cht_mc_probe() */
+	if (ctx->quirks & QUIRK_PMC_PLT_CLK_0)
+		return 0;
+
 	/*
 	 * The firmware might enable the clock at
 	 * boot (this information may or may not
@@ -423,16 +432,15 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	const char *mclk_name;
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
-	int quirks = 0;
-
-	dmi_id = dmi_first_match(cht_max98090_quirk_table);
-	if (dmi_id)
-		quirks = (unsigned long)dmi_id->driver_data;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
+	dmi_id = dmi_first_match(cht_max98090_quirk_table);
+	if (dmi_id)
+		drv->quirks = (unsigned long)dmi_id->driver_data;
+
 	drv->ts3a227e_present = acpi_dev_found("104C227E");
 	if (!drv->ts3a227e_present) {
 		/* no need probe TI jack detection chip */
@@ -458,7 +466,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
-	if (quirks & QUIRK_PMC_PLT_CLK_0)
+	if (drv->quirks & QUIRK_PMC_PLT_CLK_0)
 		mclk_name = "pmc_plt_clk_0";
 	else
 		mclk_name = "pmc_plt_clk_3";
@@ -471,6 +479,21 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return PTR_ERR(drv->mclk);
 	}
 
+	/*
+	 * Boards which have the MAX98090's clk connected to clk_0 do not seem
+	 * to like it if we muck with the clock. If we disable the clock when
+	 * it is unused we get "max98090 i2c-193C9890:00: PLL unlocked" errors
+	 * and the PLL never seems to lock again.
+	 * So for these boards we enable it here once and leave it at that.
+	 */
+	if (drv->quirks & QUIRK_PMC_PLT_CLK_0) {
+		ret_val = clk_prepare_enable(drv->mclk);
+		if (ret_val < 0) {
+			dev_err(&pdev->dev, "MCLK enable error: %d\n", ret_val);
+			return ret_val;
+		}
+	}
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
 	if (ret_val) {
 		dev_err(&pdev->dev,
@@ -481,11 +504,23 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	return ret_val;
 }
 
+static int snd_cht_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
+
+	if (ctx->quirks & QUIRK_PMC_PLT_CLK_0)
+		clk_disable_unprepare(ctx->mclk);
+
+	return 0;
+}
+
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-max98090",
 	},
 	.probe = snd_cht_mc_probe,
+	.remove = snd_cht_mc_remove,
 };
 
 module_platform_driver(snd_cht_mc_driver)
-- 
2.20.1
