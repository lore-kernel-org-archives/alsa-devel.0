From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v4 05/14] ASoC: SOF: Add PCM operations
	support
Date: Mon, 18 Feb 2019 17:51:33 +0200
Message-ID: <CAEnQRZCKZiD=yE0X_TqpiTM6_7e03cp_aA2+od9eF50cJsW4Qg@mail.gmail.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220734.10471-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

One comment inline:

On Thu, Feb 14, 2019 at 12:07 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>
> Add support for exposing PCMs to userspace. PCMs are defined by topology
> and the operations in this patch map to SOF IPC calls.
>
> The .ignore_module_refcount field is set to allow for module
> load/unload tests. There is no risk of the sof-pci/acpi-dev module
> being removed while the platform components are in use. This may need
> to be revisited when DT platforms are supported.
>
> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/sof/pcm.c | 710 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 710 insertions(+)
>  create mode 100644 sound/soc/sof/pcm.c
>
> diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
> new file mode 100644
> index 000000000000..3376633b0d46
> --- /dev/null
> +++ b/sound/soc/sof/pcm.c
> @@ -0,0 +1,710 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +//
> +// This file is provided under a dual BSD/GPLv2 license.  When using or
> +// redistributing this file, you may do so under either license.
> +//
> +// Copyright(c) 2018 Intel Corporation. All rights reserved.
> +//
> +// Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> +//
> +// PCM Layer, interface between ALSA and IPC.
> +//
> +
> +#include <linux/pm_runtime.h>
> +#include <sound/pcm_params.h>
> +#include <sound/sof.h>
> +#include "sof-priv.h"
> +#include "ops.h"
> +
> +#define DRV_NAME       "sof-audio-component"
> +
> +/* Create DMA buffer page table for DSP */
> +static int create_page_table(struct snd_pcm_substream *substream,
> +                            unsigned char *dma_area, size_t size)

dma_area is the virtual address of the DMA-able buffer. Currently, it is not
used and it is confusing. Does it makes sense to remove it?

Also, can you explain better the whole concept of page tables? As far as
I understand the only "Shared Memory" between host and DSP is the
mailbox area, right? And it is small 4k.

Now, as for transferring audio buffers: It seems that because DSP has no
direct access to host memory a DMA controller is involved? This can be
programmed to copy buffers from host "address space" to DSP "address
space"

Information for the host audio buffers is sent via compressed physical
addresses, right?
