From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/sound: use-after-free in __uac_clock_find_source
Date: Tue, 21 Nov 2017 14:52:00 +0100
Message-ID: <CAAeHK+wuqb4nCFWTriGsiT4y8dOdQM4B+wtDLYh5Z3mjwjKy=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 by alsa0.perex.cz (Postfix) with ESMTP id C85262670E5
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 14:52:02 +0100 (CET)
Received: by mail-ot0-f194.google.com with SMTP id u10so10555658otc.12
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 05:52:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit e1d1ea549b57790a3d8cf6300e6ef86118d692a3 (4.15-rc1).

This actually looks more like an out-of-bounds with large offset than
a use-after-free due to unrelated alloc and free stack traces.

==================================================================
BUG: KASAN: use-after-free in __uac_clock_find_source+0xddd/0xe40
Read of size 1 at addr ffff8800699ca00f by task kworker/1:0/18

CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 4.14.0-57501-g9284d204d604 #119
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:17
 dump_stack+0xe1/0x157 lib/dump_stack.c:53
 print_address_description+0x71/0x234 mm/kasan/report.c:252
 kasan_report_error mm/kasan/report.c:351
 kasan_report+0x173/0x270 mm/kasan/report.c:409
 __asan_report_load1_noabort+0x19/0x20 mm/kasan/report.c:427
 __uac_clock_find_source+0xddd/0xe40 sound/usb/clock.c:221
 snd_usb_clock_find_source+0x41/0x50 sound/usb/clock.c:276
 set_sample_rate_v2 sound/usb/clock.c:367
 snd_usb_init_sample_rate+0x3b6/0xa40 sound/usb/clock.c:430
 create_fixed_stream_quirk+0x510/0x8f0 sound/usb/quirks.c:192
 snd_usb_create_quirk+0xa6/0x120 sound/usb/quirks.c:560
 create_composite_quirk+0x1e0/0x420 sound/usb/quirks.c:59
 snd_usb_create_quirk+0xa6/0x120 sound/usb/quirks.c:560
 usb_audio_probe+0x1220/0x1f70 sound/usb/card.c:618
 usb_probe_interface+0x324/0x940 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:424
 driver_probe_device+0x564/0x820 drivers/base/dd.c:566
 __device_attach_driver+0x25d/0x2d0 drivers/base/dd.c:662
 bus_for_each_drv+0xff/0x160 drivers/base/bus.c:463
 __device_attach+0x1ab/0x2a0 drivers/base/dd.c:719
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:766
 bus_probe_device+0x1fc/0x2a0 drivers/base/bus.c:523
 device_add+0xc27/0x15a0 drivers/base/core.c:1835
 usb_set_configuration+0xd55/0x17a0 drivers/usb/core/message.c:1967
 generic_probe+0xbb/0x120 drivers/usb/core/generic.c:174
 usb_probe_device+0xab/0x100 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:424
 driver_probe_device+0x564/0x820 drivers/base/dd.c:566
 __device_attach_driver+0x25d/0x2d0 drivers/base/dd.c:662
 bus_for_each_drv+0xff/0x160 drivers/base/bus.c:463
 __device_attach+0x1ab/0x2a0 drivers/base/dd.c:719
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:766
 bus_probe_device+0x1fc/0x2a0 drivers/base/bus.c:523
 device_add+0xc27/0x15a0 drivers/base/core.c:1835
 usb_new_device+0x7fa/0x1090 drivers/usb/core/hub.c:2538
 hub_port_connect drivers/usb/core/hub.c:5000
 hub_port_connect_change drivers/usb/core/hub.c:5106
 port_event drivers/usb/core/hub.c:5212
 hub_event_impl+0x17bc/0x3440 drivers/usb/core/hub.c:5324
 hub_event+0x38/0x50 drivers/usb/core/hub.c:5222
 process_one_work+0x944/0x15f0 kernel/workqueue.c:2112
 worker_thread+0xef/0x10d0 kernel/workqueue.c:2246
 kthread+0x367/0x420 kernel/kthread.c:238
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:437

Allocated by task 5253:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:551
 kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
 slab_post_alloc_hook mm/slab.h:442
 slab_alloc_node mm/slub.c:2725
 slab_alloc mm/slub.c:2733
 kmem_cache_alloc+0xd3/0x270 mm/slub.c:2738
 kmem_cache_zalloc ./include/linux/slab.h:678
 get_empty_filp+0xac/0x350 fs/file_table.c:123
 path_openat+0x36/0x2860 fs/namei.c:3505
 do_filp_open+0x13f/0x1d0 fs/namei.c:3563
 do_sys_open+0x362/0x4c0 fs/open.c:1059
 SYSC_open fs/open.c:1077
 SyS_open+0x32/0x40 fs/open.c:1072
 entry_SYSCALL_64_fastpath+0x23/0x9a arch/x86/entry/entry_64.S:203

Freed by task 17:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
 slab_free_hook mm/slub.c:1391
 slab_free_freelist_hook mm/slub.c:1412
 slab_free mm/slub.c:2968
 kmem_cache_free+0xb7/0x2f0 mm/slub.c:2990
 file_free_rcu+0x67/0x90 fs/file_table.c:50
 __rcu_reclaim kernel/rcu/rcu.h:195
 rcu_do_batch kernel/rcu/tree.c:2758
 invoke_rcu_callbacks kernel/rcu/tree.c:3012
 __rcu_process_callbacks kernel/rcu/tree.c:2979
 rcu_process_callbacks+0x4df/0xcf0 kernel/rcu/tree.c:2996
 __do_softirq+0x2e0/0x88e kernel/softirq.c:285

The buggy address belongs to the object at ffff8800699ca000
 which belongs to the cache filp of size 488
The buggy address is located 15 bytes inside of
 488-byte region [ffff8800699ca000, ffff8800699ca1e8)
The buggy address belongs to the page:
page:ffffea0001a67280 count:1 mapcount:0 mapping:          (null)
index:0x0 compound_mapcount: 0
flags: 0x100000000008100(slab|head)
raw: 0100000000008100 0000000000000000 0000000000000000 00000001000c000c
raw: dead000000000100 dead000000000200 ffff88006ca97980 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8800699c9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8800699c9f80: 00 00 05 fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8800699ca000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff8800699ca080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8800699ca100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
