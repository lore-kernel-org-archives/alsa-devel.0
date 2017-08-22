From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/14] ASoC: codecs: rt5645: add quirks for
	Asus T100HA
Date: Tue, 22 Aug 2017 15:32:35 -0500
Message-ID: <20170822203239.19891-11-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B472670CE
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:15 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Fix jack detection and dmic setup

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5645.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ce31d0d..1ce9a74 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3637,6 +3637,24 @@ static const struct dmi_system_id dmi_platform_gpd_win[] = {
 	{}
 };
 
+static struct rt5645_platform_data general_platform_data2 = {
+	.dmic1_data_pin = RT5645_DMIC_DATA_IN2N,
+	.dmic2_data_pin = RT5645_DMIC2_DISABLE,
+	.jd_mode = 3,
+	.inv_jd1_1 = true,
+};
+
+static struct dmi_system_id dmi_platform_asus_t100ha[] = {
+	{
+		.ident = "ASUS T100HAN",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T100HAN"),
+		},
+	},
+	{ }
+};
+
 static bool rt5645_check_dp(struct device *dev)
 {
 	if (device_property_present(dev, "realtek,in2-differential") ||
@@ -3689,6 +3707,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		rt5645->pdata = general_platform_data;
 	else if (dmi_check_system(dmi_platform_gpd_win))
 		rt5645->pdata = gpd_win_platform_data;
+	else if (dmi_check_system(dmi_platform_asus_t100ha))
+		rt5645->pdata = general_platform_data2;
 
 	if (quirk != -1) {
 		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
-- 
2.9.3
