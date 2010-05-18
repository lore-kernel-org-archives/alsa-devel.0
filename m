From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] NUC900/audio: add nuc900 audio driver support
Date: Tue, 18 May 2010 13:36:54 +0800
Message-ID: <AANLkTinEdWDeirWSdypHD3LBFmtPdMgSqr955X5NwCn0@mail.gmail.com>
References: <4BF01069.6060102@gmail.com>
	<20100517024425.GA2485@opensource.wolfsonmicro.com>
	<4BF0E184.204@gmail.com>
	<20100517134622.GA5257@opensource.wolfsonmicro.com>
	<4BF202A7.30602@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0497894602=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4BF202A7.30602@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: zswan@marvell.com, alsa-devel <alsa-devel@alsa-project.org>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============0497894602==
Content-Type: multipart/alternative; boundary=000e0cd6adeeaa26440486d7ba07

--000e0cd6adeeaa26440486d7ba07
Content-Type: text/plain; charset=UTF-8

Dear sirs,

Submit wrong patch file, drop it.
I will resubmit it.

2010/5/18 Wan ZongShun <mcuos.com@gmail.com>

> Dear Mark,
>
> I have modified some codes according to your comments,
> now I submit the patch as v2 again.
>
> Thanks a lot for your help.
>
> From 35d6ecb61972919a8c7fd418766bd303dde687b3 Mon Sep 17 00:00:00 2001
> From: zswan <zswan@zswan-marvell.(none)>
> Date: Tue, 18 May 2010 10:51:12 +0800
> Subject: [PATCH 3/3] add-nuc900-audio-driver-support-v5.patch
>
> ---
>  sound/soc/Kconfig               |    1 +
>  sound/soc/Makefile              |    1 +
>  sound/soc/nuc900/Kconfig        |   27 +++
>  sound/soc/nuc900/Makefile       |   11 +
>  sound/soc/nuc900/nuc900-ac97.c  |  443
> +++++++++++++++++++++++++++++++++++++++
>  sound/soc/nuc900/nuc900-audio.c |   81 +++++++
>  sound/soc/nuc900/nuc900-auido.h |  121 +++++++++++
>  sound/soc/nuc900/nuc900-pcm.c   |  352 +++++++++++++++++++++++++++++++
>  8 files changed, 1037 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/nuc900/Kconfig
>  create mode 100644 sound/soc/nuc900/Makefile
>  create mode 100644 sound/soc/nuc900/nuc900-ac97.c
>  create mode 100644 sound/soc/nuc900/nuc900-audio.c
>  create mode 100644 sound/soc/nuc900/nuc900-auido.h
>  create mode 100644 sound/soc/nuc900/nuc900-pcm.c
>
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index b1749bc..6e04fc2 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -30,6 +30,7 @@ source "sound/soc/blackfin/Kconfig"
>  source "sound/soc/davinci/Kconfig"
>  source "sound/soc/fsl/Kconfig"
>  source "sound/soc/imx/Kconfig"
> +source "sound/soc/nuc900/Kconfig"
>  source "sound/soc/omap/Kconfig"
>  source "sound/soc/pxa/Kconfig"
>  source "sound/soc/s3c24xx/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 1470141..ccec241 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SND_SOC)   += blackfin/
>  obj-$(CONFIG_SND_SOC)  += davinci/
>  obj-$(CONFIG_SND_SOC)  += fsl/
>  obj-$(CONFIG_SND_SOC)   += imx/
> +obj-$(CONFIG_SND_SOC)  += nuc900/
>  obj-$(CONFIG_SND_SOC)  += omap/
>  obj-$(CONFIG_SND_SOC)  += pxa/
>  obj-$(CONFIG_SND_SOC)  += s3c24xx/
> diff --git a/sound/soc/nuc900/Kconfig b/sound/soc/nuc900/Kconfig
> new file mode 100644
> index 0000000..a0ed1c6
> --- /dev/null
> +++ b/sound/soc/nuc900/KconfigFrom 35d6ecb61972919a8c7fd418766bd303dde687b3
> Mon Sep 17 00:00:00 2001
> From: zswan <zswan@zswan-marvell.(none)>
> Date: Tue, 18 May 2010 10:51:12 +0800
> Subject: [PATCH 3/3] add-nuc900-audio-driver-support-v5.patch
>
> ---
>  sound/soc/Kconfig               |    1 +
>  sound/soc/Makefile              |    1 +
>  sound/soc/nuc900/Kconfig        |   27 +++
>  sound/soc/nuc900/Makefile       |   11 +
>  sound/soc/nuc900/nuc900-ac97.c  |  443
> +++++++++++++++++++++++++++++++++++++++
>  sound/soc/nuc900/nuc900-audio.c |   81 +++++++
>  sound/soc/nuc900/nuc900-auido.h |  121 +++++++++++
>  sound/soc/nuc900/nuc900-pcm.c   |  352 +++++++++++++++++++++++++++++++
>  8 files changed, 1037 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/nuc900/Kconfig
>  create mode 100644 sound/soc/nuc900/Makefile
>  create mode 100644 sound/soc/nuc900/nuc900-ac97.c
>  create mode 100644 sound/soc/nuc900/nuc900-audio.c
>  create mode 100644 sound/soc/nuc900/nuc900-auido.h
>  create mode 100644 sound/soc/nuc900/nuc900-pcm.c
>
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index b1749bc..6e04fc2 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -30,6 +30,7 @@ source "sound/soc/blackfin/Kconfig"
>  source "sound/soc/davinci/Kconfig"
>  source "sound/soc/fsl/Kconfig"
>  source "sound/soc/imx/Kconfig"
> +source "sound/soc/nuc900/Kconfig"
>  source "sound/soc/omap/Kconfig"
>  source "sound/soc/pxa/Kconfig"
>  source "sound/soc/s3c24xx/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 1470141..ccec241 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SND_SOC)   += blackfin/
>  obj-$(CONFIG_SND_SOC)  += davinci/
>  obj-$(CONFIG_SND_SOC)  += fsl/
>  obj-$(CONFIG_SND_SOC)   += imx/
> +obj-$(CONFIG_SND_SOC)  += nuc900/
>  obj-$(CONFIG_SND_SOC)  += omap/
>  obj-$(CONFIG_SND_SOC)  += pxa/
>  obj-$(CONFIG_SND_SOC)  += s3c24xx/
> diff --git a/sound/soc/nuc900/Kconfig b/sound/soc/nuc900/Kconfig
> new file mode 100644
> index 0000000..a0ed1c6
> --- /dev/null
> +++ b/sound/soc/nuc900/Kconfig
> @@ -0,0 +1,27 @@
> +##
> +## NUC900 series AC97 API
> +##
> +config SND_SOC_NUC900
> +       tristate "SoC Audio for NUC900 series"
> +       depends on ARCH_W90X900
> +       help
> +         This option enables support for AC97 mode on the NUC900 SoC.
> +
> +config SND_SOC_NUC900_AC97
> +       tristate
> +       select AC97_BUS
> +       select SND_AC97_CODEC
> +       select SND_SOC_AC97_BUS
> +
> +
> +##
> +## Boards
> +##
> +config SND_SOC_NUC900EVB
> +       tristate "NUC900 AC97 support for demo board"
> +       depends on SND_SOC_NUC900
> +       select SND_SOC_NUC900_AC97
> +       select SND_SOC_AC97_CODEC
> +       help
> +         Select this option to enable audio (AC97) on the
> +         NUC900 demoboard.
> diff --git a/sound/soc/nuc900/Makefile b/sound/soc/nuc900/Makefile
> new file mode 100644
> index 0000000..7e46c71
> --- /dev/null
> +++ b/sound/soc/nuc900/Makefile
> @@ -0,0 +1,11 @@
> +# NUC900 series audio
> +snd-soc-nuc900-pcm-objs := nuc900-pcm.o
> +snd-soc-nuc900-ac97-objs := nuc900-ac97.o
> +
> +obj-$(CONFIG_SND_SOC_NUC900) += snd-soc-nuc900-pcm.o
> +obj-$(CONFIG_SND_SOC_NUC900_AC97) += snd-soc-nuc900-ac97.o
> +
> +# Boards
> +snd-soc-nuc900-audio-objs := nuc900-audio.o
> +
> +obj-$(CONFIG_SND_SOC_NUC900EVB) += snd-soc-nuc900-audio.o
> diff --git a/sound/soc/nuc900/nuc900-ac97.c
> b/sound/soc/nuc900/nuc900-ac97.c
> new file mode 100644
> index 0000000..2c345e2
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -0,0 +1,443 @@
> +/*
> + * Copyright (c) 2009-2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/suspend.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +#include <linux/device.h>
> +#include <linux/clk.h>
> +
> +#include <mach/mfp.h>
> +
> +#include "nuc900-auido.h"
> +
> +static DEFINE_MUTEX(ac97_mutex);
> +struct nuc900_audio *nuc900_ac97_data;
> +
> +static int nuc900_checkready(void)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +       if (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS0) & CODEC_READY))
> +               return -EPERM;
> +
> +       return 0;
> +}
> +
> +/* AC97 controller reads codec register */
> +static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
> +                                       unsigned short reg)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long timeout = 0x10000, val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       val = nuc900_checkready();
> +       if (!!val) {
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +               goto out;
> +       }
> +
> +       /* set the R_WB bit and write register index */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS1, R_WB | reg);
> +
> +       /* set the valid frame bit and valid slots */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       val |= (VALID_FRAME | SLOT1_VALID);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);
> +
> +       udelay(100);
> +
> +       /* polling the AC_R_FINISH */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val &= AC_R_FINISH;
> +       while (!val && timeout--)
> +               mdelay(1);
> +
> +       if (!timeout) {
> +               dev_err(nuc900_audio->dev, "AC97 read register time out
> !\n");
> +               val = -EPERM;
> +               goto out;
> +       }
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0) ;
> +       val &= ~SLOT1_VALID;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);
> +
> +       if (AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS1) >> 2 != reg) {
> +               dev_err(nuc900_audio->dev,
> +                               "R_INDEX of REG_ACTL_ACIS1 not match!\n");
> +       }
> +
> +       udelay(100);
> +       val = (AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS2) & 0xFFFF);
> +
> +out:
> +       mutex_unlock(&ac97_mutex);
> +       return val;
> +}
> +
> +/* AC97 controller writes to codec register */
> +static void nuc900_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
> +                               unsigned short val)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long tmp, timeout = 0x10000;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       tmp = nuc900_checkready();
> +       if (!!tmp)
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +
> +       /* clear the R_WB bit and write register index */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS1, reg);
> +
> +       /* write register value */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS2, val);
> +
> +       /* set the valid frame bit and valid slots */
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       tmp |= SLOT1_VALID | SLOT2_VALID | VALID_FRAME;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +       udelay(100);
> +
> +       /* polling the AC_W_FINISH */
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       tmp &= AC_W_FINISH;
> +       while (tmp && timeout--)
> +               mdelay(1);
> +
> +       if (!timeout)
> +               dev_err(nuc900_audio->dev, "AC97 write register time out
> !\n");
> +
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       tmp &= ~(SLOT1_VALID | SLOT2_VALID);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +}
> +
> +static void nuc900_ac97_warm_reset(struct snd_ac97 *ac97)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* warm reset AC 97 */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val |= AC_W_RES;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       val = nuc900_checkready();
> +       if (!!val)
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +
> +       mutex_unlock(&ac97_mutex);
> +}
> +
> +static void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* reset Audio Controller */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val |= ACTL_RESET_BIT;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val &= (~ACTL_RESET_BIT);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       /* reset AC-link interface */
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val |= AC_RESET;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val &= ~AC_RESET;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       /* cold reset AC 97 */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val |= AC_C_RES;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val &= (~AC_C_RES);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +}
> +
> +/* AC97 controller operations */
> +struct snd_ac97_bus_ops soc_ac97_ops = {
> +       .read           = nuc900_ac97_read,
> +       .write          = nuc900_ac97_write,
> +       .reset          = nuc900_ac97_cold_reset,
> +       .warm_reset     = nuc900_ac97_warm_reset,
> +}
> +EXPORT_SYMBOL_GPL(soc_ac97_ops);
> +
> +static int nuc900_ac97_trigger(struct snd_pcm_substream *substream,
> +                               int cmd, struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       int ret, stype = SUBSTREAM_TYPE(substream);
> +       unsigned long val, tmp;
> +
> +       ret = 0;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +               if (PCM_TX == stype) {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +                       tmp |= (SLOT3_VALID | SLOT4_VALID | VALID_FRAME);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_PSR);
> +                       tmp |= (P_DMA_END_IRQ | P_DMA_MIDDLE_IRQ);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, tmp);
> +                       val |= AC_PLAY;
> +               } else {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_RSR);
> +                       tmp |= (R_DMA_END_IRQ | R_DMA_MIDDLE_IRQ);
> +
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, tmp);
> +                       val |= AC_RECORD;
> +               }
> +
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +               break;
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +               if (PCM_TX == stype) {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +                       tmp &= ~(SLOT3_VALID | SLOT4_VALID);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR,
> RESET_PRSR);
> +                       val &= ~AC_PLAY;
> +               } else {
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR,
> RESET_PRSR);
> +                       val &= ~AC_RECORD;
> +               }
> +
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int nuc900_ac97_probe(struct platform_device *pdev,
> +                                       struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* enable unit clock */
> +       clk_enable(nuc900_audio->clk);
> +
> +       /* enable audio controller and AC-link interface */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val |= (IIS_AC_PIN_SEL | ACLINK_EN);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +       return 0;
> +}
> +
> +static void nuc900_ac97_remove(struct platform_device *pdev,
> +                                               struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +       clk_disable(nuc900_audio->clk);
> +}
> +
> +static struct snd_soc_dai_ops nuc900_ac97_dai_ops = {
> +       .trigger        = nuc900_ac97_trigger,
> +};
> +
> +struct snd_soc_dai nuc900_ac97_dai = {
> +       .name                   = "nuc900-ac97",
> +       .probe                  = nuc900_ac97_probe,
> +       .remove                 = nuc900_ac97_remove,
> +       .ac97_control           = 1,
> +       .playback = {
> +               .rates          = SNDRV_PCM_RATE_8000_48000,
> +               .formats        = SNDRV_PCM_FMTBIT_S16_LE,
> +               .channels_min   = 1,
> +               .channels_max   = 2,
> +       },
> +       .capture = {
> +               .rates          = SNDRV_PCM_RATE_8000_48000,
> +               .formats        = SNDRV_PCM_FMTBIT_S16_LE,
> +               .channels_min   = 1,
> +               .channels_max   = 2,
> +       },
> +       .ops = &nuc900_ac97_dai_ops,
> +}
> +EXPORT_SYMBOL_GPL(nuc900_ac97_dai);
> +
> +static int __devinit nuc900_ac97_drvprobe(struct platform_device *pdev)
> +{
> +       struct nuc900_audio *nuc900_audio;
> +       int ret;
> +
> +       if (nuc900_ac97_data)
> +               return -EBUSY;
> +
> +       nuc900_audio = kzalloc(sizeof(struct nuc900_audio), GFP_KERNEL);
> +       if (!nuc900_audio)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&nuc900_audio->lock);
> +
> +       nuc900_audio->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!nuc900_audio->res) {
> +               ret = -ENODEV;
> +               goto out0;
> +       }
> +
> +       if (!request_mem_region(nuc900_audio->res->start,
> +                       resource_size(nuc900_audio->res), pdev->name)) {
> +               ret = -EBUSY;
> +               goto out0;
> +       }
> +
> +       nuc900_audio->mmio = ioremap(nuc900_audio->res->start,
> +                                       resource_size(nuc900_audio->res));
> +       if (!nuc900_audio->mmio) {
> +               ret = -ENOMEM;
> +               goto out1;
> +       }
> +
> +       nuc900_audio->clk = clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(nuc900_audio->clk)) {
> +               ret = PTR_ERR(nuc900_audio->clk);
> +               goto out2;
> +       }
> +
> +       nuc900_audio->irq_num = platform_get_irq(pdev, 0);
> +       if (!nuc900_audio->irq_num) {
> +               ret = -EBUSY;
> +               goto out2;
> +       }
> +
> +       nuc900_ac97_data = nuc900_audio;
> +
> +       nuc900_audio->dev = nuc900_ac97_dai.dev =  &pdev->dev;
> +
> +       ret = snd_soc_register_dai(&nuc900_ac97_dai);
> +       if (ret)
> +               goto out3;
> +
> +       mfp_set_groupg(nuc900_audio->dev); /* enbale ac97 multifunction
> pin*/
> +
> +       return 0;
> +
> +out3:
> +       clk_put(nuc900_audio->clk);
> +out2:
> +       iounmap(nuc900_audio->mmio);
> +out1:
> +       release_mem_region(nuc900_audio->res->start,
> +                                       resource_size(nuc900_audio->res));
> +out0:
> +       kfree(nuc900_audio);
> +       return ret;
> +}
> +
> +static int __devexit nuc900_ac97_drvremove(struct platform_device *pdev)
> +{
> +
> +       snd_soc_unregister_dai(&nuc900_ac97_dai);
> +
> +       clk_put(nuc900_ac97_data->clk);
> +       iounmap(nuc900_ac97_data->mmio);
> +       release_mem_region(nuc900_ac97_data->res->start,
> +                               resource_size(nuc900_ac97_data->res));
> +
> +       nuc900_ac97_data = NULL;
> +
> +       return 0;
> +}
> +
> +static struct platform_driver nuc900_ac97_driver = {
> +       .driver = {
> +               .name   = "nuc900-audio",
> +               .owner  = THIS_MODULE,
> +       },
> +       .probe          = nuc900_ac97_drvprobe,
> +       .remove         = __devexit_p(nuc900_ac97_drvremove),
> +};
> +
> +static int __init nuc900_ac97_init(void)
> +{
> +       return platform_driver_register(&nuc900_ac97_driver);
> +}
> +
> +static void __exit nuc900_ac97_exit(void)
> +{
> +       platform_driver_unregister(&nuc900_ac97_driver);
> +}
> +
> +module_init(nuc900_ac97_init);
> +module_exit(nuc900_ac97_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("NUC900 AC97 SoC driver!");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:nuc900-ac97");
> +
> diff --git a/sound/soc/nuc900/nuc900-audio.c
> b/sound/soc/nuc900/nuc900-audio.c
> new file mode 100644
> index 0000000..b33d5b8
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-audio.c
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/timer.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#include "../codecs/ac97.h"
> +#include "nuc900-auido.h"
> +
> +static struct snd_soc_dai_link nuc900evb_ac97_dai = {
> +       .name           = "AC97",
> +       .stream_name    = "AC97 HiFi",
> +       .cpu_dai        = &nuc900_ac97_dai,
> +       .codec_dai      = &ac97_dai,
> +};
> +
> +static struct snd_soc_card nuc900evb_audio_machine = {
> +       .name           = "NUC900EVB_AC97",
> +       .dai_link       = &nuc900evb_ac97_dai,
> +       .num_links      = 1,
> +       .platform       = &nuc900_soc_platform,
> +};
> +
> +static struct snd_soc_device nuc900evb_ac97_devdata = {
> +       .card           = &nuc900evb_audio_machine,
> +       .codec_dev      = &soc_codec_dev_ac97,
> +};
> +
> +static struct platform_device *nuc900evb_asoc_dev;
> +
> +static int __init nuc900evb_audio_init(void)
> +{
> +       int ret;
> +
> +       ret = -ENOMEM;
> +       nuc900evb_asoc_dev = platform_device_alloc("soc-audio", -1);
> +       if (!nuc900evb_asoc_dev)
> +               goto out;
> +
> +       /* nuc900 board audio device */
> +       platform_set_drvdata(nuc900evb_asoc_dev, &nuc900evb_ac97_devdata);
> +
> +       nuc900evb_ac97_devdata.dev = &nuc900evb_asoc_dev->dev;
> +       ret = platform_device_add(nuc900evb_asoc_dev);
> +
> +       if (ret) {
> +               platform_device_put(nuc900evb_asoc_dev);
> +               nuc900evb_asoc_dev = NULL;
> +       }
> +
> +out:
> +       return ret;
> +}
> +
> +static void __exit nuc900evb_audio_exit(void)
> +{
> +       platform_device_unregister(nuc900evb_asoc_dev);
> +}
> +
> +module_init(nuc900evb_audio_init);
> +module_exit(nuc900evb_audio_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("NUC900 Series ASoC audio support");
> +MODULE_AUTHOR("Wan ZongShun");
> diff --git a/sound/soc/nuc900/nuc900-auido.h
> b/sound/soc/nuc900/nuc900-auido.h
> new file mode 100644
> index 0000000..95ac4ef
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-auido.h
> @@ -0,0 +1,121 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#ifndef _NUC900_AUDIO_H
> +#define _NUC900_AUDIO_H
> +
> +#include <linux/io.h>
> +
> +/* Audio Control Registers */
> +#define ACTL_CON               0x00
> +#define ACTL_RESET             0x04
> +#define ACTL_RDSTB             0x08
> +#define ACTL_RDST_LENGTH       0x0C
> +#define ACTL_RDSTC             0x10
> +#define ACTL_RSR               0x14
> +#define ACTL_PDSTB             0x18
> +#define ACTL_PDST_LENGTH       0x1C
> +#define ACTL_PDSTC             0x20
> +#define ACTL_PSR               0x24
> +#define ACTL_IISCON            0x28
> +#define ACTL_ACCON             0x2C
> +#define ACTL_ACOS0             0x30
> +#define ACTL_ACOS1             0x34
> +#define ACTL_ACOS2             0x38
> +#define ACTL_ACIS0             0x3C
> +#define ACTL_ACIS1             0x40
> +#define ACTL_ACIS2             0x44
> +#define ACTL_COUNTER           0x48
> +
> +/* bit definition of REG_ACTL_CON register */
> +#define R_DMA_IRQ              0x1000
> +#define T_DMA_IRQ              0x0800
> +#define IIS_AC_PIN_SEL         0x0100
> +#define FIFO_TH                        0x0080
> +#define ADC_EN                 0x0010
> +#define M80_EN                 0x0008
> +#define ACLINK_EN              0x0004
> +#define IIS_EN                 0x0002
> +
> +/* bit definition of REG_ACTL_RESET register */
> +#define W5691_PLAY             0x20000
> +#define ACTL_RESET_BIT         0x10000
> +#define RECORD_RIGHT_CHNNEL    0x08000
> +#define RECORD_LEFT_CHNNEL     0x04000
> +#define PLAY_RIGHT_CHNNEL      0x02000
> +#define PLAY_LEFT_CHNNEL       0x01000
> +#define DAC_PLAY               0x00800
> +#define ADC_RECORD             0x00400
> +#define M80_PLAY               0x00200
> +#define AC_RECORD              0x00100
> +#define AC_PLAY                        0x00080
> +#define IIS_RECORD             0x00040
> +#define IIS_PLAY               0x00020
> +#define DAC_RESET              0x00010
> +#define ADC_RESET              0x00008
> +#define M80_RESET              0x00004
> +#define AC_RESET               0x00002
> +#define IIS_RESET              0x00001
> +
> +/* bit definition of REG_ACTL_ACCON register */
> +#define AC_BCLK_PU_EN          0x20
> +#define AC_R_FINISH            0x10
> +#define AC_W_FINISH            0x08
> +#define AC_W_RES               0x04
> +#define AC_C_RES               0x02
> +
> +/* bit definition of ACTL_RSR register */
> +#define R_FIFO_EMPTY           0x04
> +#define R_DMA_END_IRQ          0x02
> +#define R_DMA_MIDDLE_IRQ       0x01
> +
> +/* bit definition of ACTL_PSR register */
> +#define P_FIFO_EMPTY           0x04
> +#define P_DMA_END_IRQ          0x02
> +#define P_DMA_MIDDLE_IRQ       0x01
> +
> +/* bit definition of ACTL_ACOS0 register */
> +#define SLOT1_VALID            0x01
> +#define SLOT2_VALID            0x02
> +#define SLOT3_VALID            0x04
> +#define SLOT4_VALID            0x08
> +#define VALID_FRAME            0x10
> +
> +/* bit definition of ACTL_ACOS1 register */
> +#define R_WB                   0x80
> +
> +#define CODEC_READY            0x10
> +#define RESET_PRSR             0x00
> +#define AUDIO_WRITE(addr, val) __raw_writel(val, addr)
> +#define AUDIO_READ(addr)       __raw_readl(addr)
> +#define PCM_TX                 0
> +#define PCM_RX                 1
> +#define SUBSTREAM_TYPE(substream) \
> +       ((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX :
> PCM_RX)
> +
> +struct nuc900_audio {
> +       void __iomem *mmio;
> +       spinlock_t lock;
> +       dma_addr_t dma_addr[2];
> +       unsigned long buffersize[2];
> +       unsigned long irq_num;
> +       struct snd_pcm_substream *substream;
> +       struct resource *res;
> +       struct clk *clk;
> +       struct device *dev;
> +
> +};
> +
> +extern struct nuc900_audio *nuc900_ac97_data;
> +extern struct snd_soc_dai nuc900_ac97_dai;
> +extern struct snd_soc_platform nuc900_soc_platform;
> +
> +#endif /*end _NUC900_AUDIO_H */
> diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
> new file mode 100644
> index 0000000..32a503c
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-pcm.c
> @@ -0,0 +1,352 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <mach/hardware.h>
> +
> +#include "nuc900-auido.h"
> +
> +static const struct snd_pcm_hardware nuc900_pcm_hardware = {
> +       .info                   = SNDRV_PCM_INFO_INTERLEAVED |
> +                                       SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +                                       SNDRV_PCM_INFO_MMAP |
> +                                       SNDRV_PCM_INFO_MMAP_VALID |
> +                                       SNDRV_PCM_INFO_PAUSE |
> +                                       SNDRV_PCM_INFO_RESUME,
> +       .formats                = SNDRV_PCM_FMTBIT_S16_LE,
> +       .channels_min           = 1,
> +       .channels_max           = 2,
> +       .buffer_bytes_max       = 4*1024,
> +       .period_bytes_min       = 1*1024,
> +       .period_bytes_max       = 4*1024,
> +       .periods_min            = 1,
> +       .periods_max            = 1024,
> +};
> +
> +static int nuc900_dma_hw_params(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long flags, stype = SUBSTREAM_TYPE(substream);
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&nuc900_audio->lock, flags);
> +
> +       ret = snd_pcm_lib_malloc_pages(substream,
> params_buffer_bytes(params));
> +       if (ret < 0)
> +               return ret;
> +
> +       nuc900_audio->substream = substream;
> +       nuc900_audio->dma_addr[stype] = runtime->dma_addr;
> +       nuc900_audio->buffersize[stype] = params_buffer_bytes(params);
> +
> +       spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> +
> +       return ret;
> +}
> +
> +static void nuc900_update_dma_register(struct snd_pcm_substream
> *substream,
> +                               dma_addr_t dma_addr, size_t count)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       void __iomem *mmio_addr, *mmio_len;
> +
> +       if (SUBSTREAM_TYPE(substream) == PCM_TX) {
> +               mmio_addr = nuc900_audio->mmio + ACTL_PDSTB;
> +               mmio_len = nuc900_audio->mmio + ACTL_PDST_LENGTH;
> +       } else {
> +               mmio_addr = nuc900_audio->mmio + ACTL_RDSTB;
> +               mmio_len = nuc900_audio->mmio + ACTL_RDST_LENGTH;
> +       }
> +
> +       AUDIO_WRITE(mmio_addr, dma_addr);
> +       AUDIO_WRITE(mmio_len, count);
> +}
> +
> +static void nuc900_dma_start(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long val;
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val |= (T_DMA_IRQ | R_DMA_IRQ);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +}
> +
> +static void nuc900_dma_stop(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long val;
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val &= ~(T_DMA_IRQ | R_DMA_IRQ);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +}
> +
> +static irqreturn_t nuc900_dma_interrupt(int irq, void *dev_id)
> +{
> +       struct snd_pcm_substream *substream = dev_id;
> +       struct nuc900_audio *nuc900_audio =
> substream->runtime->private_data;
> +       unsigned long val;
> +
> +       spin_lock(&nuc900_audio->lock);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +
> +       if (val & R_DMA_IRQ) {
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val |
> R_DMA_IRQ);
> +
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RSR);
> +
> +               if (val & R_DMA_MIDDLE_IRQ) {
> +                       val |= R_DMA_MIDDLE_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, val);
> +               }
> +
> +               if (val & R_DMA_END_IRQ) {
> +                       val |= R_DMA_END_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, val);
> +               }
> +       } else if (val & T_DMA_IRQ) {
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val |
> T_DMA_IRQ);
> +
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_PSR);
> +
> +               if (val & P_DMA_MIDDLE_IRQ) {
> +                       val |= P_DMA_MIDDLE_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, val);
> +               }
> +
> +               if (val & P_DMA_END_IRQ) {
> +                       val |= P_DMA_END_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, val);
> +               }
> +       } else {
> +               dev_err(nuc900_audio->dev, "Wrong DMA interrupt
> status!\n");
> +               spin_unlock(&nuc900_audio->lock);
> +               return IRQ_HANDLED;
> +       }
> +
> +       spin_unlock(&nuc900_audio->lock);
> +
> +       snd_pcm_period_elapsed(substream);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int nuc900_dma_hw_free(struct snd_pcm_substream *substream)
> +{
> +       snd_pcm_lib_free_pages(substream);
> +       return 0;
> +}
> +
> +static int nuc900_dma_prepare(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long flags, val, stype = SUBSTREAM_TYPE(substream);;
> +
> +       spin_lock_irqsave(&nuc900_audio->lock, flags);
> +
> +       nuc900_update_dma_register(substream,
> +               nuc900_audio->dma_addr[stype],
> nuc900_audio->buffersize[stype]);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +
> +       switch (runtime->channels) {
> +       case 1:
> +               if (PCM_TX == stype) {
> +                       val &= ~(PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
> +                       val |= PLAY_RIGHT_CHNNEL;
> +               } else {
> +                       val &= ~(RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
> +                       val |= RECORD_RIGHT_CHNNEL;
> +               }
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +               break;
> +       case 2:
> +               if (PCM_TX == stype)
> +                       val |= (PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
> +               else
> +                       val |= (RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> +       return 0;
> +}
> +
> +static int nuc900_dma_trigger(struct snd_pcm_substream *substream, int
> cmd)
> +{
> +       int ret = 0;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               nuc900_dma_start(substream);
> +               break;
> +
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               nuc900_dma_stop(substream);
> +               break;
> +
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +int nuc900_dma_getposition(struct snd_pcm_substream *substream,
> +                                       dma_addr_t *src, dma_addr_t *dst)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +
> +       if (src != NULL)
> +               *src = AUDIO_READ(nuc900_audio->mmio + ACTL_PDSTC);
> +
> +       if (dst != NULL)
> +               *dst = AUDIO_READ(nuc900_audio->mmio + ACTL_RDSTC);
> +
> +       return 0;
> +}
> +
> +static snd_pcm_uframes_t nuc900_dma_pointer(struct snd_pcm_substream
> *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       dma_addr_t src, dst;
> +       unsigned long res;
> +
> +       nuc900_dma_getposition(substream, &src, &dst);
> +
> +       if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +               res = dst - runtime->dma_addr;
> +       else
> +               res = src - runtime->dma_addr;
> +
> +       return bytes_to_frames(substream->runtime, res);
> +}
> +
> +static int nuc900_dma_open(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio;
> +
> +       snd_soc_set_runtime_hwparams(substream, &nuc900_pcm_hardware);
> +
> +       nuc900_audio = nuc900_ac97_data;
> +
> +       if (request_irq(nuc900_audio->irq_num, nuc900_dma_interrupt,
> +                       IRQF_DISABLED, "nuc900-dma", substream))
> +               return -EBUSY;
> +
> +       runtime->private_data = nuc900_audio;
> +
> +       return 0;
> +}
> +
> +static int nuc900_dma_close(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +
> +       free_irq(nuc900_audio->irq_num, substream);
> +
> +       return 0;
> +}
> +
> +static int nuc900_dma_mmap(struct snd_pcm_substream *substream,
> +       struct vm_area_struct *vma)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +       return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +                                       runtime->dma_area,
> +                                       runtime->dma_addr,
> +                                       runtime->dma_bytes);
> +}
> +
> +static struct snd_pcm_ops nuc900_dma_ops = {
> +       .open           = nuc900_dma_open,
> +       .close          = nuc900_dma_close,
> +       .ioctl          = snd_pcm_lib_ioctl,
> +       .hw_params      = nuc900_dma_hw_params,
> +       .hw_free        = nuc900_dma_hw_free,
> +       .prepare        = nuc900_dma_prepare,
> +       .trigger        = nuc900_dma_trigger,
> +       .pointer        = nuc900_dma_pointer,
> +       .mmap           = nuc900_dma_mmap,
> +};
> +
> +static void nuc900_dma_free_dma_buffers(struct snd_pcm *pcm)
> +{
> +       snd_pcm_lib_preallocate_free_for_all(pcm);
> +}
> +
> +static u64 nuc900_pcm_dmamask = DMA_BIT_MASK(32);
> +static int nuc900_dma_new(struct snd_card *card,
> +       struct snd_soc_dai *dai, struct snd_pcm *pcm)
> +{
> +       if (!card->dev->dma_mask)
> +               card->dev->dma_mask = &nuc900_pcm_dmamask;
> +       if (!card->dev->coherent_dma_mask)
> +               card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +
> +       snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
> +               card->dev, 4 * 1024, (4 * 1024) - 1);
> +
> +       return 0;
> +}
> +
> +struct snd_soc_platform nuc900_soc_platform = {
> +       .name           = "nuc900-dma",
> +       .pcm_ops        = &nuc900_dma_ops,
> +       .pcm_new        = nuc900_dma_new,
> +       .pcm_free       = nuc900_dma_free_dma_buffers,
> +}
> +EXPORT_SYMBOL_GPL(nuc900_soc_platform);
> +
> +static int __init nuc900_soc_platform_init(void)
> +{
> +       return snd_soc_register_platform(&nuc900_soc_platform);
> +}
> +
> +static void __exit nuc900_soc_platform_exit(void)
> +{
> +       snd_soc_unregister_platform(&nuc900_soc_platform);
> +}
> +
> +module_init(nuc900_soc_platform_init);
> +module_exit(nuc900_soc_platform_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun, <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("nuc900 Audio DMA module");
> +MODULE_LICENSE("GPL");
> --
> 1.6.3.3
>
> @@ -0,0 +1,27 @@
> +##
> +## NUC900 series AC97 API
> +##
> +config SND_SOC_NUC900
> +       tristate "SoC Audio for NUC900 series"
> +       depends on ARCH_W90X900
> +       help
> +         This option enables support for AC97 mode on the NUC900 SoC.
> +
> +config SND_SOC_NUC900_AC97
> +       tristate
> +       select AC97_BUS
> +       select SND_AC97_CODEC
> +       select SND_SOC_AC97_BUS
> +
> +
> +##
> +## Boards
> +##
> +config SND_SOC_NUC900EVB
> +       tristate "NUC900 AC97 support for demo board"
> +       depends on SND_SOC_NUC900
> +       select SND_SOC_NUC900_AC97
> +       select SND_SOC_AC97_CODEC
> +       help
> +         Select this option to enable audio (AC97) on the
> +         NUC900 demoboard.
> diff --git a/sound/soc/nuc900/Makefile b/sound/soc/nuc900/Makefile
> new file mode 100644
> index 0000000..7e46c71
> --- /dev/null
> +++ b/sound/soc/nuc900/Makefile
> @@ -0,0 +1,11 @@
> +# NUC900 series audio
> +snd-soc-nuc900-pcm-objs := nuc900-pcm.o
> +snd-soc-nuc900-ac97-objs := nuc900-ac97.o
> +
> +obj-$(CONFIG_SND_SOC_NUC900) += snd-soc-nuc900-pcm.o
> +obj-$(CONFIG_SND_SOC_NUC900_AC97) += snd-soc-nuc900-ac97.o
> +
> +# Boards
> +snd-soc-nuc900-audio-objs := nuc900-audio.o
> +
> +obj-$(CONFIG_SND_SOC_NUC900EVB) += snd-soc-nuc900-audio.o
> diff --git a/sound/soc/nuc900/nuc900-ac97.c
> b/sound/soc/nuc900/nuc900-ac97.c
> new file mode 100644
> index 0000000..2c345e2
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -0,0 +1,443 @@
> +/*
> + * Copyright (c) 2009-2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/suspend.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +#include <linux/device.h>
> +#include <linux/clk.h>
> +
> +#include <mach/mfp.h>
> +
> +#include "nuc900-auido.h"
> +
> +static DEFINE_MUTEX(ac97_mutex);
> +struct nuc900_audio *nuc900_ac97_data;
> +
> +static int nuc900_checkready(void)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +       if (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS0) & CODEC_READY))
> +               return -EPERM;
> +
> +       return 0;
> +}
> +
> +/* AC97 controller reads codec register */
> +static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
> +                                       unsigned short reg)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long timeout = 0x10000, val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       val = nuc900_checkready();
> +       if (!!val) {
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +               goto out;
> +       }
> +
> +       /* set the R_WB bit and write register index */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS1, R_WB | reg);
> +
> +       /* set the valid frame bit and valid slots */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       val |= (VALID_FRAME | SLOT1_VALID);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);
> +
> +       udelay(100);
> +
> +       /* polling the AC_R_FINISH */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val &= AC_R_FINISH;
> +       while (!val && timeout--)
> +               mdelay(1);
> +
> +       if (!timeout) {
> +               dev_err(nuc900_audio->dev, "AC97 read register time out
> !\n");
> +               val = -EPERM;
> +               goto out;
> +       }
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0) ;
> +       val &= ~SLOT1_VALID;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);
> +
> +       if (AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS1) >> 2 != reg) {
> +               dev_err(nuc900_audio->dev,
> +                               "R_INDEX of REG_ACTL_ACIS1 not match!\n");
> +       }
> +
> +       udelay(100);
> +       val = (AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS2) & 0xFFFF);
> +
> +out:
> +       mutex_unlock(&ac97_mutex);
> +       return val;
> +}
> +
> +/* AC97 controller writes to codec register */
> +static void nuc900_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
> +                               unsigned short val)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long tmp, timeout = 0x10000;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       tmp = nuc900_checkready();
> +       if (!!tmp)
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +
> +       /* clear the R_WB bit and write register index */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS1, reg);
> +
> +       /* write register value */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS2, val);
> +
> +       /* set the valid frame bit and valid slots */
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       tmp |= SLOT1_VALID | SLOT2_VALID | VALID_FRAME;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +       udelay(100);
> +
> +       /* polling the AC_W_FINISH */
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       tmp &= AC_W_FINISH;
> +       while (tmp && timeout--)
> +               mdelay(1);
> +
> +       if (!timeout)
> +               dev_err(nuc900_audio->dev, "AC97 write register time out
> !\n");
> +
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       tmp &= ~(SLOT1_VALID | SLOT2_VALID);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +}
> +
> +static void nuc900_ac97_warm_reset(struct snd_ac97 *ac97)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* warm reset AC 97 */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val |= AC_W_RES;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       val = nuc900_checkready();
> +       if (!!val)
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +
> +       mutex_unlock(&ac97_mutex);
> +}
> +
> +static void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* reset Audio Controller */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val |= ACTL_RESET_BIT;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val &= (~ACTL_RESET_BIT);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       /* reset AC-link interface */
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val |= AC_RESET;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val &= ~AC_RESET;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       /* cold reset AC 97 */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val |= AC_C_RES;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val &= (~AC_C_RES);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +}
> +
> +/* AC97 controller operations */
> +struct snd_ac97_bus_ops soc_ac97_ops = {
> +       .read           = nuc900_ac97_read,
> +       .write          = nuc900_ac97_write,
> +       .reset          = nuc900_ac97_cold_reset,
> +       .warm_reset     = nuc900_ac97_warm_reset,
> +}
> +EXPORT_SYMBOL_GPL(soc_ac97_ops);
> +
> +static int nuc900_ac97_trigger(struct snd_pcm_substream *substream,
> +                               int cmd, struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       int ret, stype = SUBSTREAM_TYPE(substream);
> +       unsigned long val, tmp;
> +
> +       ret = 0;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +               if (PCM_TX == stype) {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +                       tmp |= (SLOT3_VALID | SLOT4_VALID | VALID_FRAME);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_PSR);
> +                       tmp |= (P_DMA_END_IRQ | P_DMA_MIDDLE_IRQ);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, tmp);
> +                       val |= AC_PLAY;
> +               } else {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_RSR);
> +                       tmp |= (R_DMA_END_IRQ | R_DMA_MIDDLE_IRQ);
> +
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, tmp);
> +                       val |= AC_RECORD;
> +               }
> +
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +               break;
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +               if (PCM_TX == stype) {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +                       tmp &= ~(SLOT3_VALID | SLOT4_VALID);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR,
> RESET_PRSR);
> +                       val &= ~AC_PLAY;
> +               } else {
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR,
> RESET_PRSR);
> +                       val &= ~AC_RECORD;
> +               }
> +
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int nuc900_ac97_probe(struct platform_device *pdev,
> +                                       struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* enable unit clock */
> +       clk_enable(nuc900_audio->clk);
> +
> +       /* enable audio controller and AC-link interface */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val |= (IIS_AC_PIN_SEL | ACLINK_EN);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +       return 0;
> +}
> +
> +static void nuc900_ac97_remove(struct platform_device *pdev,
> +                                               struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +       clk_disable(nuc900_audio->clk);
> +}
> +
> +static struct snd_soc_dai_ops nuc900_ac97_dai_ops = {
> +       .trigger        = nuc900_ac97_trigger,
> +};
> +
> +struct snd_soc_dai nuc900_ac97_dai = {
> +       .name                   = "nuc900-ac97",
> +       .probe                  = nuc900_ac97_probe,
> +       .remove                 = nuc900_ac97_remove,
> +       .ac97_control           = 1,
> +       .playback = {
> +               .rates          = SNDRV_PCM_RATE_8000_48000,
> +               .formats        = SNDRV_PCM_FMTBIT_S16_LE,
> +               .channels_min   = 1,
> +               .channels_max   = 2,
> +       },
> +       .capture = {
> +               .rates          = SNDRV_PCM_RATE_8000_48000,
> +               .formats        = SNDRV_PCM_FMTBIT_S16_LE,
> +               .channels_min   = 1,
> +               .channels_max   = 2,
> +       },
> +       .ops = &nuc900_ac97_dai_ops,
> +}
> +EXPORT_SYMBOL_GPL(nuc900_ac97_dai);
> +
> +static int __devinit nuc900_ac97_drvprobe(struct platform_device *pdev)
> +{
> +       struct nuc900_audio *nuc900_audio;
> +       int ret;
> +
> +       if (nuc900_ac97_data)
> +               return -EBUSY;
> +
> +       nuc900_audio = kzalloc(sizeof(struct nuc900_audio), GFP_KERNEL);
> +       if (!nuc900_audio)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&nuc900_audio->lock);
> +
> +       nuc900_audio->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!nuc900_audio->res) {
> +               ret = -ENODEV;
> +               goto out0;
> +       }
> +
> +       if (!request_mem_region(nuc900_audio->res->start,
> +                       resource_size(nuc900_audio->res), pdev->name)) {
> +               ret = -EBUSY;
> +               goto out0;
> +       }
> +
> +       nuc900_audio->mmio = ioremap(nuc900_audio->res->start,
> +                                       resource_size(nuc900_audio->res));
> +       if (!nuc900_audio->mmio) {
> +               ret = -ENOMEM;
> +               goto out1;
> +       }
> +
> +       nuc900_audio->clk = clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(nuc900_audio->clk)) {
> +               ret = PTR_ERR(nuc900_audio->clk);
> +               goto out2;
> +       }
> +
> +       nuc900_audio->irq_num = platform_get_irq(pdev, 0);
> +       if (!nuc900_audio->irq_num) {
> +               ret = -EBUSY;
> +               goto out2;
> +       }
> +
> +       nuc900_ac97_data = nuc900_audio;
> +
> +       nuc900_audio->dev = nuc900_ac97_dai.dev =  &pdev->dev;
> +
> +       ret = snd_soc_register_dai(&nuc900_ac97_dai);
> +       if (ret)
> +               goto out3;
> +
> +       mfp_set_groupg(nuc900_audio->dev); /* enbale ac97 multifunction
> pin*/
> +
> +       return 0;
> +
> +out3:
> +       clk_put(nuc900_audio->clk);
> +out2:
> +       iounmap(nuc900_audio->mmio);
> +out1:
> +       release_mem_region(nuc900_audio->res->start,
> +                                       resource_size(nuc900_audio->res));
> +out0:
> +       kfree(nuc900_audio);
> +       return ret;
> +}
> +
> +static int __devexit nuc900_ac97_drvremove(struct platform_device *pdev)
> +{
> +
> +       snd_soc_unregister_dai(&nuc900_ac97_dai);
> +
> +       clk_put(nuc900_ac97_data->clk);
> +       iounmap(nuc900_ac97_data->mmio);
> +       release_mem_region(nuc900_ac97_data->res->start,
> +                               resource_size(nuc900_ac97_data->res));
> +
> +       nuc900_ac97_data = NULL;
> +
> +       return 0;
> +}
> +
> +static struct platform_driver nuc900_ac97_driver = {
> +       .driver = {
> +               .name   = "nuc900-audio",
> +               .owner  = THIS_MODULE,
> +       },
> +       .probe          = nuc900_ac97_drvprobe,
> +       .remove         = __devexit_p(nuc900_ac97_drvremove),
> +};
> +
> +static int __init nuc900_ac97_init(void)
> +{
> +       return platform_driver_register(&nuc900_ac97_driver);
> +}
> +
> +static void __exit nuc900_ac97_exit(void)
> +{
> +       platform_driver_unregister(&nuc900_ac97_driver);
> +}
> +
> +module_init(nuc900_ac97_init);
> +module_exit(nuc900_ac97_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("NUC900 AC97 SoC driver!");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:nuc900-ac97");
> +
> diff --git a/sound/soc/nuc900/nuc900-audio.c
> b/sound/soc/nuc900/nuc900-audio.c
> new file mode 100644
> index 0000000..b33d5b8
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-audio.c
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/timer.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#include "../codecs/ac97.h"
> +#include "nuc900-auido.h"
> +
> +static struct snd_soc_dai_link nuc900evb_ac97_dai = {
> +       .name           = "AC97",
> +       .stream_name    = "AC97 HiFi",
> +       .cpu_dai        = &nuc900_ac97_dai,
> +       .codec_dai      = &ac97_dai,
> +};
> +
> +static struct snd_soc_card nuc900evb_audio_machine = {
> +       .name           = "NUC900EVB_AC97",
> +       .dai_link       = &nuc900evb_ac97_dai,
> +       .num_links      = 1,
> +       .platform       = &nuc900_soc_platform,
> +};
> +
> +static struct snd_soc_device nuc900evb_ac97_devdata = {
> +       .card           = &nuc900evb_audio_machine,
> +       .codec_dev      = &soc_codec_dev_ac97,
> +};
> +
> +static struct platform_device *nuc900evb_asoc_dev;
> +
> +static int __init nuc900evb_audio_init(void)
> +{
> +       int ret;
> +
> +       ret = -ENOMEM;
> +       nuc900evb_asoc_dev = platform_device_alloc("soc-audio", -1);
> +       if (!nuc900evb_asoc_dev)
> +               goto out;
> +
> +       /* nuc900 board audio device */
> +       platform_set_drvdata(nuc900evb_asoc_dev, &nuc900evb_ac97_devdata);
> +
> +       nuc900evb_ac97_devdata.dev = &nuc900evb_asoc_dev->dev;
> +       ret = platform_device_add(nuc900evb_asoc_dev);
> +
> +       if (ret) {
> +               platform_device_put(nuc900evb_asoc_dev);
> +               nuc900evb_asoc_dev = NULL;
> +       }
> +
> +out:
> +       return ret;
> +}
> +
> +static void __exit nuc900evb_audio_exit(void)
> +{
> +       platform_device_unregister(nuc900evb_asoc_dev);
> +}
> +
> +module_init(nuc900evb_audio_init);
> +module_exit(nuc900evb_audio_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("NUC900 Series ASoC audio support");
> +MODULE_AUTHOR("Wan ZongShun");
> diff --git a/sound/soc/nuc900/nuc900-auido.h
> b/sound/soc/nuc900/nuc900-auido.h
> new file mode 100644
> index 0000000..95ac4ef
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-auido.h
> @@ -0,0 +1,121 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#ifndef _NUC900_AUDIO_H
> +#define _NUC900_AUDIO_H
> +
> +#include <linux/io.h>
> +
> +/* Audio Control Registers */
> +#define ACTL_CON               0x00
> +#define ACTL_RESET             0x04
> +#define ACTL_RDSTB             0x08
> +#define ACTL_RDST_LENGTH       0x0C
> +#define ACTL_RDSTC             0x10
> +#define ACTL_RSR               0x14
> +#define ACTL_PDSTB             0x18
> +#define ACTL_PDST_LENGTH       0x1C
> +#define ACTL_PDSTC             0x20
> +#define ACTL_PSR               0x24
> +#define ACTL_IISCON            0x28
> +#define ACTL_ACCON             0x2C
> +#define ACTL_ACOS0             0x30
> +#define ACTL_ACOS1             0x34
> +#define ACTL_ACOS2             0x38
> +#define ACTL_ACIS0             0x3C
> +#define ACTL_ACIS1             0x40
> +#define ACTL_ACIS2             0x44
> +#define ACTL_COUNTER           0x48
> +
> +/* bit definition of REG_ACTL_CON register */
> +#define R_DMA_IRQ              0x1000
> +#define T_DMA_IRQ              0x0800
> +#define IIS_AC_PIN_SEL         0x0100
> +#define FIFO_TH                        0x0080
> +#define ADC_EN                 0x0010
> +#define M80_EN                 0x0008
> +#define ACLINK_EN              0x0004
> +#define IIS_EN                 0x0002
> +
> +/* bit definition of REG_ACTL_RESET register */
> +#define W5691_PLAY             0x20000
> +#define ACTL_RESET_BIT         0x10000
> +#define RECORD_RIGHT_CHNNEL    0x08000
> +#define RECORD_LEFT_CHNNEL     0x04000
> +#define PLAY_RIGHT_CHNNEL      0x02000
> +#define PLAY_LEFT_CHNNEL       0x01000
> +#define DAC_PLAY               0x00800
> +#define ADC_RECORD             0x00400
> +#define M80_PLAY               0x00200
> +#define AC_RECORD              0x00100
> +#define AC_PLAY                        0x00080
> +#define IIS_RECORD             0x00040
> +#define IIS_PLAY               0x00020
> +#define DAC_RESET              0x00010
> +#define ADC_RESET              0x00008
> +#define M80_RESET              0x00004
> +#define AC_RESET               0x00002
> +#define IIS_RESET              0x00001
> +
> +/* bit definition of REG_ACTL_ACCON register */
> +#define AC_BCLK_PU_EN          0x20
> +#define AC_R_FINISH            0x10
> +#define AC_W_FINISH            0x08
> +#define AC_W_RES               0x04
> +#define AC_C_RES               0x02
> +
> +/* bit definition of ACTL_RSR register */
> +#define R_FIFO_EMPTY           0x04
> +#define R_DMA_END_IRQ          0x02
> +#define R_DMA_MIDDLE_IRQ       0x01
> +
> +/* bit definition of ACTL_PSR register */
> +#define P_FIFO_EMPTY           0x04
> +#define P_DMA_END_IRQ          0x02
> +#define P_DMA_MIDDLE_IRQ       0x01
> +
> +/* bit definition of ACTL_ACOS0 register */
> +#define SLOT1_VALID            0x01
> +#define SLOT2_VALID            0x02
> +#define SLOT3_VALID            0x04
> +#define SLOT4_VALID            0x08
> +#define VALID_FRAME            0x10
> +
> +/* bit definition of ACTL_ACOS1 register */
> +#define R_WB                   0x80
> +
> +#define CODEC_READY            0x10
> +#define RESET_PRSR             0x00
> +#define AUDIO_WRITE(addr, val) __raw_writel(val, addr)
> +#define AUDIO_READ(addr)       __raw_readl(addr)
> +#define PCM_TX                 0
> +#define PCM_RX                 1
> +#define SUBSTREAM_TYPE(substream) \
> +       ((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX :
> PCM_RX)
> +
> +struct nuc900_audio {
> +       void __iomem *mmio;
> +       spinlock_t lock;
> +       dma_addr_t dma_addr[2];
> +       unsigned long buffersize[2];
> +       unsigned long irq_num;
> +       struct snd_pcm_substream *substream;
> +       struct resource *res;
> +       struct clk *clk;
> +       struct device *dev;
> +
> +};
> +
> +extern struct nuc900_audio *nuc900_ac97_data;
> +extern struct snd_soc_dai nuc900_ac97_dai;
> +extern struct snd_soc_platform nuc900_soc_platform;
> +
> +#endif /*end _NUC900_AUDIO_H */
> diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
> new file mode 100644
> index 0000000..32a503c
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-pcm.c
> @@ -0,0 +1,352 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <mach/hardware.h>
> +
> +#include "nuc900-auido.h"
> +
> +static const struct snd_pcm_hardware nuc900_pcm_hardware = {
> +       .info                   = SNDRV_PCM_INFO_INTERLEAVED |
> +                                       SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +                                       SNDRV_PCM_INFO_MMAP |
> +                                       SNDRV_PCM_INFO_MMAP_VALID |
> +                                       SNDRV_PCM_INFO_PAUSE |
> +                                       SNDRV_PCM_INFO_RESUME,
> +       .formats                = SNDRV_PCM_FMTBIT_S16_LE,
> +       .channels_min           = 1,
> +       .channels_max           = 2,
> +       .buffer_bytes_max       = 4*1024,
> +       .period_bytes_min       = 1*1024,
> +       .period_bytes_max       = 4*1024,
> +       .periods_min            = 1,
> +       .periods_max            = 1024,
> +};
> +
> +static int nuc900_dma_hw_params(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long flags, stype = SUBSTREAM_TYPE(substream);
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&nuc900_audio->lock, flags);
> +
> +       ret = snd_pcm_lib_malloc_pages(substream,
> params_buffer_bytes(params));
> +       if (ret < 0)
> +               return ret;
> +
> +       nuc900_audio->substream = substream;
> +       nuc900_audio->dma_addr[stype] = runtime->dma_addr;
> +       nuc900_audio->buffersize[stype] = params_buffer_bytes(params);
> +
> +       spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> +
> +       return ret;
> +}
> +
> +static void nuc900_update_dma_register(struct snd_pcm_substream
> *substream,
> +                               dma_addr_t dma_addr, size_t count)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       void __iomem *mmio_addr, *mmio_len;
> +
> +       if (SUBSTREAM_TYPE(substream) == PCM_TX) {
> +               mmio_addr = nuc900_audio->mmio + ACTL_PDSTB;
> +               mmio_len = nuc900_audio->mmio + ACTL_PDST_LENGTH;
> +       } else {
> +               mmio_addr = nuc900_audio->mmio + ACTL_RDSTB;
> +               mmio_len = nuc900_audio->mmio + ACTL_RDST_LENGTH;
> +       }
> +
> +       AUDIO_WRITE(mmio_addr, dma_addr);
> +       AUDIO_WRITE(mmio_len, count);
> +}
> +
> +static void nuc900_dma_start(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long val;
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val |= (T_DMA_IRQ | R_DMA_IRQ);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +}
> +
> +static void nuc900_dma_stop(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long val;
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val &= ~(T_DMA_IRQ | R_DMA_IRQ);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +}
> +
> +static irqreturn_t nuc900_dma_interrupt(int irq, void *dev_id)
> +{
> +       struct snd_pcm_substream *substream = dev_id;
> +       struct nuc900_audio *nuc900_audio =
> substream->runtime->private_data;
> +       unsigned long val;
> +
> +       spin_lock(&nuc900_audio->lock);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +
> +       if (val & R_DMA_IRQ) {
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val |
> R_DMA_IRQ);
> +
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RSR);
> +
> +               if (val & R_DMA_MIDDLE_IRQ) {
> +                       val |= R_DMA_MIDDLE_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, val);
> +               }
> +
> +               if (val & R_DMA_END_IRQ) {
> +                       val |= R_DMA_END_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, val);
> +               }
> +       } else if (val & T_DMA_IRQ) {
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val |
> T_DMA_IRQ);
> +
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_PSR);
> +
> +               if (val & P_DMA_MIDDLE_IRQ) {
> +                       val |= P_DMA_MIDDLE_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, val);
> +               }
> +
> +               if (val & P_DMA_END_IRQ) {
> +                       val |= P_DMA_END_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, val);
> +               }
> +       } else {
> +               dev_err(nuc900_audio->dev, "Wrong DMA interrupt
> status!\n");
> +               spin_unlock(&nuc900_audio->lock);
> +               return IRQ_HANDLED;
> +       }
> +
> +       spin_unlock(&nuc900_audio->lock);
> +
> +       snd_pcm_period_elapsed(substream);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int nuc900_dma_hw_free(struct snd_pcm_substream *substream)
> +{
> +       snd_pcm_lib_free_pages(substream);
> +       return 0;
> +}
> +
> +static int nuc900_dma_prepare(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long flags, val, stype = SUBSTREAM_TYPE(substream);;
> +
> +       spin_lock_irqsave(&nuc900_audio->lock, flags);
> +
> +       nuc900_update_dma_register(substream,
> +               nuc900_audio->dma_addr[stype],
> nuc900_audio->buffersize[stype]);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +
> +       switch (runtime->channels) {
> +       case 1:
> +               if (PCM_TX == stype) {
> +                       val &= ~(PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
> +                       val |= PLAY_RIGHT_CHNNEL;
> +               } else {
> +                       val &= ~(RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
> +                       val |= RECORD_RIGHT_CHNNEL;
> +               }
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +               break;
> +       case 2:
> +               if (PCM_TX == stype)
> +                       val |= (PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
> +               else
> +                       val |= (RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> +       return 0;
> +}
> +
> +static int nuc900_dma_trigger(struct snd_pcm_substream *substream, int
> cmd)
> +{
> +       int ret = 0;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               nuc900_dma_start(substream);
> +               break;
> +
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               nuc900_dma_stop(substream);
> +               break;
> +
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +int nuc900_dma_getposition(struct snd_pcm_substream *substream,
> +                                       dma_addr_t *src, dma_addr_t *dst)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +
> +       if (src != NULL)
> +               *src = AUDIO_READ(nuc900_audio->mmio + ACTL_PDSTC);
> +
> +       if (dst != NULL)
> +               *dst = AUDIO_READ(nuc900_audio->mmio + ACTL_RDSTC);
> +
> +       return 0;
> +}
> +
> +static snd_pcm_uframes_t nuc900_dma_pointer(struct snd_pcm_substream
> *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       dma_addr_t src, dst;
> +       unsigned long res;
> +
> +       nuc900_dma_getposition(substream, &src, &dst);
> +
> +       if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +               res = dst - runtime->dma_addr;
> +       else
> +               res = src - runtime->dma_addr;
> +
> +       return bytes_to_frames(substream->runtime, res);
> +}
> +
> +static int nuc900_dma_open(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio;
> +
> +       snd_soc_set_runtime_hwparams(substream, &nuc900_pcm_hardware);
> +
> +       nuc900_audio = nuc900_ac97_data;
> +
> +       if (request_irq(nuc900_audio->irq_num, nuc900_dma_interrupt,
> +                       IRQF_DISABLED, "nuc900-dma", substream))
> +               return -EBUSY;
> +
> +       runtime->private_data = nuc900_audio;
> +
> +       return 0;
> +}
> +
> +static int nuc900_dma_close(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +
> +       free_irq(nuc900_audio->irq_num, substream);
> +
> +       return 0;
> +}
> +
> +static int nuc900_dma_mmap(struct snd_pcm_substream *substream,
> +       struct vm_area_struct *vma)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +       return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +                                       runtime->dma_area,
> +                                       runtime->dma_addr,
> +                                       runtime->dma_bytes);
> +}
> +
> +static struct snd_pcm_ops nuc900_dma_ops = {
> +       .open           = nuc900_dma_open,
> +       .close          = nuc900_dma_close,
> +       .ioctl          = snd_pcm_lib_ioctl,
> +       .hw_params      = nuc900_dma_hw_params,
> +       .hw_free        = nuc900_dma_hw_free,
> +       .prepare        = nuc900_dma_prepare,
> +       .trigger        = nuc900_dma_trigger,
> +       .pointer        = nuc900_dma_pointer,
> +       .mmap           = nuc900_dma_mmap,
> +};
> +
> +static void nuc900_dma_free_dma_buffers(struct snd_pcm *pcm)
> +{
> +       snd_pcm_lib_preallocate_free_for_all(pcm);
> +}
> +
> +static u64 nuc900_pcm_dmamask = DMA_BIT_MASK(32);
> +static int nuc900_dma_new(struct snd_card *card,
> +       struct snd_soc_dai *dai, struct snd_pcm *pcm)
> +{
> +       if (!card->dev->dma_mask)
> +               card->dev->dma_mask = &nuc900_pcm_dmamask;
> +       if (!card->dev->coherent_dma_mask)
> +               card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +
> +       snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
> +               card->dev, 4 * 1024, (4 * 1024) - 1);
> +
> +       return 0;
> +}
> +
> +struct snd_soc_platform nuc900_soc_platform = {
> +       .name           = "nuc900-dma",
> +       .pcm_ops        = &nuc900_dma_ops,
> +       .pcm_new        = nuc900_dma_new,
> +       .pcm_free       = nuc900_dma_free_dma_buffers,
> +}
> +EXPORT_SYMBOL_GPL(nuc900_soc_platform);
> +
> +static int __init nuc900_soc_platform_init(void)
> +{
> +       return snd_soc_register_platform(&nuc900_soc_platform);
> +}
> +
> +static void __exit nuc900_soc_platform_exit(void)
> +{
> +       snd_soc_unregister_platform(&nuc900_soc_platform);
> +}
> +
> +module_init(nuc900_soc_platform_init);
> +module_exit(nuc900_soc_platform_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun, <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("nuc900 Audio DMA module");
> +MODULE_LICENSE("GPL");
> --
> 1.6.3.3
>
>


-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel@lists.infradead.org<addr%3Alinux-arm-kernel@lists.infradead.org>
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900@googlegroups.com <addr%3ANUC900@googlegroups.com>
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com@gmail.com

--000e0cd6adeeaa26440486d7ba07
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Dear sirs,</div>
<div>=C2=A0</div>
<div>Submit wrong patch file, drop it.</div>
<div>I will resubmit it.<br><br></div>
<div class=3D"gmail_quote">2010/5/18 Wan ZongShun <span dir=3D"ltr">&lt;<a =
href=3D"http://mcuos.com">mcuos.com</a>@<a href=3D"http://gmail.com">gmail.=
com</a>&gt;</span><br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">Dear Mark,<br><br>I have modifie=
d some codes according to your comments,<br>now I submit the patch as v2 ag=
ain.<br>
<br>Thanks a lot for your help.<br><br>From 35d6ecb61972919a8c7fd418766bd30=
3dde687b3 Mon Sep 17 00:00:00 2001<br>From: zswan &lt;zswan@zswan-marvell.(=
none)&gt;<br>Date: Tue, 18 May 2010 10:51:12 +0800<br>Subject: [PATCH 3/3] =
add-nuc900-audio-driver-support-v5.patch<br>
<br>---<br>=C2=A0sound/soc/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A01 +<br>=C2=A0sound/soc/Makefile =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +<br>=C2=A0sound/soc/nuc900=
/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 27 +++<br>=C2=A0sound/soc/nuc9=
00/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11 +<br>=C2=A0sound/soc/nuc900/nu=
c900-ac97.c =C2=A0| =C2=A0443 +++++++++++++++++++++++++++++++++++++++<br>
=C2=A0sound/soc/nuc900/nuc900-audio.c | =C2=A0 81 +++++++<br>=C2=A0sound/so=
c/nuc900/nuc900-auido.h | =C2=A0121 +++++++++++<br>=C2=A0sound/soc/nuc900/n=
uc900-pcm.c =C2=A0 | =C2=A0352 +++++++++++++++++++++++++++++++<br>=C2=A08 f=
iles changed, 1037 insertions(+), 0 deletions(-)<br>
=C2=A0create mode 100644 sound/soc/nuc900/Kconfig<br>=C2=A0create mode 1006=
44 sound/soc/nuc900/Makefile<br>=C2=A0create mode 100644 sound/soc/nuc900/n=
uc900-ac97.c<br>=C2=A0create mode 100644 sound/soc/nuc900/nuc900-audio.c<br=
>=C2=A0create mode 100644 sound/soc/nuc900/nuc900-auido.h<br>
=C2=A0create mode 100644 sound/soc/nuc900/nuc900-pcm.c<br><br>diff --git a/=
sound/soc/Kconfig b/sound/soc/Kconfig<br>index b1749bc..6e04fc2 100644<br>-=
-- a/sound/soc/Kconfig<br>+++ b/sound/soc/Kconfig<br>@@ -30,6 +30,7 @@ sour=
ce &quot;sound/soc/blackfin/Kconfig&quot;<br>
=C2=A0source &quot;sound/soc/davinci/Kconfig&quot;<br>=C2=A0source &quot;so=
und/soc/fsl/Kconfig&quot;<br>=C2=A0source &quot;sound/soc/imx/Kconfig&quot;=
<br>+source &quot;sound/soc/nuc900/Kconfig&quot;<br>=C2=A0source &quot;soun=
d/soc/omap/Kconfig&quot;<br>
=C2=A0source &quot;sound/soc/pxa/Kconfig&quot;<br>=C2=A0source &quot;sound/=
soc/s3c24xx/Kconfig&quot;<br>diff --git a/sound/soc/Makefile b/sound/soc/Ma=
kefile<br>index 1470141..ccec241 100644<br>--- a/sound/soc/Makefile<br>+++ =
b/sound/soc/Makefile<br>
@@ -8,6 +8,7 @@ obj-$(CONFIG_SND_SOC) =C2=A0 +=3D blackfin/<br>=C2=A0obj-$(=
CONFIG_SND_SOC) =C2=A0+=3D davinci/<br>=C2=A0obj-$(CONFIG_SND_SOC) =C2=A0+=
=3D fsl/<br>=C2=A0obj-$(CONFIG_SND_SOC) =C2=A0 +=3D imx/<br>+obj-$(CONFIG_S=
ND_SOC) =C2=A0+=3D nuc900/<br>=C2=A0obj-$(CONFIG_SND_SOC) =C2=A0+=3D omap/<=
br>
=C2=A0obj-$(CONFIG_SND_SOC) =C2=A0+=3D pxa/<br>=C2=A0obj-$(CONFIG_SND_SOC) =
=C2=A0+=3D s3c24xx/<br>diff --git a/sound/soc/nuc900/Kconfig b/sound/soc/nu=
c900/Kconfig<br>new file mode 100644<br>index 0000000..a0ed1c6<br>--- /dev/=
null<br>+++ b/sound/soc/nuc900/KconfigFrom 35d6ecb61972919a8c7fd418766bd303=
dde687b3 Mon Sep 17 00:00:00 2001<br>
From: zswan &lt;zswan@zswan-marvell.(none)&gt;<br>Date: Tue, 18 May 2010 10=
:51:12 +0800<br>Subject: [PATCH 3/3] add-nuc900-audio-driver-support-v5.pat=
ch<br><br>---<br>=C2=A0sound/soc/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +<br>=C2=A0sound/soc/Makefile =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +<br>
=C2=A0sound/soc/nuc900/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 27 +++<b=
r>=C2=A0sound/soc/nuc900/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11 +<br>=C2=
=A0sound/soc/nuc900/nuc900-ac97.c =C2=A0| =C2=A0443 +++++++++++++++++++++++=
++++++++++++++++<br>=C2=A0sound/soc/nuc900/nuc900-audio.c | =C2=A0 81 +++++=
++<br>
=C2=A0sound/soc/nuc900/nuc900-auido.h | =C2=A0121 +++++++++++<br>=C2=A0soun=
d/soc/nuc900/nuc900-pcm.c =C2=A0 | =C2=A0352 ++++++++++++++++++++++++++++++=
+<br>=C2=A08 files changed, 1037 insertions(+), 0 deletions(-)<br>=C2=A0cre=
ate mode 100644 sound/soc/nuc900/Kconfig<br>
=C2=A0create mode 100644 sound/soc/nuc900/Makefile<br>=C2=A0create mode 100=
644 sound/soc/nuc900/nuc900-ac97.c<br>=C2=A0create mode 100644 sound/soc/nu=
c900/nuc900-audio.c<br>=C2=A0create mode 100644 sound/soc/nuc900/nuc900-aui=
do.h<br>=C2=A0create mode 100644 sound/soc/nuc900/nuc900-pcm.c<br>
<br>diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig<br>index b1749bc..6e=
04fc2 100644<br>--- a/sound/soc/Kconfig<br>+++ b/sound/soc/Kconfig<br>@@ -3=
0,6 +30,7 @@ source &quot;sound/soc/blackfin/Kconfig&quot;<br>=C2=A0source =
&quot;sound/soc/davinci/Kconfig&quot;<br>
=C2=A0source &quot;sound/soc/fsl/Kconfig&quot;<br>=C2=A0source &quot;sound/=
soc/imx/Kconfig&quot;<br>+source &quot;sound/soc/nuc900/Kconfig&quot;<br>=
=C2=A0source &quot;sound/soc/omap/Kconfig&quot;<br>=C2=A0source &quot;sound=
/soc/pxa/Kconfig&quot;<br>
=C2=A0source &quot;sound/soc/s3c24xx/Kconfig&quot;<br>diff --git a/sound/so=
c/Makefile b/sound/soc/Makefile<br>index 1470141..ccec241 100644<br>--- a/s=
ound/soc/Makefile<br>+++ b/sound/soc/Makefile<br>@@ -8,6 +8,7 @@ obj-$(CONF=
IG_SND_SOC) =C2=A0 +=3D blackfin/<br>
=C2=A0obj-$(CONFIG_SND_SOC) =C2=A0+=3D davinci/<br>=C2=A0obj-$(CONFIG_SND_S=
OC) =C2=A0+=3D fsl/<br>=C2=A0obj-$(CONFIG_SND_SOC) =C2=A0 +=3D imx/<br>+obj=
-$(CONFIG_SND_SOC) =C2=A0+=3D nuc900/<br>=C2=A0obj-$(CONFIG_SND_SOC) =C2=A0=
+=3D omap/<br>=C2=A0obj-$(CONFIG_SND_SOC) =C2=A0+=3D pxa/<br>=C2=A0obj-$(CO=
NFIG_SND_SOC) =C2=A0+=3D s3c24xx/<br>
diff --git a/sound/soc/nuc900/Kconfig b/sound/soc/nuc900/Kconfig<br>new fil=
e mode 100644<br>index 0000000..a0ed1c6<br>--- /dev/null<br>+++ b/sound/soc=
/nuc900/Kconfig<br>@@ -0,0 +1,27 @@<br>+##<br>+## NUC900 series AC97 API<br=
>
+##<br>+config SND_SOC_NUC900<br>+ =C2=A0 =C2=A0 =C2=A0 tristate &quot;SoC =
Audio for NUC900 series&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 depends on ARCH_W90=
X900<br>+ =C2=A0 =C2=A0 =C2=A0 help<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 This o=
ption enables support for AC97 mode on the NUC900 SoC.<br>+<br>
+config SND_SOC_NUC900_AC97<br>+ =C2=A0 =C2=A0 =C2=A0 tristate<br>+ =C2=A0 =
=C2=A0 =C2=A0 select AC97_BUS<br>+ =C2=A0 =C2=A0 =C2=A0 select SND_AC97_COD=
EC<br>+ =C2=A0 =C2=A0 =C2=A0 select SND_SOC_AC97_BUS<br>+<br>+<br>+##<br>+#=
# Boards<br>+##<br>+config SND_SOC_NUC900EVB<br>+ =C2=A0 =C2=A0 =C2=A0 tris=
tate &quot;NUC900 AC97 support for demo board&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 depends on SND_SOC_NUC900<br>+ =C2=A0 =C2=A0 =C2=A0 =
select SND_SOC_NUC900_AC97<br>+ =C2=A0 =C2=A0 =C2=A0 select SND_SOC_AC97_CO=
DEC<br>+ =C2=A0 =C2=A0 =C2=A0 help<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 Select =
this option to enable audio (AC97) on the<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
NUC900 demoboard.<br>
diff --git a/sound/soc/nuc900/Makefile b/sound/soc/nuc900/Makefile<br>new f=
ile mode 100644<br>index 0000000..7e46c71<br>--- /dev/null<br>+++ b/sound/s=
oc/nuc900/Makefile<br>@@ -0,0 +1,11 @@<br>+# NUC900 series audio<br>+snd-so=
c-nuc900-pcm-objs :=3D nuc900-pcm.o<br>
+snd-soc-nuc900-ac97-objs :=3D nuc900-ac97.o<br>+<br>+obj-$(CONFIG_SND_SOC_=
NUC900) +=3D snd-soc-nuc900-pcm.o<br>+obj-$(CONFIG_SND_SOC_NUC900_AC97) +=
=3D snd-soc-nuc900-ac97.o<br>+<br>+# Boards<br>+snd-soc-nuc900-audio-objs :=
=3D nuc900-audio.o<br>
+<br>+obj-$(CONFIG_SND_SOC_NUC900EVB) +=3D snd-soc-nuc900-audio.o<br>diff -=
-git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c<br>n=
ew file mode 100644<br>index 0000000..2c345e2<br>--- /dev/null<br>+++ b/sou=
nd/soc/nuc900/nuc900-ac97.c<br>
@@ -0,0 +1,443 @@<br>+/*<br>+ * Copyright (c) 2009-2010 Nuvoton technology =
corporation.<br>+ *<br>+ * Wan ZongShun &lt;<a href=3D"http://mcuos.com/" t=
arget=3D"_blank">mcuos.com</a>@<a href=3D"http://gmail.com/" target=3D"_bla=
nk">gmail.com</a>&gt;<br>
+ *<br>+ * This program is free software; you can redistribute it and/or mo=
dify<br>+ * it under the terms of the GNU General Public License as publish=
ed by<br>+ * the Free Software Foundation;version 2 of the License.<br>
+ *<br>+ */<br>+<br>+#include &lt;linux/init.h&gt;<br>+#include &lt;linux/m=
odule.h&gt;<br>+#include &lt;linux/slab.h&gt;<br>+#include &lt;linux/device=
.h&gt;<br>+#include &lt;linux/delay.h&gt;<br>+#include &lt;linux/mutex.h&gt=
;<br>
+#include &lt;linux/suspend.h&gt;<br>+#include &lt;sound/core.h&gt;<br>+#in=
clude &lt;sound/pcm.h&gt;<br>+#include &lt;sound/initval.h&gt;<br>+#include=
 &lt;sound/soc.h&gt;<br>+#include &lt;linux/device.h&gt;<br>+#include &lt;l=
inux/clk.h&gt;<br>
+<br>+#include &lt;mach/mfp.h&gt;<br>+<br>+#include &quot;nuc900-auido.h&qu=
ot;<br>+<br>+static DEFINE_MUTEX(ac97_mutex);<br>+struct nuc900_audio *nuc9=
00_ac97_data;<br>+<br>+static int nuc900_checkready(void)<br>+{<br>+ =C2=A0=
 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc900_ac97_data;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (!(AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_A=
CIS0) &amp; CODEC_READY))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -EPERM;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<b=
r>+/* AC97 controller reads codec register */<br>+static unsigned short nuc=
900_ac97_read(struct snd_ac97 *ac97,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned short =
reg)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D =
nuc900_ac97_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long timeout =3D 0x100=
00, val;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;ac97_mutex);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D nuc900_checkready();<br>+ =C2=A0 =C2=A0=
 =C2=A0 if (!!val) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dev_err(nuc900_audio-&gt;dev, &quot;AC97 codec is not ready\n&quot;);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>+ =C2=A0 =C2=
=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /* set the R_WB bit and write r=
egister index */<br>
+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS1, R_WB=
 | reg);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /* set the valid frame bit and vali=
d slots */<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mm=
io + ACTL_ACOS0);<br>+ =C2=A0 =C2=A0 =C2=A0 val |=3D (VALID_FRAME | SLOT1_V=
ALID);<br>
+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS0, val)=
;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(100);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 /* polling the AC_R_FINISH */<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_R=
EAD(nuc900_audio-&gt;mmio + ACTL_ACCON);<br>+ =C2=A0 =C2=A0 =C2=A0 val &amp=
;=3D AC_R_FINISH;<br>
+ =C2=A0 =C2=A0 =C2=A0 while (!val &amp;&amp; timeout--)<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(1);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 if (!timeout) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
ev_err(nuc900_audio-&gt;dev, &quot;AC97 read register time out !\n&quot;);<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D -EPERM;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>+ =C2=A0 =
=C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_au=
dio-&gt;mmio + ACTL_ACOS0) ;<br>+ =C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~SLOT1_=
VALID;<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_A=
COS0, val);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (AUDIO_READ(nuc900_audio-&gt;=
mmio + ACTL_ACIS1) &gt;&gt; 2 !=3D reg) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(nuc900_audio-&gt=
;dev,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;R_INDEX of REG_ACTL_ACIS1 n=
ot match!\n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 udelay(100);<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D (AUDIO_READ(nuc900_audio=
-&gt;mmio + ACTL_ACIS2) &amp; 0xFFFF);<br>
+<br>+out:<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>+ =
=C2=A0 =C2=A0 =C2=A0 return val;<br>+}<br>+<br>+/* AC97 controller writes t=
o codec register */<br>+static void nuc900_ac97_write(struct snd_ac97 *ac97=
, unsigned short reg,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned short val=
)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc900_a=
c97_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long tmp, timeout =3D 0x10000;=
<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;ac97_mutex);<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 tmp =3D nuc900_checkready();<br>+ =C2=A0 =C2=A0 =C2=A0 if=
 (!!tmp)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(nuc900_audio-&gt=
;dev, &quot;AC97 codec is not ready\n&quot;);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 /* clear the R_WB bit and write register index */<br>+ =C2=A0 =C2=A0 =
=C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS1, reg);<br>+<br>
+ =C2=A0 =C2=A0 =C2=A0 /* write register value */<br>+ =C2=A0 =C2=A0 =C2=A0=
 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS2, val);<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 /* set the valid frame bit and valid slots */<br>+ =C2=A0 =C2=A0=
 =C2=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACOS0);<br>
