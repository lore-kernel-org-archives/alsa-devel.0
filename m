From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v2] ASoC: rt5645: Add the device tree parser
Date: Fri, 12 Jun 2015 14:47:36 +0800
Message-ID: <1434091656-12800-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 43C772666FA
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 08:47:43 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Modify the RT5645 driver to parse platform data from device tree. This is
missing from previous patch in sound/soc/codecs/rt5645.c, that was present
in v3.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 7d04b1a..1884264 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3231,6 +3231,20 @@ static struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{ }
 };
 
+static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
+{
+	rt5645->pdata.in2_diff = device_property_read_bool(dev,
+		"realtek,in2-differential");
+	device_property_read_u32(dev,
+		"realtek,dmic1-data-pin", &rt5645->pdata.dmic1_data_pin);
+	device_property_read_u32(dev,
+		"realtek,dmic2-data-pin", &rt5645->pdata.dmic2_data_pin);
+	device_property_read_u32(dev,
+		"realtek,jd-mode", &rt5645->pdata.jd_mode);
+
+	return 0;
+}
+
 static int rt5645_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -3247,13 +3261,12 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	rt5645->i2c = i2c;
 	i2c_set_clientdata(i2c, rt5645);
 
-	if (pdata) {
+	if (pdata)
 		rt5645->pdata = *pdata;
-	} else {
-		if (dmi_check_system(dmi_platform_intel_braswell)) {
-			rt5645->pdata = *rt5645_pdata;
-		}
-	}
+	else if (dmi_check_system(dmi_platform_intel_braswell))
+		rt5645->pdata = *rt5645_pdata;
+	else
+		rt5645_parse_dt(rt5645, &i2c->dev);
 
 	rt5645->gpiod_hp_det = devm_gpiod_get(&i2c->dev, "hp-detect", GPIOD_IN);
 
-- 
1.8.1.1.439.g50a6b54
