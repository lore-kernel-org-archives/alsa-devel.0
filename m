From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/4] ASoC: imx-sgtl5000: Let the code clock
	be a mandatory binding
Date: Wed, 24 Apr 2013 11:54:44 -0300
Message-ID: <1366815286-31820-2-git-send-email-festevam@gmail.com>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f176.google.com (mail-ye0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id A5B1F2610CC
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 16:55:10 +0200 (CEST)
Received: by mail-ye0-f176.google.com with SMTP id m3so256611yen.35
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 07:55:10 -0700 (PDT)
In-Reply-To: <1366815286-31820-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently passing a codec clock is optional.

Make the codec clock to be a required binding in order to simplify codec clock 
handling in imx-sgtl5000.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rebased against Shawn's tree and remove mx53qsb clock fix, as it was already
applied on Shawn's tree
- Confirmed that audio is working on mx51babbage.

 arch/arm/boot/dts/imx51-babbage.dts |   13 ++++++++++++-
 sound/soc/fsl/imx-sgtl5000.c        |   18 ++++++------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 6dd9486..5318d26 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -61,6 +61,16 @@
 		mux-int-port = <2>;
 		mux-ext-port = <3>;
 	};
+
+	clocks {
+		clk_26M: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+			gpios = <&gpio4 26 1>;
+		};
+	};
 };
 
 &esdhc1 {
@@ -229,6 +239,7 @@
 				MX51_PAD_EIM_A27__GPIO2_21   0x5
 				MX51_PAD_CSPI1_SS0__GPIO4_24 0x85
 				MX51_PAD_CSPI1_SS1__GPIO4_25 0x85
+				MX51_PAD_CSPI1_RDY__GPIO4_26 0x80000000
 			>;
 		};
 	};
@@ -255,7 +266,7 @@
 	sgtl5000: codec@0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clock-frequency = <26000000>;
+		clocks = <&clk_26M>;
 		VDDA-supply = <&vdig_reg>;
 		VDDIO-supply = <&vvideo_reg>;
 	};
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index fa308b1..6198ca5 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -130,20 +130,14 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 
 	data->codec_clk = clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(data->codec_clk)) {
-		/* assuming clock enabled by default */
-		data->codec_clk = NULL;
-		ret = of_property_read_u32(codec_np, "clock-frequency",
-					&data->clk_frequency);
-		if (ret) {
-			dev_err(&codec_dev->dev,
-				"clock-frequency missing or invalid\n");
-			goto fail;
-		}
-	} else {
-		data->clk_frequency = clk_get_rate(data->codec_clk);
-		clk_prepare_enable(data->codec_clk);
+		ret = PTR_ERR(data->codec_clk);
+		dev_err(&codec_dev->dev, "could not get codec clk: %d\n", ret);
+		goto fail;
 	}
 
+	data->clk_frequency = clk_get_rate(data->codec_clk);
+	clk_prepare_enable(data->codec_clk);
+
 	data->dai.name = "HiFi";
 	data->dai.stream_name = "HiFi";
 	data->dai.codec_dai_name = "sgtl5000";
-- 
1.7.9.5
