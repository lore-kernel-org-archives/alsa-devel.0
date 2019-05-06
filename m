From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/2] ASoC: stm32: i2s: manage identification registers
Date: Mon, 6 May 2019 14:54:12 +0200
Message-ID: <1557147252-18679-3-git-send-email-olivier.moysan@st.com>
References: <1557147252-18679-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557147252-18679-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com
Cc: benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add support of identification registers in STM32 I2S.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 60 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 8ee697ff1f86..8846f49b2951 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -16,6 +16,7 @@
  * details.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -37,6 +38,10 @@
 #define STM32_I2S_TXDR_REG	0X20
 #define STM32_I2S_RXDR_REG	0x30
 #define STM32_I2S_CGFR_REG	0X50
+#define STM32_I2S_HWCFGR_REG	0x3F0
+#define STM32_I2S_VERR_REG	0x3F4
+#define STM32_I2S_IPIDR_REG	0x3F8
+#define STM32_I2S_SIDR_REG	0x3FC
 
 /* Bit definition for SPI2S_CR1 register */
 #define I2S_CR1_SPE		BIT(0)
@@ -143,6 +148,23 @@
 #define I2S_CGFR_ODD		BIT(I2S_CGFR_ODD_SHIFT)
 #define I2S_CGFR_MCKOE		BIT(25)
 
+/* Registers below apply to I2S version 1.1 and more */
+
+/* Bit definition for SPI_HWCFGR register */
+#define I2S_HWCFGR_I2S_SUPPORT_MASK	GENMASK(15, 12)
+
+/* Bit definition for SPI_VERR register */
+#define I2S_VERR_MIN_MASK	GENMASK(3, 0)
+#define I2S_VERR_MAJ_MASK	GENMASK(7, 4)
+
+/* Bit definition for SPI_IPIDR register */
+#define I2S_IPIDR_ID_MASK	GENMASK(31, 0)
+
+/* Bit definition for SPI_SIDR register */
+#define I2S_SIDR_ID_MASK	GENMASK(31, 0)
+
+#define I2S_IPIDR_NUMBER	0x00130022
+
 enum i2s_master_mode {
 	I2S_MS_NOT_SET,
 	I2S_MS_MASTER,
@@ -280,6 +302,10 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 	case STM32_I2S_SR_REG:
 	case STM32_I2S_RXDR_REG:
 	case STM32_I2S_CGFR_REG:
+	case STM32_I2S_HWCFGR_REG:
+	case STM32_I2S_VERR_REG:
+	case STM32_I2S_IPIDR_REG:
+	case STM32_I2S_SIDR_REG:
 		return true;
 	default:
 		return false;
@@ -711,10 +737,11 @@ static const struct regmap_config stm32_h7_i2s_regmap_conf = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = STM32_I2S_CGFR_REG,
+	.max_register = STM32_I2S_SIDR_REG,
 	.readable_reg = stm32_i2s_readable_reg,
 	.volatile_reg = stm32_i2s_volatile_reg,
 	.writeable_reg = stm32_i2s_writeable_reg,
+	.num_reg_defaults_raw = STM32_I2S_SIDR_REG / sizeof(u32) + 1,
 	.fast_io = true,
 	.cache_type = REGCACHE_FLAT,
 };
@@ -865,6 +892,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
+	u32 val;
 	int ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
@@ -903,8 +931,34 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Set SPI/I2S in i2s mode */
-	return regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
-				  I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
+	ret = regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
+				 I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(i2s->regmap, STM32_I2S_IPIDR_REG, &val);
+	if (ret)
+		return ret;
+
+	if (val == I2S_IPIDR_NUMBER) {
+		ret = regmap_read(i2s->regmap, STM32_I2S_HWCFGR_REG, &val);
+		if (ret)
+			return ret;
+
+		if (!FIELD_GET(I2S_HWCFGR_I2S_SUPPORT_MASK, val)) {
+			dev_err(&pdev->dev,
+				"Device does not support i2s mode\n");
+			return -EPERM;
+		}
+
+		ret = regmap_read(i2s->regmap, STM32_I2S_VERR_REG, &val);
+
+		dev_dbg(&pdev->dev, "I2S version: %lu.%lu registered\n",
+			FIELD_GET(I2S_VERR_MAJ_MASK, val),
+			FIELD_GET(I2S_VERR_MIN_MASK, val));
+	}
+
+	return ret;
 }
 
 MODULE_DEVICE_TABLE(of, stm32_i2s_ids);
-- 
2.7.4
