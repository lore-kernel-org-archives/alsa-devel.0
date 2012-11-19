From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Hung task with trace after resume on kernel
 v3.7-rc6
Date: Mon, 19 Nov 2012 11:56:32 +0100
Message-ID: <20121119115632.0c41386f@ilfaris>
References: <20121118161803.58ca707c@ilfaris>
 <CAEUnVG7bFqrzfVDG5-2uL6OHGEJR-Jf35mx-OLiTx-K84P+dmA@mail.gmail.com>
 <s5h3906gcfe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id AE27E260841
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 11:56:40 +0100 (CET)
In-Reply-To: <s5h3906gcfe.wl%tiwai@suse.de>
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
Cc: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > > I have an Thinkpad X121e with the following soundcard:
> > > 00:01.1 Audio device [0403]: Advanced Micro Devices [AMD] nee ATI
> > > Wrestler HDMI Audio [Radeon HD 6250/6310] [1002:1314]
Of course I did not mean the hdmi device but this one, sorry:
00:14.2 Audio device [0403]: Advanced Micro Devices [AMD] nee ATI SBx00
Azalia (Intel HDA) [1002:4383] (rev 40)

> So, for this particular issue (at least the recursive suspend call), I
> think the easiest way is a patch like below.  This is no ideal
> solution but would be good enough as a bandaid at this late stage for
> 3.7.  Julian, could you check whether this works?
Sadly the patch does not work, I still get the spurious responses and a
trace, which looked minimaly different this time:
[  240.434881] INFO: task kworker/u:14:3617 blocked for more than 120 seconds.
[  240.434894] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.434901] kworker/u:14    D ffff88011ed128c0     0  3617      2 0x00000000
[  240.434918]  ffff880106272cd0 0000000000000046 0000000000000086 ffff88011a6e7950
[  240.434931]  ffff8801178f7fd8 ffff8801178f7fd8 ffff8801178f7fd8 ffff880106272cd0
[  240.434944]  0000000000000003 ffff8801178f7c20 ffff8801178f7c18 ffff880106272cd0
[  240.434957] Call Trace:
[  240.434978]  [<ffffffff81403342>] ? schedule_timeout+0x1e2/0x2a0
[  240.434992]  [<ffffffff8106c32d>] ? select_task_rq_fair+0x53d/0x5d0
[  240.435004]  [<ffffffff814049c2>] ? wait_for_common+0xd2/0x180
[  240.435017]  [<ffffffff810693f0>] ? try_to_wake_up+0x270/0x270
[  240.435030]  [<ffffffff81052911>] ? flush_work+0xe1/0x160
[  240.435041]  [<ffffffff81051c10>] ? gcwq_release_assoc_and_unlock+0x40/0x40
[  240.435052]  [<ffffffff8105369d>] ? __cancel_work_timer+0x5d/0xa0
[  240.435093]  [<ffffffffa0208f5c>] ? hda_call_codec_suspend+0x14c/0x160 [snd_hda_codec]
[  240.435114]  [<ffffffffa0208fb0>] ? snd_hda_suspend+0x40/0x60 [snd_hda_codec]
[  240.435131]  [<ffffffffa01e06cb>] ? azx_bus_reset+0xab/0xc0 [snd_hda_intel]
[  240.435152]  [<ffffffffa0207e55>] ? codec_exec_verb+0x185/0x1c0 [snd_hda_codec]
[  240.435173]  [<ffffffffa0207ee8>] ? snd_hda_codec_read+0x58/0x90 [snd_hda_codec]
[  240.435193]  [<ffffffffa0208b68>] ? snd_hda_shutup_pins+0x58/0x70 [snd_hda_codec]
[  240.435210]  [<ffffffffa033e369>] ? conexant_suspend+0x9/0x10 [snd_hda_codec_conexant]
[  240.435229]  [<ffffffffa0208e2e>] ? hda_call_codec_suspend+0x1e/0x160 [snd_hda_codec]
[  240.435249]  [<ffffffffa0209048>] ? hda_power_work+0x78/0xc0 [snd_hda_codec]
[  240.435260]  [<ffffffff81052f06>] ? process_one_work+0x126/0x490
[  240.435280]  [<ffffffffa0208fd0>] ? snd_hda_suspend+0x60/0x60 [snd_hda_codec]
[  240.435291]  [<ffffffff81054c3d>] ? worker_thread+0x15d/0x450
[  240.435302]  [<ffffffff81054ae0>] ? flush_delayed_work+0x40/0x40
[  240.435313]  [<ffffffff810599a3>] ? kthread+0xb3/0xc0
[  240.435323]  [<ffffffff810598f0>] ? kthread_create_on_node+0x110/0x110
[  240.435335]  [<ffffffff814061ac>] ? ret_from_fork+0x7c/0xb0
[  240.435345]  [<ffffffff810598f0>] ? kthread_create_on_node+0x110/0x110

By the way, it seems like I get the traces every 120 seconds and not
only once, forgot to mention that earlier.


With best regards,
Julian