+ =C2=A0 =C2=A0 =C2=A0 tmp |=3D SLOT1_VALID | SLOT2_VALID | VALID_FRAME;<br=
>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS0, tmp=
);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(100);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 /* polling the AC_W_FINISH */<br>+ =C2=A0 =C2=A0 =C2=A0 tmp =3D AUDIO_R=
EAD(nuc900_audio-&gt;mmio + ACTL_ACCON);<br>
+ =C2=A0 =C2=A0 =C2=A0 tmp &amp;=3D AC_W_FINISH;<br>+ =C2=A0 =C2=A0 =C2=A0 =
while (tmp &amp;&amp; timeout--)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 mdelay(1);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (!timeout)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(nuc900_audio-&gt;d=
ev, &quot;AC97 write register time out !\n&quot;);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL=
_ACOS0);<br>+ =C2=A0 =C2=A0 =C2=A0 tmp &amp;=3D ~(SLOT1_VALID | SLOT2_VALID=
);<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS0=
, tmp);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>
+<br>+}<br>+<br>+static void nuc900_ac97_warm_reset(struct snd_ac97 *ac97)<=
br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc90=
0_ac97_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =
=C2=A0 =C2=A0 mutex_lock(&amp;ac97_mutex);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 /* warm reset AC 97 */<br>+ =C2=A0 =C2=A0 =C2=
=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACCON);<br>+ =C2=A0 =C2=
=A0 =C2=A0 val |=3D AC_W_RES;<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_=
audio-&gt;mmio + ACTL_ACCON, val);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(10=
00);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D nuc900_checkready();<br>+ =C2=A0 =C2=A0=
 =C2=A0 if (!!val)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 de=
