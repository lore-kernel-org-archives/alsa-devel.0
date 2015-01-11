From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: ESI Juli@ crash with external clock switch - patch
Date: Sun, 11 Jan 2015 22:00:59 +0100
Message-ID: <54B2E48B.7020000@ivitera.com>
References: <54B28174.7060008@ivitera.com>	<s5hwq4t2u33.wl-tiwai@suse.de>	<54B2B992.7000909@ivitera.com>
 <s5hegr12gxn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C0AF26047D
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 22:01:15 +0100 (CET)
In-Reply-To: <s5hegr12gxn.wl-tiwai@suse.de>
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

Dne 11.1.2015 v 21:36 Takashi Iwai napsal(a):
>
> OK, then this should be cancel_delayed_work_sync() instead, I suppose.
> The revised patch (also for ak4113.c) below.

I am afraid it is getting stuck in the same way - see the thread stack 
below.

>
>>
>> I see, snd_ak4113_reinit of ak4113.c is never called, only
>> ak4113_init_regs. Perhaps Juli should not touch the workqueue in
>> ak4114_reinit and only initialize the regs in similar manner to ak4113?
>
> No, it's just quartet driver doesn't handle it properly :)

Why is actually the restart of the workqueue needed at reinit? The work 
(snd_ak4114_check_rate_and_errors) only reads ak4114 regs to controls 
(using i2c routine synchronized with mutexes) and handles the stream stop.


> It doesn't matter much because PM doesn't work with Quartet.
> But the juli.c also should be improved regarding PM.  It should stop
> the workq at suspend.  Also, it'd be preferable to have some control
> start/stop this background work, e.g. via a control element.
> Otherwise your machine will be constantly loaded unnecessarily.

I think we can extend the timer, perhaps to HZ/2 - the thread is just a 
security measure anyway.
>
> I'll prepare a fix patch to these later.

Thanks a lot,

Pavel.



