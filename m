From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Pass the required
	'#sound-dai-cells'
Date: Mon, 12 Mar 2018 18:28:09 -0300
Message-ID: <1520890089-29191-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C4DE267048
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 22:28:31 +0100 (CET)
Received: by mail-qk0-f193.google.com with SMTP id 132so3249010qkd.5
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 14:28:31 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

DTC now warns about missing #sound-dai-cells:
    
arch/arm/boot/dts/imx6ul-geam.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus@2100000/i2c@21a0000/codec@a or bad phandle (referred from sound-dai[0])

Pass the required '#sound-dai-cells' property to improve the documentation.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 060cb4a..9a36c7e 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -5,6 +5,8 @@ Required properties:
 
 - reg : the I2C address of the device
 
+- #sound-dai-cells: must be equal to 0
+
 - clocks : the clock provider of SYS_MCLK
 
 - VDDA-supply : the regulator provider of VDDA
@@ -40,6 +42,7 @@ Example:
 codec: sgtl5000@a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
+	#sound-dai-cells = <0>;
 	clocks = <&clks 150>;
 	micbias-resistor-k-ohms = <2>;
 	micbias-voltage-m-volts = <2250>;
-- 
2.7.4
