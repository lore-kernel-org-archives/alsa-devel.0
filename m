From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Sort DMI quirk
	list alphabetically" to the asoc tree
Date: Thu, 17 May 2018 17:39:00 +0100 (BST)
Message-ID: <20180517163900.14AEA44007E@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-17-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BCDE267673
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:39:03 +0200 (CEST)
In-Reply-To: <20180508153604.23711-17-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: Sort DMI quirk list alphabetically

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

>From 3c0d01160899576af068ce293f5688b3f0bcce3c Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 May 2018 09:24:32 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Sort DMI quirk list alphabetically

As we add more quirks it is useful to have some sort of order in the
quirk list, sort it alphabetically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 41 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b00f21ed4357..965721663749 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -401,7 +401,19 @@ static int byt_rt5640_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
+/* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+						 BYT_RT5640_MCLK_EN |
+						 BYT_RT5640_SSP0_AIF1),
+
+	},
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
@@ -426,6 +438,14 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
+	},
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
@@ -448,14 +468,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_MCLK_EN),
 	},
-	{
-		.callback = byt_rt5640_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
-		},
-		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
-	},
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
@@ -466,18 +478,7 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN |
 					BYT_RT5640_SSP0_AIF1),
 	},
-	{
-		.callback = byt_rt5640_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
-		},
-		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
-						 BYT_RT5640_MCLK_EN |
-						 BYT_RT5640_SSP0_AIF1),
-
-	},
-	{
+	{	/* Catch-all for generic Insyde tablets, must be last */
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-- 
2.17.0
