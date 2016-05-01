From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Sun, 1 May 2016 15:27:33 -0300
Message-ID: <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
 <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
 [209.85.213.171])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC5B2604DF
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2016 20:27:34 +0200 (CEST)
Received: by mail-ig0-f171.google.com with SMTP id bi2so67290453igb.0
 for <alsa-devel@alsa-project.org>; Sun, 01 May 2016 11:27:34 -0700 (PDT)
In-Reply-To: <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 1, 2016 at 11:49 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sat, Apr 30, 2016 at 8:18 AM, Petr Kulhavy <brain@jikos.cz> wrote:
>> Hi,
>>
>> I'm trying to run the latest mainline kernel 4.6 on the iMX6UL EVK. The
>> board mostly works and the only problem is audio.
>> Even though the sound card is detected and the ALSA mixer can be controlled
>> there is no MCLK coming out of the SAI2 interface.
>
> Also, have you tried setting bit 20 (SAI2_MCLK_DIR) of register IOMUXC_GPR_GPR1?
>
> You can set this bit in the bootloader for a quick test.

So I tried it myself and here are the changes I did:

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 7207280..8c20783 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -36,6 +36,23 @@
             enable-active-high;
         };
     };
+
+    sound {
+        compatible = "simple-audio-card";
+        simple-audio-card,name = "mx6ul-evk-sound-card";
+        simple-audio-card,format = "i2s";
+        simple-audio-card,bitclock-master = <&dailink_master>;
+        simple-audio-card,frame-master = <&dailink_master>;
+
+        simple-audio-card,cpu {
+            sound-dai = <&sai2>;
+        };
+
+        dailink_master: simple-audio-card,codec {
+            sound-dai = <&codec>;
+            clocks = <&clks IMX6UL_CLK_SAI2>;
+        };
+    };
 };

 &cpu0 {
@@ -43,6 +60,20 @@
     soc-supply = <&reg_soc>;
 };

+&i2c2 {
+    clock_frequency = <100000>;
+    pinctrl-names = "default";
+    pinctrl-0 = <&pinctrl_i2c2>;
+    status = "okay";
+
+    codec: wm8960@1a {
+        #sound-dai-cells = <0>;
+        compatible = "wlf,wm8960";
+        reg = <0x1a>;
+        wlf,shared-lrclk;
+    };
+};
+
 &fec1 {
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_enet1>;
@@ -86,6 +117,18 @@
     };
 };

+&sai2 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&pinctrl_sai2>;
+
+    assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+              <&clks IMX6UL_CLK_SAI2>;
+    assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+    assigned-clock-rates = <0>, <12288000>;
+
+    status = "okay";
+};
+
 &snvs_poweroff {
     status = "okay";
 };
@@ -272,6 +315,17 @@
         >;
     };

+    pinctrl_sai2: sai2grp {
+        fsl,pins = <
+            MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK    0x17088
+            MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC    0x17088
+            MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA    0x11088
+            MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA    0x11088
+            MX6UL_PAD_JTAG_TMS__SAI2_MCLK        0x17088
+            MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04    0x17059
+        >;
+    };
+
     pinctrl_pwm1: pwm1grp {
         fsl,pins = <
             MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0
-- 
1.9

also applied: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/sound/soc/codecs/Kconfig?id=465011fc56717f0227d1aa7a99cce000abc614d8

and the codec is probed successfully.

Prior to playing audio I did:
./memtool -32 20E4004=0F560005 (so that bit 20 of register GPR1 is set).

However after running aplay the system hangs.

I also tried NXP kernel 3.14.52 and 4.1.15 and I also get the same
hang after running aplay.

Which NXP kernel did you verify correct audio functionality on mx6ul-evk?
