From: El boulangero <elboulangero@gmail.com>
Subject: Loopback interface: suspend/resume leads to a kernel
	crash
Date: Thu, 31 Jan 2013 21:09:13 +0100
Message-ID: <CALGUdm_O4pP=CUxnHWQszJi=hc0b2u52St3pwdMmDPWJPtw0gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CC018264EFF
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 21:09:15 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id bn7so1763754ieb.25
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 12:09:13 -0800 (PST)
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

Hi,

I use the loopback device all the time. It works pretty good, except
when I suspend my computer to RAM. On resume, I've got a kernel call
trace.

Here is the procedure to reproduce this behaviour, it's pretty easy.

# Insert module if needed
$ modprobe snd_aloop pcm_substreams=3D2
# Let's see how it looks like
$ aplay -l
**** Liste des P=E9riph=E9riques Mat=E9riels PLAYBACK ****
carte 0: PCH [HDA Intel PCH], p=E9riph=E9rique 0: VT1802 Analog [VT1802 Ana=
log]
  Sous-p=E9riph=E9riques: 1/1
  Sous-p=E9riph=E9rique #0: subdevice #0
carte 0: PCH [HDA Intel PCH], p=E9riph=E9rique 2: VT1802 HP [VT1802 HP]
  Sous-p=E9riph=E9riques: 1/1
  Sous-p=E9riph=E9rique #0: subdevice #0
carte 0: PCH [HDA Intel PCH], p=E9riph=E9rique 3: HDMI 0 [HDMI 0]
  Sous-p=E9riph=E9riques: 1/1
  Sous-p=E9riph=E9rique #0: subdevice #0
carte 1: Loopback [Loopback], p=E9riph=E9rique 0: Loopback PCM [Loopback PC=
M]
  Sous-p=E9riph=E9riques: 2/2
  Sous-p=E9riph=E9rique #0: subdevice #0
  Sous-p=E9riph=E9rique #1: subdevice #1
carte 1: Loopback [Loopback], p=E9riph=E9rique 1: Loopback PCM [Loopback PC=
M]
  Sous-p=E9riph=E9riques: 2/2
  Sous-p=E9riph=E9rique #0: subdevice #0
  Sous-p=E9riph=E9rique #1: subdevice #1
# Use the loopback device
$ aplay -D hw:1,0,0 sound.wave &
# Suspend computer
$ pm-suspend
# Wake up the computer



That's enough to reproduce this bug. Here are the kernel logs:

