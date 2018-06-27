From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Add
	BYT_RT5651_HP_LR_SWAPPED quirk" to the asoc tree
Date: Wed, 27 Jun 2018 12:30:49 +0100 (BST)
Message-ID: <20180627113049.320C7440070@finisterre.ee.mobilebroadband>
References: <20180624140634.16835-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CC69267988
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:31:03 +0200 (CEST)
In-Reply-To: <20180624140634.16835-9-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Add BYT_RT5651_HP_LR_SWAPPED quirk

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

>From 8f250e7009d71e6f3f3aeb95a540c36fc9c03398 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 24 Jun 2018 16:06:33 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Add BYT_RT5651_HP_LR_SWAPPED quirk

One some models (Chuwi Vi8 Plus, Chuwi Hi8 Pro) the headphone output has
left and right swapped. This can be fixed in with special mixer settings
in the UCM profile, bit this requires these devices loading a different
UCM profile.

This commit adds a BYT_RT5651_HP_LR_SWAPPED quirk for this and postfixes
the longname with "-hp-swapped" if set, so that a different UCM profile
will be loaded.

We can safely do this without causing regressions (UCM profile not found
due to the longname change) as the UCM profiles are not in upstream
alsa-lib yet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e778142b8a6e..ffd62eb5c266 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -73,6 +73,7 @@ enum {
 #define BYT_RT5651_SSP2_AIF2		BIT(19) /* default is using AIF1  */
 #define BYT_RT5651_SSP0_AIF1		BIT(20)
 #define BYT_RT5651_SSP0_AIF2		BIT(21)
+#define BYT_RT5651_HP_LR_SWAPPED	BIT(22)
 
 #define BYT_RT5651_DEFAULT_QUIRKS	(BYT_RT5651_MCLK_EN | \
 					 BYT_RT5651_JD1_1   | \
@@ -359,6 +360,17 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
+	{
+		/* Chuwi Hi8 Pro (CWI513) */
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
+		},
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
+					BYT_RT5651_IN1_MAP |
+					BYT_RT5651_HP_LR_SWAPPED),
+	},
 	{
 		/* Chuwi Vi8 Plus (CWI519) */
 		.callback = byt_rt5651_quirk_cb,
@@ -367,7 +379,8 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_MAP),
+					BYT_RT5651_IN1_MAP |
+					BYT_RT5651_HP_LR_SWAPPED),
 	},
 	{
 		/* VIOS LTH17 */
@@ -662,7 +675,7 @@ static struct snd_soc_card byt_rt5651_card = {
 static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
 static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
-static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic" */
+static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic[-swapped-hp]" */
 
 static bool is_valleyview(void)
 {
@@ -687,6 +700,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
+	const char *hp_swapped;
 	bool is_bytcr = false;
 	int ret_val = 0;
 	int dai_index = 0;
@@ -829,9 +843,14 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (byt_rt5651_quirk & BYT_RT5651_HP_LR_SWAPPED)
+		hp_swapped = "-hp-swapped";
+	else
+		hp_swapped = "";
+
 	snprintf(byt_rt5651_long_name, sizeof(byt_rt5651_long_name),
-		 "bytcr-rt5651-%s-mic",
-		 mic_name[BYT_RT5651_MAP(byt_rt5651_quirk)]);
+		 "bytcr-rt5651-%s-mic%s",
+		 mic_name[BYT_RT5651_MAP(byt_rt5651_quirk)], hp_swapped);
 	byt_rt5651_card.long_name = byt_rt5651_long_name;
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5651_card);
-- 
2.17.1
