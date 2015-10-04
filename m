From: Michael Shell <list1@michaelshell.org>
Subject: sysfs: cannot create duplicate filename
 '/devices/isa/sbawe.0/sound/card0/seq-oss-0-0'
Date: Sun, 4 Oct 2015 01:12:38 -0400
Message-ID: <20151004011238.3759486f630c6605dd5c7d4d@michaelshell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.supercp.com (barracuda.supercp.com [216.234.124.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C66C12606F8
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 07:04:08 +0200 (CEST)
Received: from a2s43.a2hosting.com (a2s43.a2hosting.com [216.119.133.66]) by
 barracuda.supercp.com with ESMTP id xA3T8AoeGn5JKCku for
 <alsa-devel@alsa-project.org>; Sun, 04 Oct 2015 01:04:07 -0400 (EDT)
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



  Greetings,

I recently upgraded (an admittedly ancient K6-2 PCI/ISA machine) to kernel
version 4.2.2 (compiled from source). It went surprising well, but I did
run into a minor issue which did not occur under the older kernel 3.16.3.

Maybe the info here will help someone else out in the future or even reveal
a bug that might have greater implications that have not yet been seen.

The ancient machine has one of those ISA SoundBlaster cards whose drivers
are compiled as modules (to allow isapnp to operate) before module loading.

Upon issuing a

/sbin/modprobe snd-sbawe port=0x220 mpu_port=0x330 awe_port=0x620 irq=5 dma8=1 dma16=5 mic_agc=1 csp=0

dmesg (under 4.2.2) spits out:

EMU8000 [0x620]: 4096 KiB on-board DRAM detected
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2791 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x51/0x80()
sysfs: cannot create duplicate filename '/devices/isa/sbawe.0/sound/card0/seq-oss-0-0'
Modules linked in: snd_emu8000_synth(+) snd_emux_synth snd_seq_virmidi snd_util_mem snd_opl3_synth snd_seq_midi_emul snd_sbawe snd_opl3_lib snd_sb16_dsp snd_sb16_csp snd_sb_common snd_mpu401_uart lp parport_pc parport
CPU: 0 PID: 2791 Comm: modprobe Not tainted 4.2.2 #1
.
.
----
(full output with trace at the end of this message)


The /sys/devices/isa/sbawe.0 directory did not exist prior to the
attempt to load snd-sbawe and there are no other sound drivers
in the system other than those for the Soundblaster.

I do still have OSS emulation selected in the kernel config - I was
surpised that still is the recommended default. I probably could avoid
this bug by deselecting that. I doubt I have any software that still
requires OSS emulation, which is probably going to be removed from
future kernels anyway (and Debian systems don't even carry it anymore).

Nevertheless, a bug is a bug and this problem should not happen. I
think snd_seq_oss and snd_emux_synth are both trying to register
the same sysfs name or a single driver is trying to register the
same thing twice.

For the record, what is the correct procedure to find out exactly
which drivers are in conflict in duplicate sysfs filename cases
like this?


  Cheers and thanks in advance,

  Mike Shell



----
EMU8000 [0x620]: 4096 KiB on-board DRAM detected
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2791 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x51/0x80()
sysfs: cannot create duplicate filename '/devices/isa/sbawe.0/sound/card0/seq-oss-0-0'
Modules linked in: snd_emu8000_synth(+) snd_emux_synth snd_seq_virmidi snd_util_mem snd_opl3_synth snd_seq_midi_emul snd_sbawe snd_opl3_lib snd_sb16_dsp snd_sb16_csp snd_sb_common snd_mpu401_uart lp parport_pc parport
CPU: 0 PID: 2791 Comm: modprobe Not tainted 4.2.2 #1
 c1604e78 c1031c40 c175c544 dd6dfc48 00000ae7 c1758c38 0000001f c1103391
 c1103391 df493000 dd6ef2c0 dd6ec6b0 dd6bfe9c c1031d13 00000009 dd6dfc30
 c175c544 dd6dfc48 c1103391 c1758c38 0000001f c175c544 df493fdf dd6ef2c0
Call Trace:
 [<c1604e78>] ? dump_stack+0xa/0x13
 [<c1031c40>] ? warn_slowpath_common+0x80/0xc0
 [<c1103391>] ? sysfs_warn_dup+0x51/0x80
 [<c1103391>] ? sysfs_warn_dup+0x51/0x80
 [<c1031d13>] ? warn_slowpath_fmt+0x33/0x40
 [<c1103391>] ? sysfs_warn_dup+0x51/0x80
 [<c110346b>] ? sysfs_create_dir_ns+0x6b/0x80
 [<c11c156c>] ? kobject_add_internal+0x6c/0x2e0
 [<c11c86cb>] ? vsnprintf+0xcb/0x400
 [<c11c1956>] ? kobject_add+0x36/0x80
 [<c134de21>] ? device_add+0xc1/0x500
 [<c1441669>] ? snd_device_new+0x29/0xa0
 [<c1460a56>] ? snd_seq_device_new+0xb6/0x100
 [<c146096c>] ? snd_seq_device_dev_register+0xc/0x40
 [<c1441604>] ? snd_device_register+0x44/0x80
 [<e0bd1fc4>] ? snd_emux_init_seq_oss+0x84/0xa0 [snd_emux_synth]
 [<e0bcd1e3>] ? snd_emux_register+0x103/0x140 [snd_emux_synth]
 [<e0bcd000>] ? 0xe0bcd000
 [<e0bcd020>] ? sf_sample_new+0x20/0x20 [snd_emux_synth]
 [<e0bcd040>] ? sf_sample_free+0x20/0x20 [snd_emux_synth]
 [<e0bdf113>] ? snd_emu8000_probe+0xd3/0x180 [snd_emu8000_synth]
 [<c11036dd>] ? sysfs_create_link+0x1d/0x40
 [<c13504fb>] ? driver_probe_device+0x15b/0x220
 [<c1350631>] ? __driver_attach+0x71/0x80
 [<c13505c0>] ? driver_probe_device+0x220/0x220
 [<c134f000>] ? bus_for_each_dev+0x40/0x80
 [<c134ff7a>] ? driver_attach+0x1a/0x20
 [<c13505c0>] ? driver_probe_device+0x220/0x220
 [<c134fcf4>] ? bus_add_driver+0xd4/0x200
 [<c1350b91>] ? driver_register+0x51/0xe0
 [<e0be3000>] ? 0xe0be3000
 [<e0be3000>] ? 0xe0be3000
 [<c10003f2>] ? do_one_initcall+0x72/0x1a0
 [<e0be3000>] ? 0xe0be3000
 [<c14ac646>] ? netlink_broadcast_filtered+0x166/0x3c0
 [<c106c4a5>] ? do_init_module+0x45/0x200
 [<c10a8425>] ? __vunmap+0x85/0xe0
 [<c106dfaa>] ? load_module+0x186a/0x1ea0
 [<c106e6aa>] ? SyS_init_module+0xca/0x100
 [<c160a2dd>] ? syscall_call+0x7/0x7
---[ end trace 826ff8353957cad3 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2791 at lib/kobject.c:240 kobject_add_internal+0x252/0x2e0()
kobject_add_internal failed for seq-oss-0-0 with -EEXIST, don't try to register things with the same name in the same directory.
Modules linked in: snd_emu8000_synth(+) snd_emux_synth snd_seq_virmidi snd_util_mem snd_opl3_synth snd_seq_midi_emul snd_sbawe snd_opl3_lib snd_sb16_dsp snd_sb16_csp snd_sb_common snd_mpu401_uart lp parport_pc parport
CPU: 0 PID: 2791 Comm: modprobe Tainted: G        W       4.2.2 #1
 c1604e78 c1031c40 c1768d78 dd6dfc84 00000ae7 c1768e8e 000000f0 c11c1752
 c11c1752 dd66c274 00000000 dd66c274 dd6bfe9c c1031d13 00000009 dd6dfc6c
 c1768d78 dd6dfc84 c11c1752 c1768e8e 000000f0 c1768d78 c162bbd4 dd6ef2c0
Call Trace:
 [<c1604e78>] ? dump_stack+0xa/0x13
 [<c1031c40>] ? warn_slowpath_common+0x80/0xc0
 [<c11c1752>] ? kobject_add_internal+0x252/0x2e0
 [<c11c1752>] ? kobject_add_internal+0x252/0x2e0
 [<c1031d13>] ? warn_slowpath_fmt+0x33/0x40
 [<c11c1752>] ? kobject_add_internal+0x252/0x2e0
 [<c11c1956>] ? kobject_add+0x36/0x80
 [<c134de21>] ? device_add+0xc1/0x500
 [<c1441669>] ? snd_device_new+0x29/0xa0
 [<c1460a56>] ? snd_seq_device_new+0xb6/0x100
 [<c146096c>] ? snd_seq_device_dev_register+0xc/0x40
 [<c1441604>] ? snd_device_register+0x44/0x80
 [<e0bd1fc4>] ? snd_emux_init_seq_oss+0x84/0xa0 [snd_emux_synth]
 [<e0bcd1e3>] ? snd_emux_register+0x103/0x140 [snd_emux_synth]
 [<e0bcd000>] ? 0xe0bcd000
 [<e0bcd020>] ? sf_sample_new+0x20/0x20 [snd_emux_synth]
 [<e0bcd040>] ? sf_sample_free+0x20/0x20 [snd_emux_synth]
 [<e0bdf113>] ? snd_emu8000_probe+0xd3/0x180 [snd_emu8000_synth]
 [<c11036dd>] ? sysfs_create_link+0x1d/0x40
 [<c13504fb>] ? driver_probe_device+0x15b/0x220
 [<c1350631>] ? __driver_attach+0x71/0x80
 [<c13505c0>] ? driver_probe_device+0x220/0x220
 [<c134f000>] ? bus_for_each_dev+0x40/0x80
 [<c134ff7a>] ? driver_attach+0x1a/0x20
 [<c13505c0>] ? driver_probe_device+0x220/0x220
 [<c134fcf4>] ? bus_add_driver+0xd4/0x200
 [<c1350b91>] ? driver_register+0x51/0xe0
 [<e0be3000>] ? 0xe0be3000
 [<e0be3000>] ? 0xe0be3000
 [<c10003f2>] ? do_one_initcall+0x72/0x1a0
 [<e0be3000>] ? 0xe0be3000
 [<c14ac646>] ? netlink_broadcast_filtered+0x166/0x3c0
 [<c106c4a5>] ? do_init_module+0x45/0x200
 [<c10a8425>] ? __vunmap+0x85/0xe0
 [<c106dfaa>] ? load_module+0x186a/0x1ea0
 [<c106e6aa>] ? SyS_init_module+0xca/0x100
 [<c160a2dd>] ? syscall_call+0x7/0x7
---[ end trace 826ff8353957cad4 ]---
