From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau: Factor out shared PLL
	configuration code" to the asoc tree
Date: Thu, 09 Jun 2016 18:42:30 +0100
Message-ID: <E1bB3yQ-0003N0-Du@debutante>
References: <1465493946-32594-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2F5B261703
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 19:42:40 +0200 (CEST)
In-Reply-To: <1465493946-32594-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau: Factor out shared PLL configuration code

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0eadaa9ce2aacdcc3cf050d98c25aacabadc557f Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 9 Jun 2016 19:39:06 +0200
Subject: [PATCH] ASoC: adau: Factor out shared PLL configuration code

Multiple devices from the ADAU family share the same PLL structure and
configuration register layout. Introduce a new helper module that can be
used to calculated the PLL configuration registers based on a specified
input frequency and the desired output frequency of the PLL.

The ADAU1761/ADAU1781 and ADAU1373 drivers are updated to make use of this
new helper module. But future drivers for additional devices from the ADAU
family are also expected to make use of it.

In anticipation of sharing more infrastructure code between different
devices from the ADAU family the new module is called adau-utils.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig      |  5 ++++
 sound/soc/codecs/Makefile     |  2 ++
 sound/soc/codecs/adau-utils.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/adau-utils.h |  7 +++++
 sound/soc/codecs/adau1373.c   | 38 +++++++--------------------
 sound/soc/codecs/adau17x1.c   | 38 +++------------------------
 6 files changed, 89 insertions(+), 62 deletions(-)
 create mode 100644 sound/soc/codecs/adau-utils.c
 create mode 100644 sound/soc/codecs/adau-utils.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4d82a58ff6b0..3e215395a199 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -269,8 +269,12 @@ config SND_SOC_AD1980
 config SND_SOC_AD73311
 	tristate
 
+config SND_SOC_ADAU_UTILS
+	tristate
+
 config SND_SOC_ADAU1373
 	tristate
+	select SND_SOC_ADAU_UTILS
 
 config SND_SOC_ADAU1701
 	tristate "Analog Devices ADAU1701 CODEC"
@@ -280,6 +284,7 @@ config SND_SOC_ADAU1701
 config SND_SOC_ADAU17X1
 	tristate
 	select SND_SOC_SIGMADSP_REGMAP
+	select SND_SOC_ADAU_UTILS
 
 config SND_SOC_ADAU1761
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0f548fd34ca3..d61957f2618c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -7,6 +7,7 @@ snd-soc-ad193x-spi-objs := ad193x-spi.o
 snd-soc-ad193x-i2c-objs := ad193x-i2c.o
 snd-soc-ad1980-objs := ad1980.o
 snd-soc-ad73311-objs := ad73311.o
+snd-soc-adau-utils-objs := adau-utils.o
 snd-soc-adau1373-objs := adau1373.o
 snd-soc-adau1701-objs := adau1701.o
 snd-soc-adau17x1-objs := adau17x1.o
@@ -220,6 +221,7 @@ obj-$(CONFIG_SND_SOC_AD193X_SPI)	+= snd-soc-ad193x-spi.o
 obj-$(CONFIG_SND_SOC_AD193X_I2C)	+= snd-soc-ad193x-i2c.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
+obj-$(CONFIG_SND_SOC_ADAU_UTILS)	+= snd-soc-adau-utils.o
 obj-$(CONFIG_SND_SOC_ADAU1373)	+= snd-soc-adau1373.o
 obj-$(CONFIG_SND_SOC_ADAU1701)		+= snd-soc-adau1701.o
 obj-$(CONFIG_SND_SOC_ADAU17X1)		+= snd-soc-adau17x1.o
diff --git a/sound/soc/codecs/adau-utils.c b/sound/soc/codecs/adau-utils.c
new file mode 100644
index 000000000000..19d6a6f41b12
--- /dev/null
+++ b/sound/soc/codecs/adau-utils.c
@@ -0,0 +1,61 @@
+/*
+ * Shared helper functions for devices from the ADAU family
+ *
+ * Copyright 2011-2016 Analog Devices Inc.
+ * Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/gcd.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "adau-utils.h"
+
+int adau_calc_pll_cfg(unsigned int freq_in, unsigned int freq_out,
+	uint8_t regs[5])
+{
+	unsigned int r, n, m, i, j;
+	unsigned int div;
+
+	if (!freq_out) {
+		r = 0;
+		n = 0;
+		m = 0;
+		div = 0;
+	} else {
+		if (freq_out % freq_in != 0) {
+			div = DIV_ROUND_UP(freq_in, 13500000);
+			freq_in /= div;
+			r = freq_out / freq_in;
+			i = freq_out % freq_in;
+			j = gcd(i, freq_in);
+			n = i / j;
+			m = freq_in / j;
+			div--;
+		} else {
+			r = freq_out / freq_in;
+			n = 0;
+			m = 0;
+			div = 0;
+		}
+		if (n > 0xffff || m > 0xffff || div > 3 || r > 8 || r < 2)
+			return -EINVAL;
+	}
+
+	regs[0] = m >> 8;
+	regs[1] = m & 0xff;
+	regs[2] = n >> 8;
+	regs[3] = n & 0xff;
+	regs[4] = (r << 3) | (div << 1);
+	if (m != 0)
+		regs[4] |= 1; /* Fractional mode */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adau_calc_pll_cfg);
+
+MODULE_DESCRIPTION("ASoC ADAU audio CODECs shared helper functions");
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/adau-utils.h b/sound/soc/codecs/adau-utils.h
new file mode 100644
index 000000000000..939b5f37762f
--- /dev/null
+++ b/sound/soc/codecs/adau-utils.h
@@ -0,0 +1,7 @@
+#ifndef SOUND_SOC_CODECS_ADAU_PLL_H
+#define SOUND_SOC_CODECS_ADAU_PLL_H
+
+int adau_calc_pll_cfg(unsigned int freq_in, unsigned int freq_out,
+	uint8_t regs[5]);
+
+#endif
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index fe1353a797b9..1556b360fa15 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -23,6 +23,7 @@
 #include <sound/adau1373.h>
 
 #include "adau1373.h"
