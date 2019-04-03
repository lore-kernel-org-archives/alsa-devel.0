From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 3/7] ASoC: cs42l51: add reset management
Date: Wed, 3 Apr 2019 15:23:33 +0200
Message-ID: <1554297817-14154-4-git-send-email-olivier.moysan@st.com>
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

Manage cs42l51 audio codec reset pin.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index f43eb51d2d8d..9b3ffa16b204 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -30,6 +30,7 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/pcm.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -54,6 +55,7 @@ struct cs42l51_private {
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(cs42l51_supply_names)];
+	struct gpio_desc *reset_gpio;
 };
 
 #define CS42L51_FORMATS ( \
@@ -595,6 +597,17 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
+	cs42l51->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(cs42l51->reset_gpio))
+		return PTR_ERR(cs42l51->reset_gpio);
+
+	if (cs42l51->reset_gpio) {
+		dev_dbg(dev, "Release reset gpio\n");
+		gpiod_set_value_cansleep(cs42l51->reset_gpio, 0);
+		mdelay(2);
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
@@ -629,6 +642,8 @@ int cs42l51_remove(struct device *dev)
 {
 	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
 
+	gpiod_set_value_cansleep(cs42l51->reset_gpio, 1);
+
 	return regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
 				      cs42l51->supplies);
 }
-- 
2.7.4
