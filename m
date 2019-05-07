From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: spdifrx: manage identification registers" to
 the asoc tree
Date: Tue,  7 May 2019 03:32:46 +0100 (BST)
Message-ID: <20190507023246.A64D7440017@finisterre.sirena.org.uk>
References: <1557146646-18150-4-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1557146646-18150-4-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, tiwai@suse.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com, perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: spdifrx: manage identification registers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 1a5c0b28fc56044737f988960f3bc5fdcdba0827 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 6 May 2019 14:44:06 +0200
Subject: [PATCH] ASoC: stm32: spdifrx: manage identification registers

Add support of identification registers in STM32 SPDIFRX.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 37 +++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index b4c3d983e195..62a887ee4a03 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -16,6 +16,7 @@
  * details.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -36,6 +37,9 @@
 #define STM32_SPDIFRX_DR	0x10
 #define STM32_SPDIFRX_CSR	0x14
 #define STM32_SPDIFRX_DIR	0x18
+#define STM32_SPDIFRX_VERR	0x3F4
+#define STM32_SPDIFRX_IDR	0x3F8
+#define STM32_SPDIFRX_SIDR	0x3FC
 
 /* Bit definition for SPDIF_CR register */
 #define SPDIFRX_CR_SPDIFEN_SHIFT	0
@@ -169,6 +173,18 @@
 #define SPDIFRX_SPDIFEN_SYNC	0x1
 #define SPDIFRX_SPDIFEN_ENABLE	0x3
 
+/* Bit definition for SPDIFRX_VERR register */
+#define SPDIFRX_VERR_MIN_MASK	GENMASK(3, 0)
+#define SPDIFRX_VERR_MAJ_MASK	GENMASK(7, 4)
+
+/* Bit definition for SPDIFRX_IDR register */
+#define SPDIFRX_IDR_ID_MASK	GENMASK(31, 0)
+
+/* Bit definition for SPDIFRX_SIDR register */
+#define SPDIFRX_SIDR_SID_MASK	GENMASK(31, 0)
+
+#define SPDIFRX_IPIDR_NUMBER	0x00130041
+
 #define SPDIFRX_IN1		0x1
 #define SPDIFRX_IN2		0x2
 #define SPDIFRX_IN3		0x3
@@ -607,6 +623,9 @@ static bool stm32_spdifrx_readable_reg(struct device *dev, unsigned int reg)
 	case STM32_SPDIFRX_DR:
 	case STM32_SPDIFRX_CSR:
 	case STM32_SPDIFRX_DIR:
+	case STM32_SPDIFRX_VERR:
+	case STM32_SPDIFRX_IDR:
+	case STM32_SPDIFRX_SIDR:
 		return true;
 	default:
 		return false;
@@ -642,10 +661,11 @@ static const struct regmap_config stm32_h7_spdifrx_regmap_conf = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = STM32_SPDIFRX_DIR,
+	.max_register = STM32_SPDIFRX_SIDR,
 	.readable_reg = stm32_spdifrx_readable_reg,
 	.volatile_reg = stm32_spdifrx_volatile_reg,
 	.writeable_reg = stm32_spdifrx_writeable_reg,
+	.num_reg_defaults_raw = STM32_SPDIFRX_SIDR / sizeof(u32) + 1,
 	.fast_io = true,
 	.cache_type = REGCACHE_FLAT,
 };
@@ -911,6 +931,7 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	struct stm32_spdifrx_data *spdifrx;
 	struct reset_control *rst;
 	const struct snd_dmaengine_pcm_config *pcm_config = NULL;
+	u32 ver, idr;
 	int ret;
 
 	spdifrx = devm_kzalloc(&pdev->dev, sizeof(*spdifrx), GFP_KERNEL);
@@ -967,7 +988,19 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	return 0;
+	ret = regmap_read(spdifrx->regmap, STM32_SPDIFRX_IDR, &idr);
+	if (ret)
+		goto error;
+
+	if (idr == SPDIFRX_IPIDR_NUMBER) {
+		ret = regmap_read(spdifrx->regmap, STM32_SPDIFRX_VERR, &ver);
+
+		dev_dbg(&pdev->dev, "SPDIFRX version: %lu.%lu registered\n",
+			FIELD_GET(SPDIFRX_VERR_MAJ_MASK, ver),
+			FIELD_GET(SPDIFRX_VERR_MIN_MASK, ver));
+	}
+
+	return ret;
 
 error:
 	if (!IS_ERR(spdifrx->ctrl_chan))
-- 
2.20.1
