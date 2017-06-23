From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ASoC: codecs: rt5670: fix jd mode for
	Lenovo Miix 2 10
Date: Fri, 23 Jun 2017 12:21:01 -0500
Message-ID: <20170623172101.29079-3-pierre-louis.bossart@linux.intel.com>
References: <20170623172101.29079-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0E7266D55
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 19:21:22 +0200 (CEST)
In-Reply-To: <20170623172101.29079-1-pierre-louis.bossart@linux.intel.com>
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

jd mode 2 (3.3V) is required apparently

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96691
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5670.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index e27c5a4..d90c74e 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2849,6 +2849,10 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Tablet B"),
 		},
 	},
+	{}
+};
+
+static const struct dmi_system_id dmi_platform_intel_bytcht_jdmode2[] = {
 	{
 		.ident = "Lenovo Thinkpad Tablet 10",
 		.matches = {
@@ -2883,6 +2887,11 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 		rt5670->pdata.dmic1_data_pin = RT5670_DMIC_DATA_IN2P;
 		rt5670->pdata.dev_gpio = true;
 		rt5670->pdata.jd_mode = 1;
+	} else if (dmi_check_system(dmi_platform_intel_bytcht_jdmode2)) {
+		rt5670->pdata.dmic_en = true;
+		rt5670->pdata.dmic1_data_pin = RT5670_DMIC_DATA_IN2P;
+		rt5670->pdata.dev_gpio = true;
+		rt5670->pdata.jd_mode = 2;
 	}
 
 	rt5670->regmap = devm_regmap_init_i2c(i2c, &rt5670_regmap);
-- 
2.9.3
