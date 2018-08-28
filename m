From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Implemented safeload support"
	to the asoc tree
Date: Tue, 28 Aug 2018 21:29:57 +0100 (BST)
Message-ID: <20180828202957.87E71440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C33592678E5
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:29:59 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Danny Smith <dannys@axis.com>
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Robert Rosengren <robertr@axis.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau17x1: Implemented safeload support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b0f2d651299f0743818bdadcbe6a67d7869e0da1 Mon Sep 17 00:00:00 2001
From: Danny Smith <dannys@axis.com>
Date: Tue, 21 Aug 2018 13:07:49 +0200
Subject: [PATCH] ASoC: adau17x1: Implemented safeload support

Safeload support has been implemented which is used
when updating for instance filter parameters using
alsa controls. Without safeload support audio can
become distorted during update.

Signed-off-by: Danny Smith <dannys@axis.com>
Signed-off-by: Robert Rosengren <robertr@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau17x1.c | 77 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 57169b8ff14e..c0bc429249fa 100644
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
@@ -326,6 +333,17 @@ bool adau17x1_has_dsp(struct adau *adau)
 }
 EXPORT_SYMBOL_GPL(adau17x1_has_dsp);
 
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
@@ -957,6 +975,56 @@ int adau17x1_resume(struct snd_soc_component *component)
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
@@ -1002,8 +1070,13 @@ int adau17x1_probe(struct device *dev, struct regmap *regmap,
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
2.18.0
