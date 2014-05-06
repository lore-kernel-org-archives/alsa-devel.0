From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [RFC 3/4] ASoC: Intel: add the low level dsp
 driver for mrfld
Date: Tue, 06 May 2014 16:45:52 +0100
Message-ID: <1399391152.2814.40.camel@loki>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C0BD261B2B
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 17:47:15 +0200 (CEST)
In-Reply-To: <1399312908-20744-4-git-send-email-vinod.koul@intel.com>
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
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-05-05 at 23:31 +0530, Vinod Koul wrote:
> This driver provides low level functions like sending and receiving IPCs, managing
> power for DSP etc
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  sound/soc/intel/sst/Makefile            |    5 +
>  sound/soc/intel/sst/sst.c               |  631 ++++++++++++++++++++
>  sound/soc/intel/sst/sst.h               |  686 ++++++++++++++++++++++
>  sound/soc/intel/sst/sst_drv_interface.c |  812 ++++++++++++++++++++++++++
>  sound/soc/intel/sst/sst_ipc.c           |  388 +++++++++++++
>  sound/soc/intel/sst/sst_loader.c        |  947 +++++++++++++++++++++++++++++++
>  sound/soc/intel/sst/sst_pvt.c           |  203 +++++++
>  sound/soc/intel/sst/sst_stream.c        |  529 +++++++++++++++++

We should rename the sst directory to avoid confusion with other sst
drivers.

>  8 files changed, 4201 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/intel/sst/Makefile
>  create mode 100644 sound/soc/intel/sst/sst.c
>  create mode 100644 sound/soc/intel/sst/sst.h
>  create mode 100644 sound/soc/intel/sst/sst_drv_interface.c
>  create mode 100644 sound/soc/intel/sst/sst_ipc.c
>  create mode 100644 sound/soc/intel/sst/sst_loader.c
>  create mode 100644 sound/soc/intel/sst/sst_pvt.c
>  create mode 100644 sound/soc/intel/sst/sst_stream.c
> 
> diff --git a/sound/soc/intel/sst/Makefile b/sound/soc/intel/sst/Makefile
> new file mode 100644
> index 0000000..d5bf4e8
> --- /dev/null
> +++ b/sound/soc/intel/sst/Makefile
> @@ -0,0 +1,5 @@
> +snd-intel-sst-objs := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
> +
> +obj-$(CONFIG_SND_INTEL_SST) += snd-intel-sst.o
> +
> +CFLAGS_snd-intel-sst.o = -I$(src)
> diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
> new file mode 100644
> index 0000000..116522b
> --- /dev/null
> +++ b/sound/soc/intel/sst/sst.c
> @@ -0,0 +1,631 @@
> +/*
> + *  sst.c - Intel SST Driver for audio engine
> + *
> + *  Copyright (C) 2008-14	Intel Corp
> + *  Authors:	Vinod Koul <vinod.koul@intel.com>
> + *		Harsha Priya <priya.harsha@intel.com>
> + *		Dharageswari R <dharageswari.r@intel.com>
> + *		KP Jeeja <jeeja.kp@intel.com>
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
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/fs.h>
> +#include <linux/interrupt.h>
> +#include <linux/firmware.h>
> +#include <linux/miscdevice.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>
> +#include <linux/async.h>
> +#include <linux/delay.h>
> +#include <linux/acpi.h>
> +#include <asm/intel-mid.h>
> +#include <asm/platform_sst_audio.h>
> +#include <asm/platform_sst.h>
> +#include "../sst_platform.h"
> +#include "../platform_ipc_v2.h"
> +#include "sst.h"
> +
> +MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
> +MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
> +MODULE_DESCRIPTION("Intel (R) SST(R) Audio Engine Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_VERSION(SST_DRIVER_VERSION);
> +
> +struct intel_sst_drv *sst_drv_ctx;

static ?

> +static struct mutex drv_ctx_lock;
> +


> +
> +static int sst_save_dsp_context_v2(struct intel_sst_drv *sst)

Is there a V1 somewhere ?


> +static int intel_sst_suspend(struct device *dev)
> +{
> +

extra line ? Spotted this in a few places too.

Probably best to split this into several patches to make review easier.

Liam

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
