From: Petr Kulhavy <brain@jikos.cz>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Sun, 1 May 2016 20:43:41 +0200
Message-ID: <0721dbbe-a122-6be3-743f-669672b2c83f@jikos.cz>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
 <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
 <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep16.mx.upcmail.net (fep16.mx.upcmail.net [62.179.121.36])
 by alsa0.perex.cz (Postfix) with ESMTP id D197D2604DF
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2016 20:43:42 +0200 (CEST)
Received: from edge04.upcmail.net ([192.168.13.239]) by viefep16-int.chello.at
 (InterMail vM.8.01.05.18 201-2260-151-151-20140610) with ESMTP
 id <20160501184342.KRJT14668.viefep16-int.chello.at@edge04.upcmail.net>
 for <alsa-devel@alsa-project.org>; Sun, 1 May 2016 20:43:42 +0200
In-Reply-To: <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org



On 01/05/16 20:27, Fabio Estevam wrote:
> On Sun, May 1, 2016 at 11:49 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Sat, Apr 30, 2016 at 8:18 AM, Petr Kulhavy <brain@jikos.cz> wrote:
>>> Hi,
>>>
>>> I'm trying to run the latest mainline kernel 4.6 on the iMX6UL EVK. The
>>> board mostly works and the only problem is audio.
>>> Even though the sound card is detected and the ALSA mixer can be controlled
>>> there is no MCLK coming out of the SAI2 interface.
>> Also, have you tried setting bit 20 (SAI2_MCLK_DIR) of register IOMUXC_GPR_GPR1?
>>
>> You can set this bit in the bootloader for a quick test.
> So I tried it myself and here are the changes I did:

Hi Fabio,

and did that work for you?
In my DTS file I made a few more changes, see below.

Petr
> diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> index 7207280..8c20783 100644
> --- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> +++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> @@ -36,6 +36,23 @@
>               enable-active-high;
>           };
>       };
> +
> +    sound {
> +        compatible = "simple-audio-card";
> +        simple-audio-card,name = "mx6ul-evk-sound-card";
> +        simple-audio-card,format = "i2s";
> +        simple-audio-card,bitclock-master = <&dailink_master>;
> +        simple-audio-card,frame-master = <&dailink_master>;

                 simple-audio-card,widgets =
                         "Microphone", "Mic Jack",
                         "Line", "Line In",
                         "Line", "Line Out",
                         "Speaker", "Speaker",
                         "Headphone", "Headphone Jack";
                 simple-audio-card,routing =
                         "Headphone Jack", "HP_L",
                         "Headphone Jack", "HP_R",
                         "Speaker", "SPK_LP",
                         "Speaker", "SPK_LN",
                         "Speaker", "SPK_RP",
                         "Speaker", "SPK_RN",

                         "LINPUT1", "Mic Jack",
                         "LINPUT3", "Mic Jack",
                         "RINPUT1", "Mic Jack",
                         "RINPUT2", "Mic Jack";
> +
> +        simple-audio-card,cpu {
> +            sound-dai = <&sai2>;
> +        };
> +
> +        dailink_master: simple-audio-card,codec {
> +            sound-dai = <&codec>;
> +            clocks = <&clks IMX6UL_CLK_SAI2>;
> +        };
> +    };
>   };
>
>   &cpu0 {
> @@ -43,6 +60,20 @@
>       soc-supply = <&reg_soc>;
>   };
>
> +&i2c2 {
> +    clock_frequency = <100000>;
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&pinctrl_i2c2>;
> +    status = "okay";
> +
> +    codec: wm8960@1a {
> +        #sound-dai-cells = <0>;
> +        compatible = "wlf,wm8960";
> +        reg = <0x1a>;
                 clocks = <&clks IMX6UL_CLK_SAI2>;
                 clock-names = "mclk";

> +        wlf,shared-lrclk;
> +    };
> +};
> +
>   &fec1 {
>       pinctrl-names = "default";
>       pinctrl-0 = <&pinctrl_enet1>;
> @@ -86,6 +117,18 @@
>       };
>   };
>
> +&sai2 {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&pinctrl_sai2>;
> +
> +    assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
> +              <&clks IMX6UL_CLK_SAI2>;
> +    assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +    assigned-clock-rates = <0>, <12288000>;
> +
> +    status = "okay";
> +};
> +
>   &snvs_poweroff {
>       status = "okay";
>   };
> @@ -272,6 +315,17 @@
>           >;
>       };
>
> +    pinctrl_sai2: sai2grp {
> +        fsl,pins = <
> +            MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK    0x17088
> +            MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC    0x17088
> +            MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA    0x11088
> +            MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA    0x11088
> +            MX6UL_PAD_JTAG_TMS__SAI2_MCLK        0x17088
> +            MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04    0x17059
> +        >;
> +    };
> +
>       pinctrl_pwm1: pwm1grp {
>           fsl,pins = <
>               MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0
