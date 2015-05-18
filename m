From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v2 1/3] ASoC: zx: Add ZTE zx296702 pcm
	support
Date: Mon, 18 May 2015 16:04:30 +0800
Message-ID: <CABymUCNRH13mO0xXBB6tAZokxWhZFE5CxURxpNgoVs+enU240w@mail.gmail.com>
References: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 5259126051D
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 10:04:31 +0200 (CEST)
Received: by lagv1 with SMTP id v1so207183447lag.3
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 01:04:31 -0700 (PDT)
In-Reply-To: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Jun Nie <jun.nie@linaro.org>, ZTE-LT Mailman List <zte-lt@lists.linaro.org>
List-Id: alsa-devel@alsa-project.org

2015-05-06 20:38 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
> This patch adds zx296702 ASoC DMA audio support. It
> handle audio dma based on soc-dmaengine
>
Mark,

Do you have any comments on this patch set? Or you suggest to add HDMI
API calling in the same serial patch? For the HDMI calling, I have no
good idea except direct call currently. Because I need dts hook to
audio driver, while no HDMI call back data can be shared from video
side to audio side in this independent initialization case.

Jun

> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  sound/soc/Kconfig            |  1 +
>  sound/soc/Makefile           |  1 +
>  sound/soc/zte/Kconfig        |  8 ++++++++
>  sound/soc/zte/Makefile       |  1 +
>  sound/soc/zte/zx296702-pcm.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/zte/zx296702-pcm.h |  6 ++++++
>  6 files changed, 63 insertions(+)
>  create mode 100644 sound/soc/zte/Kconfig
>  create mode 100644 sound/soc/zte/Makefile
>  create mode 100644 sound/soc/zte/zx296702-pcm.c
>  create mode 100644 sound/soc/zte/zx296702-pcm.h
>
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index 3ba52da..e2828e1 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -57,6 +57,7 @@ source "sound/soc/tegra/Kconfig"
>  source "sound/soc/txx9/Kconfig"
>  source "sound/soc/ux500/Kconfig"
>  source "sound/soc/xtensa/Kconfig"
> +source "sound/soc/zte/Kconfig"
>
>  # Supported codecs
>  source "sound/soc/codecs/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 974ba70..57bf32d 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_SND_SOC) += tegra/
>  obj-$(CONFIG_SND_SOC)  += txx9/
>  obj-$(CONFIG_SND_SOC)  += ux500/
>  obj-$(CONFIG_SND_SOC)  += xtensa/
> +obj-$(CONFIG_SND_SOC)  += zte/
> diff --git a/sound/soc/zte/Kconfig b/sound/soc/zte/Kconfig
> new file mode 100644
> index 0000000..392ffa6
> --- /dev/null
> +++ b/sound/soc/zte/Kconfig
> @@ -0,0 +1,8 @@
> +config SND_SOC_ZX296702
> +       tristate "SoC Audio for the ZX296702 System-on-Chip"
> +       depends on SOC_ZX296702 || COMPILE_TEST
> +       depends on COMMON_CLK
> +       select SND_SOC_GENERIC_DMAENGINE_PCM
> +       help
> +         Say Y or M here if you want support for SoC audio on ZX296702
> +         chip.
> diff --git a/sound/soc/zte/Makefile b/sound/soc/zte/Makefile
> new file mode 100644
> index 0000000..f2a6af8
> --- /dev/null
> +++ b/sound/soc/zte/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_SND_SOC_ZX296702) += zx296702-pcm.o
> diff --git a/sound/soc/zte/zx296702-pcm.c b/sound/soc/zte/zx296702-pcm.c
> new file mode 100644
> index 0000000..6e1a61a
> --- /dev/null
> +++ b/sound/soc/zte/zx296702-pcm.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (C) 2015 Linaro
> + *
> + * Author: Jun Nie <jun.nie@linaro.org>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/dmaengine_pcm.h>
> +
> +#include "zx296702-pcm.h"
> +
> +static const struct snd_pcm_hardware snd_zx_hardware = {
> +       .info                   = SNDRV_PCM_INFO_MMAP |
> +                                 SNDRV_PCM_INFO_MMAP_VALID |
> +                                 SNDRV_PCM_INFO_INTERLEAVED |
> +                                 SNDRV_PCM_INFO_PAUSE |
> +                                 SNDRV_PCM_INFO_RESUME |
> +                                 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
> +       .period_bytes_min       = 32,
> +       .period_bytes_max       = 16 * 1024,
> +       .periods_min            = 2,
> +       .periods_max            = 32,
> +       .buffer_bytes_max       = 64 * 1024,
> +};
> +
> +static const struct snd_dmaengine_pcm_config zx_dmaengine_pcm_config = {
> +       .prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> +       .pcm_hardware = &snd_zx_hardware,
> +       .prealloc_buffer_size = 64 * 1024,
> +};
> +
> +int zx_pcm_platform_register(struct device *dev)
> +{
> +       return devm_snd_dmaengine_pcm_register(dev, &zx_dmaengine_pcm_config,
> +                       0);
> +}
> +EXPORT_SYMBOL_GPL(zx_pcm_platform_register);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/zte/zx296702-pcm.h b/sound/soc/zte/zx296702-pcm.h
> new file mode 100644
> index 0000000..4809a38
> --- /dev/null
> +++ b/sound/soc/zte/zx296702-pcm.h
> @@ -0,0 +1,6 @@
> +#ifndef _ZX_PCM_H
> +#define _ZX_PCM_H
> +
> +int zx_pcm_platform_register(struct device *dev);
> +
> +#endif
> --
> 1.9.1
>
