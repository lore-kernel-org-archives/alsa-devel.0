From: Joseph Spencer <joespenceris@gmail.com>
Subject: Help with TASCAM US-122
Date: Sat, 4 Aug 2018 21:48:20 -0700
Message-ID: <CAMvaF73QrtaSAUNFJW7Dy-=EdaaS=F+H-mECdbfvbaC8ZTqzvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by alsa0.perex.cz (Postfix) with ESMTP id AA4FC267692
 for <alsa-devel@alsa-project.org>; Sun,  5 Aug 2018 06:48:33 +0200 (CEST)
Received: by mail-lf1-f52.google.com with SMTP id a134-v6so6778400lfe.6
 for <alsa-devel@alsa-project.org>; Sat, 04 Aug 2018 21:48:33 -0700 (PDT)
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

Hello,

I'm on Fedora 28 (Linux localhost.localdomain 4.17.11-200.fc28.x86_64 #1
SMP Mon Jul 30 15:21:09 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux), and I'm
trying to use the TASCAM US-122 Audio/MIDI Interface
<https://alsa-project.org/main/index.php/Matrix:Vendor-Tascam>.

It seems as though the alsa-firmware package is able to detect the USB
device just fine; however, after a few moments my entire system freezes
(mouse cursor doesn't move etc.).  I'm left to forcefully power off.

I'm wondering if anyone can point me in the right direction.  I'm
comfortable with C (haven't done much kernel development), good with shell
scripts, not so familiar with alsa.  I'd be more than happy to contribute
to hopefully fix this for others and (of course) myself.

I had journalctl -f up in a terminal when I plugged in the interface and
was able to capture the system logs (in the post script of this email).
Any help would be appreciated.

Thanks,
Joe Spencer
602.777.2307

P.S.  Here's the relevant system logs of the issue:

Aug 04 03:13:50 localhost.localdomain kernel: usb 3-1: new full-speed USB
device number 2 using xhci_hcd
Aug 04 03:13:50 localhost.localdomain kernel: usb 3-1: New USB device
found, idVendor=1604, idProduct=8006, bcdDevice= 1.00
Aug 04 03:13:50 localhost.localdomain kernel: usb 3-1: New USB device
strings: Mfr=0, Product=0, SerialNumber=0
Aug 04 03:13:50 localhost.localdomain /lib/udev/tascam_fw[2834]: load
/usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to
/dev/bus/usb/003/002
Aug 04 03:13:50 localhost.localdomain /lib/udev/tascam_fw[2837]: load
/usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to
Aug 04 03:13:50 localhost.localdomain kernel: usb 3-1: USB disconnect,
device number 2
Aug 04 03:13:52 localhost.localdomain kernel: usb 3-1: new full-speed USB
device number 3 using xhci_hcd
Aug 04 03:13:52 localhost.localdomain kernel: usb 3-1: New USB device
found, idVendor=1604, idProduct=8007, bcdDevice= 0.01
Aug 04 03:13:52 localhost.localdomain kernel: usb 3-1: New USB device
strings: Mfr=0, Product=0, SerialNumber=0
Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2859]: calling
/usr/bin/usx2yloader for
Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2861]: leaving
Aug 04 03:13:52 localhost.localdomain kernel: usbcore: registered new
interface driver snd-usb-usx2y
Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2864]: calling
/usr/bin/usx2yloader for
*Aug 04 03:13:54 localhost.localdomain /lib/udev/tascam_fpga[2867]: leaving
(this was the last log entry before my screen froze, the following logs
were obtained after a reboot with my device disconnected)*
Aug 04 03:13:58 localhost.localdomain kernel: BUG: unable to handle kernel
paging request at 00000000178f90ca
Aug 04 03:13:58 localhost.localdomain kernel: PGD 800000040aa8b067 P4D
800000040aa8b067 PUD 4050d8067 PMD 0
Aug 04 03:13:58 localhost.localdomain kernel: Oops: 0000 [#1] SMP PTI
Aug 04 03:13:58 localhost.localdomain kernel: Modules linked in:
snd_seq_midi snd_seq_midi_event snd_usb_usx2y snd_usbmidi_lib snd_rawmidi
ccm rfcomm fuse vboxnetadp(OE) vboxnetflt(OE) vboxdrv>
Aug 04 03:13:58 localhost.localdomain kernel:  snd_hwdep snd_seq wmi
snd_seq_device snd_pcm snd_timer parport_pc parport snd mei_me soundcore
mei dell_rbtn rfkill lpc_ich shpchp dell_smo8800 p>
Aug 04 03:13:58 localhost.localdomain kernel: CPU: 1 PID: 1125 Comm: Xorg
Tainted: G           OE     4.17.11-200.fc28.x86_64 #1
Aug 04 03:13:58 localhost.localdomain kernel: Hardware name: Dell Inc.
Latitude E6530/, BIOS A17 08/19/2015
Aug 04 03:13:58 localhost.localdomain kernel: RIP:
0010:__kmalloc_track_caller+0xa2/0x230
Aug 04 03:13:58 localhost.localdomain kernel: RSP: 0018:ffffb4c7c22bfab8
EFLAGS: 00010206
Aug 04 03:13:58 localhost.localdomain kernel: RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
Aug 04 03:13:58 localhost.localdomain kernel: RDX: 0000000000004956 RSI:
00000000014000c0 RDI: 0000000000026120
Aug 04 03:13:58 localhost.localdomain kernel: RBP: 00000000014000c0 R08:
00000000178f90ca R09: ffff930a8d803200
Aug 04 03:13:58 localhost.localdomain kernel: R10: ffff930a860b2c00 R11:
0000000000000000 R12: 00000000000000d0
Aug 04 03:13:58 localhost.localdomain kernel: R13: ffffffffc04a7e80 R14:
ffff930a8d803200 R15: 00000000178f90ca
Aug 04 03:13:58 localhost.localdomain kernel: FS:  00007f11c22baac0(0000)
GS:ffff930a9e280000(0000) knlGS:0000000000000000
Aug 04 03:13:58 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Aug 04 03:13:58 localhost.localdomain kernel: CR2: 00000000178f90ca CR3:
0000000406ab4004 CR4: 00000000001606e0
Aug 04 03:13:58 localhost.localdomain kernel: Call Trace:
Aug 04 03:13:58 localhost.localdomain kernel:  kmemdup+0x17/0x40
Aug 04 03:13:58 localhost.localdomain kernel:
intel_plane_duplicate_state+0x20/0x50 [i915]
Aug 04 03:13:58 localhost.localdomain kernel:
drm_atomic_get_plane_state+0x6a/0x110 [drm]
Aug 04 03:13:58 localhost.localdomain kernel:
drm_atomic_helper_disable_plane+0x36/0xc0 [drm_kms_helper]
Aug 04 03:13:58 localhost.localdomain kernel:
__setplane_internal+0x1bd/0x260 [drm]
Aug 04 03:13:58 localhost.localdomain kernel:  ? sock_wfree+0x3a/0x60
Aug 04 03:13:58 localhost.localdomain kernel:  ? unix_destruct_scm+0x80/0xa0
Aug 04 03:13:58 localhost.localdomain kernel:
drm_mode_cursor_universal+0x1b7/0x1f0 [drm]
Aug 04 03:13:58 localhost.localdomain kernel:
drm_mode_cursor_common+0x18b/0x1f0 [drm]
Aug 04 03:13:58 localhost.localdomain kernel:  ?
drm_mode_setplane+0x230/0x230 [drm]
Aug 04 03:13:58 localhost.localdomain kernel:
drm_mode_cursor_ioctl+0x4d/0x70 [drm]
Aug 04 03:13:58 localhost.localdomain kernel:  drm_ioctl_kernel+0x5b/0xb0
[drm]
Aug 04 03:13:58 localhost.localdomain kernel:  drm_ioctl+0x1b3/0x370 [drm]
Aug 04 03:13:58 localhost.localdomain kernel:  ?
drm_mode_setplane+0x230/0x230 [drm]
Aug 04 03:13:58 localhost.localdomain kernel:  ? timerqueue_add+0x52/0x80
Aug 04 03:13:58 localhost.localdomain kernel:  ?
selinux_file_ioctl+0x161/0x200
Aug 04 03:13:58 localhost.localdomain kernel:  do_vfs_ioctl+0xa4/0x610
Aug 04 03:13:58 localhost.localdomain kernel:  ksys_ioctl+0x60/0x90
Aug 04 03:13:58 localhost.localdomain kernel:  __x64_sys_ioctl+0x16/0x20
Aug 04 03:13:58 localhost.localdomain kernel:  do_syscall_64+0x5b/0x160
Aug 04 03:13:58 localhost.localdomain kernel:
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 04 03:13:58 localhost.localdomain kernel: RIP: 0033:0x7f11bf53dec7
Aug 04 03:13:58 localhost.localdomain kernel: RSP: 002b:00007fffa0ee58d8
EFLAGS: 00003246 ORIG_RAX: 0000000000000010
Aug 04 03:13:58 localhost.localdomain kernel: RAX: ffffffffffffffda RBX:
00000000013cc100 RCX: 00007f11bf53dec7
Aug 04 03:13:58 localhost.localdomain kernel: RDX: 00007fffa0ee5910 RSI:
00000000c01c64a3 RDI: 0000000000000010
Aug 04 03:13:58 localhost.localdomain kernel: RBP: 00007fffa0ee5910 R08:
00007f11c2136000 R09: 0000000000000001
Aug 04 03:13:58 localhost.localdomain kernel: R10: 0000000000000780 R11:
0000000000003246 R12: 00000000c01c64a3
Aug 04 03:13:58 localhost.localdomain kernel: R13: 0000000000000010 R14:
000000000124c0d0 R15: 00000000000001cd
Aug 04 03:13:58 localhost.localdomain kernel: Code: 50 08 65 4c 03 05 e7 26
da 5e 49 83 78 10 00 4d 8b 38 0f 84 22 01 00 00 4d 85 ff 0f 84 19 01 00 00
45 8b 41 20 49 8b 39 4d 01 f8 <4d> 8b 10 >
Aug 04 03:13:58 localhost.localdomain kernel: RIP:
__kmalloc_track_caller+0xa2/0x230 RSP: ffffb4c7c22bfab8
Aug 04 03:13:58 localhost.localdomain kernel: CR2: 00000000178f90ca
Aug 04 03:13:58 localhost.localdomain kernel: ---[ end trace
59cb442553c1594d ]---
Aug 04 03:13:59 localhost.localdomain abrt-dump-journal-oops[1205]:
abrt-dump-journal-oops: Found oopses: 1
Aug 04 03:13:59 localhost.localdomain abrt-dump-journal-oops[1205]:
abrt-dump-journal-oops: Creating problem directories
Aug 04 03:13:59 localhost.localdomain kernel: BUG: unable to handle kernel
paging request at 00000000178f90ca
Aug 04 03:13:59 localhost.localdomain kernel: PGD 0 P4D 0
Aug 04 03:13:59 localhost.localdomain kernel: Oops: 0000 [#2] SMP PTI
Aug 04 03:13:59 localhost.localdomain kernel: Modules linked in:
snd_seq_midi snd_seq_midi_event snd_usb_usx2y snd_usbmidi_lib snd_rawmidi
ccm rfcomm fuse vboxnetadp(OE) vboxnetflt(OE) vboxdrv>
Aug 04 03:13:59 localhost.localdomain kernel:  snd_hwdep snd_seq wmi
snd_seq_device snd_pcm snd_timer parport_pc parport snd mei_me soundcore
mei dell_rbtn rfkill lpc_ich shpchp dell_smo8800 p>
Aug 04 03:13:59 localhost.localdomain kernel: CPU: 1 PID: 1205 Comm:
abrt-dump-journ Tainted: G      D    OE     4.17.11-200.fc28.x86_64 #1
Aug 04 03:13:59 localhost.localdomain kernel: Hardware name: Dell Inc.
Latitude E6530/, BIOS A17 08/19/2015
Aug 04 03:13:59 localhost.localdomain kernel: RIP:
0010:kmem_cache_alloc_trace+0x8d/0x1d0
Aug 04 03:13:59 localhost.localdomain kernel: RSP: 0018:ffffb4c7c25dfc60
EFLAGS: 00010206
Aug 04 03:13:59 localhost.localdomain kernel: RAX: 0000000000000000 RBX:
00000000178f90ca RCX: 0000000000000002
Aug 04 03:13:59 localhost.localdomain kernel: RDX: 0000000000004956 RSI:
00000000014080c0 RDI: 0000000000026120
Aug 04 03:13:59 localhost.localdomain kernel: RBP: ffff930a8d803200 R08:
ffff930a9e2a6120 R09: 0000000000000000
Aug 04 03:13:59 localhost.localdomain kernel: R10: 0000000000000000 R11:
e7825477348aeba9 R12: 00000000014080c0
Aug 04 03:13:59 localhost.localdomain kernel: R13: 00000000000000f8 R14:
ffff930a8d803200 R15: 00000000178f90ca
Aug 04 03:13:59 localhost.localdomain kernel: FS:  00007f0fd1a99ac0(0000)
GS:ffff930a9e280000(0000) knlGS:0000000000000000
Aug 04 03:13:59 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Aug 04 03:13:59 localhost.localdomain kernel: CR2: 00000000178f90ca CR3:
00000004082c2006 CR4: 00000000001606e0
Aug 04 03:13:59 localhost.localdomain kernel: Call Trace:
Aug 04 03:13:59 localhost.localdomain kernel:  ? full_proxy_open+0xc0/0x1d0
Aug 04 03:13:59 localhost.localdomain kernel:  full_proxy_open+0xc0/0x1d0
Aug 04 03:13:59 localhost.localdomain kernel:  ?
debugfs_create_devm_seqfile+0x80/0x80
Aug 04 03:13:59 localhost.localdomain kernel:  do_dentry_open+0x1af/0x2e0
Aug 04 03:13:59 localhost.localdomain kernel:  path_openat+0x46e/0x15f0
Aug 04 03:13:59 localhost.localdomain kernel:  ? 0xffffffffc02a8000
Aug 04 03:13:59 localhost.localdomain kernel:  ? seq_puts+0x3a/0x50
Aug 04 03:13:59 localhost.localdomain kernel:  ? __kmalloc_node+0x208/0x2d0
Aug 04 03:13:59 localhost.localdomain kernel:  ? seq_read+0x2de/0x460
Aug 04 03:13:59 localhost.localdomain kernel:  do_filp_open+0x93/0x100
Aug 04 03:13:59 localhost.localdomain kernel:  ?
__check_object_size+0x9c/0x171
Aug 04 03:13:59 localhost.localdomain kernel:  do_sys_open+0x186/0x210
Aug 04 03:13:59 localhost.localdomain kernel:  do_syscall_64+0x5b/0x160
Aug 04 03:13:59 localhost.localdomain kernel:
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 04 03:13:59 localhost.localdomain kernel: RIP: 0033:0x7f0fd03b0c9e
Aug 04 03:13:59 localhost.localdomain kernel: RSP: 002b:00007ffd7905f8b0
EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Aug 04 03:13:59 localhost.localdomain kernel: RAX: ffffffffffffffda RBX:
0000000000000001 RCX: 00007f0fd03b0c9e
Aug 04 03:13:59 localhost.localdomain kernel: RDX: 0000000000000000 RSI:
000055cf0bd89780 RDI: 00000000ffffff9c
Aug 04 03:13:59 localhost.localdomain kernel: RBP: 0000000000000000 R08:
00007f0fd067fc40 R09: 0000000000000007
Aug 04 03:13:59 localhost.localdomain kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000000
Aug 04 03:13:59 localhost.localdomain kernel: R13: 000055cf0d8c5700 R14:
0000000000000003 R15: 000055cf0d936d50
Aug 04 03:13:59 localhost.localdomain kernel: Code: 50 08 65 4c 03 05 7c 5f
da 5e 49 83 78 10 00 4d 8b 38 0f 84 10 01 00 00 4d 85 ff 0f 84 07 01 00 00
41 8b 5e 20 49 8b 3e 4c 01 fb <48> 33 1b >
Aug 04 03:13:59 localhost.localdomain kernel: RIP:
kmem_cache_alloc_trace+0x8d/0x1d0 RSP: ffffb4c7c25dfc60
Aug 04 03:13:59 localhost.localdomain kernel: CR2: 00000000178f90ca
Aug 04 03:13:59 localhost.localdomain kernel: ---[ end trace
59cb442553c1594e ]---
Aug 04 03:13:59 localhost.localdomain audit[1]: SERVICE_STOP pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
msg='unit=abrt-oops comm="systemd" exe="/usr/lib/system>
Aug 04 03:13:59 localhost.localdomain systemd[1]: abrt-oops.service: Main
process exited, code=killed, status=9/KILL
Aug 04 03:13:59 localhost.localdomain systemd[1]: abrt-oops.service: Failed
with result 'signal'.
Aug 04 03:15:24 localhost.localdomain chronyd[1036]: Selected source
208.75.89.4
Aug 04 03:15:56 localhost.localdomain systemd-logind[1024]: Power key
pressed.
Aug 04 03:15:56 localhost.localdomain systemd-logind[1024]: Suspending...
Aug 04 03:15:56 localhost.localdomain NetworkManager[1054]: <info>
[1533377756.3501] manager: sleep: sleep requested (sleeping: no  enabled:
yes)
Aug 04 03:15:56 localhost.localdomain NetworkManager[1054]: <info>
[1533377756.3506] manager: NetworkManager state is now ASLEEP
Aug 04 03:15:56 localhost.localdomain NetworkManager[1054]: <info>
[1533377756.3510] device (wlp2s0): state change: activated -> deactivating
(reason 'sleeping', sys-iface-state: 'managed')
Aug 04 03:15:56 localhost.localdomain NetworkManager[1054]: <info>
[1533377756.3714] device (wlp2s0): state change: deactivating ->
disconnected (reason 'sleeping', sys-iface-state: 'managed')
Aug 04 03:15:56 localhost.localdomain dbus-daemon[1046]: [system]
Activating via systemd: service name='org.freedesktop.nm_dispatcher'
unit='dbus-org.freedesktop.nm-dispatcher.service' request>
Aug 04 03:15:56 localhost.localdomain avahi-daemon[1030]: Withdrawing
address record for fe80::f3ca:ecd8:3b4f:e72a on wlp2s0.
Aug 04 03:15:56 localhost.localdomain avahi-daemon[1030]: Leaving mDNS
multicast group on interface wlp2s0.IPv6 with address
fe80::f3ca:ecd8:3b4f:e72a.
Aug 04 03:15:56 localhost.localdomain avahi-daemon[1030]: Interface
wlp2s0.IPv6 no longer relevant for mDNS.
Aug 04 03:15:56 localhost.localdomain systemd[1]: Starting Network Manager
Script Dispatcher Service...
Aug 04 03:15:56 localhost.localdomain kernel: BUG: unable to handle kernel
paging request at 00000000178f90ca
Aug 04 03:15:56 localhost.localdomain kernel: PGD 0 P4D 0
Aug 04 03:15:56 localhost.localdomain kernel: Oops: 0000 [#3] SMP PTI
Aug 04 03:15:56 localhost.localdomain kernel: Modules linked in:
snd_seq_midi snd_seq_midi_event snd_usb_usx2y snd_usbmidi_lib snd_rawmidi
ccm rfcomm fuse vboxnetadp(OE) vboxnetflt(OE) vboxdrv>
Aug 04 03:15:56 localhost.localdomain kernel:  snd_hwdep snd_seq wmi
snd_seq_device snd_pcm snd_timer parport_pc parport snd mei_me soundcore
mei dell_rbtn rfkill lpc_ich shpchp dell_smo8800 p>
Aug 04 03:15:56 localhost.localdomain kernel: CPU: 1 PID: 2878 Comm:
(spatcher) Tainted: G      D    OE     4.17.11-200.fc28.x86_64 #1
Aug 04 03:15:56 localhost.localdomain kernel: Hardware name: Dell Inc.
Latitude E6530/, BIOS A17 08/19/2015
Aug 04 03:15:56 localhost.localdomain kernel: RIP:
0010:kmem_cache_alloc_trace+0x8d/0x1d0
Aug 04 03:15:56 localhost.localdomain kernel: RSP: 0018:ffffb4c7c261fe68
EFLAGS: 00010206
Aug 04 03:15:56 localhost.localdomain kernel: RAX: 0000000000000000 RBX:
00000000178f90ca RCX: 0000000000000000
Aug 04 03:15:56 localhost.localdomain kernel: RDX: 0000000000004956 RSI:
00000000014080c0 RDI: 0000000000026120
Aug 04 03:15:56 localhost.localdomain kernel: RBP: ffff930a8d803200 R08:
ffff930a9e2a6120 R09: 0000555a9cca5d60
Aug 04 03:15:56 localhost.localdomain kernel: R10: fefefefefefefeff R11:
0000000000000fe0 R12: 00000000014080c0
Aug 04 03:15:56 localhost.localdomain kernel: R13: 0000000000000100 R14:
ffff930a8d803200 R15: 00000000178f90ca
Aug 04 03:15:56 localhost.localdomain kernel: FS:  00007f413dfaae40(0000)
GS:ffff930a9e280000(0000) knlGS:0000000000000000
Aug 04 03:15:56 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Aug 04 03:15:56 localhost.localdomain kernel: CR2: 00000000178f90ca CR3:
00000003c9d3e001 CR4: 00000000001606e0
Aug 04 03:15:56 localhost.localdomain kernel: Call Trace:
Aug 04 03:15:56 localhost.localdomain kernel:  ?
do_execveat_common.isra.37+0xeb/0x790
Aug 04 03:15:56 localhost.localdomain kernel:
do_execveat_common.isra.37+0xeb/0x790
Aug 04 03:15:56 localhost.localdomain kernel:  ?
strncpy_from_user+0x4a/0x170
Aug 04 03:15:56 localhost.localdomain kernel:  __x64_sys_execve+0x32/0x40
Aug 04 03:15:56 localhost.localdomain kernel:  do_syscall_64+0x5b/0x160
Aug 04 03:15:56 localhost.localdomain kernel:
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 04 03:15:56 localhost.localdomain kernel: RIP: 0033:0x7f413bc5dde7
Aug 04 03:15:56 localhost.localdomain kernel: RSP: 002b:00007ffc55bb2748
EFLAGS: 00000246 ORIG_RAX: 000000000000003b
Aug 04 03:15:56 localhost.localdomain kernel: RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007f413bc5dde7
Aug 04 03:15:56 localhost.localdomain kernel: RDX: 0000555a9cca5d60 RSI:
0000555a9cd8e4c0 RDI: 0000555a9cd92bc0
Aug 04 03:15:56 localhost.localdomain kernel: RBP: 00007ffc55bb29b0 R08:
000000000000fefe R09: 0000000000000000
Aug 04 03:15:56 localhost.localdomain kernel: R10: 0000555a9cd4a900 R11:
0000000000000246 R12: 0000555a9cd8e4c0
Aug 04 03:15:56 localhost.localdomain kernel: R13: 0000555a9cd933a0 R14:
0000555a9cd93840 R15: 0000000000000000
Aug 04 03:15:56 localhost.localdomain kernel: Code: 50 08 65 4c 03 05 7c 5f
da 5e 49 83 78 10 00 4d 8b 38 0f 84 10 01 00 00 4d 85 ff 0f 84 07 01 00 00
41 8b 5e 20 49 8b 3e 4c 01 fb <48> 33 1b >
Aug 04 03:15:56 localhost.localdomain kernel: RIP:
kmem_cache_alloc_trace+0x8d/0x1d0 RSP: ffffb4c7c261fe68
Aug 04 03:15:56 localhost.localdomain kernel: CR2: 00000000178f90ca
Aug 04 03:15:56 localhost.localdomain kernel: ---[ end trace
59cb442553c1594f ]---
Aug 04 03:15:56 localhost.localdomain kernel: wlp2s0: deauthenticating from
84:1b:5e:03:b3:bd by local choice (Reason: 3=DEAUTH_LEAVING)
Aug 04 03:15:56 localhost.localdomain kernel: IPv6: ADDRCONF(NETDEV_UP):
wlp2s0: link is not ready
Aug 04 03:15:56 localhost.localdomain kernel: BUG: unable to handle kernel
paging request at 00000000178f90ca
-- Reboot --
Aug 04 03:16:21 localhost.localdomain kernel: microcode: microcode updated
early to revision 0x1f, date = 2018-02-07
Aug 04 03:16:21 localhost.localdomain kernel: Linux version
4.17.11-200.fc28.x86_64 (mockbuild@bkernel01.phx2.fedoraproject.org) (gcc
version 8.1.1 20180712 (Red Hat 8.1.1-5) (GCC)) #1 SMP Mon>
Aug 04 03:16:21 localhost.localdomain kernel: Command line:
BOOT_IMAGE=/vmlinuz-4.17.11-200.fc28.x86_64 root=/dev/mapper/fedora-root ro
rd.luks.uuid=luks-9c1123dd-5aee-41e5-b3c4-b91249d5ed64 r>
Aug 04 03:16:21 localhost.localdomain kernel: x86/fpu: Supporting XSAVE
feature 0x001: 'x87 floating point registers'
Aug 04 03:16:21 localhost.localdomain kernel: x86/fpu: Supporting XSAVE
feature 0x002: 'SSE registers'
Aug 04 03:16:21 localhost.localdomain kernel: x86/fpu: Supporting XSAVE
feature 0x004: 'AVX registers'
Aug 04 03:16:21 localhost.localdomain kernel: x86/fpu: xstate_offset[2]:
576, xstate_sizes[2]:  256
Aug 04 03:16:21 localhost.localdomain kernel: x86/fpu: Enabled xstate
features 0x7, context size is 832 bytes, using 'standard' format.
Aug 04 03:16:21 localhost.localdomain kernel: e820: BIOS-provided physical
RAM map:
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x0000000000000000-0x000000000009d3ff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x000000000009d400-0x000000000009ffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000000e0000-0x00000000000fffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x0000000000100000-0x000000001fffffff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x0000000020000000-0x00000000201fffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x0000000020200000-0x0000000040003fff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x0000000040004000-0x0000000040004fff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x0000000040005000-0x00000000d7f09fff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000d7f0a000-0x00000000d7ffffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000d8000000-0x00000000d8752fff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000d8753000-0x00000000d87fffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000d8800000-0x00000000d8fb2fff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000d8fb3000-0x00000000d8ffffff] ACPI data
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000d9000000-0x00000000da6fbfff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000da6fc000-0x00000000da7fffff] ACPI NVS
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000da800000-0x00000000dbb1bfff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000dbb1c000-0x00000000dc7a6fff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000dc7a7000-0x00000000dc7e9fff] ACPI NVS
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000dc7ea000-0x00000000dcab2fff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000dcab3000-0x00000000dcfeffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000dcff0000-0x00000000dcffffff] usable
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000dd800000-0x00000000df9fffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000f8000000-0x00000000fbffffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000fec00000-0x00000000fec00fff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000fed00000-0x00000000fed03fff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000fed1c000-0x00000000fed1ffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000fee00000-0x00000000fee00fff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x00000000ff000000-0x00000000ffffffff] reserved
Aug 04 03:16:21 localhost.localdomain kernel: BIOS-e820: [mem
0x0000000100000000-0x000000041e5fffff] usable
Aug 04 03:16:21 localhost.localdomain kernel: NX (Execute Disable)
protection: active
Aug 04 03:16:21 localhost.localdomain kernel: random: fast init done
Aug 04 03:16:21 localhost.localdomain kernel: SMBIOS 2.7 present.
Aug 04 03:16:21 localhost.localdomain kernel: DMI: Dell Inc. Latitude
E6530/, BIOS A17 08/19/2015
Aug 04 03:16:21 localhost.localdomain kernel: e820: update [mem
0x00000000-0x00000fff] usable ==> reserved
Aug 04 03:16:21 localhost.localdomain kernel: e820: remove [mem
0x000a0000-0x000fffff] usable
Aug 04 03:16:21 localhost.localdomain kernel: e820: last_pfn = 0x41e600
max_arch_pfn = 0x400000000
Aug 04 03:16:21 localhost.localdomain kernel: MTRR default type: uncachable
Aug 04 03:16:21 localhost.localdomain kernel: MTRR fixed ranges enabled:
Aug 04 03:16:21 localhost.localdomain kernel:   00000-9FFFF write-back
