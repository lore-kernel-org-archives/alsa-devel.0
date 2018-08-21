From: Robert Rosengren <robert.rosengren@axis.com>
Subject: [PATCH v3] ASoC: adau17x1: Implemented safeload support
Date: Tue, 21 Aug 2018 13:07:49 +0200
Message-ID: <20180821110749.14067-1-robertr@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A8E4126766C
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 13:08:26 +0200 (CEST)
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
 sound/soc/codecs/adau17x1.c | 77 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 2f2afb4c0c88..3959e6ad113d 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -21,11 +21,18 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/regmap.h>
+#include <asm/unaligned.h>
 
 #include "sigmadsp.h"
 #include "adau17x1.h"
 #include "adau-utils.h"
 
+#define ADAU17X1_SAFELOAD_TARGET_ADDRESS 0x0006
+#define ADAU17X1_SAFELOAD_TRIGGER 0x0007
+#define ADAU17X1_SAFELOAD_DATA 0x0001
+#define ADAU17X1_SAFELOAD_DATA_SIZE 20
+#define ADAU17X1_WORD_SIZE 4
+
 static const char * const adau17x1_capture_mixer_boost_text[] = {
 	"Normal operation", "Boost Level 1", "Boost Level 2", "Boost Level 3",
 };
@@ -328,6 +335,17 @@ static bool adau17x1_has_dsp(struct adau *adau)
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
@@ -958,6 +976,56 @@ int adau17x1_resume(struct snd_soc_component *component)
 }
 EXPORT_SYMBOL_GPL(adau17x1_resume);
 
+static int adau17x1_safeload(struct sigmadsp *sigmadsp, unsigned int addr,
+	const uint8_t bytes[], size_t len)
+{
+	uint8_t buf[ADAU17X1_WORD_SIZE];
+	uint8_t data[ADAU17X1_SAFELOAD_DATA_SIZE];
+	unsigned int addr_offset;
+	unsigned int nbr_words;
+	int ret;
+
+	/* write data to safeload addresses. Check if len is not a multiple of
+	 * 4 bytes, if so we need to zero pad.
+	 */
+	nbr_words = len / ADAU17X1_WORD_SIZE;
+	if ((len - nbr_words * ADAU17X1_WORD_SIZE) == 0) {
+		ret = regmap_raw_write(sigmadsp->control_data,
+			ADAU17X1_SAFELOAD_DATA, bytes, len);
+	} else {
+		nbr_words++;
+		memset(data, 0, ADAU17X1_SAFELOAD_DATA_SIZE);
+		memcpy(data, bytes, len);
+		ret = regmap_raw_write(sigmadsp->control_data,
+			ADAU17X1_SAFELOAD_DATA, data,
+			nbr_words * ADAU17X1_WORD_SIZE);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	/* Write target address, target address is offset by 1 */
+	addr_offset = addr - 1;
+	put_unaligned_be32(addr_offset, buf);
+	ret = regmap_raw_write(sigmadsp->control_data,
+		ADAU17X1_SAFELOAD_TARGET_ADDRESS, buf, ADAU17X1_WORD_SIZE);
+	if (ret < 0)
+		return ret;
+
+	/* write nbr of words to trigger address */
+	put_unaligned_be32(nbr_words, buf);
+	ret = regmap_raw_write(sigmadsp->control_data,
+		ADAU17X1_SAFELOAD_TRIGGER, buf, ADAU17X1_WORD_SIZE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct sigmadsp_ops adau17x1_sigmadsp_ops = {
+	.safeload = adau17x1_safeload,
+};
+
 int adau17x1_probe(struct device *dev, struct regmap *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev),
 	const char *firmware_name)
@@ -1003,8 +1071,13 @@ int adau17x1_probe(struct device *dev, struct regmap *regmap,
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
