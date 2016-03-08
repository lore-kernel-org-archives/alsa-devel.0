From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Testing SAI with mainline
Date: Tue, 8 Mar 2016 11:28:33 -0300
Message-ID: <CAOMZO5A57roqkMqC45GqKrtLH2gO0-fyNYhn2zqvJxmvncN_AA@mail.gmail.com>
References: <CAOMZO5DnC7NGd1+QPzeaVQ0GMY_yxq3KZBQSAOoj+QKQ8W+HfQ@mail.gmail.com>
 <20160307205109.GA10095@Asurada-Nvidia>
 <CAOMZO5BLyouO6VbkR=aUwygSfizd41naR5j92zkmcSKZrKMURQ@mail.gmail.com>
 <AM3PR04MB14127296AFC982D9E19226B09AB20@AM3PR04MB1412.eurprd04.prod.outlook.com>
 <CAOMZO5BE6BitKccaYpP5sUf2zfAemUunFqht+Ke_4_Rykva41w@mail.gmail.com>
 <AM3PR04MB14125A5F200B579BAF3C1E299AB20@AM3PR04MB1412.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ED53260524
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 15:28:34 +0100 (CET)
Received: by mail-io0-f173.google.com with SMTP id z76so27598193iof.3
 for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2016 06:28:34 -0800 (PST)
In-Reply-To: <AM3PR04MB14125A5F200B579BAF3C1E299AB20@AM3PR04MB1412.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 8, 2016 at 12:03 AM, Zidan Wang <zidan.wang@nxp.com> wrote:

> IMX_DMATYPE_SAI is 24.

Thanks for the clarification. I have submitted the patches adding SAI
support for mx6sx.

Now I am trying to get SAI to work on mx7d-sdb.

Please see the consolidated changes below. After running audio
playback the system hangs.

Any ideas?

Thanks

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index b267f79..17320a1 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -95,6 +95,30 @@
             regulator-max-microvolt = <1800000>;
         };
     };
+
+    sound {
+        compatible = "simple-audio-card";
+        simple-audio-card,name = "mx7d-sdb-sound-card";
+        simple-audio-card,format = "i2s";
+        simple-audio-card,bitclock-master = <&dailink_master>;
+        simple-audio-card,frame-master = <&dailink_master>;
+
+        simple-audio-card,cpu {
+            sound-dai = <&sai1>;
+        };
+
+        dailink_master: simple-audio-card,codec {
+            sound-dai = <&codec>;
+            clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+        };
+    };
+};
+
+&clks {
+        assigned-clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_SRC>,
+                  <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+        assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+        assigned-clock-rates = <0>, <12288000>;
 };

 &adc1 {
@@ -264,14 +288,23 @@
     status = "okay";

     codec: wm8960@1a {
+        #sound-dai-cells = <0>;
         compatible = "wlf,wm8960";
         reg = <0x1a>;
-        clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
-        clock-names = "mclk";
         wlf,shared-lrclk;
     };
 };

+&sai1 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&pinctrl_sai1>;
+    assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
+              <&clks IMX7D_SAI1_ROOT_CLK>;
+    assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+    assigned-clock-rates = <0>, <36864000>;
+    status = "okay";
+};
+
 &uart1 {
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_uart1>;
@@ -390,6 +423,16 @@
             >;
         };

+        pinctrl_sai1: sai1grp {
+            fsl,pins = <
+                MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
+                MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
+                MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC    0x1f
+                MX7D_PAD_ENET1_COL__SAI1_TX_DATA0    0x30
+                MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0    0x1f
+            >;
+        };
+
         pinctrl_uart1: uart1grp {
             fsl,pins = <
                 MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX    0x79
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b5a50e0..f21b010 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -693,6 +693,20 @@
                 status = "disabled";
             };

