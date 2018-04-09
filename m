From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v6,
	2/2] ASoC: AMD: Enable/Disable auxiliary clock via common clock
	framework
Date: Mon,  9 Apr 2018 17:19:56 +0800
Message-ID: <1523265596-8837-2-git-send-email-akshu.agrawal@amd.com>
References: <1523265596-8837-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0056.outbound.protection.outlook.com [104.47.38.56])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EA8B266C1C
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 11:20:37 +0200 (CEST)
In-Reply-To: <1523265596-8837-1-git-send-email-akshu.agrawal@amd.com>
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
V6: Adding COMMON_CLK to Kconfig, moving clk_get to register, var name changes

 sound/soc/amd/Kconfig                |   2 +-
 sound/soc/amd/acp-da7219-max98357a.c | 150 +++++++++++++++++++++++++++++++++--
 2 files changed, 146 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf..8104f8f 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -8,7 +8,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
-	depends on SND_SOC_AMD_ACP && I2C
+	depends on SND_SOC_AMD_ACP && I2C && COMMON_CLK
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
 
diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 1012a80..29847f7 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -30,21 +30,42 @@
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
-#define MCLK_RATE 24576000
+#define CZ_PLAT_CLK 25000000
+#define DA7219_PLL_OUT 24576000
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
+	const char* acp_clk_name;
+	struct clk_hw acp_clk_hw;
+	struct clk_lookup *acp_clk_lookup;
+	struct clk *acp_clk;
+	void __iomem *res_base;
+};
+
 static struct snd_soc_jack cz_jack;
-struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_clk;
+static struct clk *acpd7219_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -64,13 +85,18 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
-				  CZ_PLAT_CLK, MCLK_RATE);
+				  CZ_PLAT_CLK, DA7219_PLL_OUT);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 		return ret;
 	}
 
 	da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
+	if (IS_ERR(da7219_dai_clk)) {
+		dev_err(rtd->dev, "failed to get clock: %ld\n",
+			PTR_ERR(da7219_dai_clk));
+		return PTR_ERR(da7219_dai_clk);
+	}
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
@@ -105,13 +131,20 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	ret = clk_prepare_enable(acpd7219_clk);
+	if (ret < 0)
+		dev_err(rtd->dev, "can't enable oscillator clock %d\n", ret);
+
 	return ret;
 }
 
 static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
 {
+
 	clk_disable_unprepare(da7219_dai_clk);
 
+	clk_disable_unprepare(acpd7219_clk);
+
 	return 0;
 }
 
@@ -244,6 +277,112 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
 
+static int acpd7219_clk_enable(struct clk_hw *hw)
+{
+	u32 reg_val;
+	struct cz_clock *cz_clock =
+		container_of(hw, struct cz_clock, acp_clk_hw);
+	void __iomem *base = cz_clock->res_base;
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
+static void acpd7219_clk_disable(struct clk_hw *hw)
+{
+	u32 reg_val;
+	struct cz_clock *cz_clock =
+		container_of(hw, struct cz_clock, acp_clk_hw);
+	void __iomem *base = cz_clock->res_base;
+
+	reg_val = readl(base + MISCCLKCNTL1);
+	reg_val |= (0x1 << OSCCLKENB);
+	writel(reg_val, base + MISCCLKCNTL1);
+}
+
+static int acpd7219_clk_is_enabled(struct clk_hw *hw)
+{
+	u32 reg_val;
+	struct cz_clock *cz_clock =
+		container_of(hw, struct cz_clock, acp_clk_hw);
+	void __iomem *base = cz_clock->res_base;
+
+	reg_val = readl(base + MISCCLKCNTL1);
+
+	return !(reg_val & OSCCLKENB);
+}
+
+static const struct clk_ops acpd7219_clk_ops = {
+	.enable = acpd7219_clk_enable,
+	.disable = acpd7219_clk_disable,
+	.is_enabled = acpd7219_clk_is_enabled,
+};
+
+static int register_acpd7219_clocks(struct platform_device *pdev)
+{
+	struct clk *acp_clk;
+	struct clk_lookup *acp_clk_lookup;
+	struct cz_clock *cz_clock_obj;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	static const struct clk_init_data init = {
+		.name = "acpd7219-clk",
+		.ops =  &acpd7219_clk_ops,
+	};
+
+	cz_clock_obj = kzalloc(sizeof(struct cz_clock), GFP_KERNEL);
+	if (!cz_clock_obj)
+		return -ENOMEM;
+
+	cz_clock_obj->acp_clk_name = "acpd7219-clk";
+
+	cz_clock_obj->acp_clk_hw.init = &init;
+
+	acp_clk = devm_clk_register(dev, &cz_clock_obj->acp_clk_hw);
+	if (IS_ERR(acp_clk))
+	{
+		dev_err(dev, "Failed to register DAI clocks: %ld\n",
+			 PTR_ERR(acp_clk));
+		return PTR_ERR(acp_clk);
+	}
+	cz_clock_obj->acp_clk = acp_clk;
+
+	acp_clk_lookup = clkdev_create(acp_clk, cz_clock_obj->acp_clk_name,
+					"%s", dev_name(dev));
+	if (!acp_clk_lookup)
+		dev_warn(dev, "Failed to create DAI clkdev");
+	else
+		cz_clock_obj->acp_clk_lookup = acp_clk_lookup;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get misc io resource.\n");
+		clkdev_drop(acp_clk_lookup);
+		return -EINVAL;
+	}
+	cz_clock_obj->res_base = devm_ioremap_nocache(&pdev->dev, res->start,
+					resource_size(res));
+	if (!cz_clock_obj->res_base) {
+		clkdev_drop(acp_clk_lookup);
+		return -ENOMEM;
+	}
+
+	acpd7219_clk = devm_clk_get(dev, "acpd7219-clk");
+	if (IS_ERR(acpd7219_clk)) {
+		dev_err(dev, "failed to get acpd7219-clk: %ld\n",
+			PTR_ERR(acpd7219_clk));
+		return PTR_ERR(acpd7219_clk);
+	}
+
+	return 0;
+}
+
 static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -259,7 +398,8 @@ static int cz_probe(struct platform_device *pdev)
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
