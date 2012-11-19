From: Dylan Reid <dgreid@chromium.org>
Subject: Re: Hung task with trace after resume on kernel
	v3.7-rc6
Date: Sun, 18 Nov 2012 21:54:45 -0800
Message-ID: <CAEUnVG7bFqrzfVDG5-2uL6OHGEJR-Jf35mx-OLiTx-K84P+dmA@mail.gmail.com>
References: <20121118161803.58ca707c@ilfaris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6519E2650DA
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 06:55:06 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d4so2501517eek.38
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 21:55:06 -0800 (PST)
In-Reply-To: <20121118161803.58ca707c@ilfaris>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Wollrath <jwollrath@web.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 18, 2012 at 7:18 AM, Julian Wollrath <jwollrath@web.de> wrote:
> Hello,
>
> I have an Thinkpad X121e with the following soundcard:
> 00:01.1 Audio device [0403]: Advanced Micro Devices [AMD] nee ATI
> Wrestler HDMI Audio [Radeon HD 6250/6310] [1002:1314]
>
> After resuming after an suspend (either to ram or to disk) I found this
> output in my dmesg:
> [ 7514.237941] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7514.238085] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238090] hda-intel: spurious response 0x233:0x0, last cmd=0x1970700
> [ 7514.238094] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238099] hda-intel: spurious response 0x233:0x0, last cmd=0x1970700
> [ 7514.238104] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238109] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238113] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238118] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238123] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238127] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238132] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238137] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238141] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238154] hda-intel: spurious response 0xffffffff:0x0, last cmd=0x1970700
> [ 7514.238159] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7514.238443] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238448] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
> [ 7514.238452] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238457] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
> [ 7514.238461] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238466] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238471] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238475] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238480] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238485] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238489] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238494] hda-intel: spurious response 0x233:0x0, last cmd=0x1970700
> [ 7514.238499] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7514.238563] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7514.238568] hda-intel: spurious response 0xffffffff:0x0, last cmd=0x1970700
> [ 7514.238573] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7514.238610] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7516.240988] hda-intel: azx_get_response timeout, switching to polling mode: last cmd=0x01a70700
> [ 7517.345017] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7517.345374] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345379] hda-intel: spurious response 0xffffffff:0x0, last cmd=0x1970700
> [ 7517.345384] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7517.345453] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345458] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
> [ 7517.345463] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7517.345639] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345644] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
> [ 7517.345648] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345653] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
> [ 7517.345658] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345662] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345667] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345671] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345676] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345681] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345685] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345690] hda-intel: spurious response 0x233:0x0, last cmd=0x1970700
> [ 7517.345695] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345700] hda-intel: spurious response 0x233:0x0, last cmd=0x1970700
> [ 7517.345704] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345709] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345713] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345718] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345723] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345727] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345732] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345737] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345741] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.345747] hda-intel: spurious response 0xffffffff:0x0, last cmd=0x1970700
> [ 7517.345751] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7517.346035] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.346040] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
> [ 7517.346045] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.346050] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
> [ 7517.346054] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7517.346082] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.346087] hda-intel: spurious response 0x233:0x0, last cmd=0x1970700
> [ 7517.346092] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7517.346156] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7517.346161] hda-intel: spurious response 0xffffffff:0x0, last cmd=0x1970700
> [ 7517.346166] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> ....
> [ 7517.346203] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
> [ 7518.346490] hda_intel: azx_get_response timeout, switching to single_cmd mode: last cmd=0x01a70700

This looks bad, should figure out why this happened, but it certainly
shouldn't cause a hung task.