v_err(nuc900_audio-&gt;dev, &quot;AC97 codec is not ready\n&quot;);<br>+<br=
>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>+}<br>+<br>+stati=
c void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc900_a=
c97_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 mutex_lock(&amp;ac97_mutex);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /* r=
eset Audio Controller */<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc90=
0_audio-&gt;mmio + ACTL_RESET);<br>
+ =C2=A0 =C2=A0 =C2=A0 val |=3D ACTL_RESET_BIT;<br>+ =C2=A0 =C2=A0 =C2=A0 A=
UDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RESET, val);<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(=
nuc900_audio-&gt;mmio + ACTL_RESET);<br>+ =C2=A0 =C2=A0 =C2=A0 val &amp;=3D=
 (~ACTL_RESET_BIT);<br>
+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RESET, val)=
;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 /* reset AC-link interface */<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AU=
DIO_READ(nuc900_audio-&gt;mmio + ACTL_RESET);<br>+ =C2=A0 =C2=A0 =C2=A0 val=
 |=3D AC_RESET;<br>
+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RESET, val)=
;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_RESET);<br>+ =C2=A0 =C2=
=A0 =C2=A0 val &amp;=3D ~AC_RESET;<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nu=
c900_audio-&gt;mmio + ACTL_RESET, val);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /*=
 cold reset AC 97 */<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_au=
