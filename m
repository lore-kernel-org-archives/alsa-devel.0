From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/7] ASoC: cs42l51: add regulator management
Date: Wed, 3 Apr 2019 15:23:32 +0200
Message-ID: <1554297817-14154-3-git-send-email-olivier.moysan@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, apatard@mandriva.com
List-Id: alsa-devel@alsa-project.org

Add cs42l51 audio codec power supply management
through regulator framework.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51-i2c.c |  6 ++++++
 sound/soc/codecs/cs42l51.c     | 44 +++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/cs42l51.h     |  1 +
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 4b5731a41876..8333dbf18ea2 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -35,12 +35,18 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c,
 	return cs42l51_probe(&i2c->dev, devm_regmap_init_i2c(i2c, &config));
 }
 
+static int cs42l51_i2c_remove(struct i2c_client *i2c)
+{
+	return cs42l51_remove(&i2c->dev);
+}
+
 static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
 		.name = "cs42l51",
 		.of_match_table = cs42l51_of_match,
 	},
 	.probe = cs42l51_i2c_probe,
+	.remove = cs42l51_i2c_remove,
 	.id_table = cs42l51_i2c_id,
 };
 
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 80da3cd73e04..f43eb51d2d8d 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -31,6 +31,7 @@
 #include <sound/pcm_params.h>
 #include <sound/pcm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "cs42l51.h"
 
@@ -40,11 +41,19 @@ enum master_slave_mode {
 	MODE_MASTER,
 };
 
+static const char * const cs42l51_supply_names[] = {
+	"VL",
+	"VD",
+	"VA",
+	"VAHP",
+};
+
 struct cs42l51_private {
 	unsigned int mclk;
 	struct clk *mclk_handle;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(cs42l51_supply_names)];
 };
 
 #define CS42L51_FORMATS ( \
@@ -550,7 +559,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 {
 	struct cs42l51_private *cs42l51;
 	unsigned int val;
-	int ret;
+	int ret, i;
 
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -569,6 +578,23 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		cs42l51->mclk_handle = NULL;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(cs42l51->supplies); i++)
+		cs42l51->supplies[i].supply = cs42l51_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(cs42l51->supplies),
+				      cs42l51->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l51->supplies),
+				    cs42l51->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
@@ -587,11 +613,27 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	ret = devm_snd_soc_register_component(dev,
 			&soc_component_device_cs42l51, &cs42l51_dai, 1);
+	if (ret < 0)
+		goto error;
+
+	return 0;
+
 error:
+	regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
+			       cs42l51->supplies);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cs42l51_probe);
 
+int cs42l51_remove(struct device *dev)
+{
+	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
+
+	return regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
+				      cs42l51->supplies);
+}
+EXPORT_SYMBOL_GPL(cs42l51_remove);
+
 const struct of_device_id cs42l51_of_match[] = {
 	{ .compatible = "cirrus,cs42l51", },
 	{ }
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 0ca805492ac4..aef0ede82c7b 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -22,6 +22,7 @@ struct device;
 
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
+int cs42l51_remove(struct device *dev);
 extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
-- 
2.7.4
