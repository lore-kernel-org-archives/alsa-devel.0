From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: intel: Fix crash at
 suspend/resume without card registration
Date: Mon, 28 Nov 2016 21:30:34 +0530
Message-ID: <20161128160034.GL6408@localhost>
References: <20161125155406.7617-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id B715F266EB4
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 16:50:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161125155406.7617-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 25, 2016 at 04:54:06PM +0100, Takashi Iwai wrote:
> When ASoC Intel SST Medfield driver is probed but without codec / card
> assigned, it causes an Oops and freezes the kernel at suspend/resume,
> 
>  PM: Suspending system (freeze)
>  Suspending console(s) (use no_console_suspend to debug)
>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
>  IP: [<ffffffffc09d9409>] sst_soc_prepare+0x19/0xa0 [snd_soc_sst_mfld_platform]
>  Oops: 0000 [#1] PREEMPT SMP
>  CPU: 0 PID: 1552 Comm: systemd-sleep Tainted: G W 4.9.0-rc6-1.g5f5c2ad-default #1
>  Call Trace:
>   [<ffffffffb45318f9>] dpm_prepare+0x209/0x460
>   [<ffffffffb4531b61>] dpm_suspend_start+0x11/0x60
>   [<ffffffffb40d3cc2>] suspend_devices_and_enter+0xb2/0x710
>   [<ffffffffb40d462e>] pm_suspend+0x30e/0x390
>   [<ffffffffb40d2eba>] state_store+0x8a/0x90
>   [<ffffffffb43c670f>] kobj_attr_store+0xf/0x20
>   [<ffffffffb42b0d97>] sysfs_kf_write+0x37/0x40
>   [<ffffffffb42b02bc>] kernfs_fop_write+0x11c/0x1b0
>   [<ffffffffb422be68>] __vfs_write+0x28/0x140
>   [<ffffffffb43728a8>] ? apparmor_file_permission+0x18/0x20
>   [<ffffffffb433b2ab>] ? security_file_permission+0x3b/0xc0
>   [<ffffffffb422d095>] vfs_write+0xb5/0x1a0
>   [<ffffffffb422e3d6>] SyS_write+0x46/0xa0
>   [<ffffffffb4719fbb>] entry_SYSCALL_64_fastpath+0x1e/0xad
> 
> Add proper NULL checks in the PM code of mdfld driver.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