dio-&gt;mmio + ACTL_ACCON);<br>+ =C2=A0 =C2=A0 =C2=A0 val |=3D AC_C_RES;<br=
>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACCON, val=
);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 va=
l =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACCON);<br>+ =C2=A0 =C2=A0 =
=C2=A0 val &amp;=3D (~AC_C_RES);<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc9=
00_audio-&gt;mmio + ACTL_ACCON, val);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay=
(1000);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>+<br>+}<br>+<=
br>+/* AC97 controller operations */<br>+struct snd_ac97_bus_ops soc_ac97_o=
ps =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 .read =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D nuc900_ac97_read,<br>+ =C2=A0 =C2=A0 =C2=A0 .write =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D nuc900_ac97_write,<br>
+ =C2=A0 =C2=A0 =C2=A0 .reset =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900_=
ac97_cold_reset,<br>+ =C2=A0 =C2=A0 =C2=A0 .warm_reset =C2=A0 =C2=A0 =3D nu=
c900_ac97_warm_reset,<br>+}<br>+EXPORT_SYMBOL_GPL(soc_ac97_ops);<br>+<br>+s=
tatic int nuc900_ac97_trigger(struct snd_pcm_substream *substream,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cmd, struct snd_soc_dai *dai)<br>+{<br>=
+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc900_ac97_da=
ta;<br>+ =C2=A0 =C2=A0 =C2=A0 int ret, stype =3D SUBSTREAM_TYPE(substream);=
<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val, tmp;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 switc=
h (cmd) {<br>+ =C2=A0 =C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_START:<br>+ =C2=
=A0 =C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_RESUME:<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL=
_RESET);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PCM_TX =
=3D=3D stype) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACOS0);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp |=3D=
 (SLOT3_VALID | SLOT4_VALID | VALID_FRAME);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_aud=
io-&gt;mmio + ACTL_ACOS0, tmp);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_PSR);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
mp |=3D (P_DMA_END_IRQ | P_DMA_MIDDLE_IRQ);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_aud=
io-&gt;mmio + ACTL_PSR, tmp);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val |=3D AC_PLAY;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 } else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_RSR);<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tmp |=3D (R_DMA_END_IRQ | R_DMA_MIDDLE_IRQ);<br>+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RSR, tmp);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D AC_=
RECORD;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&=
gt;mmio + ACTL_RESET, val);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>+ =C2=A0 =
=C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_STOP:<br>+ =C2=A0 =C2=A0 =C2=A0 case S=
NDRV_PCM_TRIGGER_SUSPEND:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_RESET);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PCM_TX =3D=3D stype) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACOS0);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp &amp=
;=3D ~(SLOT3_VALID | SLOT4_VALID);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio=
 + ACTL_ACOS0, tmp);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_PSR, RESET_PRSR);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val &amp;=3D ~AC_PLAY;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 } else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RSR, RESE=
T_PRSR);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val &amp;=3D ~AC_RECORD;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_=
WRITE(nuc900_audio-&gt;mmio + ACTL_RESET, val);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>+ =C2=A0 =C2=A0 =C2=A0 default:<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return ret;<br>+}<b=
r>+<br>+static int nuc900_ac97_probe(struct platform_device *pdev,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct snd_soc_dai =
*dai)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D=
 nuc900_ac97_data;<br>
