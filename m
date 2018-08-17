From: Joseph Spencer <joespenceris@gmail.com>
Subject: snd_usb_usx2y holding onto a lock?
Date: Fri, 17 Aug 2018 00:23:35 -0700
Message-ID: <CAMvaF70On5Jz3wMDUj1QU5hD+L=JTxGGuKtg9ZzL2hz=_XoU4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 09AE1267692
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 09:23:47 +0200 (CEST)
Received: by mail-lf1-f42.google.com with SMTP id y200-v6so5198365lfd.7
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 00:23:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When plugging an audio interface in with nomodeset I see the following in
the logs:

Aug 08 23:19:23 localhost.localdomain kernel: INFO: task pulseaudio:1750
blocked for more than 120 seconds.
Aug 08 23:19:23 localhost.localdomain kernel:       Tainted: G
 OE     4.17.11-200.fc28.x86_64+debug #1
Aug 08 23:19:23 localhost.localdomain kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 08 23:19:23 localhost.localdomain kernel: pulseaudio      D12408  1750
 1268 0x00000000
Aug 08 23:19:23 localhost.localdomain kernel: Call Trace:

Aug 08 23:19:23 localhost.localdomain kernel:  ? __schedule+0x2ba/0xaf0

Aug 08 23:19:23 localhost.localdomain kernel:  ?
prepare_to_wait_event+0xd2/0x180
Aug 08 23:19:23 localhost.localdomain kernel:  schedule+0x2f/0x90

Aug 08 23:19:23 localhost.localdomain kernel:  usX2Y_urbs_start+0x208/0x470
[snd_usb_usx2y]
Aug 08 23:19:23 localhost.localdomain kernel:  ? finish_wait+0x80/0x80

Aug 08 23:19:23 localhost.localdomain kernel:
snd_usX2Y_pcm_prepare+0xb4/0xd0 [snd_usb_usx2y]
Aug 08 23:19:23 localhost.localdomain kernel:  snd_pcm_do_prepare+0x19/0x30
[snd_pcm]
Aug 08 23:19:23 localhost.localdomain kernel:
snd_pcm_action_single+0x36/0x80 [snd_pcm]
Aug 08 23:19:23 localhost.localdomain kernel:
snd_pcm_action_nonatomic+0x61/0x70 [snd_pcm]
Aug 08 23:19:23 localhost.localdomain kernel:
snd_pcm_common_ioctl+0x3d2/0xb70 [snd_pcm]
Aug 08 23:19:23 localhost.localdomain kernel:  ?
selinux_file_ioctl+0x171/0x210
Aug 08 23:19:23 localhost.localdomain kernel:  snd_pcm_ioctl+0x23/0x30
[snd_pcm]
Aug 08 23:19:23 localhost.localdomain kernel:  do_vfs_ioctl+0xa5/0x6d0

Aug 08 23:19:23 localhost.localdomain kernel:  ksys_ioctl+0x60/0x90

Aug 08 23:19:23 localhost.localdomain kernel:  __x64_sys_ioctl+0x16/0x20

Aug 08 23:19:23 localhost.localdomain kernel:  do_syscall_64+0x60/0x1f0

Aug 08 23:19:23 localhost.localdomain kernel:
entry_SYSCALL_64_after_hwframe+0x49/0xbe
Aug 08 23:19:23 localhost.localdomain kernel: RIP: 0033:0x7f59021c4ec7

Aug 08 23:19:23 localhost.localdomain kernel: RSP: 002b:00007ffd83d81448
EFLAGS: 00000206 ORIG_RAX: 0000000000000010
Aug 08 23:19:23 localhost.localdomain kernel: RAX: ffffffffffffffda RBX:
0000556d69312220 RCX: 00007f59021c4ec7
Aug 08 23:19:23 localhost.localdomain kernel: RDX: 0000556d6931ae20 RSI:
0000000000004140 RDI: 0000000000000016
Aug 08 23:19:23 localhost.localdomain kernel: RBP: 00007ffd83d81b60 R08:
0000000000000000 R09: 0000000000001138
Aug 08 23:19:23 localhost.localdomain kernel: R10: 0000000000000004 R11:
0000000000000206 R12: 00007ffd83d81830
Aug 08 23:19:23 localhost.localdomain kernel: R13: 00007ffd83d81cf4 R14:
0000000000000000 R15: 00007ffd83d815c0
Aug 08 23:19:23 localhost.localdomain kernel:

                                              Showing all locks held in the
system:
Aug 08 23:19:23 localhost.localdomain kernel: 1 lock held by
khungtaskd/38:
Aug 08 23:19:23 localhost.localdomain kernel:  #0: 00000000b04056c7
(tasklist_lock){.+.+}, at: debug_show_all_locks+0x3e/0x165
Aug 08 23:19:23 localhost.localdomain kernel: 2 locks held by
pulseaudio/1750:
Aug 08 23:19:23 localhost.localdomain kernel:  #0: 000000008d30dafb
(snd_pcm_link_rwsem){++++}, at: snd_pcm_action_nonatomic+0x1e/0x70 [snd_pcm]
Aug 08 23:19:23 localhost.localdomain kernel:  #1: 00000000c8fc4ab6
(&usX2Y(card)->pcm_mutex){+.+.}, at: snd_usX2Y_pcm_prepare+0x38/0xd0
[snd_usb_usx2y]

The audio interface doesn't work and without nomodeset X freezes.

Any help pointing me in the right direction would be greatly appreciated.
It looks like an issue with the snd_usb_usx2y driver to me, but I'm not
sure.

Joe Spencer
