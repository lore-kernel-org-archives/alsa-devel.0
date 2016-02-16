From: Vinod Koul <vinod.koul@intel.com>
Subject: another locking issue with nonatomic ops?
Date: Tue, 16 Feb 2016 21:07:11 +0530
Message-ID: <20160216153711.GW19598@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 587AA2606EB
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 16:33:22 +0100 (CET)
Content-Disposition: inline
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

We found another issue with non atomic ops.

This occurs when we have snd_pcm_do_prepare being invoked which acquires
the lock snd_pcm_link_rwsem twice, first in snd_pcm_common_ioctl1, and then again in
dpcm_dapm_stream_event. Normally this is fine, but if we have another stream
get closed in between two read accesses we get stuck.

First thread:

[  419.657259] AudioOut_2      D ffff8800704a3a60     0  3691      1	0x20020004
[  419.665946]  ffff8800704a3a60 00000000704a3a60 ffff88006d1fddd0 ffffffff8252ffd8
[  419.674678]  ffff8800704a4000 ffffffff8252ffc0 ffffffffffffffff ffffffff8252ffd8
[  419.683513]  0000000000000000 ffff8800704a3a80 ffffffff81ca2987 ffffffffffffffff
[  419.683574] Call Trace:
[  419.692290]  [<ffffffff81ca2987>] schedule+0x37/0x90
[  419.692306]  [<ffffffff81ca6f6d>] rwsem_down_read_failed+0xdd/0x130
[  419.701050]  [<ffffffff814df454>] call_rwsem_down_read_failed+0x14/0x30
[  419.709758]  [<ffffffff810e793b>] ? down_read_nested+0x5b/0x70
[  419.709805]  [<ffffffff81adfda9>] ? snd_pcm_stream_lock+0xa9/0x120
[  419.723012]  [<ffffffff81adfda9>] snd_pcm_stream_lock+0xa9/0x120

< ============     2nd Read lock is acquired here, without releasing previous one.

[  419.723026]  [<ffffffff81adfe4c>] snd_pcm_stream_lock_irq+0x2c/0x30
[  419.731801]  [<ffffffff81b01f5e>] ? dpcm_dapm_stream_event+0xbe/0xd0
[  419.740565]  [<ffffffff81b0079c>] dpcm_set_fe_update_state+0x3c/0xb0
[  419.749252]  [<ffffffff81b04514>] dpcm_fe_dai_prepare+0xc4/0x150
[  419.749301]  [<ffffffff81adf7eb>] snd_pcm_do_prepare+0x1b/0x30
[  419.758083]  [<ffffffff81adf3bf>] snd_pcm_action_single+0x2f/0x70
[  419.766897]  [<ffffffff81ca6827>] ? down_read+0x47/0x60
[  419.766962]  [<ffffffff81adf577>] ? snd_pcm_action_nonatomic+0x27/0x80
[  419.775565]  [<ffffffff81adf5c6>] snd_pcm_action_nonatomic+0x76/0x80

< ============     1st Read lock is acquired here

[  419.784419]  [<ffffffff81ae2c62>] snd_pcm_common_ioctl1+0x802/0xd30
[  419.784495]  [<ffffffff81ae332b>] snd_pcm_playback_ioctl1+0x19b/0x280
[  419.793106]  [<ffffffff81230915>] ? __fget+0x5/0x210
[  419.801943]  [<ffffffff81ae3dca>] snd_pcm_ioctl_compat+0x41a/0x770
[  419.801959]  [<ffffffff81230915>] ? __fget+0x5/0x210
[  419.810793]  [<ffffffff8126d670>] compat_SyS_ioctl+0xd0/0x13b0
[  419.819491]  [<ffffffff81ca7bc4>] ? do_nanosleep+0x94/0x190
[  419.819535]  [<ffffffff810eb696>] ? trace_hardirqs_on_caller+0x16/0x210
[  419.828306]  [<ffffffff814df4f8>] ? trace_hardirqs_on_thunk+0x17/0x19
[  419.837104]  [<ffffffff81cabf0e>] sysenter_dispatch+0x7/0x1f


Second thread:
[  419.543062] mediaserver     D ffff880170957cd8     0  3690      1	0x20020004
[  419.543191]  ffff880170957cd8 0000000070957cd8 ffff88006de49ad0 ffffffff8252ffd8
[  419.551920]  ffff880170958000 ffff88006de49ad0 ffffffff8252ffc0 ffffffff00000001
[  419.560555]  ffffffff8252ffd8 ffff880170957cf8 ffffffff81ca2987 ffffffff8252ffc0
[  419.569368] Call Trace:
[  419.569392]  [<ffffffff81ca2987>] schedule+0x37/0x90
[  419.578026]  [<ffffffff81ca71f5>] rwsem_down_write_failed+0x235/0x450
[  419.586884]  [<ffffffff81ca7005>] ? rwsem_down_write_failed+0x45/0x450
[  419.586941]  [<ffffffff814df483>] call_rwsem_down_write_failed+0x13/0x20
[  419.595620]  [<ffffffff81ca689f>] ? down_write+0x5f/0x80

< ============     Write lock acquired here. If this occurs between two read
lock's then it's hangs

[  419.604428]  [<ffffffff81aded58>] ? snd_pcm_unlink+0x28/0x120
[  419.604465]  [<ffffffff81aded58>] snd_pcm_unlink+0x28/0x120
[  419.613215]  [<ffffffff81adee5e>] pcm_release_private+0xe/0x10
[  419.622058]  [<ffffffff81ae0d57>] snd_pcm_release_substream.part.34+0x67/0x90
[  419.622143]  [<ffffffff81ae0e68>] snd_pcm_release+0xb8/0xc0
[  419.630889]  [<ffffffff8120f1aa>] __fput+0xea/0x200
[  419.639680]  [<ffffffff8120f30e>] ____fput+0xe/0x10
[  419.639744]  [<ffffffff810ba43c>] task_work_run+0xcc/0x100
[  419.648435]  [<ffffffff81002e41>] do_notify_resume+0x51/0x70
[  419.657205]  [<ffffffff81ca986c>] int_signal+0x12/0x17

Thanks
-- 
~Vinod
