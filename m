From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Add
	BYT_RT5651_DEFAULT_QUIRKS define" to the asoc tree
Date: Wed, 27 Jun 2018 12:32:45 +0100 (BST)
Message-ID: <20180627113245.37593440070@finisterre.ee.mobilebroadband>
References: <20180624140634.16835-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CF5E5267978
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:32:46 +0200 (CEST)
In-Reply-To: <20180624140634.16835-2-hdegoede@redhat.com>
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

   ASoC: Intel: bytcr_rt5651: Add BYT_RT5651_DEFAULT_QUIRKS define

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

>From fc7c460fbb4003bf3f5d2b435079c85888644663 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 24 Jun 2018 16:06:26 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Add BYT_RT5651_DEFAULT_QUIRKS
 define

Almost all boards use the mclk and use the same jack-detect settings, add
a BYT_RT5651_DEFAULT_QUIRKS define for this.

This shaves of some lines and makes it easier to see which settings are
unique to a certain model.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 987720e203f9..735b8312e275 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -77,6 +77,11 @@ enum {
 #define BYT_RT5651_SSP0_AIF1		BIT(20)
 #define BYT_RT5651_SSP0_AIF2		BIT(21)
 
+#define BYT_RT5651_DEFAULT_QUIRKS	(BYT_RT5651_MCLK_EN | \
+					 BYT_RT5651_JD1_1   | \
+					 BYT_RT5651_OVCD_TH_2000UA | \
+					 BYT_RT5651_OVCD_SF_0P75)
+
 /* jack-detect-source + dmic-en + ovcd-th + -sf + terminating empty entry */
 #define MAX_NO_PROPS 5
 
@@ -86,10 +91,7 @@ struct byt_rt5651_private {
 };
 
 /* Default: jack-detect on JD1_1, internal mic on in2, headsetmic on in3 */
-static unsigned long byt_rt5651_quirk = BYT_RT5651_MCLK_EN |
-					BYT_RT5651_JD1_1 |
-					BYT_RT5651_OVCD_TH_2000UA |
-					BYT_RT5651_OVCD_SF_0P75 |
+static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_HS_IN3_MAP;
 
 static void log_quirks(struct device *dev)
@@ -379,10 +381,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
 		},
-		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_JD1_1 |
-					BYT_RT5651_OVCD_TH_2000UA |
-					BYT_RT5651_OVCD_SF_0P75 |
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{
@@ -392,10 +391,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
-		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_JD1_1 |
-					BYT_RT5651_OVCD_TH_2000UA |
-					BYT_RT5651_OVCD_SF_0P75 |
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_HS_IN3_MAP),
 	},
 	{
@@ -405,10 +401,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "VIOS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
-		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_JD1_1 |
-					BYT_RT5651_OVCD_TH_2000UA |
-					BYT_RT5651_OVCD_SF_1P0 |
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
-- 
2.17.1
