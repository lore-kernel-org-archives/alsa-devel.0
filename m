From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 10/19] ASoC: Intel: add mrfld DSP registers
Date: Fri, 20 Jun 2014 10:22:30 +0200
Message-ID: <53A3EF46.9000704@metafoo.de>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-236.synserver.de (smtp-out-242.synserver.de
 [212.40.185.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 14731261A0D
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 10:22:30 +0200 (CEST)
In-Reply-To: <1402662848-24534-11-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/13/2014 02:33 PM, Vinod Koul wrote:
> The add the registers space for MRFLD DSP. The initialization is done in
> soc_probe of the platform. This will be used in subsequent patches to add
> platform widgets
>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>   sound/soc/intel/Makefile                |    3 +-
>   sound/soc/intel/sst-atom-controls.c     |   90 +++++++++
>   sound/soc/intel/sst-atom-controls.h     |  318 +++++++++++++++++++++++++++++++
>   sound/soc/intel/sst-mfld-platform-pcm.c |   10 +-
>   sound/soc/intel/sst-mfld-platform.h     |   10 +
>   5 files changed, 429 insertions(+), 2 deletions(-)
>   create mode 100644 sound/soc/intel/sst-atom-controls.c
>
> diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
> index 4bfca79..9480b5d 100644
> --- a/sound/soc/intel/Makefile
> +++ b/sound/soc/intel/Makefile
> @@ -2,7 +2,8 @@
>   snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
>   snd-soc-sst-acpi-objs := sst-acpi.o
>
> -snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o sst-mfld-platform-compress.o
> +snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o \
> +	sst-mfld-platform-compress.o sst-atom-controls.o
>   snd-soc-mfld-machine-objs := mfld_machine.o
>
>   obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
> diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
> new file mode 100644
> index 0000000..f710888
> --- /dev/null
> +++ b/sound/soc/intel/sst-atom-controls.c
> @@ -0,0 +1,90 @@
> +/*
> + *  sst-atom-controls.c - Intel MID Platform driver DPCM ALSA controls for Mrfld
> + *
> + *  Copyright (C) 2013-14 Intel Corp
> + *  Author: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
> + *  	Vinod Koul <vinod.koul@intel.com>
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/slab.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +#include "sst-mfld-platform.h"
> +#include "sst-atom-controls.h"
> +
> +unsigned int sst_soc_read(struct snd_soc_platform *platform,
> +			unsigned int reg)
> +{
> +	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
> +
> +	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, drv->widget[reg]);
> +	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
> +	return drv->widget[reg];
> +}
> +
> +int sst_soc_write(struct snd_soc_platform *platform,
> +		  unsigned int reg, unsigned int val)
> +{
> +	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
> +
> +	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, val);
> +	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
> +	drv->widget[reg] = val;
> +	return 0;
> +}

These seem to be purely virtual registers, what is this about? The DAPM core 
is able to handle widgets and controls without any register backing just 
fine. There is no need to emulate virtual registers.

> +
> +unsigned int sst_reg_read(struct sst_data *drv, unsigned int reg,
> +			  unsigned int shift, unsigned int max)
> +{
[...]
> +}
> +
> +unsigned int sst_reg_write(struct sst_data *drv, unsigned int reg,
> +			   unsigned int shift, unsigned int max, unsigned int val)
> +{
[..]
> +}

How are these functions different from snd_soc_platform_{read,update_bits}()?

- Lars
