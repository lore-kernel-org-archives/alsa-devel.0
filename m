From: yang.a.fang@intel.com
Subject: [PATCH 4/4] ASoC: ts3a227e: set irq flag base on dmi
Date: Wed, 29 Apr 2015 18:43:58 -0700
Message-ID: <1430358238-74659-4-git-send-email-yang.a.fang@intel.com>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DDC42608EC
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 03:44:42 +0200 (CEST)
In-Reply-To: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, praveen.diwakar@intel.com, denny.iriawan@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

Cyan platform need edge trigger interrupt

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/ts3a227e.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 422f66f..75f2a43 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>
+#include <linux/dmi.h>
 
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -270,6 +271,33 @@ static int ts3a227e_parse_dt(struct ts3a227e *ts3a227e, struct device_node *np)
 	return 0;
 }
 
+static struct ts3a227e_platform_data *ts3a227e_pdata;
+
+static struct ts3a227e_platform_data cyan_platform_data = {
+
+	.irqflag = IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+
+};
+
+static int cyan_quirk_cb(const struct dmi_system_id *id)
+{
+
+	ts3a227e_pdata = &cyan_platform_data;
+
+	return 1;
+}
+
+static struct dmi_system_id dmi_platform_intel_braswell[] = {
+	{
+		.ident = "Braswell Cyan",
+		.callback = cyan_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
+		},
+	},
+	{ }
+};
+
 static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 			      const struct i2c_device_id *id)
 {
@@ -287,9 +315,12 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 
 	ts3a227e->pdata.irqflag = IRQF_TRIGGER_LOW | IRQF_ONESHOT;
 
-	if (pdata)
+	if (pdata) {
 		ts3a227e->pdata = *pdata;
-
+	} else {
+		if (dmi_check_system(dmi_platform_intel_braswell))
+			ts3a227e->pdata = *ts3a227e_pdata;
+	}
 	ts3a227e->regmap = devm_regmap_init_i2c(i2c, &ts3a227e_regmap_config);
 	if (IS_ERR(ts3a227e->regmap))
 		return PTR_ERR(ts3a227e->regmap);
-- 
1.7.9.5