[11280.656021] INFO: task kworker/0:1:46 blocked for more than 120 seconds.
[11280.656027]       Tainted: G           OX 3.13.0-37-generic #64-Ubuntu
[11280.656028] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[11280.656031] kworker/0:1     D ffff88021fc14480     0    46      2 
0x00000000
[11280.656041] Workqueue: events ak4114_stats [snd_ak4114]
[11280.656043]  ffff880213c71b80 0000000000000046 ffff880213c69800 
ffff880213c71fd8
[11280.656047]  0000000000014480 0000000000014480 ffff880213c69800 
ffff880213c71cc0
[11280.656051]  ffff880213c71cc8 7fffffffffffffff ffff880213c69800 
ffff8801e206e968
[11280.656054] Call Trace:
[11280.656062]  [<ffffffff81723129>] schedule+0x29/0x70
[11280.656065]  [<ffffffff81722379>] schedule_timeout+0x239/0x2d0
[11280.656070]  [<ffffffff810980f5>] ? check_preempt_curr+0x85/0xa0
[11280.656074]  [<ffffffff81098129>] ? ttwu_do_wakeup+0x19/0xc0
[11280.656077]  [<ffffffff8109827d>] ? 
ttwu_do_activate.constprop.74+0x5d/0x70
[11280.656080]  [<ffffffff81723c46>] wait_for_completion+0xa6/0x160
[11280.656084]  [<ffffffff8109a8d0>] ? wake_up_state+0x20/0x20
[11280.656088]  [<ffffffff81084b8d>] flush_work+0xed/0x1b0
[11280.656091]  [<ffffffff81080e60>] ? wake_up_worker+0x30/0x30
[11280.656095]  [<ffffffff81084cc5>] __cancel_work_timer+0x75/0xf0
[11280.656098]  [<ffffffff81084d73>] cancel_delayed_work_sync+0x13/0x20
[11280.656102]  [<ffffffffa03ca4e5>] snd_ak4114_reinit+0x25/0x60 
[snd_ak4114]
[11280.656112]  [<ffffffffa05e526a>] juli_akm_set_rate_val+0xca/0xf0 
[snd_ice1724]
[11280.656119]  [<ffffffffa05e52de>] juli_ak4114_change+0x4e/0x60 
[snd_ice1724]
[11280.656123]  [<ffffffffa03cab97>] 
snd_ak4114_check_rate_and_errors+0x1f7/0x390 [snd_ak4114]
[11280.656127]  [<ffffffffa03cad58>] ak4114_stats+0x28/0x50 [snd_ak4114]
[11280.656130]  [<ffffffff810839c2>] process_one_work+0x182/0x450
[11280.656134]  [<ffffffff810847b1>] worker_thread+0x121/0x410
[11280.656137]  [<ffffffff81084690>] ? rescuer_thread+0x430/0x430
[11280.656140]  [<ffffffff8108b492>] kthread+0xd2/0xf0
[11280.656144]  [<ffffffff8108b3c0>] ? kthread_create_on_node+0x1c0/0x1c0
[11280.656147]  [<ffffffff8172f77c>] ret_from_fork+0x7c/0xb0
[11280.656150]  [<ffffffff8108b3c0>] ? kthread_create_on_node+0x1c0/0x1c0
[11280.656205] INFO: task pulseaudio:8418 blocked for more than 120 seconds.
[11280.656206]       Tainted: G           OX 3.13.0-37-generic #64-Ubuntu
[11280.656207] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[11280.656209] pulseaudio      D ffff88021fc14480     0  8418   8416 
0x00000000
[11280.656211]  ffff8800bb903bd0 0000000000000082 ffff880210263000 
ffff8800bb903fd8
[11280.656214]  0000000000014480 0000000000014480 ffff880210263000 
ffff8800bb903d18
[11280.656216]  ffff8800bb903d20 7fffffffffffffff ffff880210263000 
ffff8801e206e968
[11280.656219] Call Trace:
[11280.656222]  [<ffffffff81723129>] schedule+0x29/0x70
[11280.656224]  [<ffffffff81722379>] schedule_timeout+0x239/0x2d0
[11280.656227]  [<ffffffff81722cb1>] ? __schedule+0x381/0x7d0
[11280.656229]  [<ffffffff81723c46>] wait_for_completion+0xa6/0x160
[11280.656232]  [<ffffffff8109a8d0>] ? wake_up_state+0x20/0x20
[11280.656234]  [<ffffffff81084b8d>] flush_work+0xed/0x1b0
[11280.656237]  [<ffffffff81080e60>] ? wake_up_worker+0x30/0x30
[11280.656239]  [<ffffffff81084cf2>] __cancel_work_timer+0xa2/0xf0
[11280.656242]  [<ffffffff81084d73>] cancel_delayed_work_sync+0x13/0x20
[11280.656244]  [<ffffffffa03ca4e5>] snd_ak4114_reinit+0x25/0x60 
[snd_ak4114]
[11280.656250]  [<ffffffffa05e526a>] juli_akm_set_rate_val+0xca/0xf0 
[snd_ice1724]
[11280.656255]  [<ffffffffa05da642>] snd_vt1724_set_pro_rate+0x122/0x220 
[snd_ice1724]
[11280.656259]  [<ffffffffa05da768>] 
snd_vt1724_capture_pro_close+0x28/0x40 [snd_ice1724]
[11280.656271]  [<ffffffffa038db0f>] 
snd_pcm_release_substream.part.34+0x3f/0x90 [snd_pcm]
[11280.656275]  [<ffffffffa038dc38>] snd_pcm_release+0xa8/0xd0 [snd_pcm]
[11280.656280]  [<ffffffff811bed64>] __fput+0xe4/0x260
[11280.656282]  [<ffffffff811bef2e>] ____fput+0xe/0x10
[11280.656285]  [<ffffffff81088227>] task_work_run+0xa7/0xe0
[11280.656290]  [<ffffffff81013df7>] do_notify_resume+0x97/0xb0
[11280.656292]  [<ffffffff8172faea>] int_signal+0x12/0x17
