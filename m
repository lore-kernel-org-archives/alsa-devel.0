From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: merge DMI tables of google
	projects" to the asoc tree
Date: Mon, 30 Nov 2015 12:31:10 +0000
Message-ID: <E1a3Nbq-000449-UU@debutante>
References: <1448863821-10211-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A55512612AF
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 13:31:16 +0100 (CET)
In-Reply-To: <1448863821-10211-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: merge DMI tables of google projects

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9761c0f65d3a4c7ae8ceec86ac9d8d2c64197d57 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 30 Nov 2015 14:10:21 +0800
Subject: [PATCH] ASoC: rt5645: merge DMI tables of google projects

There are more and more google projects need to use DMI to get the
platform data configuration. And those projects use the same
configuration. To clean those redundant code, we define a general
DMI for those projects with the same platform data configuration.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 79 +++++++++++------------------------------------
 1 file changed, 18 insertions(+), 61 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 7b140ccf9d2e..3e8d66661b7e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3514,69 +3514,23 @@ static struct acpi_device_id rt5645_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
 #endif
 
-static struct rt5645_platform_data *rt5645_pdata;
-
-static struct rt5645_platform_data strago_platform_data = {
+static struct rt5645_platform_data general_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
 };
 
-static int strago_quirk_cb(const struct dmi_system_id *id)
-{
-	rt5645_pdata = &strago_platform_data;
-
-	return 1;
-}
-
 static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{
 		.ident = "Intel Strago",
-		.callback = strago_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Strago"),
 		},
 	},
 	{
-		.ident = "Google Celes",
-		.callback = strago_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
-		},
-	},
-	{
-		.ident = "Google Ultima",
-		.callback = strago_quirk_cb,
+		.ident = "Google Chrome",
 		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Ultima"),
-		},
-	},
-	{
-		.ident = "Google Reks",
-		.callback = strago_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Reks"),
-		},
-	},
-	{
-		.ident = "Google Edgar",
-		.callback = strago_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Edgar"),
-		},
-	},
-	{
-		.ident = "Google Wizpig",
-		.callback = strago_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Wizpig"),
-		},
-	},
-	{
-		.ident = "Google Terra",
-		.callback = strago_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Terra"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 		},
 	},
 	{ }
@@ -3589,17 +3543,9 @@ static struct rt5645_platform_data buddy_platform_data = {
 	.jd_invert = true,
 };
 
-static int buddy_quirk_cb(const struct dmi_system_id *id)
-{
-	rt5645_pdata = &buddy_platform_data;
-
-	return 1;
-}
-
 static struct dmi_system_id dmi_platform_intel_broadwell[] = {
 	{
 		.ident = "Chrome Buddy",
-		.callback = buddy_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Buddy"),
 		},
@@ -3607,6 +3553,16 @@ static struct dmi_system_id dmi_platform_intel_broadwell[] = {
 	{ }
 };
 
+static bool rt5645_check_dp(struct device *dev)
+{
+	if (device_property_present(dev, "realtek,in2-differential") ||
+		device_property_present(dev, "realtek,dmic1-data-pin") ||
+		device_property_present(dev, "realtek,dmic2-data-pin") ||
+		device_property_present(dev, "realtek,jd-mode"))
+		return true;
+
+	return false;
+}
 
 static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
 {
@@ -3641,11 +3597,12 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5645->pdata = *pdata;
-	else if (dmi_check_system(dmi_platform_intel_braswell) ||
-			dmi_check_system(dmi_platform_intel_broadwell))
-		rt5645->pdata = *rt5645_pdata;
-	else
+	else if (dmi_check_system(dmi_platform_intel_broadwell))
+		rt5645->pdata = buddy_platform_data;
+	else if (rt5645_check_dp(&i2c->dev))
 		rt5645_parse_dt(rt5645, &i2c->dev);
+	else if (dmi_check_system(dmi_platform_intel_braswell))
+		rt5645->pdata = general_platform_data;
 
 	rt5645->gpiod_hp_det = devm_gpiod_get_optional(&i2c->dev, "hp-detect",
 						       GPIOD_IN);
-- 
2.6.2
