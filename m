From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: implement new endpoint
	streaming model
Date: Thu, 22 Dec 2011 17:55:29 +0000
Message-ID: <CAE-xCyOsFj_uXhAbQr_j8e0gW6UyefQZnzkY7UTXdnEMvCshEw@mail.gmail.com>
References: <1324424088-5705-1-git-send-email-zonque@gmail.com>
	<1324424088-5705-3-git-send-email-zonque@gmail.com>
	<CAE-xCyM-RZxQHbXUH4aswQS_xraEM-vMVynfDiSsj5ZUyq5Gkw@mail.gmail.com>
	<4EF20A81.9070307@gmail.com>
	<CAE-xCyNV0u1PBiHt_tXQT5dqgGE=LhLYyTEfuoAKxO1TvqOXyQ@mail.gmail.com>
	<4EF214E6.8050405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C482103EC0
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 18:55:29 +0100 (CET)
Received: by vcbf13 with SMTP id f13so5946896vcb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 09:55:29 -0800 (PST)
In-Reply-To: <4EF214E6.8050405@gmail.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

> Which hardware is connected? Did you try that with both? Did you try
> with anything else than jack? I'd need more information about your setup
> to get an idea.

Ok, here is a bit more info: I'm running a 64bit Ubuntu Oneiric.
Kernel is the 3.2 rc6.

With the M-Audio Fast Track Ultra:
- Alsa is working ok. That is, I can read a mp3 with mplayer without
any problem for example.
- As soon as I start Jackd2, my whole system freezes.
- 3.2 rc4 and the previous version of your patch, all was working ok
with the FTU.

With the Edirol UA25-Ex:
- It was working with 3.2 rc and the previous version of your patch.
- With the current version, the soundcard doesn't work at all. The
following trace appears in dmesg:

[   33.724071] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000040
[   33.724078] IP: [<ffffffffa054edae>] start_endpoints+0x5e/0xc0
[snd_usb_audio]
[   33.724090] PGD 120018067 PUD 137aaf067 PMD 0
[   33.724095] Oops: 0002 [#1] PREEMPT SMP
[   33.724100] CPU 0
[   33.724102] Modules linked in: speedstep_lib parport_pc ppdev
binfmt_misc joydev snd_usb_audio arc4 snd_pcm snd_page_alloc snd_hwdep
snd_usbmidi_lib snd_seq_midi snd_rawmidi b43 mac80211 cfg80211
snd_seq_midi_event snd_seq snd_timer fglrx(P) ssb bcma psmouse
snd_seq_device hp_wmi snd i7core_edac soundcore sparse_keymap
serio_raw lp edac_core parport usbhid hid uvesafb ahci libahci wmi
video
[   33.724139]
[   33.724142] Pid: 1803, comm: pulseaudio Tainted: P           O
3.2.0-rc6-music+ #2 Hewlett-Packard HP ENVY 17 Notebook PC/144D
[   33.724148] RIP: 0010:[<ffffffffa054edae>]  [<ffffffffa054edae>]
start_endpoints+0x5e/0xc0 [snd_usb_audio]
[   33.724156] RSP: 0018:ffff88011f587cd8  EFLAGS: 00010246
[   33.724159] RAX: ffff88011f618000 RBX: ffff8801236d0018 RCX: 00000000002=
a9800
[   33.724162] RDX: 0000000000000000 RSI: 0000000000000286 RDI: 00000000000=
00000
[   33.724164] RBP: ffff88011f587ce8 R08: ffffea00048026c0 R09: ffffffff814=
89699
[   33.724167] R10: 0000000000000000 R11: ffff8800365972a0 R12: ffff8801342=
6e800
[   33.724170] R13: 0000000000088802 R14: 0000000000088802 R15: 00000000000=
00000
[   33.724173] FS:  00007f6a1bbda720(0000) GS:ffff88013fc00000(0000)
knlGS:0000000000000000
[   33.724177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.724179] CR2: 0000000000000040 CR3: 0000000120011000 CR4: 00000000000=
006f0
[   33.724182] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   33.724185] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
00400
[   33.724188] Process pulseaudio (pid: 1803, threadinfo
ffff88011f586000, task ffff88011f588000)
[   33.724191] Stack:
[   33.724192]  00007f6a1bbfa000 ffff88013426e800 ffff88011f587cf8
ffffffffa054f445
[   33.724198]  ffff88011f587d18 ffffffffa05313cb 00007f6a1bbfa008
ffffffffa053e180
[   33.724203]  ffff88011f587d58 ffffffffa0530ce6 0000000000000000
0000000000000000
[   33.724208] Call Trace:
[   33.724215]  [<ffffffffa054f445>] snd_usb_pcm_prepare+0xb5/0xd0
[snd_usb_audio]
[   33.724223]  [<ffffffffa05313cb>] snd_pcm_do_prepare+0x1b/0x30 [snd_pcm]
[   33.724229]  [<ffffffffa0530ce6>] snd_pcm_action_single+0x36/0x80 [snd_p=
cm]
[   33.724236]  [<ffffffffa0530e7e>]
snd_pcm_action_nonatomic+0x7e/0x90 [snd_pcm]
[   33.724242]  [<ffffffffa0533ada>] snd_pcm_common_ioctl1+0x7da/0xcb0 [snd=
_pcm]
[   33.724249]  [<ffffffffa053427c>]
snd_pcm_playback_ioctl1+0x4c/0x240 [snd_pcm]
[   33.724256]  [<ffffffff81616f00>] ? do_page_fault+0x210/0x5c0
[   33.724262]  [<ffffffffa05344a4>] snd_pcm_playback_ioctl+0x34/0x40 [snd_=
pcm]
[   33.724267]  [<ffffffff81186fef>] do_vfs_ioctl+0x8f/0x500
[   33.724272]  [<ffffffff81141081>] ? sys_mmap_pgoff+0xe1/0x230
[   33.724276]  [<ffffffff811874f1>] sys_ioctl+0x91/0xa0
[   33.724281]  [<ffffffff8161afc2>] system_call_fastpath+0x16/0x1b
[   33.724284] Code: 21 00 00 01 19 d2 31 c0 85 d2 74 11 48 83 c4 08
5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 48 8b bb 58 21 00 00 48 8b 83
50 21 00 00 <48> 89 47 40 e8 19 96 ff ff 85 c0 78 35 48 83 c4 08 31 c0
5b 5d
[   33.724335] RIP  [<ffffffffa054edae>] start_endpoints+0x5e/0xc0
[snd_usb_audio]
[   33.724342]  RSP <ffff88011f587cd8>
[   33.724344] CR2: 0000000000000040
[   33.724348] ---[ end trace 759045e1bb073007 ]---

If there is anything else relevant I can send you, let me know.

Regards,
Aur=E9lien
