From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/3] ASoC: dapm - Use card mutex for DAPM
 ops instead of codec mutex.
Date: Mon, 05 Mar 2012 15:55:10 +0000
Message-ID: <1330962910.4370.21.camel@odin>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
	<1330711872-27436-2-git-send-email-lrg@ti.com>
	<20120304140939.GH3083@opensource.wolfsonmicro.com>
	<1330958882.4370.15.camel@odin>
	<20120305152616.GS3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FDA6104377
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 16:55:15 +0100 (CET)
Received: by mail-ww0-f49.google.com with SMTP id dr1so1355397wgb.18
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 07:55:12 -0800 (PST)
In-Reply-To: <20120305152616.GS3224@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-03-05 at 15:26 +0000, Mark Brown wrote:
> On Mon, Mar 05, 2012 at 02:48:02PM +0000, Liam Girdwood wrote:
> 
> > A separate DAPM mutex and subclass (for init and PCM ops) would be
> > required here but I'm fine with that too. 
> 
> What's the path where init and PCM ops end up fighting with each other
> for DAPM?  I can't think of one right now.
> 

PCM ops and DAPM don't fight with each other, there is a dependency with
the snd_card->control_rwsem. The calling ordering is different for init
that it is for kcontrol updates that causes the warning below :-

[   24.726867] ======================================================
[   24.733367] [ INFO: possible circular locking dependency detected ]
[   24.739959] 3.3.0-rc4+ #72 Not tainted
[   24.742919] -------------------------------------------------------
[   24.743927] alsactl/3986 is trying to acquire lock:
[   24.754455]  (&card->dapm_mutex){+.+.+.}, at: [<bf1f2858>] snd_soc_dapm_mixer_update_power+0x38/0x5c [snd_soc_core]
[   24.765075] 
[   24.765075] but task is already holding lock:
[   24.772979]  (&card->controls_rwsem){++++.+}, at: [<bf0519fc>] snd_ctl_ioctl+0x214/0xbc4 [snd]
[   24.778411] 
[   24.778411] which lock already depends on the new lock.
[   24.782165] 
[   24.782165] 
[   24.790771] the existing dependency chain (in reverse order) is:
[   24.798645] 
[   24.798645] -> #1 (&card->controls_rwsem){++++.+}:
[   24.805267]        [<c0098ab8>] __lock_acquire+0x1380/0x19dc
[   24.806579]        [<c0099698>] lock_acquire+0xa0/0x130
[   24.816741]        [<c04e08e8>] down_write+0x3c/0x4c
[   24.816741]        [<bf051280>] snd_ctl_add+0x70/0x1d0 [snd]
[   24.827331]        [<bf1f1534>] snd_soc_dapm_new_widgets+0x480/0x6ac [snd_soc_core]
[   24.827972]        [<bf311a38>] abe_mixer_add_widgets+0x194/0x218 [snd_soc_omap_abe]
[   24.839508]        [<bf310578>] abe_probe+0x4c8/0x6cc [snd_soc_omap_abe]
[   24.851348]        [<bf1eb914>] snd_soc_instantiate_cards+0x868/0x1210 [snd_soc_core]
[   24.851348]        [<bf1ec534>] snd_soc_register_dais+0x150/0x1f0 [snd_soc_core]
[   24.865783]        [<bf3a2960>] asoc_mcpdm_probe+0x14c/0x1d4 [snd_soc_omap_mcpdm]
[   24.874816]        [<c031fc18>] platform_drv_probe+0x28/0x2c
[   24.875427]        [<c031e4a4>] driver_probe_device+0xc0/0x2c4
[   24.882751]        [<c031e74c>] __driver_attach+0xa4/0xa8
[   24.889862]        [<c031ca0c>] bus_for_each_dev+0x60/0x8c
[   24.894531]        [<c031e074>] driver_attach+0x28/0x30
[   24.903167]        [<c031dc94>] bus_add_driver+0x1a4/0x288
[   24.903167]        [<c031ecdc>] driver_register+0x88/0x140
[   24.915008]        [<c031ff40>] platform_driver_register+0x54/0x68
[   24.922760]        [<bf3a5014>] 0xbf3a5014
[   24.922760]        [<c0008734>] do_one_initcall+0x48/0x190
[   24.932861]        [<c00a4554>] sys_init_module+0xeac/0x1da0
[   24.934997]        [<c0014780>] ret_fast_syscall+0x0/0x3c
[   24.944549] 
[   24.944549] -> #0 (&card->dapm_mutex){+.+.+.}:
[   24.948974]        [<c04db2e8>] print_circular_bug+0x68/0x2b8
[   24.952301]        [<c0098d14>] __lock_acquire+0x15dc/0x19dc
[   24.952301]        [<c0099698>] lock_acquire+0xa0/0x130
[   24.968353]        [<c04e0154>] mutex_lock_nested+0x4c/0x308
[   24.968353]        [<bf1f2858>] snd_soc_dapm_mixer_update_power+0x38/0x5c [snd_soc_core]
[   24.975769]        [<bf3110ec>] abe_put_switch+0x80/0xd0 [snd_soc_omap_abe]
[   24.983581]        [<bf052014>] snd_ctl_ioctl+0x82c/0xbc4 [snd]
[   24.996673]        [<c012851c>] do_vfs_ioctl+0x8c/0x590
[   24.999206]        [<c0128aa0>] sys_ioctl+0x80/0x88
[   25.007324]        [<c0014780>] ret_fast_syscall+0x0/0x3c
[   25.011810] 
[   25.011810] other info that might help us debug this:
[   25.013031] 
[   25.021453]  Possible unsafe locking scenario:
[   25.021453] 
[   25.027282]        CPU0                    CPU1
[   25.032440]        ----                    ----
[   25.037200]   lock(&card->controls_rwsem);
[   25.040435]                                lock(&card->dapm_mutex);
[   25.048126]                                lock(&card->controls_rwsem);
[   25.055084]   lock(&card->dapm_mutex);
[   25.059051] 
[   25.059051]  *** DEADLOCK ***
[   25.059051] 
[   25.059051] 2 locks held by alsactl/3986:
[   25.066955]  #0:  (&card->power_lock){+.+...}, at: [<bf0519dc>] snd_ctl_ioctl+0x1f4/0xbc4 [snd]
[   25.078704]  #1:  (&card->controls_rwsem){++++.+}, at: [<bf0519fc>] snd_ctl_ioctl+0x214/0xbc4 [snd]

Liam