[  181.994434] PM: resume of devices complete after 3301.753 msecs
[  182.006413] Restarting tasks ... done.
[  182.006590] ------------[ cut here ]------------
[  182.006605] kernel BUG at kernel/timer.c:908!
[  182.006619] video LNXVIDEO:00: Restoring backlight state
[  182.006621] invalid opcode: 0000 [#1] PREEMPT SMP
[  182.006640] Modules linked in: snd_aloop af_packet nfsd auth_rpcgss
nfs_acl nfs lockd fscache sunrpc ipv6 loop uvcvideo videobuf2_vmalloc
videobuf2_memops videobuf2_core videodev media joydev hid_generic
usbhid coretemp kvm_intel kvm crc32c_intel ghash_clmulni_intel
aesni_intel xts aes_x86_64 lrw i915 gf128mul i2c_algo_bit intel_agp
intel_gtt drm_kms_helper ablk_helper drm cryptd iTCO_wdt
snd_hda_codec_hdmi i2c_i801 psmouse iTCO_vendor_support
snd_hda_codec_via snd_hda_intel snd_hda_codec snd_hwdep snd_pcm
snd_page_alloc iwlwifi cfg80211 snd_seq snd_seq_device snd_timer snd
ehci_pci button battery ac rtc_cmos microcode video i2c_core soundcore
lpc_ich evdev serio_raw mei wmi ehci_hcd rfkill ext4 crc16 jbd2
mbcache sg sr_mod sd_mod cdrom ahci libahci libata scsi_mod thermal
r8169 mii xhci_hcd
[  182.006642] CPU 1
[  182.006642] Pid: 2982, comm: aplay Not tainted 3.8.0-rc5-kdump #1
System76, Inc. Gazelle Professional/Gazelle Professional
[  182.006646] RIP: 0010:[<ffffffff81063f8f>]  [<ffffffff81063f8f>]
add_timer+0xf/0x20
[  182.006647] RSP: 0018:ffff880214a93d40  EFLAGS: 00010082
[  182.006647] RAX: 00000000fffe34c9 RBX: ffff88021570e200 RCX: 00000000fff=
e344c
[  182.006648] RDX: 000000000001f3ff RSI: 0000000000f42400 RDI: ffff8802149=
2f350
[  182.006648] RBP: ffff88021492f300 R08: 000000000001f400 R09: 00000000000=
00020
[  182.006649] R10: ffff88021588f800 R11: 0000000000000206 R12: 00000000fff=
ffffe
[  182.006649] R13: ffff880214a3cc00 R14: ffff880214bbc464 R15: ffff8802158=
8f800
[  182.006650] FS:  00007f3489ed0700(0000) GS:ffff88021f240000(0000)
knlGS:0000000000000000
[  182.006650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  182.006651] CR2: 0000000000000000 CR3: 00000002148fe000 CR4: 00000000001=
407e0
[  182.006652] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  182.006652] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
00400
[  182.006653] Process aplay (pid: 2982, threadinfo ffff880214a92000,
task ffff880215928000)
[  182.006653] Stack:
[  182.006654]  ffffffffa0d0947c 00000000000000b4 00000b2c00000003
0000000000003e80
[  182.006655]  ffffffffa02fbe80 ffff880214a3cc00 0000000000000003
ffff880214a3cc00
[  182.006656]  0000000000000000 0000000000000fa0 ffffffffa02f01b0
0000000000003e80
[  182.006656] Call Trace:
[  182.006659]  [<ffffffffa0d0947c>] ? loopback_trigger+0x20c/0x2e0 [snd_al=
oop]
[  182.006664]  [<ffffffffa02f01b0>] ? snd_pcm_action_single+0x30/0x80 [snd=
_pcm]
[  182.006667]  [<ffffffffa02f86d1>] ? snd_pcm_lib_write1+0x391/0x400 [snd_=
pcm]
[  182.006669]  [<ffffffffa02f5ab0>] ?
snd_pcm_lib_readv_transfer+0x170/0x170 [snd_pcm]
[  182.006672]  [<ffffffffa02f3f05>] ?
snd_pcm_playback_ioctl1+0x255/0x270 [snd_pcm]
[  182.006674]  [<ffffffffa02f3f47>] ?
snd_pcm_playback_ioctl+0x27/0x30 [snd_pcm]
[  182.006676]  [<ffffffff8115f43f>] ? do_vfs_ioctl+0x8f/0x530
[  182.006678]  [<ffffffff8114e4de>] ? vfs_read+0xfe/0x180
[  182.006679]  [<ffffffff8115f980>] ? sys_ioctl+0xa0/0xc0
[  182.006681]  [<ffffffff814591ad>] ? system_call_fastpath+0x1a/0x1f
[  182.006691] Code: e9 4c fe ff ff 4d 89 f4 e9 d4 fe ff ff 66 66 66
66 66 66 2e 0f 1f 84 00 00 00 00 00 48 83 3f 00 75 09 48 8b 77 10 e9
a1 fd ff ff <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 48 83
ec 08
[  182.006692] RIP  [<ffffffff81063f8f>] add_timer+0xf/0x20
[  182.006692]  RSP <ffff880214a93d40>


I tried to change a few things in the snd_aloop driver, but this code
is way beyond my understanding. I can't fix that myself.

Feel free to contact me if you need more information. Thanks !

Regards,
Arnaud