> [ 7670.241195] INFO: task kworker/u:13:3734 blocked for more than 120 seconds.
> [ 7670.241208] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 7670.241215] kworker/u:13    D ffff88011ec128c0     0  3734      2 0x00000000
> [ 7670.241229]  ffff880104538690 0000000000000046 ffff880118c19b14 ffffffff81813420
> [ 7670.241240]  ffff880118c19fd8 ffff880118c19fd8 ffff880118c19fd8 ffff880104538690
> [ 7670.241250]  ffff88008d688098 ffff880118c19c20 ffff880118c19c18 ffff880104538690
> [ 7670.241261] Call Trace:
> [ 7670.241281]  [<ffffffff81403302>] ? schedule_timeout+0x1e2/0x2a0
> [ 7670.241293]  [<ffffffff81404982>] ? wait_for_common+0xd2/0x180
> [ 7670.241305]  [<ffffffff810693f0>] ? try_to_wake_up+0x270/0x270
> [ 7670.241315]  [<ffffffff81052911>] ? flush_work+0xe1/0x160
> [ 7670.241325]  [<ffffffff81051c10>] ? gcwq_release_assoc_and_unlock+0x40/0x40
> [ 7670.241335]  [<ffffffff8105369d>] ? __cancel_work_timer+0x5d/0xa0
> [ 7670.241377]  [<ffffffffa01b7f5c>] ? hda_call_codec_suspend+0x14c/0x160 [snd_hda_codec]
> [ 7670.241397]  [<ffffffffa01b7fb0>] ? snd_hda_suspend+0x40/0x60 [snd_hda_codec]
> [ 7670.241413]  [<ffffffffa018d693>] ? azx_bus_reset+0x73/0xa0 [snd_hda_intel]
> [ 7670.241433]  [<ffffffffa01b6e55>] ? codec_exec_verb+0x185/0x1c0 [snd_hda_codec]
> [ 7670.241452]  [<ffffffffa01b6ee8>] ? snd_hda_codec_read+0x58/0x90 [snd_hda_codec]
> [ 7670.241473]  [<ffffffffa01b7b68>] ? snd_hda_shutup_pins+0x58/0x70 [snd_hda_codec]
> [ 7670.241489]  [<ffffffffa028c369>] ? conexant_suspend+0x9/0x10 [snd_hda_codec_conexant]
> [ 7670.241507]  [<ffffffffa01b7e2e>] ? hda_call_codec_suspend+0x1e/0x160 [snd_hda_codec]
> [ 7670.241526]  [<ffffffffa01b8048>] ? hda_power_work+0x78/0xc0 [snd_hda_codec]
> [ 7670.241536]  [<ffffffff81052f06>] ? process_one_work+0x126/0x490
> [ 7670.241554]  [<ffffffffa01b7fd0>] ? snd_hda_suspend+0x60/0x60 [snd_hda_codec]
> [ 7670.241564]  [<ffffffff81054c3d>] ? worker_thread+0x15d/0x450
> [ 7670.241573]  [<ffffffff81054ae0>] ? flush_delayed_work+0x40/0x40
> [ 7670.241582]  [<ffffffff810599a3>] ? kthread+0xb3/0xc0
> [ 7670.241591]  [<ffffffff810598f0>] ? kthread_create_on_node+0x110/0x110
> [ 7670.241601]  [<ffffffff8140616c>] ? ret_from_fork+0x7c/0xb0
> [ 7670.241609]  [<ffffffff810598f0>] ? kthread_create_on_node+0x110/0x110

I added a fix recently to prevent a similar lockup but I missed the
case where snd_hda_suspend is called from azx_reset_bus in turn called
from snd_hda_suspend.

I'm torn between fixing this lockup and just avoiding this recursive
call.  Without the lockup, what state do we leave the codec in when
this happens?

Am I understanding the scenario below correctly?

- do first half of suspend
- verb exec error --> reset
--- suspend
--- resume (and queue work to suspend later
- second half of suspend (Is this OK?)

Maybe a state machine of some sort could be added to manage the power
state. It could notice the error and restart the suspend from the
beginning. That way the codec suspend function is called again and a
complete transition to suspended is performed.

Takashi, do you see a simple way of handling this?


-Dylan

>
>
> If you need further information, please feel free to ask.
>
>
> With best regards,
> Julian Wollrath
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
