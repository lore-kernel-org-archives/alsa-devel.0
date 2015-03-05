From: Fabio Estevam <festevam@gmail.com>
Subject: Using simple-audio-card with imx6sl-evk
Date: Thu, 5 Mar 2015 00:07:23 -0300
Message-ID: <CAOMZO5C_-fv8A7kaM42dbskpmr91xkVk-5uTXN6Pe-TxydFo2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C1BF726520E
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 04:07:23 +0100 (CET)
Received: by labge10 with SMTP id ge10so48665615lab.12
 for <alsa-devel@alsa-project.org>; Wed, 04 Mar 2015 19:07:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to get imx6sl-evk to work with simple-audio-card with the
following changes:

 arch/arm/boot/dts/imx6sl-evk.dts | 52 ++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index fda4932..24b9849 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -10,6 +10,7 @@

 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 #include "imx6sl.dtsi"

 / {
@@ -92,19 +93,25 @@
     };

     sound {
-        compatible = "fsl,imx6sl-evk-wm8962", "fsl,imx-audio-wm8962";
-        model = "wm8962-audio";
-        ssi-controller = <&ssi2>;
-        audio-codec = <&codec>;
-        audio-routing =
+        compatible = "simple-audio-card";
+        simple-audio-card,name = "wm8962-audio";
+        simple-audio-card,format = "i2s";
+        simple-audio-card,bitclock-master = <&dailink_master>;
+        simple-audio-card,frame-master = <&dailink_master>;
+        simple-audio-card,widgets =
+            "Headphone", "Headphone Jack";
+        simple-audio-card,routing =
             "Headphone Jack", "HPOUTL",
-            "Headphone Jack", "HPOUTR",
-            "Ext Spk", "SPKOUTL",
-            "Ext Spk", "SPKOUTR",
-            "AMIC", "MICBIAS",
-            "IN3R", "AMIC";
-        mux-int-port = <2>;
-        mux-ext-port = <3>;
+            "Headphone Jack", "HPOUTR";
+
+        simple-audio-card,cpu {
+            sound-dai = <&ssi2>;
+        };
+
+        dailink_master: simple-audio-card,codec {
+            sound-dai = <&codec>;
+        };
     };
 };

@@ -112,6 +119,26 @@
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_audmux3>;
     status = "okay";
+
+    ssi2 {
+        fsl,audmux-port = <1>;
+        fsl,port-config = <
+            (IMX_AUDMUX_V2_PTCR_SYN |
+            IMX_AUDMUX_V2_PTCR_TFSDIR |
+            IMX_AUDMUX_V2_PTCR_TFSEL(2) |
+            IMX_AUDMUX_V2_PTCR_TCLKDIR |
+            IMX_AUDMUX_V2_PTCR_TCSEL(2))
+            IMX_AUDMUX_V2_PDCR_RXDSEL(2)
+        >;
+    };
+
+    audmuxpins3 {
+        fsl,audmux-port = <2>;
+        fsl,port-config = <
+            IMX_AUDMUX_V2_PTCR_SYN
+            IMX_AUDMUX_V2_PDCR_RXDSEL(1)
+        >;
+    };
 };

 &ecspi1 {
@@ -255,6 +282,7 @@
         compatible = "wlf,wm8962";
         reg = <0x1a>;
         clocks = <&clks IMX6SL_CLK_EXTERN_AUDIO>;
+        #sound-dai-cells = <0>;
         DCVDD-supply = <&vgen3_reg>;
         DBVDD-supply = <&reg_aud3v>;
         AVDD-supply = <&vgen3_reg>;


Then I get the following probe error:

[    2.030249] input: WM8962 Beep Generator as
/devices/soc0/soc/2100000.aips-bus/21a4000.i2c/i2c-1/1-001a/input/input1
[    2.042388] wm8962 1-001a: simple-card: set_sysclk error
[    2.047805] asoc-simple-card sound: ASoC: failed to init
202c000.ssi-wm8962: -22
[    2.055242] asoc-simple-card sound: ASoC: failed to instantiate card -22
[    2.065117] asoc-simple-card: probe of sound failed with error -22

I compared how imx-wm8962 calls snd_soc_dai_set_sysclk and did the
same on simple card (quick hack):

--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -134,7 +134,7 @@ static int __asoc_simple_card_dai_init(struct
snd_soc_dai *dai,
        }

        if (set->sysclk) {
-               ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
+               ret = snd_soc_dai_set_sysclk(dai, 1, set->sysclk, 0);
                if (ret && ret != -ENOTSUPP) {
                        dev_err(dai->dev, "simple-card: set_sysclk error\n");
                        goto err;

,and this allows the probe to succeed.

When I try to play I get:

root@freescale /home$ aplay clarinet.wav
[   16.424340] wm8962 1-001a: Unsupported sysclk ratio 680
Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono

and the track is played with the wrong frequency and wrong sysclk ratio.

Any suggestions as to how to use simple-card on this board?

Thanks,

Fabio Estevam
