From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: PM issue with Intel SST Atom driver
Date: Mon, 24 Apr 2017 14:42:14 +0530
Message-ID: <20170424091213.GO6263@localhost>
References: <s5hpog5dgh8.wl-tiwai@suse.de> <20170424050144.GG6263@localhost>
 <s5ho9vmjmyv.wl-tiwai@suse.de> <s5hpog2b2o2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B959B265DB7
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 11:10:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpog2b2o2.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 11:00:45AM +0200, Takashi Iwai wrote:
 
> Removing ignore_suspend makes the PM succeeds.  But it hits some other
> ugly kernel bugs.

Okay have you marked .nonatomic = true for the machine DAIs?

> 
> At suspending:
> 
> [  567.913706] WARNING: CPU: 3 PID: 3144 at ../kernel/softirq.c:161 __local_bh_enable_ip+0x71/0x90
> [  567.913842] CPU: 3 PID: 3144 Comm: systemd-sleep Tainted: G         C O    4.11.0-rc7-3.g64b92e2-default #1
> [  567.913847] Call Trace:
> [  567.913861]  dump_stack+0x5c/0x7a
> [  567.913869]  __warn+0xbe/0xe0
> [  567.913879]  __local_bh_enable_ip+0x71/0x90
> [  567.913891]  sst_create_block+0x83/0xd0 [snd_intel_sst_core]
> [  567.913906]  sst_create_block_and_ipc_msg+0x4a/0x70 [snd_intel_sst_core]
> [  567.913920]  sst_prepare_and_post_msg+0x1a0/0x960 [snd_intel_sst_core]
> [  567.913936]  sst_pause_stream+0x9b/0x110 [snd_intel_sst_core]
> [  567.913952]  sst_platform_pcm_trigger+0x123/0x1b0 [snd_soc_sst_atom_hifi2_platform]
> [  567.913980]  soc_pcm_trigger+0xa0/0x120 [snd_soc_core]
> [  567.913996]  ? sst_soc_complete+0xa0/0xa0 [snd_soc_sst_atom_hifi2_platform]
> [  567.914012]  dpcm_fe_dai_do_trigger+0xc8/0x1f0 [snd_soc_core]
> [  567.914034]  snd_pcm_do_suspend+0x3d/0x40 [snd_pcm]
> [  567.914054]  snd_pcm_action_single+0x2a/0x70 [snd_pcm]
> [  567.914065]  snd_pcm_suspend+0x2c/0x40 [snd_pcm]
> [  567.914076]  snd_pcm_suspend_all+0x32/0x70 [snd_pcm]
> [  567.914092]  snd_soc_suspend+0x15c/0x3d0 [snd_soc_core]
> [  567.914102]  sst_soc_prepare+0x23/0xa0 [snd_soc_sst_atom_hifi2_platform]
> [  567.914108]  dpm_prepare+0x237/0x480
> [  567.914113]  dpm_suspend_start+0xd/0x50
> [  567.914117]  suspend_devices_and_enter+0xac/0x6f0
> [  567.914123]  pm_suspend+0x304/0x380
> [  567.914128]  state_store+0x5e/0x90
> [  567.914134]  kernfs_fop_write+0xfc/0x190
> [  567.914140]  __vfs_write+0x23/0x140
> [  567.914146]  ? handle_mm_fault+0xd3/0x240
> [  567.914148]  ? security_file_permission+0x36/0xb0
> [  567.914151]  vfs_write+0xb0/0x190
> [  567.914156]  SyS_write+0x42/0x90
> [  567.914160]  entry_SYSCALL_64_fastpath+0x1e/0xad
> [  567.914164] ---[ end trace b3703d94611f9a06 ]---
> [  567.914176] BUG: scheduling while atomic: systemd-sleep/3144/0x00000003
> [  567.914260] CPU: 3 PID: 3144 Comm: systemd-sleep Tainted: G        WC O    4.11.0-rc7-3.g64b92e2-default #1
> [  567.914262] Call Trace:
> [  567.914273]  dump_stack+0x5c/0x7a
> [  567.914278]  __schedule_bug+0x55/0x70
> [  567.914284]  __schedule+0x63c/0x8c0
> [  567.914290]  schedule+0x3d/0x90
> [  567.914295]  schedule_timeout+0x16b/0x320
> [  567.914301]  ? del_timer_sync+0x50/0x50
> [  567.914308]  ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
> [  567.914313]  ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
> [  567.914316]  ? remove_wait_queue+0x60/0x60
> [  567.914321]  ? sst_prepare_and_post_msg+0x275/0x960 [snd_intel_sst_core]
> [  567.914326]  ? sst_pause_stream+0x9b/0x110 [snd_intel_sst_core]
> [  567.914333]  ? sst_platform_pcm_trigger+0x123/0x1b0 [snd_soc_sst_atom_hifi2_platform]
> [  567.914346]  ? soc_pcm_trigger+0xa0/0x120 [snd_soc_core]
> [  567.914353]  ? sst_soc_complete+0xa0/0xa0 [snd_soc_sst_atom_hifi2_platform]
> [  567.914365]  ? dpcm_fe_dai_do_trigger+0xc8/0x1f0 [snd_soc_core]
> [  567.914373]  ? snd_pcm_do_suspend+0x3d/0x40 [snd_pcm]
> [  567.914381]  ? snd_pcm_action_single+0x2a/0x70 [snd_pcm]
> [  567.914389]  ? snd_pcm_suspend+0x2c/0x40 [snd_pcm]
> [  567.914396]  ? snd_pcm_suspend_all+0x32/0x70 [snd_pcm]
> [  567.914408]  ? snd_soc_suspend+0x15c/0x3d0 [snd_soc_core]
> [  567.914415]  ? sst_soc_prepare+0x23/0xa0 [snd_soc_sst_atom_hifi2_platform]
> [  567.914418]  ? dpm_prepare+0x237/0x480
> [  567.914421]  ? dpm_suspend_start+0xd/0x50
> [  567.914423]  ? suspend_devices_and_enter+0xac/0x6f0
> [  567.914426]  ? pm_suspend+0x304/0x380
> [  567.914428]  ? state_store+0x5e/0x90
> [  567.914430]  ? kernfs_fop_write+0xfc/0x190
> [  567.914433]  ? __vfs_write+0x23/0x140
> [  567.914437]  ? handle_mm_fault+0xd3/0x240
> [  567.914439]  ? security_file_permission+0x36/0xb0
> [  567.914442]  ? vfs_write+0xb0/0x190
> [  567.914445]  ? SyS_write+0x42/0x90
> [  567.914447]  ? entry_SYSCALL_64_fastpath+0x1e/0xad
> [  567.914857] BUG: scheduling while atomic: systemd-sleep/3144/0x7fffffff
> [  567.915222] CPU: 1 PID: 3144 Comm: systemd-sleep Tainted: G        WC O    4.11.0-rc7-3.g64b92e2-default #1
> [  567.915231] Call Trace:
> [  567.915300]  dump_stack+0x5c/0x7a
> [  567.915324]  __schedule_bug+0x55/0x70
> [  567.915345]  __schedule+0x63c/0x8c0
> [  567.915375]  schedule+0x3d/0x90
> [  567.915392]  async_synchronize_cookie_domain+0x85/0x130
> [  567.915414]  ? remove_wait_queue+0x60/0x60
> [  567.915472]  dapm_power_widgets+0x3d4/0x9c0 [snd_soc_core]
> [  567.915530]  ? sst_soc_complete+0xa0/0xa0 [snd_soc_sst_atom_hifi2_platform]
> [  567.915579]  ? snd_soc_dapm_stream_event+0x87/0xa0 [snd_soc_core]
> [  567.915628]  ? snd_soc_dapm_stream_event+0x87/0xa0 [snd_soc_core]
> [  567.915674]  ? snd_soc_suspend+0x39c/0x3d0 [snd_soc_core]
> [  567.915699]  ? sst_soc_prepare+0x23/0xa0 [snd_soc_sst_atom_hifi2_platform]
> [  567.915712]  ? dpm_prepare+0x237/0x480
> [  567.915723]  ? dpm_suspend_start+0xd/0x50
> [  567.915738]  ? suspend_devices_and_enter+0xac/0x6f0
> [  567.915749]  ? pm_suspend+0x304/0x380
> [  567.915757]  ? state_store+0x5e/0x90
> [  567.915771]  ? kernfs_fop_write+0xfc/0x190
> [  567.915785]  ? __vfs_write+0x23/0x140
> [  567.915800]  ? handle_mm_fault+0xd3/0x240
> [  567.915814]  ? security_file_permission+0x36/0xb0
> [  567.915824]  ? vfs_write+0xb0/0x190
> [  567.915834]  ? SyS_write+0x42/0x90
> [  567.915846]  ? entry_SYSCALL_64_fastpath+0x1e/0xad
> 
> 
> ... and at resume:
> 
> [  574.320255] BUG: scheduling while atomic: alsa-source-3/1729/0x00000003
> [  574.320435] CPU: 1 PID: 1729 Comm: alsa-source-3 Tainted: G        WC O    4.11.0-rc7-3.g64b92e2-default #1
> [  574.320440] Call Trace:
> [  574.320474]  dump_stack+0x5c/0x7a
> [  574.320484]  __schedule_bug+0x55/0x70
> [  574.320493]  __schedule+0x63c/0x8c0
> [  574.320503]  schedule+0x3d/0x90
> [  574.320509]  schedule_timeout+0x16b/0x320
> [  574.320517]  ? del_timer_sync+0x50/0x50
> [  574.320529]  ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
> [  574.320535]  ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
> [  574.320539]  ? remove_wait_queue+0x60/0x60
> [  574.320546]  ? sst_prepare_and_post_msg+0x275/0x960 [snd_intel_sst_core]
> [  574.320553]  ? sst_resume_stream+0x5b/0x100 [snd_intel_sst_core]
> [  574.320564]  ? sst_platform_pcm_trigger+0x6b/0x1b0 [snd_soc_sst_atom_hifi2_platform]
> [  574.320586]  ? soc_pcm_trigger+0xa0/0x120 [snd_soc_core]
> [  574.320603]  ? dpcm_fe_dai_do_trigger+0xc8/0x1f0 [snd_soc_core]
> [  574.320618]  ? snd_pcm_action_single+0x2a/0x70 [snd_pcm]
> [  574.320628]  ? snd_pcm_common_ioctl1+0x2e5/0xc60 [snd_pcm]
> [  574.320634]  ? do_signal+0x23/0x670
> [  574.320644]  ? snd_pcm_capture_ioctl1+0x117/0x280 [snd_pcm]
> [  574.320648]  ? ktime_get_ts64+0x4a/0xf0
> [  574.320659]  ? snd_pcm_capture_ioctl+0x2a/0x30 [snd_pcm]
> [  574.320663]  ? do_vfs_ioctl+0x8f/0x5d0
> [  574.320667]  ? __fget+0x70/0xc0
> [  574.320671]  ? SyS_ioctl+0x74/0x80
> [  574.320675]  ? entry_SYSCALL_64_fastpath+0x1e/0xad
> [  574.320799] show_signal_msg: 8 callbacks suppressed
> [  574.320805] alsa-source-3[1729]: segfault at 7f28e8052000 ip 00007f28f635eac4 sp 00007f28f0ad4be8 error 6
> [  574.320882] BUG: scheduling while atomic: alsa-source-3/1729/0x7fffffff
> [  574.321040] CPU: 1 PID: 1729 Comm: alsa-source-3 Tainted: G        WC O    4.11.0-rc7-3.g64b92e2-default #1
> [  574.321043] Call Trace:
> [  574.321068]  dump_stack+0x5c/0x7a
> [  574.321076]  __schedule_bug+0x55/0x70
> [  574.321083]  __schedule+0x63c/0x8c0
> [  574.321093]  ? wakeup_preempt_entity.isra.58+0x3c/0x50
> [  574.321097]  schedule+0x3d/0x90
> [  574.321104]  schedule_timeout+0x25a/0x320
> [  574.321109]  ? check_preempt_curr+0x79/0x90
> [  574.321113]  ? select_task_rq_rt+0x57/0xa0
> [  574.321117]  ? sched_clock+0x5/0x10
> [  574.321120]  ? sched_clock_cpu+0xc/0xc0
> [  574.321124]  ? wait_for_completion+0xe6/0x150
> [  574.321128]  ? wait_for_completion+0xe6/0x150
> [  574.321131]  ? wake_up_q+0x80/0x80
> [  574.321135]  ? do_coredump+0x3ab/0xf10
> [  574.321139]  ? __wake_up+0x34/0x50
> [  574.321144]  ? get_signal+0x33b/0x660
> [  574.321150]  ? do_signal+0x23/0x670
> [  574.321154]  ? __send_signal+0x213/0x4d0
> [  574.321160]  ? force_sig_info_fault+0x88/0xd0
> [  574.321166]  ? exit_to_usermode_loop+0x71/0xb0
> [  574.321169]  ? prepare_exit_to_usermode+0x2a/0x30
> [  574.321172]  ? retint_user+0x8/0x10
> 
> 
> There seem many beasts hidden in this jungle...
> 
> 
> Takashi

-- 
~Vinod