+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mu=
tex_lock(&amp;ac97_mutex);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /* enable unit cl=
ock */<br>+ =C2=A0 =C2=A0 =C2=A0 clk_enable(nuc900_audio-&gt;clk);<br>+<br>=
+ =C2=A0 =C2=A0 =C2=A0 /* enable audio controller and AC-link interface */<=
br>
+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_CON)=
;<br>+ =C2=A0 =C2=A0 =C2=A0 val |=3D (IIS_AC_PIN_SEL | ACLINK_EN);<br>+ =C2=
=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_CON, val);<br>+<=
br>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static void nuc900_ac9=
7_remove(struct platform_device *pdev,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct snd_soc_dai =
*dai)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D=
 nuc900_ac97_data;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 clk_disable(nuc900_audio-&gt;clk);<br>+}<br>+<b=
r>+static struct snd_soc_dai_ops nuc900_ac97_dai_ops =3D {<br>+ =C2=A0 =C2=
=A0 =C2=A0 .trigger =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900_ac97_trigger,<br>=
+};<br>+<br>+struct snd_soc_dai nuc900_ac97_dai =3D {<br>
+ =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D &quot;nuc900-ac97&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 .p=
robe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc9=
00_ac97_probe,<br>+ =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D nuc900_ac97_remove,<br>+ =C2=A0 =C2=A0 =
=C2=A0 .ac97_control =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,<br>+ =C2=A0 =
=C2=A0 =C2=A0 .playback =3D {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rates =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D SNDRV_PCM_RATE_8000_48000,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .formats =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D SNDRV_P=
CM_FMTBIT_S16_LE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ch=
annels_min =C2=A0 =3D 1,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .channels_max =C2=A0 =3D 2,<br>+ =C2=A0 =C2=A0 =C2=A0 },<br>+ =C2=A0 =
=C2=A0 =C2=A0 .capture =3D {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rates =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D SNDRV_PCM_RATE_8000_48000,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .formats =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D SNDRV_P=
CM_FMTBIT_S16_LE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ch=
annels_min =C2=A0 =3D 1,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .channels_max =C2=A0 =3D 2,<br>+ =C2=A0 =C2=A0 =C2=A0 },<br>+ =C2=A0 =
=C2=A0 =C2=A0 .ops =3D &amp;nuc900_ac97_dai_ops,<br>
+}<br>+EXPORT_SYMBOL_GPL(nuc900_ac97_dai);<br>+<br>+static int __devinit nu=
c900_ac97_drvprobe(struct platform_device *pdev)<br>+{<br>+ =C2=A0 =C2=A0 =
=C2=A0 struct nuc900_audio *nuc900_audio;<br>+ =C2=A0 =C2=A0 =C2=A0 int ret=
;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (nuc900_ac97_data)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;<br>+<br>+=
 =C2=A0 =C2=A0 =C2=A0 nuc900_audio =3D kzalloc(sizeof(struct nuc900_audio),=
 GFP_KERNEL);<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900_audio)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 spin_lock_init(&amp;nuc900_audio-&gt;lock);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;res =3D platform_get_resource(=
pdev, IORESOURCE_MEM, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900_audio-&gt;r=
es) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out0;<br>+ =C2=
=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (!request_mem_region(=
nuc900_audio-&gt;res-&gt;start,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 resource_size(nuc900_audio-&gt;res), pdev-&gt;name)) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EBUSY;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out0;<br>+ =C2=A0 =C2=A0 =C2=A0 }<b=
r>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;mmio =3D ioremap(nuc900_audi=
o-&gt;res-&gt;start,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size(n=
uc900_audio-&gt;res));<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900_audio-&gt;mmio=
) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out1;<br>+ =C2=
=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;clk =3D=
 clk_get(&amp;pdev-&gt;dev, NULL);<br>
+ =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(nuc900_audio-&gt;clk)) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D PTR_ERR(nuc900_audio-&gt;clk=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out2;<br>+ =
=C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;irq_=
num =3D platform_get_irq(pdev, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900_au=
dio-&gt;irq_num) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EBUSY;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out2;<br>+ =C2=A0 =C2=A0=
 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_ac97_data =3D nuc900_audio;=
<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;dev =3D nuc900_ac97_dai.de=
v =3D =C2=A0&amp;pdev-&gt;dev;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 ret =3D snd_s=
oc_register_dai(&amp;nuc900_ac97_dai);<br>
+ =C2=A0 =C2=A0 =C2=A0 if (ret)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out3;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mfp_set_groupg(nuc900_=
audio-&gt;dev); /* enbale ac97 multifunction pin*/<br>+<br>+ =C2=A0 =C2=A0 =
=C2=A0 return 0;<br>+<br>+out3:<br>+ =C2=A0 =C2=A0 =C2=A0 clk_put(nuc900_au=
dio-&gt;clk);<br>
+out2:<br>+ =C2=A0 =C2=A0 =C2=A0 iounmap(nuc900_audio-&gt;mmio);<br>+out1:<=
br>+ =C2=A0 =C2=A0 =C2=A0 release_mem_region(nuc900_audio-&gt;res-&gt;start=
,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource=
_size(nuc900_audio-&gt;res));<br>+out0:<br>+ =C2=A0 =C2=A0 =C2=A0 kfree(nuc=
900_audio);<br>
+ =C2=A0 =C2=A0 =C2=A0 return ret;<br>+}<br>+<br>+static int __devexit nuc9=
00_ac97_drvremove(struct platform_device *pdev)<br>+{<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 snd_soc_unregister_dai(&amp;nuc900_ac97_dai);<br>+<br>+ =C2=A0 =
=C2=A0 =C2=A0 clk_put(nuc900_ac97_data-&gt;clk);<br>
+ =C2=A0 =C2=A0 =C2=A0 iounmap(nuc900_ac97_data-&gt;mmio);<br>+ =C2=A0 =C2=
=A0 =C2=A0 release_mem_region(nuc900_ac97_data-&gt;res-&gt;start,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size(nuc900_ac97_data-&gt;res));<br>+<=
br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_ac97_data =3D NULL;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static struct platform=
_driver nuc900_ac97_driver =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 .driver =3D {<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D &quot;=
nuc900-audio&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .=
owner =C2=A0=3D THIS_MODULE,<br>+ =C2=A0 =C2=A0 =C2=A0 },<br>
+ =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900_=
ac97_drvprobe,<br>+ =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D __devexit_p(nuc900_ac97_drvremove),<br>+};<br>+<br>+static int __in=
it nuc900_ac97_init(void)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 return platform_d=
river_register(&amp;nuc900_ac97_driver);<br>
+}<br>+<br>+static void __exit nuc900_ac97_exit(void)<br>+{<br>+ =C2=A0 =C2=
=A0 =C2=A0 platform_driver_unregister(&amp;nuc900_ac97_driver);<br>+}<br>+<=
br>+module_init(nuc900_ac97_init);<br>+module_exit(nuc900_ac97_exit);<br>+<=
br>+MODULE_AUTHOR(&quot;Wan ZongShun &lt;<a href=3D"http://mcuos.com/" targ=
et=3D"_blank">mcuos.com</a>@<a href=3D"http://gmail.com/" target=3D"_blank"=
>gmail.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;NUC900 AC97 SoC driver!&quot;);<br>+MODULE_LICENS=
E(&quot;GPL&quot;);<br>+MODULE_ALIAS(&quot;platform:nuc900-ac97&quot;);<br>=
+<br>diff --git a/sound/soc/nuc900/nuc900-audio.c b/sound/soc/nuc900/nuc900=
-audio.c<br>
new file mode 100644<br>index 0000000..b33d5b8<br>--- /dev/null<br>+++ b/so=
und/soc/nuc900/nuc900-audio.c<br>@@ -0,0 +1,81 @@<br>+/*<br>+ * Copyright (=
c) 2010 Nuvoton technology corporation.<br>+ *<br>+ * Wan ZongShun &lt;<a h=
ref=3D"http://mcuos.com/" target=3D"_blank">mcuos.com</a>@<a href=3D"http:/=
/gmail.com/" target=3D"_blank">gmail.com</a>&gt;<br>
+ *<br>+ * This program is free software; you can redistribute it and/or mo=
dify<br>+ * it under the terms of the GNU General Public License as publish=
ed by<br>+ * the Free Software Foundation;version 2 of the License.<br>
+ *<br>+ */<br>+<br>+#include &lt;linux/module.h&gt;<br>+#include &lt;linux=
/moduleparam.h&gt;<br>+#include &lt;linux/timer.h&gt;<br>+#include &lt;linu=
x/interrupt.h&gt;<br>+#include &lt;linux/platform_device.h&gt;<br>+<br>
+#include &lt;sound/core.h&gt;<br>+#include &lt;sound/pcm.h&gt;<br>+#includ=
e &lt;sound/soc.h&gt;<br>+#include &lt;sound/soc-dapm.h&gt;<br>+<br>+#inclu=
de &quot;../codecs/ac97.h&quot;<br>+#include &quot;nuc900-auido.h&quot;<br>
+<br>+static struct snd_soc_dai_link nuc900evb_ac97_dai =3D {<br>+ =C2=A0 =
=C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;AC97&quot;=
,<br>+ =C2=A0 =C2=A0 =C2=A0 .stream_name =C2=A0 =C2=A0=3D &quot;AC97 HiFi&q=
uot;,<br>+ =C2=A0 =C2=A0 =C2=A0 .cpu_dai =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &am=
p;nuc900_ac97_dai,<br>+ =C2=A0 =C2=A0 =C2=A0 .codec_dai =C2=A0 =C2=A0 =C2=
=A0=3D &amp;ac97_dai,<br>
+};<br>+<br>+static struct snd_soc_card nuc900evb_audio_machine =3D {<br>+ =
=C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;NUC=
900EVB_AC97&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 .dai_link =C2=A0 =C2=A0 =C2=A0=
 =3D &amp;nuc900evb_ac97_dai,<br>+ =C2=A0 =C2=A0 =C2=A0 .num_links =C2=A0 =
=C2=A0 =C2=A0=3D 1,<br>+ =C2=A0 =C2=A0 =C2=A0 .platform =C2=A0 =C2=A0 =C2=
=A0 =3D &amp;nuc900_soc_platform,<br>
+};<br>+<br>+static struct snd_soc_device nuc900evb_ac97_devdata =3D {<br>+=
 =C2=A0 =C2=A0 =C2=A0 .card =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &amp;nuc=
900evb_audio_machine,<br>+ =C2=A0 =C2=A0 =C2=A0 .codec_dev =C2=A0 =C2=A0 =
=C2=A0=3D &amp;soc_codec_dev_ac97,<br>+};<br>+<br>+static struct platform_d=
evice *nuc900evb_asoc_dev;<br>
+<br>+static int __init nuc900evb_audio_init(void)<br>+{<br>+ =C2=A0 =C2=A0=
 =C2=A0 int ret;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;<br>+ =C2=
=A0 =C2=A0 =C2=A0 nuc900evb_asoc_dev =3D platform_device_alloc(&quot;soc-au=
dio&quot;, -1);<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900evb_asoc_dev)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 /* nuc900 board audio device */<br>+ =C2=A0 =C2=A0 =C2=A0=
 platform_set_drvdata(nuc900evb_asoc_dev, &amp;nuc900evb_ac97_devdata);<br>=
+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900evb_ac97_devdata.dev =3D &amp;nuc900evb_a=
soc_dev-&gt;dev;<br>
+ =C2=A0 =C2=A0 =C2=A0 ret =3D platform_device_add(nuc900evb_asoc_dev);<br>=
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 platform_device_put(nuc900evb_asoc_dev);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900evb_asoc_dev =3D NULL;<br>+ =
=C2=A0 =C2=A0 =C2=A0 }<br>+<br>+out:<br>+ =C2=A0 =C2=A0 =C2=A0 return ret;<=
br>
+}<br>+<br>+static void __exit nuc900evb_audio_exit(void)<br>+{<br>+ =C2=A0=
 =C2=A0 =C2=A0 platform_device_unregister(nuc900evb_asoc_dev);<br>+}<br>+<b=
r>+module_init(nuc900evb_audio_init);<br>+module_exit(nuc900evb_audio_exit)=
;<br>+<br>+MODULE_LICENSE(&quot;GPL&quot;);<br>
+MODULE_DESCRIPTION(&quot;NUC900 Series ASoC audio support&quot;);<br>+MODU=
LE_AUTHOR(&quot;Wan ZongShun&quot;);<br>diff --git a/sound/soc/nuc900/nuc90=
0-auido.h b/sound/soc/nuc900/nuc900-auido.h<br>new file mode 100644<br>
index 0000000..95ac4ef<br>--- /dev/null<br>+++ b/sound/soc/nuc900/nuc900-au=
ido.h<br>@@ -0,0 +1,121 @@<br>+/*<br>+ * Copyright (c) 2010 Nuvoton technol=
ogy corporation.<br>+ *<br>+ * Wan ZongShun &lt;<a href=3D"http://mcuos.com=
/" target=3D"_blank">mcuos.com</a>@<a href=3D"http://gmail.com/" target=3D"=
_blank">gmail.com</a>&gt;<br>
+ *<br>+ * This program is free software; you can redistribute it and/or mo=
dify<br>+ * it under the terms of the GNU General Public License as publish=
ed by<br>+ * the Free Software Foundation;version 2 of the License.<br>
+ *<br>+ */<br>+<br>+#ifndef _NUC900_AUDIO_H<br>+#define _NUC900_AUDIO_H<br=
>+<br>+#include &lt;linux/io.h&gt;<br>+<br>+/* Audio Control Registers */<b=
r>+#define ACTL_CON =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<b=
r>+#define ACTL_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
+#define ACTL_RDSTB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08<br>+#def=
ine ACTL_RDST_LENGTH =C2=A0 =C2=A0 =C2=A0 0x0C<br>+#define ACTL_RDSTC =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10<br>+#define ACTL_RSR =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x14<br>+#define ACTL_PDSTB =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x18<br>+#define ACTL_PDST_LENGTH =C2=A0=
 =C2=A0 =C2=A0 0x1C<br>
+#define ACTL_PDSTC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20<br>+#def=
ine ACTL_PSR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x24<br>+#def=
ine ACTL_IISCON =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x28<br>+#define A=
CTL_ACCON =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2C<br>+#define ACTL_A=
COS0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x30<br>+#define ACTL_ACOS1 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x34<br>
+#define ACTL_ACOS2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x38<br>+#def=
ine ACTL_ACIS0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3C<br>+#define A=
CTL_ACIS1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x40<br>+#define ACTL_A=
CIS2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x44<br>+#define ACTL_COUNTE=
R =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x48<br>+<br>+/* bit definition of REG=
_ACTL_CON register */<br>
+#define R_DMA_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1000<b=
r>+#define T_DMA_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0800=
<br>+#define IIS_AC_PIN_SEL =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0100<br>+#define =
FIFO_TH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0080<br>+#define ADC_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x0010<br>+#define M80_EN =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0008<br>
+#define ACLINK_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0004<b=
r>+#define IIS_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
x0002<br>+<br>+/* bit definition of REG_ACTL_RESET register */<br>+#define =
W5691_PLAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20000<br>+#define AC=
TL_RESET_BIT =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10000<br>
+#define RECORD_RIGHT_CHNNEL =C2=A0 =C2=A00x08000<br>+#define RECORD_LEFT_C=
HNNEL =C2=A0 =C2=A0 0x04000<br>+#define PLAY_RIGHT_CHNNEL =C2=A0 =C2=A0 =C2=
=A00x02000<br>+#define PLAY_LEFT_CHNNEL =C2=A0 =C2=A0 =C2=A0 0x01000<br>+#d=
efine DAC_PLAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00800<br>=
+#define ADC_RECORD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00400<br>
+#define M80_PLAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00200<=
br>+#define AC_RECORD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x001=
00<br>+#define AC_PLAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00080<br>+#define IIS_RECORD =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00040<br>+#define IIS_PLAY =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00020<br>
+#define DAC_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00010<=
br>+#define ADC_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x000=
08<br>+#define M80_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
00004<br>+#define AC_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x00002<br>+#define IIS_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x00001<br>+<br>+/* bit definition of REG_ACTL_ACCON register */<br>
+#define AC_BCLK_PU_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x20<br>+#define A=
C_R_FINISH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>+#define AC_W_F=
INISH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>+#define AC_W_RES =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>+#define AC_C_RES =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02<br>+<br>+/* bit defin=
ition of ACTL_RSR register */<br>
+#define R_FIFO_EMPTY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>+#define R=
_DMA_END_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x02<br>+#define R_DMA_MIDDL=
E_IRQ =C2=A0 =C2=A0 =C2=A0 0x01<br>+<br>+/* bit definition of ACTL_PSR regi=
ster */<br>+#define P_FIFO_EMPTY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br=
>+#define P_DMA_END_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x02<br>
+#define P_DMA_MIDDLE_IRQ =C2=A0 =C2=A0 =C2=A0 0x01<br>+<br>+/* bit definit=
ion of ACTL_ACOS0 register */<br>+#define SLOT1_VALID =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x01<br>+#define SLOT2_VALID =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x02<br>+#define SLOT3_VALID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x04<br>+#define SLOT4_VALID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x08<br>
+#define VALID_FRAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>+<br>=
+/* bit definition of ACTL_ACOS1 register */<br>+#define R_WB =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80<br>+<br>+#define COD=
EC_READY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>+#define RESET_PR=
SR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<br>+#define AUDIO_WRITE(a=
ddr, val) __raw_writel(val, addr)<br>
+#define AUDIO_READ(addr) =C2=A0 =C2=A0 =C2=A0 __raw_readl(addr)<br>+#defin=
e PCM_TX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>+#def=
ine PCM_RX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>+#d=
efine SUBSTREAM_TYPE(substream) \<br>+ =C2=A0 =C2=A0 =C2=A0 ((substream)-&g=
t;stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX : PCM_RX)<br>
+<br>+struct nuc900_audio {<br>+ =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio;<b=
r>+ =C2=A0 =C2=A0 =C2=A0 spinlock_t lock;<br>+ =C2=A0 =C2=A0 =C2=A0 dma_add=
r_t dma_addr[2];<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long buffersize[2];<br>=
+ =C2=A0 =C2=A0 =C2=A0 unsigned long irq_num;<br>+ =C2=A0 =C2=A0 =C2=A0 str=
uct snd_pcm_substream *substream;<br>
+ =C2=A0 =C2=A0 =C2=A0 struct resource *res;<br>+ =C2=A0 =C2=A0 =C2=A0 stru=
ct clk *clk;<br>+ =C2=A0 =C2=A0 =C2=A0 struct device *dev;<br>+<br>+};<br>+=
<br>+extern struct nuc900_audio *nuc900_ac97_data;<br>+extern struct snd_so=
c_dai nuc900_ac97_dai;<br>+extern struct snd_soc_platform nuc900_soc_platfo=
rm;<br>
+<br>+#endif /*end _NUC900_AUDIO_H */<br>diff --git a/sound/soc/nuc900/nuc9=
00-pcm.c b/sound/soc/nuc900/nuc900-pcm.c<br>new file mode 100644<br>index 0=
000000..32a503c<br>--- /dev/null<br>+++ b/sound/soc/nuc900/nuc900-pcm.c<br>
@@ -0,0 +1,352 @@<br>+/*<br>+ * Copyright (c) 2010 Nuvoton technology corpo=
ration.<br>+ *<br>+ * Wan ZongShun &lt;<a href=3D"http://mcuos.com/" target=
=3D"_blank">mcuos.com</a>@<a href=3D"http://gmail.com/" target=3D"_blank">g=
mail.com</a>&gt;<br>
+ *<br>+ * This program is free software; you can redistribute it and/or mo=
dify<br>+ * it under the terms of the GNU General Public License as publish=
ed by<br>+ * the Free Software Foundation;version 2 of the License.<br>
+ *<br>+ */<br>+<br>+#include &lt;linux/module.h&gt;<br>+#include &lt;linux=
/init.h&gt;<br>+#include &lt;linux/io.h&gt;<br>+#include &lt;linux/platform=
_device.h&gt;<br>+#include &lt;linux/slab.h&gt;<br>+#include &lt;linux/dma-=
mapping.h&gt;<br>
+<br>+#include &lt;sound/core.h&gt;<br>+#include &lt;sound/pcm.h&gt;<br>+#i=
nclude &lt;sound/pcm_params.h&gt;<br>+#include &lt;sound/soc.h&gt;<br>+<br>=
+#include &lt;mach/hardware.h&gt;<br>+<br>+#include &quot;nuc900-auido.h&qu=
ot;<br>
+<br>+static const struct snd_pcm_hardware nuc900_pcm_hardware =3D {<br>+ =
=C2=A0 =C2=A0 =C2=A0 .info =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =3D SNDRV_PCM_INFO_INTERLEAVED |<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SNDRV_PCM_INFO_BLOCK_TRANSFER |<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SNDRV_PCM_INFO_=
MMAP |<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SNDRV_PCM_INFO_=
MMAP_VALID |<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SNDRV_PCM_INFO_PAUSE |<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 SNDRV_PCM_INFO_RESUME,<br>+ =C2=A0 =C2=A0 =C2=A0 .formats=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D SNDRV_PCM_FMTBI=
T_S16_LE,<br>
+ =C2=A0 =C2=A0 =C2=A0 .channels_min =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 1,<br>+ =C2=A0 =C2=A0 =C2=A0 .channels_max =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 2,<br>+ =C2=A0 =C2=A0 =C2=A0 .buffer_bytes_max =C2=A0 =C2=A0 =C2=A0=
 =3D 4*1024,<br>+ =C2=A0 =C2=A0 =C2=A0 .period_bytes_min =C2=A0 =C2=A0 =C2=
=A0 =3D 1*1024,<br>+ =C2=A0 =C2=A0 =C2=A0 .period_bytes_max =C2=A0 =C2=A0 =
=C2=A0 =3D 4*1024,<br>+ =C2=A0 =C2=A0 =C2=A0 .periods_min =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,<br>
+ =C2=A0 =C2=A0 =C2=A0 .periods_max =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D 1024,<br>+};<br>+<br>+static int nuc900_dma_hw_params(struct snd_pcm=
_substream *substream,<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_hw_params *=
params)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D=
 substream-&gt;runtime;<br>
