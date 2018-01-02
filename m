From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/6] ASoC: rt5645: cleanup DMI matching code
Date: Tue,  2 Jan 2018 19:53:12 +0100
Message-ID: <20180102185314.17189-5-hdegoede@redhat.com>
References: <20180102185314.17189-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DE2A2674CE
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 19:53:25 +0100 (CET)
In-Reply-To: <20180102185314.17189-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Rather then doing a dmi_check_system() per possible system use an array
with all known systems, with dmi_system_id.driver_data pointing to the
platform-data for the matching system.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5645.c | 124 +++++++++++++++++++---------------------------
 1 file changed, 51 insertions(+), 73 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 6c134f4d881b..cadfc8871bb9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3625,66 +3625,74 @@ static const struct acpi_device_id rt5645_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
 #endif
 
-static const struct rt5645_platform_data general_platform_data = {
+static const struct rt5645_platform_data intel_braswell_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
 };
 
-static const struct dmi_system_id dmi_platform_intel_braswell[] = {
+static const struct rt5645_platform_data buddy_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
+	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
+	.jd_mode = 3,
+	.level_trigger_irq = true,
+};
+
+static const struct rt5645_platform_data gpd_win_platform_data = {
+	.jd_mode = 3,
+	.inv_jd1_1 = true,
+	.long_name = "gpd-win-pocket-rt5645",
+	/* The GPD pocket has a diff. mic, for the win this does not matter. */
+	.in2_diff = true,
+};
+
+static const struct rt5645_platform_data asus_t100ha_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC_DATA_IN2N,
+	.dmic2_data_pin = RT5645_DMIC2_DISABLE,
+	.jd_mode = 3,
+	.inv_jd1_1 = true,
+};
+
+static const struct rt5645_platform_data jd_mode3_platform_data = {
+	.jd_mode = 3,
+};
+
+static const struct dmi_system_id dmi_platform_data[] = {
+	{
+		.ident = "Chrome Buddy",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Buddy"),
+		},
+		.driver_data = (void *)&buddy_platform_data,
+	},
 	{
 		.ident = "Intel Strago",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Strago"),
 		},
+		.driver_data = (void *)&intel_braswell_platform_data,
 	},
 	{
 		.ident = "Google Chrome",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 		},
+		.driver_data = (void *)&intel_braswell_platform_data,
 	},
 	{
 		.ident = "Google Setzer",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
 		},
+		.driver_data = (void *)&intel_braswell_platform_data,
 	},
 	{
 		.ident = "Microsoft Surface 3",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
 		},
+		.driver_data = (void *)&intel_braswell_platform_data,
 	},
-	{ }
-};
-
-static const struct rt5645_platform_data buddy_platform_data = {
-	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
-	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
-	.jd_mode = 3,
-	.level_trigger_irq = true,
-};
-
-static const struct dmi_system_id dmi_platform_intel_broadwell[] = {
-	{
-		.ident = "Chrome Buddy",
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Buddy"),
-		},
-	},
-	{ }
-};
-
-static const struct rt5645_platform_data gpd_win_platform_data = {
-	.jd_mode = 3,
-	.inv_jd1_1 = true,
-	.long_name = "gpd-win-pocket-rt5645",
-	/* The GPD pocket has a diff. mic, for the win this does not matter. */
-	.in2_diff = true,
-};
-
-static const struct dmi_system_id dmi_platform_gpd_win[] = {
 	{
 		/*
 		 * Match for the GPDwin which unfortunately uses somewhat
@@ -3695,61 +3703,34 @@ static const struct dmi_system_id dmi_platform_gpd_win[] = {
 		 * the same default product_name. Also the GPDwin is the
 		 * only device to have both board_ and product_name not set.
 		 */
-		.ident = "GPD Win",
+		.ident = "GPD Win / Pocket",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		},
+		.driver_data = (void *)&gpd_win_platform_data,
 	},
-	{}
-};
-
-static const struct rt5645_platform_data general_platform_data2 = {
-	.dmic1_data_pin = RT5645_DMIC_DATA_IN2N,
-	.dmic2_data_pin = RT5645_DMIC2_DISABLE,
-	.jd_mode = 3,
-	.inv_jd1_1 = true,
-};
-
-static const struct dmi_system_id dmi_platform_asus_t100ha[] = {
 	{
 		.ident = "ASUS T100HAN",
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "T100HAN"),
 		},
+		.driver_data = (void *)&asus_t100ha_platform_data,
 	},
-	{ }
-};
-
-static const struct rt5645_platform_data minix_z83_4_platform_data = {
-	.jd_mode = 3,
-};
-
-static const struct dmi_system_id dmi_platform_minix_z83_4[] = {
 	{
 		.ident = "MINIX Z83-4",
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
 		},
+		.driver_data = (void *)&jd_mode3_platform_data,
 	},
 	{ }
 };
 
-static bool rt5645_check_dp(struct device *dev)
-{
-	if (device_property_present(dev, "realtek,in2-differential") ||
-		device_property_present(dev, "realtek,dmic1-data-pin") ||
-		device_property_present(dev, "realtek,dmic2-data-pin") ||
-		device_property_present(dev, "realtek,jd-mode"))
-		return true;
-
-	return false;
-}
-
 static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
 {
 	rt5645->pdata.in2_diff = device_property_read_bool(dev,
@@ -3768,6 +3749,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
 	struct rt5645_platform_data *pdata = dev_get_platdata(&i2c->dev);
+	const struct dmi_system_id *dmi_data;
 	struct rt5645_priv *rt5645;
 	int ret, i;
 	unsigned int val;
@@ -3781,20 +3763,16 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	rt5645->i2c = i2c;
 	i2c_set_clientdata(i2c, rt5645);
 
+	dmi_data = dmi_first_match(dmi_platform_data);
+	if (dmi_data) {
+		dev_info(&i2c->dev, "Detected %s platform\n", dmi_data->ident);
+		pdata = dmi_data->driver_data;
+	}
+
 	if (pdata)
 		rt5645->pdata = *pdata;
-	else if (dmi_check_system(dmi_platform_intel_broadwell))
-		rt5645->pdata = buddy_platform_data;
-	else if (rt5645_check_dp(&i2c->dev))
+	else
 		rt5645_parse_dt(rt5645, &i2c->dev);
-	else if (dmi_check_system(dmi_platform_intel_braswell))
-		rt5645->pdata = general_platform_data;
-	else if (dmi_check_system(dmi_platform_gpd_win))
-		rt5645->pdata = gpd_win_platform_data;
-	else if (dmi_check_system(dmi_platform_asus_t100ha))
-		rt5645->pdata = general_platform_data2;
-	else if (dmi_check_system(dmi_platform_minix_z83_4))
-		rt5645->pdata = minix_z83_4_platform_data;
 
 	if (quirk != -1) {
 		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
-- 
2.14.3
