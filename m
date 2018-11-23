From: Meelis Roos <mroos@linux.ee>
Subject: Undefined behaviour in ac97_codec.c - shift exponent
 68 is too large for 32-bit type 'int'
Date: Fri, 23 Nov 2018 11:16:53 +0200
Message-ID: <0f267366-2ecc-9a53-a5fb-d7bf29da99b4@linux.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.cyber.ee (mx2.cyber.ee [193.40.6.72])
 by alsa0.perex.cz (Postfix) with ESMTP id A6BE726786E
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 10:16:54 +0100 (CET)
Content-Language: et-EE
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

I updated one of my old laptops (ECS Desknote 532 with Transmeta CPU) to newest kernel
(4.20.0-rc3-00145-gedeca3a769ad) and turned on UBSAN checks. Got the following UBSAN
warning multiple times per boot.

The soundcard:
00:04.0 Multimedia audio controller [0401]: ULi Electronics Inc. M5455 PCI AC-Link Controller Audio Device [10b9:5455] (rev 10)
         Subsystem: Elitegroup Computer Systems M5455 PCI AC-Link Controller Audio Device [1019:0f56]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 64 (16000ns min), Cache Line Size: 128 bytes
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at e400 [size=256]
         Region 1: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: <access denied>
         Kernel driver in use: snd_intel8x0
         Kernel modules: snd_intel8x0

/proc/asound/cards:

  0 [M5455          ]: ICH - ALi M5455
                       ALi M5455 with ALC655 at irq 5

gcc version 8.2.0 (Debian 8.2.0-9)

[   15.688683] snd_intel8x0 0000:00:04.0: intel8x0_measure_ac97_clock: measured 58318 usecs (2808 samples)
[   15.689033] snd_intel8x0 0000:00:04.0: clocking to 48000
...
[   19.667746] ================================================================================
[   19.668078] UBSAN: Undefined behaviour in sound/pci/ac97/ac97_codec.c:836:7
[   19.668268] shift exponent 68 is too large for 32-bit type 'int'
[   19.668465] CPU: 0 PID: 199 Comm: alsactl Not tainted 4.20.0-rc3-00145-gedeca3a769ad #2
[   19.668602] Hardware name: Elitegroup Co. 532/532, BIOS 080010  02/22/2005
[   19.668602] Call Trace:
[   19.668602]  dump_stack+0x16/0x19
[   19.668602]  ubsan_epilogue+0xb/0x29
[   19.668602]  __ubsan_handle_shift_out_of_bounds.cold.15+0x26/0x78
[   19.668602]  snd_ac97_put_spsa.cold.50+0xf/0x24 [snd_ac97_codec]
[   19.668602]  ? _copy_from_user+0x33/0xd0
[   19.668602]  snd_ctl_ioctl+0x69e/0x820
[   19.668602]  ? __seccomp_filter+0x60/0x320
[   19.668602]  ? snd_ctl_elem_add_user+0x8a0/0x8a0
[   19.668602]  do_vfs_ioctl+0x90/0x6c0
[   19.668602]  ? __switch_to_asm+0x26/0x4c
[   19.668602]  ? __switch_to_asm+0x32/0x4c
[   19.668602]  ? __switch_to_asm+0x26/0x4c
[   19.668602]  ? __switch_to_asm+0x32/0x4c
[   19.668602]  ? __switch_to_asm+0x26/0x4c
[   19.668602]  ? __switch_to_asm+0x32/0x4c
[   19.668602]  ? __switch_to_asm+0x26/0x4c
[   19.668602]  ? __switch_to_asm+0x32/0x4c
[   19.668602]  ? __switch_to_asm+0x26/0x4c
[   19.668602]  ? __switch_to_asm+0x26/0x4c
[   19.668602]  ? __secure_computing+0x2b/0x80
[   19.668602]  ? syscall_trace_enter+0x141/0x1b0
[   19.668602]  ? __switch_to_asm+0x26/0x4c
[   19.668602]  ksys_ioctl+0x39/0x70
[   19.668602]  sys_ioctl+0x11/0x13
[   19.668602]  do_fast_syscall_32+0x90/0x1c0
[   19.668602]  entry_SYSENTER_32+0x6b/0xbd
[   19.668602] EIP: 0xb7fd69ad
[   19.668602] Code: 54 cd ff ff 85 d2 8b 98 58 cd ff ff 89 c8 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[   19.668602] EAX: ffffffda EBX: 00000003 ECX: c2c45513 EDX: bffff670
[   19.668602] ESI: 00000000 EDI: 00000001 EBP: bffff9c8 ESP: bffff508
[   19.668602] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   19.668602] ================================================================================


-- 
Meelis Roos <mroos@linux.ee>
