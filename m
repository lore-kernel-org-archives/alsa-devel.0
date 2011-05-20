From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Fri, 20 May 2011 12:12:31 +0200
Message-ID: <4DD63E8F.2030306@showlabor.de>
References: <4DD3E39D.30100@showlabor.de>	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>	<4DD413FC.2090808@showlabor.de>	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>	<s5hhb8r1c20.wl%tiwai@suse.de>
	<4DD4BC97.5090702@showlabor.de>	<s5h39kb17bv.wl%tiwai@suse.de>
	<4DD4D162.20608@showlabor.de>	<BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>	<BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>	<4DD51E38.7090406@showlabor.de>
	<BANLkTiksJbpMr61QOfJ26iVhETDhSBDRFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id E6DF7103806
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 12:12:35 +0200 (CEST)
In-Reply-To: <BANLkTiksJbpMr61QOfJ26iVhETDhSBDRFA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org


Am 19.05.2011 16:12, schrieb Daniel Mack:
>
> Ah, fail. Ok, try this one.
>
> Daniel
>


Hmm, this one crashes:

  4104.824184] Modules linked in: snd_usb_audio(+) snd_usbmidi_lib 
snd_hrtimer binfmt_misc parport_pc ppdev dm_crypt vesafb 
snd_hda_codec_hdmi snd_hda_codec_idt snd_hda_intel snd_hda_codec 
snd_seq_midi snd_hwdep snd_rawmidi snd_pcm snd_seq_midi_event snd_seq 
snd_timer snd_seq_device fglrx(P) dcdbas snd psmouse soundcore serio_raw 
snd_page_alloc lp parport usbhid hid usb_storage firewire_ohci uas 
firewire_core crc_itu_t e1000e
[ 4104.824220]
[ 4104.824223] Pid: 3406, comm: modprobe Tainted: P            
2.6.38-8-generic #42-Ubuntu Dell Inc.                 Dell 
DM061                   /0WG864
[ 4104.824231] RIP: 0010:[<ffffffffa04b0119>]  [<ffffffffa04b0119>] 
snd_usb_mixer_controls+0x49/0x1a0 [snd_usb_audio]
[ 4104.824241] RSP: 0018:ffff88005eb3fb38  EFLAGS: 00010246
[ 4104.824243] RAX: 00000000041e3000 RBX: 0000000000000000 RCX: 
0000000000000000
[ 4104.824246] RDX: ffff88008fcdbc28 RSI: 0000000000000000 RDI: 
ffff88005eb3fba0
[ 4104.824249] RBP: ffff88005eb3fbc8 R08: 0000000000000005 R09: 
ffff88008315b028
[ 4104.824251] R10: ffff88009b39acc8 R11: 0000000000016e50 R12: 
ffff88005eb3fb38
[ 4104.824254] R13: ffff8800922449e8 R14: 0000000000000000 R15: 
0000000000000000
[ 4104.824258] FS:  00007f5c64217720(0000) GS:ffff8800bfc00000(0000) 
knlGS:0000000000000000
[ 4104.824261] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 4104.824263] CR2: 0000000000000020 CR3: 00000000652b5000 CR4: 
00000000000006f0
[ 4104.824266] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 4104.824269] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[ 4104.824272] Process modprobe (pid: 3406, threadinfo ffff88005eb3e000, 
task ffff88005d1116e0)
[ 4104.824274] Stack:
[ 4104.824276]  ffff88008fcdbc28 ffff8800922449e8 0000000000000000 
0000000000000000
[ 4104.824281]  0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 4104.824286]  0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 4104.824291] Call Trace:
[ 4104.824303]  [<ffffffffa03dd1b7>] ? snd_hidden_kzalloc+0x37/0x50 [snd]
[ 4104.824312]  [<ffffffffa04b065a>] snd_usb_create_mixer+0xba/0x2a0 
[snd_usb_audio]
[ 4104.824318]  [<ffffffffa03dd1b7>] ? snd_hidden_kzalloc+0x37/0x50 [snd]
[ 4104.824327]  [<ffffffffa04b1dce>] 
create_standard_mixer_quirk+0x1e/0x20 [snd_usb_audio]
[ 4104.824335]  [<ffffffffa04b228d>] snd_usb_create_quirk+0x1d/0x50 
[snd_usb_audio]
[ 4104.824344]  [<ffffffffa04b233e>] create_composite_quirk+0x7e/0xd0 
[snd_usb_audio]
[ 4104.824353]  [<ffffffffa04b228d>] snd_usb_create_quirk+0x1d/0x50 
[snd_usb_audio]
[ 4104.824360]  [<ffffffffa04ac686>] usb_audio_probe+0x146/0x8d0 
[snd_usb_audio]
[ 4104.824368]  [<ffffffff8143e439>] usb_probe_interface+0x109/0x200
[ 4104.824373]  [<ffffffff813ba858>] really_probe+0x68/0x190
[ 4104.824377]  [<ffffffff813bab65>] driver_probe_device+0x45/0x70
[ 4104.824381]  [<ffffffff813bac3b>] __driver_attach+0xab/0xb0
[ 4104.824385]  [<ffffffff813bab90>] ? __driver_attach+0x0/0xb0
[ 4104.824389]  [<ffffffff813b99de>] bus_for_each_dev+0x5e/0x90
[ 4104.824393]  [<ffffffff813ba6ae>] driver_attach+0x1e/0x20
[ 4104.824396]  [<ffffffff813ba215>] bus_add_driver+0xc5/0x280
[ 4104.824400]  [<ffffffff813baed6>] driver_register+0x76/0x140
[ 4104.824405]  [<ffffffff815c6e2d>] ? notifier_call_chain+0x4d/0x70
[ 4104.824409]  [<ffffffff8143d008>] usb_register_driver+0xb8/0x170
[ 4104.824417]  [<ffffffffa04cc000>] ? snd_usb_audio_init+0x0/0x1000 
[snd_usb_audio]
[ 4104.824424]  [<ffffffffa04cc040>] snd_usb_audio_init+0x40/0x1000 
[snd_usb_audio]
[ 4104.824429]  [<ffffffff81002175>] do_one_initcall+0x45/0x190
[ 4104.824435]  [<ffffffff810a4feb>] sys_init_module+0xfb/0x250
[ 4104.824439]  [<ffffffff8100c002>] system_call_fastpath+0x16/0x1b
[ 4104.824442] Code: 4c 8d a5 70 ff ff ff 49 89 fd 4c 89 e7 48 8b 9a a0 
00 00 00 f3 48 ab 48 89 95 70 ff ff ff 4c 89 ad 78 ff ff ff 8b 05 07 0c 
01 00 <48> 8b 7b 20 8b 73 28 85 c0 48 89 7d 80 89 75 88 74 27 8b 4a 20
[ 4104.824482] RIP  [<ffffffffa04b0119>] 
snd_usb_mixer_controls+0x49/0x1a0 [snd_usb_audio]
[ 4104.824491]  RSP <ffff88005eb3fb38>
[ 4104.824493] CR2: 0000000000000020
[ 4104.824497] ---[ end trace b721d79c7e9b68a1 ]---
