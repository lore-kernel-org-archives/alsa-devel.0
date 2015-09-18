From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2 1/2] ASoC: rt5645: Add dmi for Broadwell
Date: Fri, 18 Sep 2015 10:55:58 +0800
Message-ID: <1442544959-10695-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E34226588E
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 04:56:10 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, benzh@chromium.org, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add DMI data for Buddy project.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 66e9ce6..2fc437f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3210,6 +3210,31 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{ }
 };
 
+static struct rt5645_platform_data buddy_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
+	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
+	.jd_mode = 3,
+};
+
+static int buddy_quirk_cb(const struct dmi_system_id *id)
+{
+	rt5645_pdata = &buddy_platform_data;
+
+	return 1;
+}
+
+static struct dmi_system_id dmi_platform_intel_broadwell[] __initdata = {
+	{
+		.ident = "Chrome Buddy",
+		.callback = buddy_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Buddy"),
+		},
+	},
+	{ }
+};
+
+
 static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
 {
 	rt5645->pdata.in2_diff = device_property_read_bool(dev,
@@ -3242,7 +3267,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5645->pdata = *pdata;
-	else if (dmi_check_system(dmi_platform_intel_braswell))
+	else if (dmi_check_system(dmi_platform_intel_braswell) ||
+			dmi_check_system(dmi_platform_intel_broadwel)
 		rt5645->pdata = *rt5645_pdata;
 	else
 		rt5645_parse_dt(rt5645, &i2c->dev);
-- 
1.8.1.1.439.g50a6b54
