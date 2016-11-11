From: Shuah Khan <shuahkhan@gmail.com>
Subject: BUG: KASAN: use-after-free in snd_usb_audio_free
Date: Fri, 11 Nov 2016 16:34:38 -0700
Message-ID: <CAKocOOPt1s2m1JBGSqEBwO1SdeOt-CinDmw-Lp3JFUz5gMT5Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, shuahkh@osg.samsung.com, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I am seeing the following use-after-free error when I disconnect an
USB speaker. I saw this on 4.9-rc4 and 4.8.7. There might be race
condition between the disconnect and pcm close perhaps.

-- Shuah


[ 1099.305137] ==================================================================
[ 1099.305172] BUG: KASAN: use-after-free in
snd_usb_audio_free+0x134/0x160 [snd_usb_audio] at addr
ffff8801c863ce10
[ 1099.305180] Write of size 8 by task pulseaudio/2244
[ 1099.305189] CPU: 0 PID: 2244 Comm: pulseaudio Not tainted 4.8.7 #8
[ 1099.305192] Hardware name: Hewlett-Packard HP ProBook 6475b/180F,
BIOS 68TTU Ver. F.04 08/03/2012
[ 1099.305196]  ffff8801c863d480 ffff8801ca6bfae8 ffffffff81b31473
ffff8801fa403040
[ 1099.305207]  ffff8801c863cc80 ffff8801ca6bfb10 ffffffff81564ef1
ffff8801ca6bfba0
[ 1099.305217]  ffff8801c863cc80 ffff8801fa403040 ffff8801ca6bfb90
ffffffff8156518a
[ 1099.305227] Call Trace:
[ 1099.305236]  [<ffffffff81b31473>] dump_stack+0x67/0x94
[ 1099.305244]  [<ffffffff81564ef1>] kasan_object_err+0x21/0x70
[ 1099.305250]  [<ffffffff8156518a>] kasan_report_error+0x1fa/0x4e0
[ 1099.305256]  [<ffffffff81564ad7>] ? kasan_slab_free+0x87/0xb0
[ 1099.305262]  [<ffffffff81565733>] __asan_report_store8_noabort+0x43/0x50
[ 1099.305280]  [<ffffffffa0fc0f54>] ? snd_usb_audio_free+0x134/0x160
[snd_usb_audio]
[ 1099.305297]  [<ffffffffa0fc0f54>] snd_usb_audio_free+0x134/0x160
[snd_usb_audio]
[ 1099.305316]  [<ffffffffa0fc0fb1>] snd_usb_audio_dev_free+0x31/0x40
[snd_usb_audio]
[ 1099.305324]  [<ffffffff8243c78a>] __snd_device_free+0x12a/0x210
[ 1099.305329]  [<ffffffff8243d1f5>] snd_device_free_all+0x85/0xd0
[ 1099.305335]  [<ffffffff8242cae4>] release_card_device+0x34/0x130
[ 1099.305342]  [<ffffffff81ef1846>] device_release+0x76/0x1e0
[ 1099.305348]  [<ffffffff81b37ad7>] kobject_release+0x107/0x370
[ 1099.305353]  [<ffffffff81b376ee>] kobject_put+0x4e/0xa0
[ 1099.305358]  [<ffffffff81ef1f77>] put_device+0x17/0x20
[ 1099.305363]  [<ffffffff8242dcdd>] snd_card_file_remove+0x2ed/0x3d0
[ 1099.305369]  [<ffffffff82431327>] snd_ctl_release+0x277/0x380
[ 1099.305374]  [<ffffffff8242d326>] snd_disconnect_release+0x276/0x3a0
[ 1099.305380]  [<ffffffff815a421c>] __fput+0x1fc/0x6c0
[ 1099.305385]  [<ffffffff815a474e>] ____fput+0xe/0x10
[ 1099.305392]  [<ffffffff8117a2ee>] task_work_run+0xde/0x140
[ 1099.305398]  [<ffffffff81003a30>] exit_to_usermode_loop+0x140/0x170
[ 1099.305405]  [<ffffffff8100661a>] syscall_return_slowpath+0x16a/0x1a0
[ 1099.305411]  [<ffffffff828cdef3>] entry_SYSCALL_64_fastpath+0xa6/0xa8
[ 1099.305417] Object at ffff8801c863cc80, in cache kmalloc-2048 size: 2048
[ 1099.305422] Allocated:
[ 1099.305427] PID = 1788
[ 1099.305432]  [<ffffffff810804eb>] save_stack_trace+0x2b/0x50
[ 1099.305440]  [<ffffffff81564296>] save_stack+0x46/0xd0
[ 1099.305446]  [<ffffffff8156450d>] kasan_kmalloc+0xad/0xe0
[ 1099.305453]  [<ffffffff81560d1a>] kmem_cache_alloc_trace+0xfa/0x240
[ 1099.305460]  [<ffffffff8214ea47>] usb_alloc_dev+0x57/0xc90
[ 1099.305467]  [<ffffffff8216349d>] hub_event+0xf1d/0x35f0
[ 1099.305473]  [<ffffffff8116c66a>] process_one_work+0x68a/0x19f0
[ 1099.305479]  [<ffffffff8116daa9>] worker_thread+0xd9/0x12f0
[ 1099.305485]  [<ffffffff8117eed4>] kthread+0x1d4/0x270
[ 1099.305490]  [<ffffffff828ce07f>] ret_from_fork+0x1f/0x40
[ 1099.305497] Freed:
[ 1099.305502] PID = 1788
[ 1099.305506]  [<ffffffff810804eb>] save_stack_trace+0x2b/0x50
[ 1099.305512]  [<ffffffff81564296>] save_stack+0x46/0xd0
[ 1099.305519]  [<ffffffff81564ac1>] kasan_slab_free+0x71/0xb0
[ 1099.305526]  [<ffffffff81560929>] kfree+0xd9/0x280
[ 1099.305531]  [<ffffffff8214de6e>] usb_release_dev+0xde/0x110
[ 1099.305537]  [<ffffffff81ef1846>] device_release+0x76/0x1e0
[ 1099.305544]  [<ffffffff81b37ad7>] kobject_release+0x107/0x370
[ 1099.305550]  [<ffffffff81b376ee>] kobject_put+0x4e/0xa0
[ 1099.305555]  [<ffffffff81ef1f77>] put_device+0x17/0x20
[ 1099.305562]  [<ffffffff8215d248>] usb_disconnect+0x4d8/0x8b0
[ 1099.305568]  [<ffffffff821633a0>] hub_event+0xe20/0x35f0
[ 1099.305573]  [<ffffffff8116c66a>] process_one_work+0x68a/0x19f0
[ 1099.305579]  [<ffffffff8116daa9>] worker_thread+0xd9/0x12f0
[ 1099.305585]  [<ffffffff8117eed4>] kthread+0x1d4/0x270
[ 1099.305591]  [<ffffffff828ce07f>] ret_from_fork+0x1f/0x40
[ 1099.305597] Memory state around the buggy address:
[ 1099.305605]  ffff8801c863cd00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1099.305612]  ffff8801c863cd80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1099.305618] >ffff8801c863ce00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1099.305623]                          ^
[ 1099.305629]  ffff8801c863ce80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1099.305635]  ffff8801c863cf00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1099.305639] ==================================================================
[ 1099.305643] Disabling lock debugging due to kernel taint
