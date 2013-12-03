From: Marius Graefe <alsa@mgraefe.de>
Subject: Re: [PATCH - oxygen 1/1] Patch for the Xonar DG Patch
 by Roman Volkov
Date: Tue, 03 Dec 2013 18:27:57 +0100
Message-ID: <529E149D.7000907@mgraefe.de>
References: <1386085561-20131-1-git-send-email-alsa@mgraefe.de>
 <529E0157.4050807@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mgraefe.de (mail.mgraefe.de [212.224.84.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 7034326524C
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 18:27:58 +0100 (CET)
In-Reply-To: <529E0157.4050807@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, v1ron@mail.ru
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Marius Graefe wrote:
>> 2) I had to assign a .shortname in xonar_dg_model, otherwise my kernel
>> (unmodified ubuntu 3.2.0-56-generic-pae) throws an oops, the backtrace
>> led me to the missing string.
> What code tries to access the shortname?  What is the backtrace?
>
>
> Regards,
> Clemens
I think it is oxygen_pci_probe in oxygen_lib.c. Line 667 of that file says:
strcpy(card->shortname, chip->model.shortname);

This was the kernels output before my fix:


[   13.712048] BUG: unable to handle kernel NULL pointer dereference 
at   (null)
[   13.712050] IP: [<c12b9bf7>] strcpy+0x17/0x30
[   13.712054] *pdpt = 000000002b069001 *pde = 0000000000000000
[   13.712056] Oops: 0000 [#1] SMP
[   13.712058] Modules linked in: bnep snd_hda_codec_hdmi(O) 
snd_hda_intel(O) snd_oxygen(O+) rfcomm bluetooth snd_oxygen_lib(O) 
snd_hda_codec(O) snd_mpu401_uart(O) ir_lirc_codec lirc_dev snd_hwdep(O) 
ir_mce_kbd_decoder parport_pc ir_sony_decoder ppdev snd_seq_dummy(O) 
ir_jvc_decoder snd_seq_oss(O) snd_seq_midi(O) ir_rc6_decoder 
snd_rawmidi(O) snd_seq_midi_event(O) ir_rc5_decoder ir_nec_decoder 
snd_seq(O) rc_core videobuf_dma_sg altera_stapl snd_pcm_oss(O) 
snd_mixer_oss(O) snd_pcm(O) snd_seq_device(O) fglrx(P) lp snd_timer(O) 
cx2341x videobuf_dvb videobuf_core v4l2_common videodev altera_ci 
dvb_core eeepc_wmi asus_wmi btcx_risc mei(C) tveeprom snd(O) joydev 
psmouse serio_raw mac_hid snd_page_alloc(O) sparse_keymap parport 
soundcore binfmt_misc vesafb usbhid hid wmi r8169
[   13.712081]
[   13.712083] Pid: 862, comm: modprobe Tainted: P         C O 
3.2.0-56-generic-pae #86-Ubuntu System manufacturer System Product 
Name/P8P67 REV 3.1
[   13.712085] EIP: 0060:[<c12b9bf7>] EFLAGS: 00010292 CPU: 0
[   13.712087] EIP is at strcpy+0x17/0x30
[   13.712088] EAX: eebdd024 EBX: eebdd210 ECX: eebdd024 EDX: 00000000
[   13.712089] ESI: 00000000 EDI: eebdd024 EBP: f5cedde4 ESP: f5cedddc
[   13.712090]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   13.712091] Process modprobe (pid: 862, ti=f5cec000 task=ee777230 
task.ti=f5cec000)
[   13.712092] Stack:
[   13.712092]  f7684000 f7684800 f5cede20 f8d10604 00000080 f8d14cbd 
eebdd210 f5cede00
[   13.712096]  c1036a88 f5cede14 f7684860 00000000 eebdd000 f76848ba 
f7684800 f5cede58
[   13.712099]  f7684860 f5cede34 f8ccec75 f8cd0140 f8ccf900 f8cce96c 
f5cede4c c12d3b07
[   13.712102] Call Trace:
[   13.712105]  [<f8d10604>] oxygen_pci_probe+0x824/0xd00 [snd_oxygen_lib]
[   13.712108]  [<c1036a88>] ? default_spin_lock_flags+0x8/0x10
[   13.712111]  [<f8ccec75>] generic_oxygen_probe+0x52/0x66 [snd_oxygen]
[   13.712113]  [<f8cce96c>] ? xonar_dg_pga_volume_put+0xbc/0xbc 
[snd_oxygen]
[   13.712115]  [<c12d3b07>] local_pci_probe+0x47/0xb0
[   13.712117]  [<c12d5008>] pci_device_probe+0x68/0x90
[   13.712119]  [<c11a9e77>] ? sysfs_create_link+0x17/0x20
[   13.712122]  [<c1387d6d>] really_probe+0x4d/0x150
[   13.712124]  [<c13913f9>] ? pm_runtime_barrier+0x49/0xb0
[   13.712125]  [<c1387faa>] driver_probe_device+0x3a/0x60
[   13.712127]  [<c1388061>] __driver_attach+0x91/0xa0
[   13.712128]  [<c1387fd0>] ? driver_probe_device+0x60/0x60
[   13.712130]  [<c13870e1>] bus_for_each_dev+0x51/0x80
[   13.712131]  [<c1387ba1>] driver_attach+0x21/0x30
[   13.712132]  [<c1387fd0>] ? driver_probe_device+0x60/0x60
[   13.712134]  [<c138787f>] bus_add_driver+0x17f/0x260
[   13.712135]  [<c12d5030>] ? pci_device_probe+0x90/0x90
[   13.712137]  [<c1388536>] driver_register+0x66/0x110
[   13.712138]  [<c12d4db2>] __pci_register_driver+0x42/0xc0
[   13.712140]  [<f8cd3017>] alsa_card_oxygen_init+0x17/0x1000 [snd_oxygen]
[   13.712142]  [<c1003035>] do_one_initcall+0x35/0x170
[   13.712145]  [<f8cd3000>] ? 0xf8cd2fff
[   13.712147]  [<c10968ec>] sys_init_module+0xac/0x210
[   13.712149]  [<c15b295f>] sysenter_do_call+0x12/0x28
[   13.712150] Code: ff ff 59 c3 51 52 e8 39 a9 ff ff 5a 59 c3 90 90 90 
90 90 90 55 89 e5 83 ec 08 89 75 f8 89 7d fc 66 66 66 66 90 89 c1 89 d6 
89 c7 <ac> aa 84 c0 75 fa 8b 75 f8 89 c8 8b 7d fc 89 ec 5d c3 8d b4 26
[   13.712168] EIP: [<c12b9bf7>] strcpy+0x17/0x30 SS:ESP 0068:f5cedddc
[   13.712170] CR2: 0000000000000000
[   13.712172] ---[ end trace 54937d844202c50f ]---
