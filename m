From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Sort DMI table
	entries alphabetically" to the asoc tree
Date: Wed, 27 Jun 2018 12:30:31 +0100 (BST)
Message-ID: <20180627113031.4C764440070@finisterre.ee.mobilebroadband>
References: <20180624140634.16835-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 80CED267993
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:30:36 +0200 (CEST)
In-Reply-To: <20180624140634.16835-10-hdegoede@redhat.com>
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

   ASoC: Intel: bytcr_rt5651: Sort DMI table entries alphabetically

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

>From 55d69c0309acea65fb3dd99a05a665b51630362d Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 24 Jun 2018 16:06:34 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Sort DMI table entries
 alphabetically

As we get more entries in the DMI quirk table it is nice to have some
sort of ordering in the table, sort it alphabetically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 41 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index ffd62eb5c266..ba2753e0e12a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -335,23 +335,29 @@ static int byt_rt5651_quirk_cb(const struct dmi_system_id *id)
 
 static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 	{
+		/* Chuwi Hi8 Pro (CWI513) */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
 		},
-		.driver_data = (void *)(BYT_RT5651_IN1_MAP),
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
+					BYT_RT5651_IN1_MAP |
+					BYT_RT5651_HP_LR_SWAPPED),
 	},
 	{
+		/* Chuwi Vi8 Plus (CWI519) */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ADI"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Turbot"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
-		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_IN1_MAP),
+		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
+					BYT_RT5651_IN1_MAP |
+					BYT_RT5651_HP_LR_SWAPPED),
 	},
 	{
+		/* KIANO SlimNote 14.2 */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
@@ -361,26 +367,23 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{
-		/* Chuwi Hi8 Pro (CWI513) */
+		/* Minnowboard Max B3 */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
 		},
-		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_MAP |
-					BYT_RT5651_HP_LR_SWAPPED),
+		.driver_data = (void *)(BYT_RT5651_IN1_MAP),
 	},
 	{
-		/* Chuwi Vi8 Plus (CWI519) */
+		/* Minnowboard Turbot */
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ADI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Turbot"),
 		},
-		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_MAP |
-					BYT_RT5651_HP_LR_SWAPPED),
+		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_IN1_MAP),
 	},
 	{
 		/* VIOS LTH17 */
-- 
2.17.1
