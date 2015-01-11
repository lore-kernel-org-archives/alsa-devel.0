From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: ESI Juli@ crash with external clock switch - patch
Date: Sun, 11 Jan 2015 18:57:38 +0100
Message-ID: <54B2B992.7000909@ivitera.com>
References: <54B28174.7060008@ivitera.com> <s5hwq4t2u33.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C19826046A
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 18:57:56 +0100 (CET)
In-Reply-To: <s5hwq4t2u33.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Dne 11.1.2015 v 16:52 Takashi Iwai napsal(a):
> Does the patch below work instead?

Thanks a lot for your Sunday response. Unfortunately this patch does not 
help, again stuck in the flush_delayed work call - see stack trace below.

> The reason it appears only on
> Juli@ is that juli@ is the only board using this function.

I see, snd_ak4113_reinit of ak4113.c is never called, only 
ak4113_init_regs. Perhaps Juli should not touch the workqueue in 
ak4114_reinit and only initialize the regs in similar manner to ak4113?

But then should we restart the workqueue in juli_resume or just reinit 
ak4114 regs? Quartet does not have the resume functionality implemented 
at all yet.

The following patch removing any workqueue functions seems to work too 
(making it the same functionality as in quartet - only reinitializing 
ak411x registers). The workqueue gets executed since upon changing the 
incoming rate the running capture is stopped. The recorded file stops 
growing but arecord does not stop, must be killed with kill -9. Not a 
problem for now.

==========
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index c7f5633..65efac7 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -154,12 +154,9 @@ void snd_ak4114_reinit(struct ak4114 *chip)
  {
         chip->init = 1;
         mb();
-       flush_delayed_work(&chip->work);
         ak4114_init_regs(chip);
         /* bring up statistics / event queing */
         chip->init = 0;
-       if (chip->kctls[0])
-               schedule_delayed_work(&chip->work, HZ / 10);
  }

  static unsigned int external_rate(unsigned char rcs1)

==========


Thanks a lot,

Pavel.


