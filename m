From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 12/14] ASoC: codecs: rt5670: add jack detection
	quirk for Dell Venue 5585
Date: Tue, 22 Aug 2017 15:32:37 -0500
Message-ID: <20170822203239.19891-13-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 80E8E2670F8
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:17 +0200 (CEST)
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

Jack is not detected by default, using jdmode=3 works fine

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5670.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index e56c12a..9545764 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2851,6 +2851,17 @@ static const struct dmi_system_id dmi_platform_intel_bytcht_jdmode2[] = {
 	{}
 };
 
+static const struct dmi_system_id dmi_platform_intel_bytcht_jdmode3[] = {
+	{
+		.ident = "Dell Venue 8 Pro 5855",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5855"),
+		},
+	},
+	{}
+};
+
 static int rt5670_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -2880,6 +2891,11 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 		rt5670->pdata.dmic1_data_pin = RT5670_DMIC_DATA_IN2P;
 		rt5670->pdata.dev_gpio = true;
 		rt5670->pdata.jd_mode = 2;
+	} else if (dmi_check_system(dmi_platform_intel_bytcht_jdmode3)) {
+		rt5670->pdata.dmic_en = true;
+		rt5670->pdata.dmic1_data_pin = RT5670_DMIC_DATA_IN2P;
+		rt5670->pdata.dev_gpio = true;
+		rt5670->pdata.jd_mode = 3;
 	}
 
 	rt5670->regmap = devm_regmap_init_i2c(i2c, &rt5670_regmap);
-- 
2.9.3
