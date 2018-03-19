From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v2 3/3] ASoC: AMD: Enable/Disable auxiliary
	clock via common clock framework
Date: Mon, 19 Mar 2018 13:56:39 +0530
Message-ID: <1521447999-24120-3-git-send-email-akshu.agrawal@amd.com>
References: <1521447999-24120-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0088.outbound.protection.outlook.com [104.47.36.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 44BD82672C0
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 09:42:24 +0100 (CET)
In-Reply-To: <1521447999-24120-1-git-send-email-akshu.agrawal@amd.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, djkurtz@chromium.org, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

This enables/disables and sets auxiliary clock at 25Mhz. It uses
common clock framework for proper ref counting. This approach will
save power in comparison to keeping it always On in firmware.

V2: Correcting the pin to OSCOUT1 from OSCOUT2

TEST= aplay -vv <file>
check register to see clock enabled
kill aplay
check register to see clock disabled

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 133 ++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 99c6b5c..f36b4c2 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>
+#include <linux/types.h>
 
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
@@ -41,6 +42,18 @@
 #define CZ_PLAT_CLK 24000000
 #define MCLK_RATE 24576000
 #define DUAL_CHANNEL		2
+#define CLKDRVSTR2	0x28
+#define MISCCLKCNTL1	0x40
+#define OSCCLKENB	2
+#define OSCOUT1CLK25MHZ	16
+
+struct cz_clock {
+	const char* acp_clks_name;
+	struct clk_hw acp_clks_hw;
+	struct clk_lookup *acp_clks_lookup;
+	struct clk *acp_clks;
+	void __iomem *res_base;
+};
 
 static struct snd_soc_jack cz_jack;
 struct clk *da7219_dai_clk;
@@ -91,6 +104,8 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct clk *acpd7219_clk;
 
 	ret = clk_prepare_enable(da7219_dai_clk);
 	if (ret < 0) {
@@ -98,13 +113,27 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	acpd7219_clk = clk_get(card->dev, "acpd7219-clks");
+	ret = clk_prepare_enable(acpd7219_clk);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't enable oscillator clock %d\n", ret);
+		return ret;
+	}
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
+	clk_disable_unprepare(acpd7219_clk);
+
 	return 0;
 }
 
@@ -237,9 +266,106 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
 
+static int acpd7219_clks_prepare(struct clk_hw *hw)
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
+static void acpd7219_clks_unprepare(struct clk_hw *hw)
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
+const struct clk_ops acpd7219_clks_ops = {
+	.prepare = acpd7219_clks_prepare,
+	.unprepare = acpd7219_clks_unprepare,
+	.is_enabled = acpd7219_clks_is_enabled,
+};
+
+static int register_acpd7219_clocks(struct platform_device *pdev)
+{
+	struct clk_init_data init = {};
+	struct clk *acp_clks;
+	struct clk_lookup *acp_clks_lookup;
+	struct cz_clock *cz_clock_obj;
+	struct resource *res;
+	struct device dev = pdev->dev;
+
+	cz_clock_obj = kzalloc(sizeof(struct cz_clock), GFP_KERNEL);
+	if (!cz_clock_obj)
+		return -ENOMEM;
+
+	cz_clock_obj->acp_clks_name = "acpd7219-clks";
+
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	init.name = cz_clock_obj->acp_clks_name;
+	init.ops = &acpd7219_clks_ops;
+	cz_clock_obj->acp_clks_hw.init = &init;
+
+	acp_clks = devm_clk_register(&dev, &cz_clock_obj->acp_clks_hw);
+	if (IS_ERR(acp_clks))
+	{
+		dev_err(&dev, "Failed to register DAI clocks: %ld\n",
+			 PTR_ERR(acp_clks));
+		return -EINVAL;
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
+		return -EINVAL;
+	}
+	cz_clock_obj->res_base = devm_ioremap_nocache(&pdev->dev, res->start,
+					resource_size(res));
+	if (!cz_clock_obj->res_base)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int cz_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret = 0;
 	struct snd_soc_card *card;
 
 	card = &cz_card;
@@ -252,7 +378,10 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
-	return 0;
+
+	ret = register_acpd7219_clocks(pdev);
+
+	return ret;
 }
 
 static const struct acpi_device_id cz_audio_acpi_match[] = {
-- 
1.9.1