[  360.656039] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  360.656040] kworker/3:1     D ffff88021fd94480     0    49      2 
0x00000000
[  360.656052] Workqueue: events ak4114_stats [snd_ak4114]
[  360.656055]  ffff880213c9fba0 0000000000000046 ffff880214233000 
ffff880213c9ffd8
[  360.656058]  0000000000014480 0000000000014480 ffff880214233000 
ffff880213c9fce8
[  360.656061]  ffff880213c9fcf0 7fffffffffffffff ffff880214233000 
ffff880212cb02a8
[  360.656063] Call Trace:
[  360.656188]  [<ffffffff81723129>] schedule+0x29/0x70
[  360.656191]  [<ffffffff81722379>] schedule_timeout+0x239/0x2d0
[  360.656193]  [<ffffffff81722cb1>] ? __schedule+0x381/0x7d0
[  360.656196]  [<ffffffff81723c46>] wait_for_completion+0xa6/0x160
[  360.656198]  [<ffffffff8109a8d0>] ? wake_up_state+0x20/0x20
[  360.656201]  [<ffffffff81084b8d>] flush_work+0xed/0x1b0
[  360.656203]  [<ffffffff81080e60>] ? wake_up_worker+0x30/0x30
[  360.656205]  [<ffffffff81084e2f>] flush_delayed_work+0x3f/0x50
[  360.656208]  [<ffffffffa03e8695>] snd_ak4114_reinit+0x25/0x60 
[snd_ak4114]
[  360.656214]  [<ffffffffa042b26a>] juli_akm_set_rate_val+0xca/0xf0 
[snd_ice1724]
[  360.656219]  [<ffffffffa0420642>] snd_vt1724_set_pro_rate+0x122/0x220 
[snd_ice1724]
[  360.656224]  [<ffffffffa042300d>] 
snd_vt1724_pro_internal_clock_put+0xad/0x1f0 [snd_ice1724]
[  360.656234]  [<ffffffffa0302df5>] ? snd_ctl_find_id+0xb5/0xe0 [snd]
[  360.656240]  [<ffffffffa03034fd>] snd_ctl_elem_write+0x11d/0x1a0 [snd]
[  360.656243]  [<ffffffff811a1dc5>] ? __kmalloc+0xa5/0x230
[  360.656248]  [<ffffffffa02ff01d>] ? __snd_kmalloc+0x1d/0x90 [snd]
[  360.656253]  [<ffffffffa0305266>] ? snd_ctl_ioctl+0xa6/0x7a0 [snd]
[  360.656258]  [<ffffffffa03052cc>] snd_ctl_ioctl+0x10c/0x7a0 [snd]
[  360.656261]  [<ffffffff8109a8d0>] ? wake_up_state+0x20/0x20
[  360.656265]  [<ffffffff811d03a0>] do_vfs_ioctl+0x2e0/0x4c0
[  360.656268]  [<ffffffff811bd0ce>] ? vfs_read+0xee/0x160
[  360.656270]  [<ffffffff811d0601>] SyS_ioctl+0x81/0xa0
[  360.656272]  [<ffffffff811bdb89>] ? SyS_read+0x49/0xa0
[  360.656275]  [<ffffffff8172f82d>] system_call_fastpath+0x1a/0x1f
[  360.656277] INFO: task amixer:2917 blocked for more than 120 seconds.
[  360.656278]       Tainted: G           OX 3.13.0-37-generic #64-Ubuntu
[  360.656279] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  360.656281] amixer          D ffff88021fd14480     0  2917   2916 
0x00000004
[  360.656283]  ffff8800d2ba7d98 0000000000000082 ffff880212d84800 
ffff8800d2ba7fd8
[  360.656286]  0000000000014480 0000000000014480 ffff880212d84800 
ffff880212d84800
[  360.656288]  ffff8802119709c0 ffff8802119709c8 ffffffff00000000 
ffff8802119709d0
[  360.656291] Call Trace:
[  360.656293]  [<ffffffff81723129>] schedule+0x29/0x70
[  360.656296]  [<ffffffff81725da5>] rwsem_down_write_failed+0x115/0x230
[  360.656298]  [<ffffffff811a1dc5>] ? __kmalloc+0xa5/0x230
[  360.656302]  [<ffffffff8136fd13>] call_rwsem_down_write_failed+0x13/0x20
[  360.656304]  [<ffffffff817257bd>] ? down_write+0x2d/0x30
[  360.656310]  [<ffffffffa030324d>] snd_ctl_release+0x7d/0x130 [snd]
[  360.656312]  [<ffffffff811bed64>] __fput+0xe4/0x260
[  360.656315]  [<ffffffff811bef2e>] ____fput+0xe/0x10
[  360.656318]  [<ffffffff81088227>] task_work_run+0xa7/0xe0
[  360.656321]  [<ffffffff81013df7>] do_notify_resume+0x97/0xb0
[  360.656324]  [<ffffffff8172faea>] int_signal+0x12/0x17
[  360.656326] INFO: task amixer:2934 blocked for more than 120 seconds.
[  360.656327]       Tainted: G           OX 3.13.0-37-generic #64-Ubuntu
[  360.656329] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  360.656330] amixer          D ffff88021fd94480     0  2934   2933 
0x00000004
[  360.656332]  ffff8802110cfd98 0000000000000086 ffff88003569c800 
ffff8802110cffd8
[  360.656335]  0000000000014480 0000000000014480 ffff88003569c800 
ffff88003569c800
[  360.656337]  ffff8802119709c0 ffff8802119709c8 ffffffff00000000 
ffff8802119709d0
[  360.656339] Call Trace:
[  360.656342]  [<ffffffff81723129>] schedule+0x29/0x70
[  360.656344]  [<ffffffff81725da5>] rwsem_down_write_failed+0x115/0x230
[  360.656347]  [<ffffffff8136fd13>] call_rwsem_down_write_failed+0x13/0x20
[  360.656349]  [<ffffffff817257bd>] ? down_write+0x2d/0x30
[  360.656355]  [<ffffffffa030324d>] snd_ctl_release+0x7d/0x130 [snd]
[  360.656357]  [<ffffffff811bed64>] __fput+0xe4/0x260
[  360.656360]  [<ffffffff811bef2e>] ____fput+0xe/0x10
[  360.656362]  [<ffffffff81088227>] task_work_run+0xa7/0xe0
[  360.656365]  [<ffffffff81013df7>] do_notify_resume+0x97/0xb0
[  360.656367]  [<ffffffff8172faea>] int_signal+0x12/0x17
[  360.656369] INFO: task amixer:2938 blocked for more than 120 seconds.
[  360.656370]       Tainted: G           OX 3.13.0-37-generic #64-Ubuntu
[  360.656372] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  360.656373] amixer          D ffff88021fd94480     0  2938   2937 
0x00000004
[  360.656375]  ffff88020ff1dd98 0000000000000086 ffff8800d2a1b000 
ffff88020ff1dfd8
[  360.656378]  0000000000014480 0000000000014480 ffff8800d2a1b000 
ffff8800d2a1b000
[  360.656380]  ffff8802119709c0 ffff8802119709c8 ffffffff00000000 
ffff8802119709d0
[  360.656383] Call Trace:
[  360.656385]  [<ffffffff81723129>] schedule+0x29/0x70
[  360.656387]  [<ffffffff81725da5>] rwsem_down_write_failed+0x115/0x230
[  360.656390]  [<ffffffff8136fd13>] call_rwsem_down_write_failed+0x13/0x20
[  360.656392]  [<ffffffff817257bd>] ? down_write+0x2d/0x30
[  360.656398]  [<ffffffffa030324d>] snd_ctl_release+0x7d/0x130 [snd]
[  360.656400]  [<ffffffff811bed64>] __fput+0xe4/0x260
[  360.656402]  [<ffffffff811bef2e>] ____fput+0xe/0x10
[  360.656405]  [<ffffffff81088227>] task_work_run+0xa7/0xe0
[  360.656408]  [<ffffffff81013df7>] do_notify_resume+0x97/0xb0
[  360.656410]  [<ffffffff8172faea>] int_signal+0x12/0x17


>