+            sai1: sai@308a0000 {
+                #sound-dai-cells = <0>;
+                compatible = "fsl,imx7d-sai";
+                reg = <0x308a0000 0x10000>;
+                interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clks IMX7D_SAI1_IPG_CLK>,
+                    <&clks IMX7D_SAI1_ROOT_CLK>,
+                    <&clks IMX7D_CLK_DUMMY>, <&clks IMX7D_CLK_DUMMY>;
+                clock-names = "bus", "mclk1", "mclk2", "mclk3";
+                dma-names = "rx", "tx";
+                dmas = <&sdma 8 24 0>, <&sdma 9 24 0>;
+                status = "disabled";
+            };
+
             i2c1: i2c@30a20000 {
                 #address-cells = <1>;
                 #size-cells = <0>;
@@ -884,6 +898,17 @@
                 status = "disabled";
             };

+            sdma: sdma@30bd0000 {
+                compatible = "fsl,imx7d-sdma";
+                reg = <0x30bd0000 0x10000>;
+                interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clks IMX7D_SDMA_CORE_CLK>,
+                    <&clks IMX7D_AHB_CHANNEL_ROOT_CLK>;
+                clock-names = "ipg", "ahb";
+                #dma-cells = <3>;
+                fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+            };
+
             fec1: ethernet@30be0000 {
                 compatible = "fsl,imx7d-fec", "fsl,imx6sx-fec";
                 reg = <0x30be0000 0x10000>;
diff --git a/arch/arm/configs/imx_v6_v7_defconfig
b/arch/arm/configs/imx_v6_v7_defconfig
index 978c5de..6e69bf55 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -258,6 +258,7 @@ CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_SND_SOC_FSL_ASOC_CARD=y
 CONFIG_SND_SOC_CS42XX8_I2C=y
 CONFIG_SND_SOC_TLV320AIC3X=y
+CONFIG_SND_SOC_WM8960=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index fbb6a8c..c2f0c85 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -22,6 +22,10 @@

 #include "clk.h"

+static u32 share_count_sai1;
+static u32 share_count_sai2;
+static u32 share_count_sai3;
+
 static struct clk *clks[IMX7D_CLK_END];
 static const char *arm_a7_sel[] = { "osc", "pll_arm_main_clk",
     "pll_enet_500m_clk", "pll_dram_main_clk",
@@ -777,9 +781,12 @@ static void __init imx7d_clocks_init(struct
device_node *ccm_node)
     clks[IMX7D_MIPI_DSI_ROOT_CLK] =
imx_clk_gate2("mipi_dsi_root_clk", "mipi_dsi_post_div", base + 0x4650,
0);
     clks[IMX7D_MIPI_CSI_ROOT_CLK] =
imx_clk_gate2("mipi_csi_root_clk", "mipi_csi_post_div", base + 0x4640,
0);
     clks[IMX7D_MIPI_DPHY_ROOT_CLK] =
imx_clk_gate2("mipi_dphy_root_clk", "mipi_dphy_post_div", base +
0x4660, 0);
-    clks[IMX7D_SAI1_ROOT_CLK] = imx_clk_gate2("sai1_root_clk",
"sai1_post_div", base + 0x48c0, 0);
-    clks[IMX7D_SAI2_ROOT_CLK] = imx_clk_gate2("sai2_root_clk",
"sai2_post_div", base + 0x48d0, 0);
-    clks[IMX7D_SAI3_ROOT_CLK] = imx_clk_gate2("sai3_root_clk",
"sai3_post_div", base + 0x48e0, 0);
+    clks[IMX7D_SAI1_ROOT_CLK] = imx_clk_gate2_shared("sai1_root_clk",
"sai1_post_div", base + 0x48c0, 0, &share_count_sai1);
+    clks[IMX7D_SAI1_IPG_CLK]  = imx_clk_gate2_shared("sai1_ipg_clk",
"ipg_root_clk",  base + 0x48c0, 0, &share_count_sai1);
+    clks[IMX7D_SAI2_ROOT_CLK] = imx_clk_gate2_shared("sai2_root_clk",
"sai2_post_div", base + 0x48d0, 0, &share_count_sai2);
+    clks[IMX7D_SAI2_IPG_CLK]  = imx_clk_gate2_shared("sai2_ipg_clk",
"ipg_root_clk",  base + 0x48d0, 0, &share_count_sai2);
+    clks[IMX7D_SAI3_ROOT_CLK] = imx_clk_gate2_shared("sai3_root_clk",
"sai3_post_div", base + 0x48e0, 0, &share_count_sai3);
+    clks[IMX7D_SAI3_IPG_CLK]  = imx_clk_gate2_shared("sai3_ipg_clk",
"ipg_root_clk",  base + 0x48e0, 0, &share_count_sai3);
     clks[IMX7D_SPDIF_ROOT_CLK] = imx_clk_gate2("spdif_root_clk",
"spdif_post_div", base + 0x44d0, 0);
     clks[IMX7D_ENET1_REF_ROOT_CLK] =
imx_clk_gate2("enet1_ref_root_clk", "enet1_ref_post_div", base +
0x44e0, 0);
     clks[IMX7D_ENET1_TIME_ROOT_CLK] =
imx_clk_gate2("enet1_time_root_clk", "enet1_time_post_div", base +
0x44f0, 0);
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0f6fd42..620849f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -477,6 +477,24 @@ static struct sdma_driver_data sdma_imx6q = {
     .script_addrs = &sdma_script_imx6q,
 };

+static struct sdma_script_start_addrs sdma_script_imx7d = {
+    .ap_2_ap_addr = 644,
+    .uart_2_mcu_addr = 819,
+    .mcu_2_app_addr = 749,
+    .uartsh_2_mcu_addr = 1034,
+    .mcu_2_shp_addr = 962,
+    .app_2_mcu_addr = 685,
+    .shp_2_mcu_addr = 893,
+    .spdif_2_mcu_addr = 1102,
+    .mcu_2_spdif_addr = 1136,
+};
+
+static struct sdma_driver_data sdma_imx7d = {
+    .chnenbl0 = SDMA_CHNENBL0_IMX35,
+    .num_events = 48,
+    .script_addrs = &sdma_script_imx7d,
+};
+
 static const struct platform_device_id sdma_devtypes[] = {
     {
         .name = "imx25-sdma",
@@ -497,6 +515,9 @@ static const struct platform_device_id sdma_devtypes[] = {
         .name = "imx6q-sdma",
         .driver_data = (unsigned long)&sdma_imx6q,
     }, {
+        .name = "imx7d-sdma",
+        .driver_data = (unsigned long)&sdma_imx7d,
+    }, {
         /* sentinel */
     }
 };
@@ -509,6 +530,7 @@ static const struct of_device_id sdma_dt_ids[] = {
     { .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },
     { .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
     { .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
+    { .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
     { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
@@ -1384,6 +1406,7 @@ static void sdma_issue_pending(struct dma_chan *chan)
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1    34
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2    38
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3    41
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4    42

 static void sdma_add_scripts(struct sdma_engine *sdma,
         const struct sdma_script_start_addrs *addr)
@@ -1433,6 +1456,9 @@ static void sdma_load_firmware(const struct
firmware *fw, void *context)
     case 3:
         sdma->script_number = SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3;
         break;
+    case 4:
+        sdma->script_number = SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4;
+        break;
     default:
         dev_err(sdma->dev, "unknown firmware version\n");
         goto err_firmware;
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 649e92a..62d041c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -909,7 +909,8 @@ config SND_SOC_WM8955
     tristate

 config SND_SOC_WM8960
-    tristate
+tristate "Wolfson Microelectronics WM8960 CODEC"
+    depends on I2C

 config SND_SOC_WM8961
     tristate
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 0754df7..b60497c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -797,7 +797,8 @@ static int fsl_sai_probe(struct platform_device *pdev)

     sai->pdev = pdev;

-    if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
+    if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai") ||
+        of_device_is_compatible(pdev->dev.of_node, "fsl,imx7d-sai"))
         sai->sai_on_imx = true;

     sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
@@ -898,6 +899,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 static const struct of_device_id fsl_sai_ids[] = {
     { .compatible = "fsl,vf610-sai", },
     { .compatible = "fsl,imx6sx-sai", },
+    { .compatible = "fsl,imx7d-sai", },
     { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