+#include "adau-utils.h"
 
 struct adau1373_dai {
 	unsigned int clk_src;
@@ -1254,7 +1255,8 @@ static int adau1373_set_pll(struct snd_soc_codec *codec, int pll_id,
 {
 	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
 	unsigned int dpll_div = 0;
-	unsigned int x, r, n, m, i, j, mode;
+	uint8_t pll_regs[5];
+	int ret;
 
 	switch (pll_id) {
 	case ADAU1373_PLL1:
@@ -1295,27 +1297,8 @@ static int adau1373_set_pll(struct snd_soc_codec *codec, int pll_id,
 		dpll_div++;
 	}
 
-	if (freq_out % freq_in != 0) {
-		/* fout = fin * (r + (n/m)) / x */
-		x = DIV_ROUND_UP(freq_in, 13500000);
-		freq_in /= x;
-		r = freq_out / freq_in;
-		i = freq_out % freq_in;
-		j = gcd(i, freq_in);
-		n = i / j;
-		m = freq_in / j;
-		x--;
-		mode = 1;
-	} else {
-		/* fout = fin / r */
-		r = freq_out / freq_in;
-		n = 0;
-		m = 0;
-		x = 0;
-		mode = 0;
-	}
-
-	if (r < 2 || r > 8 || x > 3 || m > 0xffff || n > 0xffff)
+	ret = adau_calc_pll_cfg(freq_in, freq_out, pll_regs);
+	if (ret)
 		return -EINVAL;
 
 	if (dpll_div) {
@@ -1330,12 +1313,11 @@ static int adau1373_set_pll(struct snd_soc_codec *codec, int pll_id,
 
 	regmap_write(adau1373->regmap, ADAU1373_DPLL_CTRL(pll_id),
 		(source << 4) | dpll_div);
-	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL1(pll_id), (m >> 8) & 0xff);
-	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL2(pll_id), m & 0xff);
-	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL3(pll_id), (n >> 8) & 0xff);
-	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL4(pll_id), n & 0xff);
-	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL5(pll_id),
-		(r << 3) | (x << 1) | mode);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL1(pll_id), pll_regs[0]);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL2(pll_id), pll_regs[1]);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL3(pll_id), pll_regs[2]);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL4(pll_id), pll_regs[3]);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL5(pll_id), pll_regs[4]);
 
 	/* Set sysclk to pll_rate / 4 */
 	regmap_update_bits(adau1373->regmap, ADAU1373_CLK_SRC_DIV(pll_id), 0x3f, 0x09);
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index fcf05b254ecd..66a6e061923d 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -23,6 +23,7 @@
 
 #include "sigmadsp.h"
 #include "adau17x1.h"
+#include "adau-utils.h"
 
 static const char * const adau17x1_capture_mixer_boost_text[] = {
 	"Normal operation", "Boost Level 1", "Boost Level 2", "Boost Level 3",
@@ -391,45 +392,14 @@ static int adau17x1_set_dai_pll(struct snd_soc_dai *dai, int pll_id,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
-	unsigned int r, n, m, i, j;
-	unsigned int div;
 	int ret;
 
 	if (freq_in < 8000000 || freq_in > 27000000)
 		return -EINVAL;
 
-	if (!freq_out) {
-		r = 0;
-		n = 0;
-		m = 0;
-		div = 0;
-	} else {
-		if (freq_out % freq_in != 0) {
-			div = DIV_ROUND_UP(freq_in, 13500000);
-			freq_in /= div;
-			r = freq_out / freq_in;
-			i = freq_out % freq_in;
-			j = gcd(i, freq_in);
-			n = i / j;
-			m = freq_in / j;
-			div--;
-		} else {
-			r = freq_out / freq_in;
-			n = 0;
-			m = 0;
-			div = 0;
-		}
-		if (n > 0xffff || m > 0xffff || div > 3 || r > 8 || r < 2)
-			return -EINVAL;
-	}
-
-	adau->pll_regs[0] = m >> 8;
-	adau->pll_regs[1] = m & 0xff;
-	adau->pll_regs[2] = n >> 8;
-	adau->pll_regs[3] = n & 0xff;
-	adau->pll_regs[4] = (r << 3) | (div << 1);
-	if (m != 0)
-		adau->pll_regs[4] |= 1; /* Fractional mode */
+	ret = adau_calc_pll_cfg(freq_in, freq_out, adau->pll_regs);
+	if (ret < 0)
+		return ret;
 
 	/* The PLL register is 6 bytes long and can only be written at once. */
 	ret = regmap_raw_write(adau->regmap, ADAU17X1_PLL_CONTROL,
-- 
2.8.1
