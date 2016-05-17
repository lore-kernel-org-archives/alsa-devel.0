From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: rockchip: Add shared file
 for audio related nodes for veyron boards
Date: Tue, 17 May 2016 10:14:55 +0200
Message-ID: <CAFqH_51XmijOmfY2K1Yxcq1=x8T6m5nC0C5_2Qz-7FVR02HrMA@mail.gmail.com>
References: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
 <1462790795-25345-5-git-send-email-enric.balletbo@collabora.com>
 <1769207.YFf2RsNhBy@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AA7DC26070F
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 10:14:56 +0200 (CEST)
Received: by mail-io0-f193.google.com with SMTP id i75so1952415ioa.2
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 01:14:56 -0700 (PDT)
In-Reply-To: <1769207.YFf2RsNhBy@phil>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Heiko,

2016-05-16 0:06 GMT+02:00 Heiko Stuebner <heiko@sntech.de>:
> Am Montag, 9. Mai 2016, 12:46:34 schrieb Enric Balletbo i Serra:
>> Set i2s block to "okay", add sound node for max98090 with gpios for
>> HP and Mic detect and pinctrl, and add a max98090 device and ts3a227e to
>> the correct i2c bus.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> I only got a "applied" reply from Marks scripts for patch 3/5, so only today
> saw that all 3 actually got applied.
>
> Anyway, I've applied this to my dts32-branch for 4.8 now [0] with some
> modifications regarding
> - the commit subject+message
> - ordering
> - io_domains access (via the phandle now)
> - regulator suspend property
> so maybe take a look and holler if you see a mistake.
>

The changes looks good to me, thanks.

> I was able to get audio over the headphones (so definitly an improvement),
> but so far not over the built-in speakers. Did you need to do something
> special in the configuration for this?
>

I added an UCM file [1] to my setup to test this and tested as follows
(you can also use alsamixer but as you know this is not safe though ;)
)

# enable the speaker at bootup:
alsaucm -c ROCKCHIP-I2S set _verb HiFi
# set speaker to half loudness:
amixer set Speaker 50%
# play something
aplay music.wav
# enable headphones (disable speaker):
alsaucm -c ROCKCHIP-I2S set _verb HiFi set _enadev Headphone
# set headphones to half loudness:
amixer set Headphone 50%
# play something
aplay music.wav
# disable headphones (enable speaker):
alsaucm -c ROCKCHIP-I2S set _verb HiFi set _disdev Headphone


[1] http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=a192f52fc63a86e1fbb9a09adb0bc2a6bbc8dab1

>
> Heiko
>
> [0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=volatile-v4.8-armsoc/dts32&id=1452aee5a7acc03518ef5215dd3dbac4444efe52
>
>> ---
>> Changes since v1:
>>  - None
>>
>>  arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi | 102
>> ++++++++++++++++++++++ 1 file changed, 102 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
>>
>> diff --git a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
>> b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi new file mode 100644
>> index 0000000..f045e1a
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
>> @@ -0,0 +1,102 @@
>> +/*
>> + * Google Veyron (and derivatives) fragment for the  max98090 audio
>> + * codec and analog headphone jack.
>> + *
>> + * Copyright 2016 Google, Inc
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/ {
>> +
>> +     sound {
>> +             compatible = "rockchip,rockchip-audio-max98090";
>> +             rockchip,model = "ROCKCHIP-I2S";
>> +             rockchip,i2s-controller = <&i2s>;
>> +             rockchip,audio-codec = <&max98090>;
>> +             rockchip,hp-det-gpios = <&gpio6 5 GPIO_ACTIVE_HIGH>;
>> +             rockchip,mic-det-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
>> +             rockchip,headset-codec = <&headsetcodec>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&mic_det>, <&hp_det>;
>> +     };
>> +
>> +     io-domains {
>> +             audio-supply = <&vcc18_codec>;
>> +     };
>> +};
>> +
>> +&rk808 {
>> +     vcc10-supply = <&vcc33_sys>;
>> +
>> +     regulators {
>> +             vcc18_codec: LDO_REG6 {
>> +                     regulator-always-on;
>> +                     regulator-boot-on;
>> +                     regulator-min-microvolt = <1800000>;
>> +                     regulator-max-microvolt = <1800000>;
>> +                     regulator-name = "vcc18_codec";
>> +                     regulator-suspend-mem-disabled;
>> +             };
>> +     };
>> +};
>> +
>> +&i2c2 {
>> +     max98090: max98090@10 {
>> +             compatible = "maxim,max98090";
>> +             reg = <0x10>;
>> +             clock-names = "mclk";
>> +             clocks = <&cru SCLK_I2S0_OUT>;
>> +             interrupt-parent = <&gpio6>;
>> +             interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&int_codec>;
>> +     };
>> +};
>> +
>> +&i2c4 {
>> +     headsetcodec: ts3a227e@3b {
>> +             compatible = "ti,ts3a227e";
>> +             reg = <0x3b>;
>> +             interrupt-parent = <&gpio0>;
>> +             interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&ts3a227e_int_l>;
>> +             ti,micbias = <7>;               /* MICBIAS = 2.8V */
>> +     };
>> +};
>> +
>> +&i2s {
>> +     status = "okay";
>> +     clock-names = "i2s_hclk", "i2s_clk";
>> +     clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
>> +};
>> +
>> +&pinctrl {
>> +     codec {
>> +             hp_det: hp-det {
>> +                     rockchip,pins = <6 5 RK_FUNC_GPIO &pcfg_pull_up>;
>> +             };
>> +
>> +             /*
>> +              * HACK: We're going to _pull down_ this _active low_ interrupt
>> +              * so that it never fires.  We don't need this interrupt because
>> +              * we've got a ts3a227e chip but the driver requires it.
>> +              */
>> +             int_codec: int-codec {
>> +                     rockchip,pins = <6 7 RK_FUNC_GPIO &pcfg_pull_down>;
>> +             };
>> +
>> +             mic_det: mic-det {
>> +                     rockchip,pins = <6 11 RK_FUNC_GPIO &pcfg_pull_up>;
>> +             };
>> +     };
>> +
>> +     headset {
>> +             ts3a227e_int_l: ts3a227e-int-l {
>> +                     rockchip,pins = <0 3 RK_FUNC_GPIO &pcfg_pull_up>;
>> +             };
>> +     };
>> +};
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
