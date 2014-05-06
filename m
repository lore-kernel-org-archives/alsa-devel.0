From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [RFC 4/4] ASoC: Intel: add support for mrfld DPCM
 platform
Date: Tue, 06 May 2014 16:53:18 +0100
Message-ID: <1399391598.2814.46.camel@loki>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BBDD261B2B
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 17:53:44 +0200 (CEST)
In-Reply-To: <1399312908-20744-5-git-send-email-vinod.koul@intel.com>
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
> This patch adds DPCM based supprt for managing mrfld platform
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  sound/soc/intel/Kconfig                          |    3 +
>  sound/soc/intel/platform-libs/controls_v2.h      |  754 +++++++++++++
>  sound/soc/intel/platform-libs/controls_v2_dpcm.c | 1315 ++++++++++++++++++++++
>  sound/soc/intel/platform-libs/sst_widgets.h      |  378 +++++++
>  sound/soc/intel/platform_ipc_v2.h                |  694 ++++++++++++
>  sound/soc/intel/sst-mfld-platform-compress.c     |    8 +-
>  sound/soc/intel/sst-mfld-platform-pcm.c          |  384 ++++++-
>  sound/soc/intel/sst-mfld-platform.h              |    2 +
>  8 files changed, 3480 insertions(+), 58 deletions(-)
>  create mode 100644 sound/soc/intel/platform-libs/controls_v2.h
>  create mode 100644 sound/soc/intel/platform-libs/controls_v2_dpcm.c
>  create mode 100644 sound/soc/intel/platform-libs/sst_widgets.h
>  create mode 100644 sound/soc/intel/platform_ipc_v2.h
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 422c32d..1254eb8 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -66,3 +66,6 @@ config SND_SOC_INTEL_MRFLD_WM8958_MACH
>            used as alsa device in audio substem in Intel(R) MID devices
>            Say Y if you have such a device
>            If unsure select "N".
> +
> +config SND_INTEL_SST
> +       tristate
> diff --git a/sound/soc/intel/platform-libs/controls_v2.h b/sound/soc/intel/platform-libs/controls_v2.h
> new file mode 100644
> index 0000000..7988d81
> --- /dev/null
> +++ b/sound/soc/intel/platform-libs/controls_v2.h
> @@ -0,0 +1,754 @@
> +/*
> + *  controls_v2.h - Intel MID Platform driver header file
> + *
> + *  Copyright (C) 2013-14 Intel Corp
> + *  Author: Ramesh Babu <ramesh.babu.koul@intel.com>
> + *  	Omair M Abdullah <omair.m.abdullah@intel.com>
> + *  	Samreen Nilofer <samreen.nilofer@intel.com>
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
> + *
> + */
> +
> +#ifndef __SST_CONTROLS_V2_H__
> +#define __SST_CONTROLS_V2_H__
> +
> +enum {
> +	MERR_DPCM_AUDIO = 0,
> +	MERR_DPCM_COMPR,

SST_ prefix


> +enum sst_cmd {
> +	SBA_IDLE		= 14,
> +	SBA_VB_SET_SPEECH_PATH	= 26,
> +	MMX_SET_GAIN		= 33,
> +	SBA_VB_SET_GAIN		= 33,
> +	FBA_VB_RX_CNI		= 35,
> +	MMX_SET_GAIN_TIMECONST	= 36,
> +	SBA_VB_SET_TIMECONST	= 36,
> +	FBA_VB_ANA		= 37,
> +	FBA_VB_SET_FIR		= 38,
> +	FBA_VB_SET_IIR		= 39,
> +	SBA_VB_START_TONE	= 41,
> +	SBA_VB_STOP_TONE	= 42,
> +	FBA_VB_AEC		= 47,
> +	FBA_VB_NR_UL		= 48,
> +	FBA_VB_AGC		= 49,
> +	FBA_VB_WNR		= 52,
> +	FBA_VB_SLV		= 53,
> +	FBA_VB_NR_DL		= 55,
> +	SBA_PROBE		= 66,
> +	MMX_PROBE		= 66,
> +	FBA_VB_SET_BIQUAD_D_C	= 69,
> +	FBA_VB_DUAL_BAND_COMP	= 70,
> +	FBA_VB_SNS		= 72,
> +	FBA_VB_SER		= 78,
> +	FBA_VB_TX_CNI		= 80,
> +	SBA_VB_START		= 85,
> +	FBA_VB_SET_REF_LINE	= 94,
> +	FBA_VB_SET_DELAY_LINE	= 95,
> +	FBA_VB_BWX		= 104,
> +	FBA_VB_GMM		= 105,
> +	FBA_VB_GLC		= 107,
> +	FBA_VB_BMF		= 111,
> +	FBA_VB_DNR		= 113,
> +	MMX_SET_SWM		= 114,
> +	SBA_SET_SWM		= 114,
> +	SBA_SET_MDRP            = 116,
> +	SBA_HW_SET_SSP		= 117,
> +	SBA_SET_MEDIA_LOOP_MAP	= 118,
> +	SBA_SET_MEDIA_PATH	= 119,
> +	MMX_SET_MEDIA_PATH	= 119,
> +	FBA_VB_TNR_UL		= 119,
> +	FBA_VB_TNR_DL		= 121,
> +	FBA_VB_NLF		= 125,
> +	SBA_VB_LPRO		= 126,
> +	FBA_VB_MDRP		= 127,
> +	SBA_VB_SET_FIR          = 128,
> +	SBA_VB_SET_IIR          = 129,
> +	SBA_SET_SSP_SLOT_MAP	= 130,
> +	AWARE_ENV_CLASS_PARAMS	= 130,
> +	VAD_ENV_CLASS_PARAMS	= 2049,
> +};

ditto


> +
> +#define MAX_DBG_RW_BYTES 80
> +#define MAX_NUM_SCATTER_BUFFERS 8
> +#define MAX_LOOP_BACK_DWORDS 8
> +/* IPC base address and mailbox, timestamp offsets */
> +#define SST_MAILBOX_SIZE 0x0400
> +#define SST_MAILBOX_SEND 0x0000
> +#define SST_TIME_STAMP 0x1800
> +#define SST_TIME_STAMP_MRFLD 0x680
> +#define SST_TIME_STAMP_BYT 0x800
> +#define SST_RESERVED_OFFSET 0x1A00
> +#define SST_SCU_LPE_MAILBOX 0x1000
> +#define SST_LPE_SCU_MAILBOX 0x1400
> +#define SST_SCU_LPE_LOG_BUF (SST_SCU_LPE_MAILBOX+16)
> +#define PROCESS_MSG 0x80
> +

ditto (for some of the above)

This could probably benefit from being split into smaller patches too.

Thanks !

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
