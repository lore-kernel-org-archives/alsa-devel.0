From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 1/4] ASoC: Intel: Skylake: Add debugfs
	support
Date: Thu, 29 Jun 2017 16:43:38 +0900
Message-ID: <e7607f1b-540b-fcda-a784-918ef9eafbeb@sakamocchi.jp>
References: <20170629065604.30105-1-guneshwor.o.singh@intel.com>
 <20170629065604.30105-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E39A9266E2C
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 09:43:43 +0200 (CEST)
In-Reply-To: <20170629065604.30105-2-guneshwor.o.singh@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Vinod Koul <vinod.koul@intel.com>, Vunny Sodhi <vunnyx.sodhi@intel.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 29 2017 15:56, Guneshwor Singh wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> For debug, the kernel debugfs mechanism is available. We can add various
> debug options for driver like module configuration read, firmware register
> read etc.
> 
> This patch adds debugfs root and caller is added for skylake driver to
> do init and cleanup of debugfs
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Vunny Sodhi <vunnyx.sodhi@intel.com>
> Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
> ---
>  sound/soc/intel/skylake/Makefile    |  4 +++
>  sound/soc/intel/skylake/skl-debug.c | 54 +++++++++++++++++++++++++++++++++++++
>  sound/soc/intel/skylake/skl.c       |  5 ++++
>  sound/soc/intel/skylake/skl.h       | 16 +++++++++++
>  4 files changed, 79 insertions(+)
>  create mode 100644 sound/soc/intel/skylake/skl-debug.c
> 
> diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
> index 60fbc9bbe473..e7d77722d560 100644
> --- a/sound/soc/intel/skylake/Makefile
> +++ b/sound/soc/intel/skylake/Makefile
> @@ -1,6 +1,10 @@
>  snd-soc-skl-objs := skl.o skl-pcm.o skl-nhlt.o skl-messages.o \
>  skl-topology.o
>  
> +ifdef CONFIG_DEBUG_FS
> +  snd-soc-skl-objs += skl-debug.o
> +endif
> +
>  obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
>  
>  # Skylake IPC Support
> diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
> new file mode 100644
> index 000000000000..c9a387e3d4f6
> --- /dev/null
> +++ b/sound/soc/intel/skylake/skl-debug.c
> @@ -0,0 +1,54 @@
> +/*
> + *  skl-debug.c - Debugfs for skl driver
> + *
> + *  Copyright (C) 2016-17 Intel Corp
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/debugfs.h>
> +#include "skl.h"
> +
> +struct skl_debug {
> +	struct skl *skl;
> +	struct device *dev;
> +
> +	struct dentry *fs;
> +};
> +
> +struct skl_debug *skl_debugfs_init(struct skl *skl)
> +{
> +	struct skl_debug *d;
> +
> +	d = devm_kzalloc(&skl->pci->dev, sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		return NULL;
> +
> +	/* create the root dir first */
> +	d->fs = debugfs_create_dir(KBUILD_MODNAME, NULL);

ALSA SoC part has a debugfs support. It adds "asoc" node into debugfs
mount point and export "snd_soc_debugfs_root" symbol as a root node. I
think it a better idea to collect relevant nodes into the place, rather
than dispersing them.

As a quick glance, "snd_soc_skl" depends on "snd_soc_core", which
exports the symbol. So no matter to dependencies.

$ lsmod | grep snd_soc_core
snd_soc_core          233472  1 snd_soc_skl
$ mount | grep debugfs
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
$ sudo find /sys/kernel/debug/asoc
/sys/kernel/debug/asoc
/sys/kernel/debug/asoc/platforms
/sys/kernel/debug/asoc/dais
/sys/kernel/debug/asoc/codecs

$ cd mainline.git/
$ git grep snd_soc_debugfs_root sound/soc/soc-core.c | grep EXPORT
sound/soc/soc-core.c:EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);


Regards

Takashi Sakamoto