+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D runtime-&gt;pr=
ivate_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long flags, stype =3D SUBSTR=
EAM_TYPE(substream);<br>+ =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;nuc900_audio-&gt;lock, flags);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 ret =3D snd_pcm_lib_malloc_pages(substream, par=
ams_buffer_bytes(params));<br>+ =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;substream =3D substream;<br>+ =C2=A0 =C2=
=A0 =C2=A0 nuc900_audio-&gt;dma_addr[stype] =3D runtime-&gt;dma_addr;<br>
+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;buffersize[stype] =3D params_buffer=
_bytes(params);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&amp;=
nuc900_audio-&gt;lock, flags);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>+}<br>+<br>+static void nuc900_update_dma_register(struct snd_pcm_substre=
am *substream,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_addr_t dma_addr, size_t count)<br>+{<br=
>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-&gt;r=
untime;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D run=
time-&gt;private_data;<br>+ =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio_addr, *=
mmio_len;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (SUBSTREAM_TYPE(substream) =3D=3D PCM_TX) {<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_addr =3D nuc900_=
audio-&gt;mmio + ACTL_PDSTB;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmio_len =3D nuc900_audio-&gt;mmio + ACTL_PDST_LENGTH;<br>+ =C2=A0 =
=C2=A0 =C2=A0 } else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmio_addr =3D nuc900_audio-&gt;mmio + ACTL_RDSTB;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_len =3D nuc900_audi=
o-&gt;mmio + ACTL_RDST_LENGTH;<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0=
 =C2=A0 =C2=A0 AUDIO_WRITE(mmio_addr, dma_addr);<br>+ =C2=A0 =C2=A0 =C2=A0 =
AUDIO_WRITE(mmio_len, count);<br>+}<br>+<br>+static void nuc900_dma_start(s=
truct snd_pcm_substream *substream)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =
=3D runtime-&gt;private_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<=
br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + A=
CTL_CON);<br>
+ =C2=A0 =C2=A0 =C2=A0 val |=3D (T_DMA_IRQ | R_DMA_IRQ);<br>+ =C2=A0 =C2=A0=
 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_CON, val);<br>+}<br>+<br>+=
static void nuc900_dma_stop(struct snd_pcm_substream *substream)<br>+{<br>+=
 =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-&gt;run=
time;<br>
+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D runtime-&gt;pr=
ivate_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =
=C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_CON);<br>+ =
=C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~(T_DMA_IRQ | R_DMA_IRQ);<br>+ =C2=A0 =C2=
=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_CON, val);<br>
+}<br>+<br>+static irqreturn_t nuc900_dma_interrupt(int irq, void *dev_id)<=
br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_substream *substream =3D dev=
_id;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D substr=
eam-&gt;runtime-&gt;private_data;<br>
+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 sp=
in_lock(&amp;nuc900_audio-&gt;lock);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D=
 AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_CON);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 if (val &amp; R_DMA_IRQ) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_CON, val | R_DMA_IRQ);<=
br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(=
nuc900_audio-&gt;mmio + ACTL_RSR);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (val &amp; R_DMA_MIDDLE_IRQ) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D R_D=
MA_MIDDLE_IRQ;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RSR, val);<b=
r>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; R_DMA_END_IRQ) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val |=3D R_DMA_END_IRQ;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL=
_RSR, val);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+ =C2=A0 =C2=A0 =C2=A0 } else if (val &amp; T_DMA_IRQ) {<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACT=
L_CON, val | T_DMA_IRQ);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_PSR);<br>+<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; P_DMA_MIDDLE=
_IRQ) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val |=3D P_DMA_MIDDLE_IRQ;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + =
ACTL_PSR, val);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; P_DMA=
_END_IRQ) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 val |=3D P_DMA_END_IRQ;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_PSR, val);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>+ =C2=A0 =C2=A0 =C2=A0 } else {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(nuc900_audio-&gt=
;dev, &quot;Wrong DMA interrupt status!\n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;nuc900_audio-&gt;lock);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;<br>+=
 =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;nuc=
900_audio-&gt;lock);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 snd_pcm_period_elapsed(=
substream);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;<br>+}<br>+<b=
r>+static int nuc900_dma_hw_free(struct snd_pcm_substream *substream)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 snd_pcm_lib_free_pages(substream);<br>+ =C2=A0=
 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static int nuc900_dma_prepare(struc=
t snd_pcm_substream *substream)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_=
pcm_runtime *runtime =3D substream-&gt;runtime;<br>
+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D runtime-&gt;pr=
ivate_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long flags, val, stype =3D S=
UBSTREAM_TYPE(substream);;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave=
(&amp;nuc900_audio-&gt;lock, flags);<br>+<br>
+ =C2=A0 =C2=A0 =C2=A0 nuc900_update_dma_register(substream,<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;dma_addr[stype],=
 nuc900_audio-&gt;buffersize[stype]);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =
=3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_RESET);<br>+<br>+ =C2=A0 =C2=A0=
 =C2=A0 switch (runtime-&gt;channels) {<br>
+ =C2=A0 =C2=A0 =C2=A0 case 1:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (PCM_TX =3D=3D stype) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~(PLAY_LEFT_CHNN=
EL | PLAY_RIGHT_CHNNEL);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D PLAY_RIGHT_CHNNEL;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val &amp;=3D ~(RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=
=3D RECORD_RIGHT_CHNNEL;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc=
900_audio-&gt;mmio + ACTL_RESET, val);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>+ =C2=A0 =C2=
=A0 =C2=A0 case 2:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (PCM_TX =3D=3D stype)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D (PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHN=
NEL);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
al |=3D (RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio=
-&gt;mmio + ACTL_RESET, val);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>+ =C2=A0 =C2=A0 =C2=A0 default:<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>+ =C2=A0 =C2=A0 =C2=A0 }=
<br>+ =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&amp;nuc900_audio-&gt;loc=
k, flags);<br>
+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static int nuc900_dma_trigg=
er(struct snd_pcm_substream *substream, int cmd)<br>+{<br>+ =C2=A0 =C2=A0 =
=C2=A0 int ret =3D 0;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 switch (cmd) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_START:<br>+ =C2=A0 =C2=A0 =C2=
=A0 case SNDRV_PCM_TRIGGER_RESUME:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900_dma_start(substre=
am);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>+<br>+=
 =C2=A0 =C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_STOP:<br>+ =C2=A0 =C2=A0 =C2=
=A0 case SNDRV_PCM_TRIGGER_SUSPEND:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 nuc900_dma_stop(substream);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 default:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 break;<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =
=C2=A0 return ret;<br>+}<br>+<br>+int nuc900_dma_getposition(struct snd_pcm=
_substream *substream,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dma_addr_t *src, dma_addr_t *dst)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =
=3D runtime-&gt;private_data;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (src !=3D N=
ULL)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *src =3D AUDIO_R=
EAD(nuc900_audio-&gt;mmio + ACTL_PDSTC);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (dst !=3D NULL)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *dst =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACT=
L_RDSTC);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static sn=
d_pcm_uframes_t nuc900_dma_pointer(struct snd_pcm_substream *substream)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>+ =C2=A0 =C2=A0 =C2=A0 dma_addr_t src, dst;<br>+ =C2=A0 =C2=
=A0 =C2=A0 unsigned long res;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_dma_get=
position(substream, &amp;src, &amp;dst);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if =
(substream-&gt;stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D dst - runtime-&g=
t;dma_addr;<br>+ =C2=A0 =C2=A0 =C2=A0 else<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 res =3D src - runtime-&gt;dma_addr;<br>+<br>+ =C2=A0 =
=C2=A0 =C2=A0 return bytes_to_frames(substream-&gt;runtime, res);<br>+}<br>=
+<br>+static int nuc900_dma_open(struct snd_pcm_substream *substream)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio;<b=
r>+<br>+ =C2=A0 =C2=A0 =C2=A0 snd_soc_set_runtime_hwparams(substream, &amp;=
nuc900_pcm_hardware);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio =3D nuc90=
0_ac97_data;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (request_irq(nuc900_audio-&gt;irq_num, nuc90=
0_dma_interrupt,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_DISABLED, &quot;nuc900-dma&quot;, substream))=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;<br>+<=
br>+ =C2=A0 =C2=A0 =C2=A0 runtime-&gt;private_data =3D nuc900_audio;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static int nuc900_dma_=
close(struct snd_pcm_substream *substream)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 =
struct snd_pcm_runtime *runtime =3D substream-&gt;runtime;<br>+ =C2=A0 =C2=
=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D runtime-&gt;private_data;<=
br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 free_irq(nuc900_audio-&gt;irq_num, substream);<=
br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static int nuc900_d=
ma_mmap(struct snd_pcm_substream *substream,<br>+ =C2=A0 =C2=A0 =C2=A0 stru=
ct vm_area_struct *vma)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runt=
ime *runtime =3D substream-&gt;runtime;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 return dma_mmap_writecombine(substream-&gt;pcm-=
&gt;card-&gt;dev, vma,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 runtime-&gt;dma_area,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 runtime-&gt;dma_addr,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runtime-&gt;dma_bytes);<br>
+}<br>+<br>+static struct snd_pcm_ops nuc900_dma_ops =3D {<br>+ =C2=A0 =C2=
=A0 =C2=A0 .open =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D nuc900_dma_open,<br=
>+ =C2=A0 =C2=A0 =C2=A0 .close =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900=
_dma_close,<br>+ =C2=A0 =C2=A0 =C2=A0 .ioctl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D snd_pcm_lib_ioctl,<br>+ =C2=A0 =C2=A0 =C2=A0 .hw_params =C2=A0 =
=C2=A0 =C2=A0=3D nuc900_dma_hw_params,<br>
+ =C2=A0 =C2=A0 =C2=A0 .hw_free =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900_dma_h=
w_free,<br>+ =C2=A0 =C2=A0 =C2=A0 .prepare =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D n=
uc900_dma_prepare,<br>+ =C2=A0 =C2=A0 =C2=A0 .trigger =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D nuc900_dma_trigger,<br>+ =C2=A0 =C2=A0 =C2=A0 .pointer =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D nuc900_dma_pointer,<br>+ =C2=A0 =C2=A0 =C2=A0 .mmap =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D nuc900_dma_mmap,<br>
+};<br>+<br>+static void nuc900_dma_free_dma_buffers(struct snd_pcm *pcm)<b=
r>+{<br>+ =C2=A0 =C2=A0 =C2=A0 snd_pcm_lib_preallocate_free_for_all(pcm);<b=
r>+}<br>+<br>+static u64 nuc900_pcm_dmamask =3D DMA_BIT_MASK(32);<br>+stati=
c int nuc900_dma_new(struct snd_card *card,<br>
+ =C2=A0 =C2=A0 =C2=A0 struct snd_soc_dai *dai, struct snd_pcm *pcm)<br>+{<=
br>+ =C2=A0 =C2=A0 =C2=A0 if (!card-&gt;dev-&gt;dma_mask)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card-&gt;dev-&gt;dma_mask =3D &amp;n=
uc900_pcm_dmamask;<br>+ =C2=A0 =C2=A0 =C2=A0 if (!card-&gt;dev-&gt;coherent=
_dma_mask)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card-&gt;dev-&gt;coheren=
t_dma_mask =3D DMA_BIT_MASK(32);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 snd_pcm_lib=
_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card-&gt;dev, 4 * 1024, (4 * 1024) - 1);<br=
>+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+}<br>+<br>+struct snd_soc_platform nuc900_soc_platform =3D {<br>+ =C2=A0 =
=C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;nuc900-dma=
&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 .pcm_ops =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
amp;nuc900_dma_ops,<br>+ =C2=A0 =C2=A0 =C2=A0 .pcm_new =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D nuc900_dma_new,<br>+ =C2=A0 =C2=A0 =C2=A0 .pcm_free =C2=A0 =C2=
=A0 =C2=A0 =3D nuc900_dma_free_dma_buffers,<br>
+}<br>+EXPORT_SYMBOL_GPL(nuc900_soc_platform);<br>+<br>+static int __init n=
uc900_soc_platform_init(void)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 return snd_so=
c_register_platform(&amp;nuc900_soc_platform);<br>+}<br>+<br>+static void _=
_exit nuc900_soc_platform_exit(void)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 snd_soc_unregister_platform(&amp;nuc900_soc_pl=
atform);<br>+}<br>+<br>+module_init(nuc900_soc_platform_init);<br>+module_e=
xit(nuc900_soc_platform_exit);<br>+<br>+MODULE_AUTHOR(&quot;Wan ZongShun, &=
lt;<a href=3D"http://mcuos.com/" target=3D"_blank">mcuos.com</a>@<a href=3D=
"http://gmail.com/" target=3D"_blank">gmail.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;nuc900 Audio DMA module&quot;);<br>+MODULE_LICENS=
E(&quot;GPL&quot;);<br>-- <br>1.6.3.3<br><br>@@ -0,0 +1,27 @@<br>+##<br>+##=
 NUC900 series AC97 API<br>+##<br>+config SND_SOC_NUC900<br>+ =C2=A0 =C2=A0=
 =C2=A0 tristate &quot;SoC Audio for NUC900 series&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 depends on ARCH_W90X900<br>+ =C2=A0 =C2=A0 =C2=A0 he=
lp<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 This option enables support for AC97 mo=
de on the NUC900 SoC.<br>+<br>+config SND_SOC_NUC900_AC97<br>+ =C2=A0 =C2=
=A0 =C2=A0 tristate<br>+ =C2=A0 =C2=A0 =C2=A0 select AC97_BUS<br>+ =C2=A0 =
=C2=A0 =C2=A0 select SND_AC97_CODEC<br>
+ =C2=A0 =C2=A0 =C2=A0 select SND_SOC_AC97_BUS<br>+<br>+<br>+##<br>+## Boar=
ds<br>+##<br>+config SND_SOC_NUC900EVB<br>+ =C2=A0 =C2=A0 =C2=A0 tristate &=
quot;NUC900 AC97 support for demo board&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 dep=
ends on SND_SOC_NUC900<br>+ =C2=A0 =C2=A0 =C2=A0 select SND_SOC_NUC900_AC97=
<br>
+ =C2=A0 =C2=A0 =C2=A0 select SND_SOC_AC97_CODEC<br>+ =C2=A0 =C2=A0 =C2=A0 =
help<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 Select this option to enable audio (A=
C97) on the<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 NUC900 demoboard.<br>diff --gi=
t a/sound/soc/nuc900/Makefile b/sound/soc/nuc900/Makefile<br>new file mode =
100644<br>
index 0000000..7e46c71<br>--- /dev/null<br>+++ b/sound/soc/nuc900/Makefile<=
br>@@ -0,0 +1,11 @@<br>+# NUC900 series audio<br>+snd-soc-nuc900-pcm-objs :=
=3D nuc900-pcm.o<br>+snd-soc-nuc900-ac97-objs :=3D nuc900-ac97.o<br>+<br>+o=
bj-$(CONFIG_SND_SOC_NUC900) +=3D snd-soc-nuc900-pcm.o<br>
+obj-$(CONFIG_SND_SOC_NUC900_AC97) +=3D snd-soc-nuc900-ac97.o<br>+<br>+# Bo=
ards<br>+snd-soc-nuc900-audio-objs :=3D nuc900-audio.o<br>+<br>+obj-$(CONFI=
G_SND_SOC_NUC900EVB) +=3D snd-soc-nuc900-audio.o<br>diff --git a/sound/soc/=
nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c<br>
new file mode 100644<br>index 0000000..2c345e2<br>--- /dev/null<br>+++ b/so=
und/soc/nuc900/nuc900-ac97.c<br>@@ -0,0 +1,443 @@<br>+/*<br>+ * Copyright (=
c) 2009-2010 Nuvoton technology corporation.<br>+ *<br>+ * Wan ZongShun &lt=
;<a href=3D"http://mcuos.com/" target=3D"_blank">mcuos.com</a>@<a href=3D"h=
ttp://gmail.com/" target=3D"_blank">gmail.com</a>&gt;<br>
+ *<br>+ * This program is free software; you can redistribute it and/or mo=
dify<br>+ * it under the terms of the GNU General Public License as publish=
ed by<br>+ * the Free Software Foundation;version 2 of the License.<br>
+ *<br>+ */<br>+<br>+#include &lt;linux/init.h&gt;<br>+#include &lt;linux/m=
odule.h&gt;<br>+#include &lt;linux/slab.h&gt;<br>+#include &lt;linux/device=
.h&gt;<br>+#include &lt;linux/delay.h&gt;<br>+#include &lt;linux/mutex.h&gt=
;<br>
+#include &lt;linux/suspend.h&gt;<br>+#include &lt;sound/core.h&gt;<br>+#in=
clude &lt;sound/pcm.h&gt;<br>+#include &lt;sound/initval.h&gt;<br>+#include=
 &lt;sound/soc.h&gt;<br>+#include &lt;linux/device.h&gt;<br>+#include &lt;l=
inux/clk.h&gt;<br>
+<br>+#include &lt;mach/mfp.h&gt;<br>+<br>+#include &quot;nuc900-auido.h&qu=
ot;<br>+<br>+static DEFINE_MUTEX(ac97_mutex);<br>+struct nuc900_audio *nuc9=
00_ac97_data;<br>+<br>+static int nuc900_checkready(void)<br>+{<br>+ =C2=A0=
 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc900_ac97_data;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (!(AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_A=
CIS0) &amp; CODEC_READY))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -EPERM;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<b=
r>+/* AC97 controller reads codec register */<br>+static unsigned short nuc=
900_ac97_read(struct snd_ac97 *ac97,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned short =
reg)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D =
nuc900_ac97_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long timeout =3D 0x100=
00, val;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;ac97_mutex);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D nuc900_checkready();<br>+ =C2=A0 =C2=A0=
 =C2=A0 if (!!val) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dev_err(nuc900_audio-&gt;dev, &quot;AC97 codec is not ready\n&quot;);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>+ =C2=A0 =C2=
=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /* set the R_WB bit and write r=
egister index */<br>
+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS1, R_WB=
 | reg);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /* set the valid frame bit and vali=
d slots */<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mm=
io + ACTL_ACOS0);<br>+ =C2=A0 =C2=A0 =C2=A0 val |=3D (VALID_FRAME | SLOT1_V=
ALID);<br>
+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS0, val)=
;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(100);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 /* polling the AC_R_FINISH */<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_R=
EAD(nuc900_audio-&gt;mmio + ACTL_ACCON);<br>+ =C2=A0 =C2=A0 =C2=A0 val &amp=
;=3D AC_R_FINISH;<br>
+ =C2=A0 =C2=A0 =C2=A0 while (!val &amp;&amp; timeout--)<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(1);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 if (!timeout) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
ev_err(nuc900_audio-&gt;dev, &quot;AC97 read register time out !\n&quot;);<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D -EPERM;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>+ =C2=A0 =
=C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_au=
dio-&gt;mmio + ACTL_ACOS0) ;<br>+ =C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~SLOT1_=
VALID;<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_A=
COS0, val);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (AUDIO_READ(nuc900_audio-&gt;=
mmio + ACTL_ACIS1) &gt;&gt; 2 !=3D reg) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(nuc900_audio-&gt=
;dev,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;R_INDEX of REG_ACTL_ACIS1 n=
ot match!\n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 udelay(100);<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D (AUDIO_READ(nuc900_audio=
-&gt;mmio + ACTL_ACIS2) &amp; 0xFFFF);<br>
+<br>+out:<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>+ =
=C2=A0 =C2=A0 =C2=A0 return val;<br>+}<br>+<br>+/* AC97 controller writes t=
o codec register */<br>+static void nuc900_ac97_write(struct snd_ac97 *ac97=
, unsigned short reg,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned short val=
)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc900_a=
c97_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long tmp, timeout =3D 0x10000;=
<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;ac97_mutex);<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 tmp =3D nuc900_checkready();<br>+ =C2=A0 =C2=A0 =C2=A0 if=
 (!!tmp)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(nuc900_audio-&gt=
;dev, &quot;AC97 codec is not ready\n&quot;);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 /* clear the R_WB bit and write register index */<br>+ =C2=A0 =C2=A0 =
=C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS1, reg);<br>+<br>
+ =C2=A0 =C2=A0 =C2=A0 /* write register value */<br>+ =C2=A0 =C2=A0 =C2=A0=
 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS2, val);<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 /* set the valid frame bit and valid slots */<br>+ =C2=A0 =C2=A0=
 =C2=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACOS0);<br>
