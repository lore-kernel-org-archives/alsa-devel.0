From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Testing SAI with mainline
Date: Mon, 7 Mar 2016 17:54:49 -0300
Message-ID: <CAOMZO5BLyouO6VbkR=aUwygSfizd41naR5j92zkmcSKZrKMURQ@mail.gmail.com>
References: <CAOMZO5DnC7NGd1+QPzeaVQ0GMY_yxq3KZBQSAOoj+QKQ8W+HfQ@mail.gmail.com>
 <20160307205109.GA10095@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F4726154F
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 21:54:50 +0100 (CET)
Received: by mail-ig0-f182.google.com with SMTP id vs8so33492233igb.1
 for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2016 12:54:50 -0800 (PST)
In-Reply-To: <20160307205109.GA10095@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 7, 2016 at 5:51 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> Can't access your link.

Here it goes:

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi
b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index f1d3730..28f43b5 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -134,7 +134,7 @@
     sound {
         compatible = "fsl,imx6sx-sdb-wm8962", "fsl,imx-audio-wm8962";
         model = "wm8962-audio";
-        ssi-controller = <&ssi2>;
+        audio-cpu = <&sai1>;
         audio-codec = <&codec>;
         audio-routing =
             "Headphone Jack", "HPOUTL",
@@ -143,15 +143,13 @@
             "Ext Spk", "SPKOUTR",
             "AMIC", "MICBIAS",
             "IN3R", "AMIC";
-        mux-int-port = <2>;
-        mux-ext-port = <6>;
     };
 };

 &audmux {
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_audmux>;
-    status = "okay";
+    status = "disabled";
 };

 &fec1 {
@@ -254,10 +252,22 @@
     status = "okay";
 };

-&ssi2 {
+&sai1 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&pinctrl_sai1>;
     status = "okay";
 };

+&sdma {
+    gpr = <&gpr>;
+    /* SDMA event remap for SAI1 */
+    fsl,sdma-event-remap = <0 15 1>, <0 16 1>;
+};
+
+&ssi2 {
+    status = "disabled";
+};
+
 &uart1 {
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_uart1>;
@@ -468,6 +478,16 @@
             >;
         };

+                pinctrl_sai1: sai1grp {
+                        fsl,pins = <
+                                MX6SX_PAD_CSI_DATA00__SAI1_TX_BCLK     0x130b0
+                                MX6SX_PAD_CSI_DATA01__SAI1_TX_SYNC     0x130b0
+                                MX6SX_PAD_CSI_HSYNC__SAI1_TX_DATA_0    0x120b0
+                                MX6SX_PAD_CSI_VSYNC__SAI1_RX_DATA_0    0x130b0
+                                MX6SX_PAD_CSI_PIXCLK__AUDMUX_MCLK      0x130b0
+                        >;
+                };
+
         pinctrl_uart1: uart1grp {
             fsl,pins = <
                 MX6SX_PAD_GPIO1_IO04__UART1_TX        0x1b0b1
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0f6fd42..01ecb95 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -477,6 +477,24 @@ static struct sdma_driver_data sdma_imx6q = {
     .script_addrs = &sdma_script_imx6q,
 };

+static struct sdma_script_start_addrs sdma_script_imx6sx = {
+    .ap_2_ap_addr = 642,
+    .uart_2_mcu_addr = 817,
+    .mcu_2_app_addr = 747,
+    .uartsh_2_mcu_addr = 1032,
+    .mcu_2_shp_addr = 960,
+    .app_2_mcu_addr = 683,
+    .shp_2_mcu_addr = 891,
+    .spdif_2_mcu_addr = 1100,
+    .mcu_2_spdif_addr = 1134,
+};
+
+static struct sdma_driver_data sdma_imx6sx = {
+    .chnenbl0 = SDMA_CHNENBL0_IMX35,
+    .num_events = 48,
+    .script_addrs = &sdma_script_imx6sx,
+};
+
 static const struct platform_device_id sdma_devtypes[] = {
     {
         .name = "imx25-sdma",
@@ -497,12 +515,16 @@ static const struct platform_device_id sdma_devtypes[] = {
         .name = "imx6q-sdma",
         .driver_data = (unsigned long)&sdma_imx6q,
     }, {
+        .name = "imx6sx-sdma",
+        .driver_data = (unsigned long)&sdma_imx6sx,
+    }, {
         /* sentinel */
     }
 };
 MODULE_DEVICE_TABLE(platform, sdma_devtypes);

 static const struct of_device_id sdma_dt_ids[] = {
+    { .compatible = "fsl,imx6sx-sdma", .data = &sdma_imx6sx, },
     { .compatible = "fsl,imx6q-sdma", .data = &sdma_imx6q, },
     { .compatible = "fsl,imx53-sdma", .data = &sdma_imx53, },
     { .compatible = "fsl,imx51-sdma", .data = &sdma_imx51, },
-- 
1.9.1

> You need a dts patch to configure SDMA channels via GPR. I don't have
> it on hand. May send you after I get home.

Yes, I did that. Thanks
