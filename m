From: Robert Rosengren <robert.rosengren@axis.com>
Subject: [PATCH v2 2/2] ASoC: adau17x1: Implemented safeload
	support
Date: Mon, 13 Aug 2018 09:33:59 +0200
Message-ID: <20180813073359.3374-2-robertr@axis.com>
References: <20180813073359.3374-1-robertr@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 1360526763C
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2018 09:34:11 +0200 (CEST)
In-Reply-To: <20180813073359.3374-1-robertr@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Robert Rosengren <robertr@axis.com>, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

From: Danny Smith <dannys@axis.com>

Safeload support has been implemented which is used
when updating for instance filter parameters using
alsa controls. Without safeload support audio can
become distorted during update.

Signed-off-by: Danny Smith <dannys@axis.com>
Signed-off-by: Robert Rosengren <robertr@axis.com>
---
 sound/soc/codecs/adau17x1.c | 68 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 2f2afb4c0c88..6d0b2261c959 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -26,6 +26,10 @@
 #include "adau17x1.h"
 #include "adau-utils.h"
 
+#define ADAU17X1_SAFELOAD_TARGET_ADDRESS 0x0006
+#define ADAU17X1_SAFELOAD_TRIGGER 0x0007
+#define ADAU17X1_SAFELOAD_DATA(i) (0x0001 + (i))
+
 static const char * const adau17x1_capture_mixer_boost_text[] = {
 	"Normal operation", "Boost Level 1", "Boost Level 2", "Boost Level 3",
 };
@@ -328,6 +332,17 @@ static bool adau17x1_has_dsp(struct adau *adau)
 	}
 }
 
+static bool adau17x1_has_safeload(struct adau *adau)
+{
+	switch (adau->type) {
+	case ADAU1761:
+	case ADAU1781:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int adau17x1_set_dai_pll(struct snd_soc_dai *dai, int pll_id,
 	int source, unsigned int freq_in, unsigned int freq_out)
 {
@@ -958,6 +973,50 @@ int adau17x1_resume(struct snd_soc_component *component)
 }
 EXPORT_SYMBOL_GPL(adau17x1_resume);
 
+static int adau17x1_safeload(struct sigmadsp *sigmadsp, unsigned int addr,
+	const uint8_t bytes[], size_t len)
+{
+	uint8_t buf[4];
+	unsigned int i;
+	int ret;
+
+	/* target address is offset by 1 */
+	unsigned int addr_offset = addr - 1;
+
+	/* write safeload addresses */
+	for (i = 0; i < len / 4; i++) {
+		memcpy(buf, bytes + i * 4, 4);
+		ret = regmap_raw_write(sigmadsp->control_data,
+			ADAU17X1_SAFELOAD_DATA(i), buf, 4);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* write target address */
+	buf[0] = (addr_offset >> 24) & 0xff;
+	buf[1] = (addr_offset >> 16) & 0xff;
+	buf[2] = (addr_offset >> 8) & 0xff;
+	buf[3] = (addr_offset) & 0xff;
+	ret = regmap_raw_write(sigmadsp->control_data,
+		ADAU17X1_SAFELOAD_TARGET_ADDRESS, buf, 4);
+	if (ret < 0)
+		return ret;
+
+	/* write nbr of words to trigger address */
+	buf[0] = 0x00;
+	buf[1] = 0x00;
+	buf[2] = 0x00;
+	buf[3] = i & 0xff;
+	ret = regmap_raw_write(sigmadsp->control_data,
+		ADAU17X1_SAFELOAD_TRIGGER, buf, 4);
+
+	return ret;
+}
+
+static const struct sigmadsp_ops adau17x1_sigmadsp_ops = {
+	.safeload = adau17x1_safeload,
+};
+
 int adau17x1_probe(struct device *dev, struct regmap *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev),
 	const char *firmware_name)
@@ -1003,8 +1062,13 @@ int adau17x1_probe(struct device *dev, struct regmap *regmap,
 	dev_set_drvdata(dev, adau);
 
 	if (firmware_name) {
-		adau->sigmadsp = devm_sigmadsp_init_regmap(dev, regmap, NULL,
-			firmware_name);
+		if (adau17x1_has_safeload(adau)) {
+			adau->sigmadsp = devm_sigmadsp_init_regmap(dev, regmap,
+				&adau17x1_sigmadsp_ops, firmware_name);
+		} else {
+			adau->sigmadsp = devm_sigmadsp_init_regmap(dev, regmap,
+				NULL, firmware_name);
+		}
 		if (IS_ERR(adau->sigmadsp)) {
 			dev_warn(dev, "Could not find firmware file: %ld\n",
 				PTR_ERR(adau->sigmadsp));
-- 
2.11.0