+ =C2=A0 =C2=A0 =C2=A0 tmp |=3D SLOT1_VALID | SLOT2_VALID | VALID_FRAME;<br=
>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS0, tmp=
);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(100);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 /* polling the AC_W_FINISH */<br>+ =C2=A0 =C2=A0 =C2=A0 tmp =3D AUDIO_R=
EAD(nuc900_audio-&gt;mmio + ACTL_ACCON);<br>
+ =C2=A0 =C2=A0 =C2=A0 tmp &amp;=3D AC_W_FINISH;<br>+ =C2=A0 =C2=A0 =C2=A0 =
while (tmp &amp;&amp; timeout--)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 mdelay(1);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (!timeout)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(nuc900_audio-&gt;d=
ev, &quot;AC97 write register time out !\n&quot;);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL=
_ACOS0);<br>+ =C2=A0 =C2=A0 =C2=A0 tmp &amp;=3D ~(SLOT1_VALID | SLOT2_VALID=
);<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACOS0=
, tmp);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>
+<br>+}<br>+<br>+static void nuc900_ac97_warm_reset(struct snd_ac97 *ac97)<=
br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc90=
0_ac97_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =
=C2=A0 =C2=A0 mutex_lock(&amp;ac97_mutex);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 /* warm reset AC 97 */<br>+ =C2=A0 =C2=A0 =C2=
=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACCON);<br>+ =C2=A0 =C2=
=A0 =C2=A0 val |=3D AC_W_RES;<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_=
audio-&gt;mmio + ACTL_ACCON, val);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(10=
00);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D nuc900_checkready();<br>+ =C2=A0 =C2=A0=
 =C2=A0 if (!!val)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 de=
v_err(nuc900_audio-&gt;dev, &quot;AC97 codec is not ready\n&quot;);<br>+<br=
>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>+}<br>+<br>+stati=
c void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc900_a=
c97_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 mutex_lock(&amp;ac97_mutex);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /* r=
eset Audio Controller */<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc90=
0_audio-&gt;mmio + ACTL_RESET);<br>
+ =C2=A0 =C2=A0 =C2=A0 val |=3D ACTL_RESET_BIT;<br>+ =C2=A0 =C2=A0 =C2=A0 A=
UDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RESET, val);<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(=
nuc900_audio-&gt;mmio + ACTL_RESET);<br>+ =C2=A0 =C2=A0 =C2=A0 val &amp;=3D=
 (~ACTL_RESET_BIT);<br>
+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RESET, val)=
;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 /* reset AC-link interface */<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AU=
DIO_READ(nuc900_audio-&gt;mmio + ACTL_RESET);<br>+ =C2=A0 =C2=A0 =C2=A0 val=
 |=3D AC_RESET;<br>
+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RESET, val)=
;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_RESET);<br>+ =C2=A0 =C2=
=A0 =C2=A0 val &amp;=3D ~AC_RESET;<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nu=
c900_audio-&gt;mmio + ACTL_RESET, val);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /*=
 cold reset AC 97 */<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_au=
dio-&gt;mmio + ACTL_ACCON);<br>+ =C2=A0 =C2=A0 =C2=A0 val |=3D AC_C_RES;<br=
>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_ACCON, val=
);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay(1000);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 va=
l =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACCON);<br>+ =C2=A0 =C2=A0 =
=C2=A0 val &amp;=3D (~AC_C_RES);<br>+ =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc9=
00_audio-&gt;mmio + ACTL_ACCON, val);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 udelay=
(1000);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>+<br>+}<br>+<=
br>+/* AC97 controller operations */<br>+struct snd_ac97_bus_ops soc_ac97_o=
ps =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 .read =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D nuc900_ac97_read,<br>+ =C2=A0 =C2=A0 =C2=A0 .write =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D nuc900_ac97_write,<br>
+ =C2=A0 =C2=A0 =C2=A0 .reset =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900_=
ac97_cold_reset,<br>+ =C2=A0 =C2=A0 =C2=A0 .warm_reset =C2=A0 =C2=A0 =3D nu=
c900_ac97_warm_reset,<br>+}<br>+EXPORT_SYMBOL_GPL(soc_ac97_ops);<br>+<br>+s=
tatic int nuc900_ac97_trigger(struct snd_pcm_substream *substream,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cmd, struct snd_soc_dai *dai)<br>+{<br>=
+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D nuc900_ac97_da=
ta;<br>+ =C2=A0 =C2=A0 =C2=A0 int ret, stype =3D SUBSTREAM_TYPE(substream);=
<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val, tmp;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 switc=
h (cmd) {<br>+ =C2=A0 =C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_START:<br>+ =C2=
=A0 =C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_RESUME:<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL=
_RESET);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PCM_TX =
=3D=3D stype) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACOS0);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp |=3D=
 (SLOT3_VALID | SLOT4_VALID | VALID_FRAME);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_aud=
io-&gt;mmio + ACTL_ACOS0, tmp);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_PSR);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
mp |=3D (P_DMA_END_IRQ | P_DMA_MIDDLE_IRQ);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_aud=
io-&gt;mmio + ACTL_PSR, tmp);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val |=3D AC_PLAY;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 } else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_RSR);<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tmp |=3D (R_DMA_END_IRQ | R_DMA_MIDDLE_IRQ);<br>+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RSR, tmp);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D AC_=
RECORD;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&=
gt;mmio + ACTL_RESET, val);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>+ =C2=A0 =
=C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_STOP:<br>+ =C2=A0 =C2=A0 =C2=A0 case S=
NDRV_PCM_TRIGGER_SUSPEND:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_RESET);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PCM_TX =3D=3D stype) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tmp =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_ACOS0);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp &amp=
;=3D ~(SLOT3_VALID | SLOT4_VALID);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio=
 + ACTL_ACOS0, tmp);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_PSR, RESET_PRSR);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val &amp;=3D ~AC_PLAY;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 } else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RSR, RESE=
T_PRSR);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val &amp;=3D ~AC_RECORD;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_=
WRITE(nuc900_audio-&gt;mmio + ACTL_RESET, val);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>+ =C2=A0 =C2=A0 =C2=A0 default:<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return ret;<br>+}<b=
r>+<br>+static int nuc900_ac97_probe(struct platform_device *pdev,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct snd_soc_dai =
*dai)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D=
 nuc900_ac97_data;<br>
+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mu=
tex_lock(&amp;ac97_mutex);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 /* enable unit cl=
ock */<br>+ =C2=A0 =C2=A0 =C2=A0 clk_enable(nuc900_audio-&gt;clk);<br>+<br>=
+ =C2=A0 =C2=A0 =C2=A0 /* enable audio controller and AC-link interface */<=
br>
+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_CON)=
;<br>+ =C2=A0 =C2=A0 =C2=A0 val |=3D (IIS_AC_PIN_SEL | ACLINK_EN);<br>+ =C2=
=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_CON, val);<br>+<=
br>+ =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;ac97_mutex);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static void nuc900_ac9=
7_remove(struct platform_device *pdev,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct snd_soc_dai =
*dai)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D=
 nuc900_ac97_data;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 clk_disable(nuc900_audio-&gt;clk);<br>+}<br>+<b=
r>+static struct snd_soc_dai_ops nuc900_ac97_dai_ops =3D {<br>+ =C2=A0 =C2=
=A0 =C2=A0 .trigger =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900_ac97_trigger,<br>=
+};<br>+<br>+struct snd_soc_dai nuc900_ac97_dai =3D {<br>
+ =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D &quot;nuc900-ac97&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 .p=
robe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc9=
00_ac97_probe,<br>+ =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D nuc900_ac97_remove,<br>+ =C2=A0 =C2=A0 =
=C2=A0 .ac97_control =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,<br>+ =C2=A0 =
=C2=A0 =C2=A0 .playback =3D {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rates =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D SNDRV_PCM_RATE_8000_48000,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .formats =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D SNDRV_P=
CM_FMTBIT_S16_LE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ch=
annels_min =C2=A0 =3D 1,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .channels_max =C2=A0 =3D 2,<br>+ =C2=A0 =C2=A0 =C2=A0 },<br>+ =C2=A0 =
=C2=A0 =C2=A0 .capture =3D {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rates =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D SNDRV_PCM_RATE_8000_48000,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .formats =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D SNDRV_P=
CM_FMTBIT_S16_LE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ch=
annels_min =C2=A0 =3D 1,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .channels_max =C2=A0 =3D 2,<br>+ =C2=A0 =C2=A0 =C2=A0 },<br>+ =C2=A0 =
=C2=A0 =C2=A0 .ops =3D &amp;nuc900_ac97_dai_ops,<br>
+}<br>+EXPORT_SYMBOL_GPL(nuc900_ac97_dai);<br>+<br>+static int __devinit nu=
c900_ac97_drvprobe(struct platform_device *pdev)<br>+{<br>+ =C2=A0 =C2=A0 =
=C2=A0 struct nuc900_audio *nuc900_audio;<br>+ =C2=A0 =C2=A0 =C2=A0 int ret=
;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (nuc900_ac97_data)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;<br>+<br>+=
 =C2=A0 =C2=A0 =C2=A0 nuc900_audio =3D kzalloc(sizeof(struct nuc900_audio),=
 GFP_KERNEL);<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900_audio)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 spin_lock_init(&amp;nuc900_audio-&gt;lock);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;res =3D platform_get_resource(=
pdev, IORESOURCE_MEM, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900_audio-&gt;r=
es) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out0;<br>+ =C2=
=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (!request_mem_region(=
nuc900_audio-&gt;res-&gt;start,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 resource_size(nuc900_audio-&gt;res), pdev-&gt;name)) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EBUSY;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out0;<br>+ =C2=A0 =C2=A0 =C2=A0 }<b=
r>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;mmio =3D ioremap(nuc900_audi=
o-&gt;res-&gt;start,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size(n=
uc900_audio-&gt;res));<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900_audio-&gt;mmio=
) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out1;<br>+ =C2=
=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;clk =3D=
 clk_get(&amp;pdev-&gt;dev, NULL);<br>
+ =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(nuc900_audio-&gt;clk)) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D PTR_ERR(nuc900_audio-&gt;clk=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out2;<br>+ =
=C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;irq_=
num =3D platform_get_irq(pdev, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900_au=
dio-&gt;irq_num) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EBUSY;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out2;<br>+ =C2=A0 =C2=A0=
 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_ac97_data =3D nuc900_audio;=
<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;dev =3D nuc900_ac97_dai.de=
v =3D =C2=A0&amp;pdev-&gt;dev;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 ret =3D snd_s=
oc_register_dai(&amp;nuc900_ac97_dai);<br>
+ =C2=A0 =C2=A0 =C2=A0 if (ret)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out3;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 mfp_set_groupg(nuc900_=
audio-&gt;dev); /* enbale ac97 multifunction pin*/<br>+<br>+ =C2=A0 =C2=A0 =
=C2=A0 return 0;<br>+<br>+out3:<br>+ =C2=A0 =C2=A0 =C2=A0 clk_put(nuc900_au=
dio-&gt;clk);<br>
+out2:<br>+ =C2=A0 =C2=A0 =C2=A0 iounmap(nuc900_audio-&gt;mmio);<br>+out1:<=
br>+ =C2=A0 =C2=A0 =C2=A0 release_mem_region(nuc900_audio-&gt;res-&gt;start=
,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource=
_size(nuc900_audio-&gt;res));<br>+out0:<br>+ =C2=A0 =C2=A0 =C2=A0 kfree(nuc=
900_audio);<br>
+ =C2=A0 =C2=A0 =C2=A0 return ret;<br>+}<br>+<br>+static int __devexit nuc9=
00_ac97_drvremove(struct platform_device *pdev)<br>+{<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 snd_soc_unregister_dai(&amp;nuc900_ac97_dai);<br>+<br>+ =C2=A0 =
=C2=A0 =C2=A0 clk_put(nuc900_ac97_data-&gt;clk);<br>
+ =C2=A0 =C2=A0 =C2=A0 iounmap(nuc900_ac97_data-&gt;mmio);<br>+ =C2=A0 =C2=
=A0 =C2=A0 release_mem_region(nuc900_ac97_data-&gt;res-&gt;start,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size(nuc900_ac97_data-&gt;res));<br>+<=
br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_ac97_data =3D NULL;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static struct platform=
_driver nuc900_ac97_driver =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 .driver =3D {<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D &quot;=
nuc900-audio&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .=
owner =C2=A0=3D THIS_MODULE,<br>+ =C2=A0 =C2=A0 =C2=A0 },<br>
+ =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900_=
ac97_drvprobe,<br>+ =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D __devexit_p(nuc900_ac97_drvremove),<br>+};<br>+<br>+static int __in=
it nuc900_ac97_init(void)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 return platform_d=
river_register(&amp;nuc900_ac97_driver);<br>
+}<br>+<br>+static void __exit nuc900_ac97_exit(void)<br>+{<br>+ =C2=A0 =C2=
=A0 =C2=A0 platform_driver_unregister(&amp;nuc900_ac97_driver);<br>+}<br>+<=
br>+module_init(nuc900_ac97_init);<br>+module_exit(nuc900_ac97_exit);<br>+<=
br>+MODULE_AUTHOR(&quot;Wan ZongShun &lt;<a href=3D"http://mcuos.com/" targ=
et=3D"_blank">mcuos.com</a>@<a href=3D"http://gmail.com/" target=3D"_blank"=
>gmail.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;NUC900 AC97 SoC driver!&quot;);<br>+MODULE_LICENS=
E(&quot;GPL&quot;);<br>+MODULE_ALIAS(&quot;platform:nuc900-ac97&quot;);<br>=
+<br>diff --git a/sound/soc/nuc900/nuc900-audio.c b/sound/soc/nuc900/nuc900=
-audio.c<br>
new file mode 100644<br>index 0000000..b33d5b8<br>--- /dev/null<br>+++ b/so=
und/soc/nuc900/nuc900-audio.c<br>@@ -0,0 +1,81 @@<br>+/*<br>+ * Copyright (=
c) 2010 Nuvoton technology corporation.<br>+ *<br>+ * Wan ZongShun &lt;<a h=
ref=3D"http://mcuos.com/" target=3D"_blank">mcuos.com</a>@<a href=3D"http:/=
/gmail.com/" target=3D"_blank">gmail.com</a>&gt;<br>
+ *<br>+ * This program is free software; you can redistribute it and/or mo=
dify<br>+ * it under the terms of the GNU General Public License as publish=
ed by<br>+ * the Free Software Foundation;version 2 of the License.<br>
+ *<br>+ */<br>+<br>+#include &lt;linux/module.h&gt;<br>+#include &lt;linux=
/moduleparam.h&gt;<br>+#include &lt;linux/timer.h&gt;<br>+#include &lt;linu=
x/interrupt.h&gt;<br>+#include &lt;linux/platform_device.h&gt;<br>+<br>
+#include &lt;sound/core.h&gt;<br>+#include &lt;sound/pcm.h&gt;<br>+#includ=
e &lt;sound/soc.h&gt;<br>+#include &lt;sound/soc-dapm.h&gt;<br>+<br>+#inclu=
de &quot;../codecs/ac97.h&quot;<br>+#include &quot;nuc900-auido.h&quot;<br>
+<br>+static struct snd_soc_dai_link nuc900evb_ac97_dai =3D {<br>+ =C2=A0 =
=C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;AC97&quot;=
,<br>+ =C2=A0 =C2=A0 =C2=A0 .stream_name =C2=A0 =C2=A0=3D &quot;AC97 HiFi&q=
uot;,<br>+ =C2=A0 =C2=A0 =C2=A0 .cpu_dai =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &am=
p;nuc900_ac97_dai,<br>+ =C2=A0 =C2=A0 =C2=A0 .codec_dai =C2=A0 =C2=A0 =C2=
=A0=3D &amp;ac97_dai,<br>
+};<br>+<br>+static struct snd_soc_card nuc900evb_audio_machine =3D {<br>+ =
=C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;NUC=
900EVB_AC97&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 .dai_link =C2=A0 =C2=A0 =C2=A0=
 =3D &amp;nuc900evb_ac97_dai,<br>+ =C2=A0 =C2=A0 =C2=A0 .num_links =C2=A0 =
=C2=A0 =C2=A0=3D 1,<br>+ =C2=A0 =C2=A0 =C2=A0 .platform =C2=A0 =C2=A0 =C2=
=A0 =3D &amp;nuc900_soc_platform,<br>
+};<br>+<br>+static struct snd_soc_device nuc900evb_ac97_devdata =3D {<br>+=
 =C2=A0 =C2=A0 =C2=A0 .card =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &amp;nuc=
900evb_audio_machine,<br>+ =C2=A0 =C2=A0 =C2=A0 .codec_dev =C2=A0 =C2=A0 =
=C2=A0=3D &amp;soc_codec_dev_ac97,<br>+};<br>+<br>+static struct platform_d=
evice *nuc900evb_asoc_dev;<br>
+<br>+static int __init nuc900evb_audio_init(void)<br>+{<br>+ =C2=A0 =C2=A0=
 =C2=A0 int ret;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;<br>+ =C2=
=A0 =C2=A0 =C2=A0 nuc900evb_asoc_dev =3D platform_device_alloc(&quot;soc-au=
dio&quot;, -1);<br>+ =C2=A0 =C2=A0 =C2=A0 if (!nuc900evb_asoc_dev)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 /* nuc900 board audio device */<br>+ =C2=A0 =C2=A0 =C2=A0=
 platform_set_drvdata(nuc900evb_asoc_dev, &amp;nuc900evb_ac97_devdata);<br>=
+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900evb_ac97_devdata.dev =3D &amp;nuc900evb_a=
soc_dev-&gt;dev;<br>
+ =C2=A0 =C2=A0 =C2=A0 ret =3D platform_device_add(nuc900evb_asoc_dev);<br>=
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 platform_device_put(nuc900evb_asoc_dev);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900evb_asoc_dev =3D NULL;<br>+ =
=C2=A0 =C2=A0 =C2=A0 }<br>+<br>+out:<br>+ =C2=A0 =C2=A0 =C2=A0 return ret;<=
br>
+}<br>+<br>+static void __exit nuc900evb_audio_exit(void)<br>+{<br>+ =C2=A0=
 =C2=A0 =C2=A0 platform_device_unregister(nuc900evb_asoc_dev);<br>+}<br>+<b=
r>+module_init(nuc900evb_audio_init);<br>+module_exit(nuc900evb_audio_exit)=
;<br>+<br>+MODULE_LICENSE(&quot;GPL&quot;);<br>
+MODULE_DESCRIPTION(&quot;NUC900 Series ASoC audio support&quot;);<br>+MODU=
LE_AUTHOR(&quot;Wan ZongShun&quot;);<br>diff --git a/sound/soc/nuc900/nuc90=
0-auido.h b/sound/soc/nuc900/nuc900-auido.h<br>new file mode 100644<br>
index 0000000..95ac4ef<br>--- /dev/null<br>+++ b/sound/soc/nuc900/nuc900-au=
ido.h<br>@@ -0,0 +1,121 @@<br>+/*<br>+ * Copyright (c) 2010 Nuvoton technol=
ogy corporation.<br>+ *<br>+ * Wan ZongShun &lt;<a href=3D"http://mcuos.com=
/" target=3D"_blank">mcuos.com</a>@<a href=3D"http://gmail.com/" target=3D"=
_blank">gmail.com</a>&gt;<br>
+ *<br>+ * This program is free software; you can redistribute it and/or mo=
dify<br>+ * it under the terms of the GNU General Public License as publish=
ed by<br>+ * the Free Software Foundation;version 2 of the License.<br>
+ *<br>+ */<br>+<br>+#ifndef _NUC900_AUDIO_H<br>+#define _NUC900_AUDIO_H<br=
>+<br>+#include &lt;linux/io.h&gt;<br>+<br>+/* Audio Control Registers */<b=
r>+#define ACTL_CON =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<b=
r>+#define ACTL_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
+#define ACTL_RDSTB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08<br>+#def=
ine ACTL_RDST_LENGTH =C2=A0 =C2=A0 =C2=A0 0x0C<br>+#define ACTL_RDSTC =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10<br>+#define ACTL_RSR =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x14<br>+#define ACTL_PDSTB =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x18<br>+#define ACTL_PDST_LENGTH =C2=A0=
 =C2=A0 =C2=A0 0x1C<br>
