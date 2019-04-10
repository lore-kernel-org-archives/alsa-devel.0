From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/3] sound: Add hikey960 i2s audio driver
Date: Wed, 10 Apr 2019 15:57:21 +0300
Message-ID: <CAEnQRZDWHkWqL=v7PiuiW6-Ke+c0wZrEJ+SeTirdNnTzYdOgeg@mail.gmail.com>
References: <1551362220-99351-1-git-send-email-lipengcheng8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551362220-99351-1-git-send-email-lipengcheng8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pengcheng Li <lipengcheng8@huawei.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, john.stultz@linaro.org, Linux-ALSA <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, suzhuangluan@hisilicon.com, kongfei@hisilicon.com, liyuequan@hisilicon.com, cash.qianli@hisilicon.com, huangli295@hisilicon.com, hantanglei@huawei.com, wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com, xuwei5@huawei.com
List-Id: alsa-devel@alsa-project.org

Hello Pengcheng,

Make sure you run ./scripts/checkpatch.pl --strict yourpatchfile.patch

On Thu, Feb 28, 2019 at 4:15 PM Pengcheng Li <lipengcheng8@huawei.com> wrote:
>
> From: Youlin Wang <wangyoulin1@hisilicon.com>
>
> Add i2s driver for hisi3660 soc found on the hikey960 board.
> Add conpile line in make file.
> Technical support by Guangke Ji.

Care to add here some documentation pointers to I2S IP on the SOC?

> diff --git a/sound/soc/hisilicon/Kconfig b/sound/soc/hisilicon/Kconfig
> index 4356d5a..b023ef9 100644
> --- a/sound/soc/hisilicon/Kconfig
> +++ b/sound/soc/hisilicon/Kconfig
> @@ -1,5 +1,11 @@
>  config SND_I2S_HI6210_I2S
> -       tristate "Hisilicon I2S controller"
> +       tristate "Hisilicon Hi6210 I2S controller"
> +       select SND_SOC_GENERIC_DMAENGINE_PCM
> +       help
> +         Hisilicon I2S

Can you enahance the help text? Something like "I2S controller driver
for hisi3600 SoC"
<snip>

> + * Copyright (c) 2001-2021, Huawei Tech. Co., Ltd.

2021? :) IANAL but this looks strange :).

> +struct hi3660_i2s {
> +       struct device *dev;
> +       struct reset_control *rc;
> +       int clocks;
> +       struct regulator *regu_asp;
> +       struct pinctrl *pctrl;
> +       struct pinctrl_state *pin_default;
> +       struct pinctrl_state *pin_idle;
> +       struct clk *asp_subsys_clk;
> +       struct snd_soc_dai_driver dai;
> +       void __iomem *base;
> +       void __iomem *base_syscon;
> +       phys_addr_t base_phys;
> +       struct snd_dmaengine_dai_dma_data dma_data[2];
> +       spinlock_t lock;

What is this lock used for? Please add some docs.

> +       int rate;
> +       int format;
> +       int bits;
> +       int channels;
> +       u32 master;
> +       u32 status;
> +};
> +
> +static void update_bits(struct hi3660_i2s *i2s, u32 ofs, u32 reset, u32 set)
> +{
> +       u32 val = readl(i2s->base + ofs) & ~reset;
> +
> +       writel(val | set, i2s->base + ofs);
> +}
> +
> +static void update_bits_syscon(struct hi3660_i2s *i2s,
> +                       u32 ofs, u32 reset, u32 set)
> +{
> +       u32 val = readl(i2s->base_syscon + ofs) & ~reset;
> +
> +       writel(val | set, i2s->base_syscon + ofs);
> +}

Look at the snd_soc_component_update_bits. You can make these two
functions following the same
pattern for parameters.
