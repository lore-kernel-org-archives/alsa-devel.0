From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 2/2] ASoC: AMD: Enable/Disable auxiliary clock
	via common clock framework
Date: Fri, 30 Mar 2018 15:34:57 +0530
Message-ID: <1522404297-7555-2-git-send-email-akshu.agrawal@amd.com>
References: <1522404297-7555-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0044.outbound.protection.outlook.com [104.47.34.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 983702671F9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 12:05:20 +0200 (CEST)
In-Reply-To: <1522404297-7555-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, lgirdwood@gmail.com, djkurtz@chromium.org, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

This enables/disables and sets auxiliary clock at 25Mhz. It uses
common clock framework for proper ref counting. This approach will
save power in comparison to keeping it always On in firmware.

TEST= aplay -vv <file>
check register to see clock enabled
kill aplay
check register to see clock disabled

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
V2: Correcting the pin to OSCOUT1 from OSCOUT2
V3: Fix error/warnings from kbuild test
V4: Fix build errors for platform which do not support CONFIG_COMMON_CLK
V5: Review comments by Dan and Sriram

 sound/soc/amd/acp-da7219-max98357a.c | 159 ++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index d9491e1..9e649c3 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -30,19 +30,41 @@
 #include <sound/soc-dapm.h>
 #include <sound/jack.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
+#include <linux/types.h>
 
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 24000000
+#define CZ_PLAT_CLK 25000000
 #define MCLK_RATE 24576000
 #define DUAL_CHANNEL		2
 
+/* Clock Driving Strength 2 register */
+#define CLKDRVSTR2	0x28
+/* Clock Control 1 register */
+#define MISCCLKCNTL1	0x40
+/* Auxiliary clock1 enable bit */
+#define OSCCLKENB	2
+/* 25Mhz auxiliary output clock freq bit */
+#define OSCOUT1CLK25MHZ	16
+
+struct cz_clock {
+	const char* acp_clks_name;
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw acp_clks_hw;
+#endif
+	struct clk_lookup *acp_clks_lookup;
+	struct clk *acp_clks;
+	void __iomem *res_base;
+};
+
 static struct snd_soc_jack cz_jack;
 struct clk *da7219_dai_clk;
 
@@ -98,6 +120,8 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct clk *acpd7219_clk;
 
 	ret = clk_prepare_enable(da7219_dai_clk);
 	if (ret < 0) {
@@ -105,13 +129,37 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	acpd7219_clk = clk_get(card->dev, "acpd7219-clks");
+	if (IS_ERR(acpd7219_clk)) {
+		dev_err(rtd->dev, "failed to get clock: %ld\n",
+			PTR_ERR(acpd7219_clk));
+		return PTR_ERR(acpd7219_clk);
+	}
+
+	ret = clk_prepare_enable(acpd7219_clk);
+	if (ret < 0)
+		dev_err(rtd->dev, "can't enable oscillator clock %d\n", ret);
+
 	return ret;
 }
 
 static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct clk *acpd7219_clk;
+
 	clk_disable_unprepare(da7219_dai_clk);
 
+	acpd7219_clk = clk_get(card->dev, "acpd7219-clks");
+	if (IS_ERR(acpd7219_clk)) {
+		dev_err(rtd->dev, "failed to get clock: %ld\n",
+			PTR_ERR(acpd7219_clk));
+		return PTR_ERR(acpd7219_clk);
+	}
+
+	clk_disable_unprepare(acpd7219_clk);
+
 	return 0;
 }
 
@@ -244,6 +292,112 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
 
+#ifdef CONFIG_COMMON_CLK
+static int acpd7219_clks_enable(struct clk_hw *hw)
+{
+	u32 reg_val;
+	struct cz_clock *cz_clock_obj =
+		container_of(hw, struct cz_clock, acp_clks_hw);
+	void __iomem *base = cz_clock_obj->res_base;
+
+	reg_val = readl(base + MISCCLKCNTL1);
+	reg_val &= ~(0x1 << OSCCLKENB);
+	writel(reg_val, base + MISCCLKCNTL1);
+	reg_val = readl(base + CLKDRVSTR2);
+	reg_val |= (0x1 << OSCOUT1CLK25MHZ);
+	writel(reg_val, base + CLKDRVSTR2);
+
+	return 0;
+}
+
+static void acpd7219_clks_disable(struct clk_hw *hw)
+{
+	u32 reg_val;
+	struct cz_clock *cz_clock_obj =
+		container_of(hw, struct cz_clock, acp_clks_hw);
+	void __iomem *base = cz_clock_obj->res_base;
+
+	reg_val = readl(base + MISCCLKCNTL1);
+	reg_val |= (0x1 << OSCCLKENB);
+	writel(reg_val, base + MISCCLKCNTL1);
+}
+
+static int acpd7219_clks_is_enabled(struct clk_hw *hw)
+{
+	u32 reg_val;
+	struct cz_clock *cz_clock_obj =
+		container_of(hw, struct cz_clock, acp_clks_hw);
+	void __iomem *base = cz_clock_obj->res_base;
+
+	reg_val = readl(base + MISCCLKCNTL1);
+
+	return !(reg_val & OSCCLKENB);
+}
+
+static const struct clk_ops acpd7219_clks_ops = {
+	.enable = acpd7219_clks_enable,
+	.disable = acpd7219_clks_disable,
+	.is_enabled = acpd7219_clks_is_enabled,
+};
+
+static int register_acpd7219_clocks(struct platform_device *pdev)
+{
+	struct clk *acp_clks;
+	struct clk_lookup *acp_clks_lookup;
+	struct cz_clock *cz_clock_obj;
+	struct resource *res;
+	struct device dev = pdev->dev;
+	static const struct clk_init_data init = {
+		.name = "acpd7219-clks",
+		.ops =  &acpd7219_clks_ops,
+	};
+
+	cz_clock_obj = kzalloc(sizeof(struct cz_clock), GFP_KERNEL);
+	if (!cz_clock_obj)
+		return -ENOMEM;
+
+	cz_clock_obj->acp_clks_name = "acpd7219-clks";
+
+	cz_clock_obj->acp_clks_hw.init = &init;
+
+	acp_clks = devm_clk_register(&dev, &cz_clock_obj->acp_clks_hw);
+	if (IS_ERR(acp_clks))
+	{
+		dev_err(&dev, "Failed to register DAI clocks: %ld\n",
+			 PTR_ERR(acp_clks));
+		return PTR_ERR(acp_clks);
+	}
+	cz_clock_obj->acp_clks = acp_clks;
+
+	acp_clks_lookup = clkdev_create(acp_clks, cz_clock_obj->acp_clks_name,
+					"%s", dev_name(&dev));
+	if (!acp_clks_lookup)
+		dev_warn(&dev, "Failed to create DAI clkdev");
+	else
+		cz_clock_obj->acp_clks_lookup = acp_clks_lookup;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get misc io resource.\n");
+		clkdev_drop(acp_clks_lookup);
+		return -EINVAL;
+	}
+	cz_clock_obj->res_base = devm_ioremap_nocache(&pdev->dev, res->start,
+					resource_size(res));
+	if (!cz_clock_obj->res_base) {
+		clkdev_drop(acp_clks_lookup);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+#else
+static int register_acpd7219_clocks(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif /* CONFIG_COMMON_CLK */
+
 static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -259,7 +413,8 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
-	return 0;
+
+	return register_acpd7219_clocks(pdev);
 }
 
 static const struct acpi_device_id cz_audio_acpi_match[] = {
-- 
1.9.1
