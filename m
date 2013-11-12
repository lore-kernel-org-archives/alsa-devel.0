From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [snd_msnd_init] WARNING: CPU: 0 PID: 1 at
 fs/sysfs/dir.c:486 sysfs_warn_dup+0x7d/0xa0()
Date: Tue, 12 Nov 2013 16:35:36 +0800
Message-ID: <20131112083536.GA32285@localhost>
References: <20131112001104.GA23993@localhost> <s5h7gcec9za.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 911AF26087D
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 09:35:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7gcec9za.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 12, 2013 at 09:14:49AM +0100, Takashi Iwai wrote:
> At Tue, 12 Nov 2013 08:11:04 +0800,
> Fengguang Wu wrote:
> > 
> > Greetings,
> > 
> > I got this warning when booting a kernel with the attached kconfig.
> > 
> > [    5.073253] kobject: 'msnd-pinnacle.7' (cec33408): kobject_release, parent   (null) (delayed)
> > [    5.074347] kobject: 'msnd-pinnacle' (cecd4980): kobject_release, parent cf3ad9b0 (delayed)
> > [    5.075576] ------------[ cut here ]------------
> > [    5.076200] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:486 sysfs_warn_dup+0x7d/0xa0()
> > [    5.077434] sysfs: cannot create duplicate filename '/bus/isa/drivers/msnd-pinnacle'
> > [    5.078422] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-wl-05537-gf1c1073 #242
> > [    5.079529] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> > [    5.080418]  00000000 00000000 cb857d74 c17a4989 cb857db4 cb857da4 c10944ba c1a23264
> > [    5.081680]  cb857dd0 00000001 c1a231f8 000001e6 c11c051d c11c051d c0025000 000001e6
> > [    5.083104]  c0025000 cb857dbc c109452e 00000009 cb857db4 c1a23264 cb857dd0 cb857de0
> > [    5.084361] Call Trace:
> > [    5.084745]  [<c17a4989>] dump_stack+0x4b/0x98
> > [    5.085463]  [<c10944ba>] warn_slowpath_common+0x7a/0xa0
> > [    5.086182]  [<c11c051d>] ? sysfs_warn_dup+0x7d/0xa0
> > [    5.086785]  [<c11c051d>] ? sysfs_warn_dup+0x7d/0xa0
> > [    5.087397]  [<c109452e>] warn_slowpath_fmt+0x2e/0x30
> > [    5.087980]  [<c11c051d>] sysfs_warn_dup+0x7d/0xa0
> > [    5.088621]  [<c11c0569>] sysfs_add_one+0x29/0x40
> > [    5.089230]  [<c11c0648>] create_dir+0x58/0xa0
> > [    5.089797]  [<c11c0a1d>] sysfs_create_dir_ns+0xfd/0x120
> > [    5.090709]  [<c12343c2>] kobject_add_internal+0xc2/0x240
> > [    5.091505]  [<c1179fbb>] ? kfree+0x7b/0x210
> > [    5.092211]  [<c1233fc2>] ? kobject_set_name_vargs+0x42/0x60
> > [    5.092978]  [<c123458d>] kobject_init_and_add+0x4d/0x60
> > [    5.093706]  [<c13e108a>] bus_add_driver+0x7a/0x200
> > [    5.094351]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
> > [    5.095085]  [<c13ebbb0>] ? isa_bus_remove+0x30/0x30
> > [    5.095817]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
> > [    5.096521]  [<c13e285f>] driver_register+0xaf/0xf0
> > [    5.097136]  [<c10c4492>] ? preempt_count_sub+0xf2/0x150
> > [    5.097795]  [<c13ebca6>] isa_register_driver+0x26/0x160
> > [    5.098534]  [<c1c1c6e0>] ? alsa_card_gusextreme_init+0x14/0x14
> > [    5.099423]  [<c17b3f20>] ? _raw_spin_unlock+0x50/0x60
> > [    5.100093]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
> > [    5.100715]  [<c1c1c73b>] snd_msnd_init+0x12/0x49
> > [    5.101336]  [<c1bd3bb3>] do_one_initcall+0x90/0x155
> > [    5.102207]  [<c10d00e0>] ? put_prev_task_fair+0x130/0x490
> > [    5.102891]  [<c123ecfd>] ? strlen+0xd/0x20
> > [    5.103490]  [<c1bd3500>] ? do_early_param+0x5e/0x7a
> > [    5.104164]  [<c10b4a6c>] ? parse_args+0x1ec/0x330
> > [    5.104746]  [<c17b3fa8>] ? _raw_spin_unlock_irqrestore+0x78/0x90
> > [    5.105526]  [<c1bd3e18>] kernel_init_freeable+0x1a0/0x23f
> > [    5.106240]  [<c1bd351c>] ? do_early_param+0x7a/0x7a
> > [    5.106961]  [<c179bbcb>] kernel_init+0xb/0x150
> > [    5.107566]  [<c17b5937>] ret_from_kernel_thread+0x1b/0x28
> > [    5.108356]  [<c179bbc0>] ? rest_init+0xc0/0xc0
> > [    5.109054] ---[ end trace f2f06bffaee363dd ]---
> > [    5.109705] ------------[ cut here ]------------
> 
> The patch below should fix the issue.

Thanks for the quick fix! Takashi, you may directly push it to your
tree (to some temp branch if not sure) and I'll then check the test
results. :)

Thanks,
Fengguang

> ===
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: msnd: Avoid duplicated driver name
> 
> msnd_pinnacle.c is used for both snd-msnd-pinnacle and
> snd-msnd-classic drivers, and both should have different driver
> names.  Using the same driver name results in the sysfs warning for
> duplicated entries like
>  kobject: 'msnd-pinnacle.7' (cec33408): kobject_release, parent   (null) (delayed)
>  kobject: 'msnd-pinnacle' (cecd4980): kobject_release, parent cf3ad9b0 (delayed)
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:486 sysfs_warn_dup+0x7d/0xa0()
>  sysfs: cannot create duplicate filename '/bus/isa/drivers/msnd-pinnacle'
>  ......
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/isa/msnd/msnd_pinnacle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
> index 81aeb934261a..0a90bd6ae232 100644
> --- a/sound/isa/msnd/msnd_pinnacle.c
> +++ b/sound/isa/msnd/msnd_pinnacle.c
> @@ -73,9 +73,11 @@
>  #ifdef MSND_CLASSIC
>  #  include "msnd_classic.h"
>  #  define LOGNAME			"msnd_classic"
> +#  define DEV_NAME			"msnd-classic"
>  #else
>  #  include "msnd_pinnacle.h"
>  #  define LOGNAME			"snd_msnd_pinnacle"
> +#  define DEV_NAME			"msnd-pinnacle"
>  #endif
>  
>  static void set_default_audio_parameters(struct snd_msnd *chip)
> @@ -1067,8 +1069,6 @@ static int snd_msnd_isa_remove(struct device *pdev, unsigned int dev)
>  	return 0;
>  }
>  
> -#define DEV_NAME "msnd-pinnacle"
> -
>  static struct isa_driver snd_msnd_driver = {
>  	.match		= snd_msnd_isa_match,
>  	.probe		= snd_msnd_isa_probe,
> -- 
> 1.8.4.2
> 
