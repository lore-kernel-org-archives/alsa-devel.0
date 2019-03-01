From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 3/3] arm64: dts: hi3660-hikey960: Add i2s & sound device
Date: Fri, 1 Mar 2019 08:45:47 -0800
Message-ID: <CALAqxLUNG6wyQGVoenTqCU1dD=001hjqMRh=3xEiJsn2BXWWYw@mail.gmail.com>
References: <1551362893-100023-1-git-send-email-lipengcheng8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551362893-100023-1-git-send-email-lipengcheng8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pengcheng Li <lipengcheng8@huawei.com>
Cc: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux-ALSA <alsa-devel@alsa-project.org>, lkml <linux-kernel@vger.kernel.org>, Zhuangluan Su <suzhuangluan@hisilicon.com>, Kongfei <kongfei@hisilicon.com>, Liyuequan <liyuequan@hisilicon.com>, "Qianli (A)" <cash.qianli@hisilicon.com>, "huangli (I)" <huangli295@hisilicon.com>, Hantanglei <hantanglei@huawei.com>, wangyoulin <wangyoulin1@hisilicon.com>, ninggaoyu <ninggaoyu@hisilicon.com>, "xuwei (O)" <xuwei5@huawei.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 28, 2019 at 6:24 AM Pengcheng Li <lipengcheng8@huawei.com> wrote:
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 186251f..457cebc 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -27,6 +27,35 @@
>                 /* rewrite this at bootloader */
>                 reg = <0x0 0x0 0x0 0x0>;
>         };
> +
> +       i2s2: hi3660_i2s {
> +               compatible = "hisilicon,hi3660-i2s-1.0";
> +               reg = <0x0 0xe804f800 0x0 0x400>,
> +                       <0x0 0xe804e000 0x0 0x400>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
> +               dmas = <&asp_dmac 18 &asp_dmac 19>;
> +               dma-names = "rx", "tx";
> +               #sound-dai-cells = <0>;
> +       };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "hikey-hdmi";
> +               simple-audio-card,format = "i2s";
> +
> +               simple-audio-card,bitclock-master = <&sound_master>;
> +               simple-audio-card,frame-master = <&sound_master>;
> +
> +               sound_master: simple-audio-card,cpu {
> +                       sound-dai = <&i2s2>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&adv7533>;
> +               };
> +       };
> +
>  };

Hey Pengcheng,
  Thanks for sending this out!   I've noticed one small issue with
this dts patch compared to the previous iterations.

When building I hit the following errors:
arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts:292.27-294.5:
Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing
property '#sound-dai-cells' in node /soc/i2c@ffd72000/adv7533@39 or
bad phandle (referred from sound-dai[0])

Which seems to us missing the sound-dai-cells addition to the adv7511
node we had the first chunk of the patch here:
https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=4279d58b622acd686b4d17fbf378ace1c467763e

thanks
-john