+#define ACTL_PDSTC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20<br>+#def=
ine ACTL_PSR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x24<br>+#def=
ine ACTL_IISCON =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x28<br>+#define A=
CTL_ACCON =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2C<br>+#define ACTL_A=
COS0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x30<br>+#define ACTL_ACOS1 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x34<br>
+#define ACTL_ACOS2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x38<br>+#def=
ine ACTL_ACIS0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3C<br>+#define A=
CTL_ACIS1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x40<br>+#define ACTL_A=
CIS2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x44<br>+#define ACTL_COUNTE=
R =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x48<br>+<br>+/* bit definition of REG=
_ACTL_CON register */<br>
+#define R_DMA_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1000<b=
r>+#define T_DMA_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0800=
<br>+#define IIS_AC_PIN_SEL =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0100<br>+#define =
FIFO_TH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0080<br>+#define ADC_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x0010<br>+#define M80_EN =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0008<br>
+#define ACLINK_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0004<b=
r>+#define IIS_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
x0002<br>+<br>+/* bit definition of REG_ACTL_RESET register */<br>+#define =
W5691_PLAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20000<br>+#define AC=
TL_RESET_BIT =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10000<br>
+#define RECORD_RIGHT_CHNNEL =C2=A0 =C2=A00x08000<br>+#define RECORD_LEFT_C=
HNNEL =C2=A0 =C2=A0 0x04000<br>+#define PLAY_RIGHT_CHNNEL =C2=A0 =C2=A0 =C2=
=A00x02000<br>+#define PLAY_LEFT_CHNNEL =C2=A0 =C2=A0 =C2=A0 0x01000<br>+#d=
efine DAC_PLAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00800<br>=
+#define ADC_RECORD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00400<br>
+#define M80_PLAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00200<=
br>+#define AC_RECORD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x001=
00<br>+#define AC_PLAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00080<br>+#define IIS_RECORD =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00040<br>+#define IIS_PLAY =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00020<br>
+#define DAC_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00010<=
br>+#define ADC_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x000=
08<br>+#define M80_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
00004<br>+#define AC_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x00002<br>+#define IIS_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x00001<br>+<br>+/* bit definition of REG_ACTL_ACCON register */<br>
+#define AC_BCLK_PU_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x20<br>+#define A=
C_R_FINISH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>+#define AC_W_F=
INISH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>+#define AC_W_RES =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>+#define AC_C_RES =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02<br>+<br>+/* bit defin=
ition of ACTL_RSR register */<br>
+#define R_FIFO_EMPTY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>+#define R=
_DMA_END_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x02<br>+#define R_DMA_MIDDL=
E_IRQ =C2=A0 =C2=A0 =C2=A0 0x01<br>+<br>+/* bit definition of ACTL_PSR regi=
ster */<br>+#define P_FIFO_EMPTY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br=
>+#define P_DMA_END_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x02<br>
+#define P_DMA_MIDDLE_IRQ =C2=A0 =C2=A0 =C2=A0 0x01<br>+<br>+/* bit definit=
ion of ACTL_ACOS0 register */<br>+#define SLOT1_VALID =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x01<br>+#define SLOT2_VALID =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x02<br>+#define SLOT3_VALID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x04<br>+#define SLOT4_VALID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x08<br>
+#define VALID_FRAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>+<br>=
+/* bit definition of ACTL_ACOS1 register */<br>+#define R_WB =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80<br>+<br>+#define COD=
EC_READY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>+#define RESET_PR=
SR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<br>+#define AUDIO_WRITE(a=
ddr, val) __raw_writel(val, addr)<br>
+#define AUDIO_READ(addr) =C2=A0 =C2=A0 =C2=A0 __raw_readl(addr)<br>+#defin=
e PCM_TX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>+#def=
ine PCM_RX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>+#d=
efine SUBSTREAM_TYPE(substream) \<br>+ =C2=A0 =C2=A0 =C2=A0 ((substream)-&g=
t;stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX : PCM_RX)<br>
+<br>+struct nuc900_audio {<br>+ =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio;<b=
r>+ =C2=A0 =C2=A0 =C2=A0 spinlock_t lock;<br>+ =C2=A0 =C2=A0 =C2=A0 dma_add=
r_t dma_addr[2];<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long buffersize[2];<br>=
+ =C2=A0 =C2=A0 =C2=A0 unsigned long irq_num;<br>+ =C2=A0 =C2=A0 =C2=A0 str=
uct snd_pcm_substream *substream;<br>
+ =C2=A0 =C2=A0 =C2=A0 struct resource *res;<br>+ =C2=A0 =C2=A0 =C2=A0 stru=
ct clk *clk;<br>+ =C2=A0 =C2=A0 =C2=A0 struct device *dev;<br>+<br>+};<br>+=
<br>+extern struct nuc900_audio *nuc900_ac97_data;<br>+extern struct snd_so=
c_dai nuc900_ac97_dai;<br>+extern struct snd_soc_platform nuc900_soc_platfo=
rm;<br>
+<br>+#endif /*end _NUC900_AUDIO_H */<br>diff --git a/sound/soc/nuc900/nuc9=
00-pcm.c b/sound/soc/nuc900/nuc900-pcm.c<br>new file mode 100644<br>index 0=
000000..32a503c<br>--- /dev/null<br>+++ b/sound/soc/nuc900/nuc900-pcm.c<br>
@@ -0,0 +1,352 @@<br>+/*<br>+ * Copyright (c) 2010 Nuvoton technology corpo=
ration.<br>+ *<br>+ * Wan ZongShun &lt;<a href=3D"http://mcuos.com/" target=
=3D"_blank">mcuos.com</a>@<a href=3D"http://gmail.com/" target=3D"_blank">g=
mail.com</a>&gt;<br>
+ *<br>+ * This program is free software; you can redistribute it and/or mo=
dify<br>+ * it under the terms of the GNU General Public License as publish=
ed by<br>+ * the Free Software Foundation;version 2 of the License.<br>
+ *<br>+ */<br>+<br>+#include &lt;linux/module.h&gt;<br>+#include &lt;linux=
/init.h&gt;<br>+#include &lt;linux/io.h&gt;<br>+#include &lt;linux/platform=
_device.h&gt;<br>+#include &lt;linux/slab.h&gt;<br>+#include &lt;linux/dma-=
mapping.h&gt;<br>
+<br>+#include &lt;sound/core.h&gt;<br>+#include &lt;sound/pcm.h&gt;<br>+#i=
nclude &lt;sound/pcm_params.h&gt;<br>+#include &lt;sound/soc.h&gt;<br>+<br>=
+#include &lt;mach/hardware.h&gt;<br>+<br>+#include &quot;nuc900-auido.h&qu=
ot;<br>
+<br>+static const struct snd_pcm_hardware nuc900_pcm_hardware =3D {<br>+ =
=C2=A0 =C2=A0 =C2=A0 .info =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =3D SNDRV_PCM_INFO_INTERLEAVED |<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SNDRV_PCM_INFO_BLOCK_TRANSFER |<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SNDRV_PCM_INFO_=
MMAP |<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SNDRV_PCM_INFO_=
MMAP_VALID |<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SNDRV_PCM_INFO_PAUSE |<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 SNDRV_PCM_INFO_RESUME,<br>+ =C2=A0 =C2=A0 =C2=A0 .formats=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D SNDRV_PCM_FMTBI=
T_S16_LE,<br>
+ =C2=A0 =C2=A0 =C2=A0 .channels_min =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 1,<br>+ =C2=A0 =C2=A0 =C2=A0 .channels_max =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 2,<br>+ =C2=A0 =C2=A0 =C2=A0 .buffer_bytes_max =C2=A0 =C2=A0 =C2=A0=
 =3D 4*1024,<br>+ =C2=A0 =C2=A0 =C2=A0 .period_bytes_min =C2=A0 =C2=A0 =C2=
=A0 =3D 1*1024,<br>+ =C2=A0 =C2=A0 =C2=A0 .period_bytes_max =C2=A0 =C2=A0 =
=C2=A0 =3D 4*1024,<br>+ =C2=A0 =C2=A0 =C2=A0 .periods_min =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,<br>
+ =C2=A0 =C2=A0 =C2=A0 .periods_max =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D 1024,<br>+};<br>+<br>+static int nuc900_dma_hw_params(struct snd_pcm=
_substream *substream,<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_hw_params *=
params)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D=
 substream-&gt;runtime;<br>
+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D runtime-&gt;pr=
ivate_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long flags, stype =3D SUBSTR=
EAM_TYPE(substream);<br>+ =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;nuc900_audio-&gt;lock, flags);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 ret =3D snd_pcm_lib_malloc_pages(substream, par=
ams_buffer_bytes(params));<br>+ =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;substream =3D substream;<br>+ =C2=A0 =C2=
=A0 =C2=A0 nuc900_audio-&gt;dma_addr[stype] =3D runtime-&gt;dma_addr;<br>
+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;buffersize[stype] =3D params_buffer=
_bytes(params);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&amp;=
nuc900_audio-&gt;lock, flags);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>+}<br>+<br>+static void nuc900_update_dma_register(struct snd_pcm_substre=
am *substream,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_addr_t dma_addr, size_t count)<br>+{<br=
>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-&gt;r=
untime;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D run=
time-&gt;private_data;<br>+ =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio_addr, *=
mmio_len;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (SUBSTREAM_TYPE(substream) =3D=3D PCM_TX) {<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_addr =3D nuc900_=
audio-&gt;mmio + ACTL_PDSTB;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmio_len =3D nuc900_audio-&gt;mmio + ACTL_PDST_LENGTH;<br>+ =C2=A0 =
=C2=A0 =C2=A0 } else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmio_addr =3D nuc900_audio-&gt;mmio + ACTL_RDSTB;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_len =3D nuc900_audi=
o-&gt;mmio + ACTL_RDST_LENGTH;<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0=
 =C2=A0 =C2=A0 AUDIO_WRITE(mmio_addr, dma_addr);<br>+ =C2=A0 =C2=A0 =C2=A0 =
AUDIO_WRITE(mmio_len, count);<br>+}<br>+<br>+static void nuc900_dma_start(s=
truct snd_pcm_substream *substream)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =
=3D runtime-&gt;private_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<=
br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + A=
CTL_CON);<br>
+ =C2=A0 =C2=A0 =C2=A0 val |=3D (T_DMA_IRQ | R_DMA_IRQ);<br>+ =C2=A0 =C2=A0=
 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_CON, val);<br>+}<br>+<br>+=
static void nuc900_dma_stop(struct snd_pcm_substream *substream)<br>+{<br>+=
 =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-&gt;run=
time;<br>
+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D runtime-&gt;pr=
ivate_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =
=C2=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_CON);<br>+ =
=C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~(T_DMA_IRQ | R_DMA_IRQ);<br>+ =C2=A0 =C2=
=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_CON, val);<br>
+}<br>+<br>+static irqreturn_t nuc900_dma_interrupt(int irq, void *dev_id)<=
br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_substream *substream =3D dev=
_id;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D substr=
eam-&gt;runtime-&gt;private_data;<br>
+ =C2=A0 =C2=A0 =C2=A0 unsigned long val;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 sp=
in_lock(&amp;nuc900_audio-&gt;lock);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =3D=
 AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_CON);<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 if (val &amp; R_DMA_IRQ) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_CON, val | R_DMA_IRQ);<=
br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D AUDIO_READ(=
nuc900_audio-&gt;mmio + ACTL_RSR);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (val &amp; R_DMA_MIDDLE_IRQ) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D R_D=
MA_MIDDLE_IRQ;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_RSR, val);<b=
r>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; R_DMA_END_IRQ) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val |=3D R_DMA_END_IRQ;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL=
_RSR, val);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+ =C2=A0 =C2=A0 =C2=A0 } else if (val &amp; T_DMA_IRQ) {<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACT=
L_CON, val | T_DMA_IRQ);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 val =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_PSR);<br>+<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; P_DMA_MIDDLE=
_IRQ) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val |=3D P_DMA_MIDDLE_IRQ;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + =
ACTL_PSR, val);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; P_DMA=
_END_IRQ) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 val |=3D P_DMA_END_IRQ;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AUDIO_WRITE(nuc900_audio-&gt;mmio + ACTL_PSR, val);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>+ =C2=A0 =C2=A0 =C2=A0 } else {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(nuc900_audio-&gt=
;dev, &quot;Wrong DMA interrupt status!\n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;nuc900_audio-&gt;lock);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;<br>+=
 =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;nuc=
900_audio-&gt;lock);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 snd_pcm_period_elapsed(=
substream);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;<br>+}<br>+<b=
r>+static int nuc900_dma_hw_free(struct snd_pcm_substream *substream)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 snd_pcm_lib_free_pages(substream);<br>+ =C2=A0=
 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static int nuc900_dma_prepare(struc=
t snd_pcm_substream *substream)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_=
pcm_runtime *runtime =3D substream-&gt;runtime;<br>
+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D runtime-&gt;pr=
ivate_data;<br>+ =C2=A0 =C2=A0 =C2=A0 unsigned long flags, val, stype =3D S=
UBSTREAM_TYPE(substream);;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave=
(&amp;nuc900_audio-&gt;lock, flags);<br>+<br>
+ =C2=A0 =C2=A0 =C2=A0 nuc900_update_dma_register(substream,<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900_audio-&gt;dma_addr[stype],=
 nuc900_audio-&gt;buffersize[stype]);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 val =
=3D AUDIO_READ(nuc900_audio-&gt;mmio + ACTL_RESET);<br>+<br>+ =C2=A0 =C2=A0=
 =C2=A0 switch (runtime-&gt;channels) {<br>
+ =C2=A0 =C2=A0 =C2=A0 case 1:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (PCM_TX =3D=3D stype) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~(PLAY_LEFT_CHNN=
EL | PLAY_RIGHT_CHNNEL);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D PLAY_RIGHT_CHNNEL;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val &amp;=3D ~(RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=
=3D RECORD_RIGHT_CHNNEL;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc=
900_audio-&gt;mmio + ACTL_RESET, val);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>+ =C2=A0 =C2=
=A0 =C2=A0 case 2:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (PCM_TX =3D=3D stype)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D (PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHN=
NEL);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
al |=3D (RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AUDIO_WRITE(nuc900_audio=
-&gt;mmio + ACTL_RESET, val);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>+ =C2=A0 =C2=A0 =C2=A0 default:<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>+ =C2=A0 =C2=A0 =C2=A0 }=
<br>+ =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&amp;nuc900_audio-&gt;loc=
k, flags);<br>
+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static int nuc900_dma_trigg=
er(struct snd_pcm_substream *substream, int cmd)<br>+{<br>+ =C2=A0 =C2=A0 =
=C2=A0 int ret =3D 0;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 switch (cmd) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_START:<br>+ =C2=A0 =C2=A0 =C2=
=A0 case SNDRV_PCM_TRIGGER_RESUME:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nuc900_dma_start(substre=
am);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>+<br>+=
 =C2=A0 =C2=A0 =C2=A0 case SNDRV_PCM_TRIGGER_STOP:<br>+ =C2=A0 =C2=A0 =C2=
=A0 case SNDRV_PCM_TRIGGER_SUSPEND:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 nuc900_dma_stop(substream);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 default:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 break;<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+<br>+ =C2=A0 =C2=A0 =
=C2=A0 return ret;<br>+}<br>+<br>+int nuc900_dma_getposition(struct snd_pcm=
_substream *substream,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dma_addr_t *src, dma_addr_t *dst)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio =
=3D runtime-&gt;private_data;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (src !=3D N=
ULL)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *src =3D AUDIO_R=
EAD(nuc900_audio-&gt;mmio + ACTL_PDSTC);<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (dst !=3D NULL)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *dst =3D AUDIO_READ(nuc900_audio-&gt;mmio + ACT=
L_RDSTC);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static sn=
d_pcm_uframes_t nuc900_dma_pointer(struct snd_pcm_substream *substream)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>+ =C2=A0 =C2=A0 =C2=A0 dma_addr_t src, dst;<br>+ =C2=A0 =C2=
=A0 =C2=A0 unsigned long res;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_dma_get=
position(substream, &amp;src, &amp;dst);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if =
(substream-&gt;stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D dst - runtime-&g=
t;dma_addr;<br>+ =C2=A0 =C2=A0 =C2=A0 else<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 res =3D src - runtime-&gt;dma_addr;<br>+<br>+ =C2=A0 =
=C2=A0 =C2=A0 return bytes_to_frames(substream-&gt;runtime, res);<br>+}<br>=
+<br>+static int nuc900_dma_open(struct snd_pcm_substream *substream)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>+ =C2=A0 =C2=A0 =C2=A0 struct nuc900_audio *nuc900_audio;<b=
r>+<br>+ =C2=A0 =C2=A0 =C2=A0 snd_soc_set_runtime_hwparams(substream, &amp;=
nuc900_pcm_hardware);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 nuc900_audio =3D nuc90=
0_ac97_data;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 if (request_irq(nuc900_audio-&gt;irq_num, nuc90=
0_dma_interrupt,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_DISABLED, &quot;nuc900-dma&quot;, substream))=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;<br>+<=
br>+ =C2=A0 =C2=A0 =C2=A0 runtime-&gt;private_data =3D nuc900_audio;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static int nuc900_dma_=
close(struct snd_pcm_substream *substream)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 =
struct snd_pcm_runtime *runtime =3D substream-&gt;runtime;<br>+ =C2=A0 =C2=
=A0 =C2=A0 struct nuc900_audio *nuc900_audio =3D runtime-&gt;private_data;<=
br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 free_irq(nuc900_audio-&gt;irq_num, substream);<=
br>+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>+}<br>+<br>+static int nuc900_d=
ma_mmap(struct snd_pcm_substream *substream,<br>+ =C2=A0 =C2=A0 =C2=A0 stru=
ct vm_area_struct *vma)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 struct snd_pcm_runt=
ime *runtime =3D substream-&gt;runtime;<br>
+<br>+ =C2=A0 =C2=A0 =C2=A0 return dma_mmap_writecombine(substream-&gt;pcm-=
&gt;card-&gt;dev, vma,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 runtime-&gt;dma_area,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 runtime-&gt;dma_addr,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runtime-&gt;dma_bytes);<br>
+}<br>+<br>+static struct snd_pcm_ops nuc900_dma_ops =3D {<br>+ =C2=A0 =C2=
=A0 =C2=A0 .open =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D nuc900_dma_open,<br=
>+ =C2=A0 =C2=A0 =C2=A0 .close =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900=
_dma_close,<br>+ =C2=A0 =C2=A0 =C2=A0 .ioctl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D snd_pcm_lib_ioctl,<br>+ =C2=A0 =C2=A0 =C2=A0 .hw_params =C2=A0 =
=C2=A0 =C2=A0=3D nuc900_dma_hw_params,<br>
+ =C2=A0 =C2=A0 =C2=A0 .hw_free =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nuc900_dma_h=
w_free,<br>+ =C2=A0 =C2=A0 =C2=A0 .prepare =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D n=
uc900_dma_prepare,<br>+ =C2=A0 =C2=A0 =C2=A0 .trigger =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D nuc900_dma_trigger,<br>+ =C2=A0 =C2=A0 =C2=A0 .pointer =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D nuc900_dma_pointer,<br>+ =C2=A0 =C2=A0 =C2=A0 .mmap =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D nuc900_dma_mmap,<br>
+};<br>+<br>+static void nuc900_dma_free_dma_buffers(struct snd_pcm *pcm)<b=
r>+{<br>+ =C2=A0 =C2=A0 =C2=A0 snd_pcm_lib_preallocate_free_for_all(pcm);<b=
r>+}<br>+<br>+static u64 nuc900_pcm_dmamask =3D DMA_BIT_MASK(32);<br>+stati=
c int nuc900_dma_new(struct snd_card *card,<br>
+ =C2=A0 =C2=A0 =C2=A0 struct snd_soc_dai *dai, struct snd_pcm *pcm)<br>+{<=
br>+ =C2=A0 =C2=A0 =C2=A0 if (!card-&gt;dev-&gt;dma_mask)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card-&gt;dev-&gt;dma_mask =3D &amp;n=
uc900_pcm_dmamask;<br>+ =C2=A0 =C2=A0 =C2=A0 if (!card-&gt;dev-&gt;coherent=
_dma_mask)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card-&gt;dev-&gt;coheren=
t_dma_mask =3D DMA_BIT_MASK(32);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 snd_pcm_lib=
_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card-&gt;dev, 4 * 1024, (4 * 1024) - 1);<br=
>+<br>+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+}<br>+<br>+struct snd_soc_platform nuc900_soc_platform =3D {<br>+ =C2=A0 =
=C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;nuc900-dma=
&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 .pcm_ops =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
amp;nuc900_dma_ops,<br>+ =C2=A0 =C2=A0 =C2=A0 .pcm_new =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D nuc900_dma_new,<br>+ =C2=A0 =C2=A0 =C2=A0 .pcm_free =C2=A0 =C2=
=A0 =C2=A0 =3D nuc900_dma_free_dma_buffers,<br>
+}<br>+EXPORT_SYMBOL_GPL(nuc900_soc_platform);<br>+<br>+static int __init n=
uc900_soc_platform_init(void)<br>+{<br>+ =C2=A0 =C2=A0 =C2=A0 return snd_so=
c_register_platform(&amp;nuc900_soc_platform);<br>+}<br>+<br>+static void _=
_exit nuc900_soc_platform_exit(void)<br>
+{<br>+ =C2=A0 =C2=A0 =C2=A0 snd_soc_unregister_platform(&amp;nuc900_soc_pl=
atform);<br>+}<br>+<br>+module_init(nuc900_soc_platform_init);<br>+module_e=
xit(nuc900_soc_platform_exit);<br>+<br>+MODULE_AUTHOR(&quot;Wan ZongShun, &=
lt;<a href=3D"http://mcuos.com/" target=3D"_blank">mcuos.com</a>@<a href=3D=
"http://gmail.com/" target=3D"_blank">gmail.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;nuc900 Audio DMA module&quot;);<br>+MODULE_LICENS=
E(&quot;GPL&quot;);<br><font color=3D"#888888">-- <br>1.6.3.3<br><br></font=
></blockquote></div><br><br clear=3D"all"><br>-- <br>*linux-arm-kernel mail=
ing list<br>
mail <a href=3D"mailto:addr%3Alinux-arm-kernel@lists.infradead.org">addr:li=
nux-arm-kernel@lists.infradead.org</a><br>you can subscribe by:<br><a href=
=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel">http://li=
sts.infradead.org/mailman/listinfo/linux-arm-kernel</a><br>
<br>* linux-arm-NUC900 mailing list<br>mail <a href=3D"mailto:addr%3ANUC900=
@googlegroups.com">addr:NUC900@googlegroups.com</a><br>main web: <a href=3D=
"https://groups.google.com/group/NUC900">https://groups.google.com/group/NU=
C900</a><br>
you can subscribe it by sending me mail:<br><a href=3D"http://mcuos.com">mc=
uos.com</a>@<a href=3D"http://gmail.com">gmail.com</a><br><br><br>

--000e0cd6adeeaa26440486d7ba07--


--===============0497894602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0497894602==--
