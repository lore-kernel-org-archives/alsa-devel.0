From: "Ted T. Logian" <tedtheologian@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 10 Oct 2008 01:26:15 -0500
Message-ID: <1223619975.4700.2.camel@home>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AB5B103811
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 08:26:38 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id j67so319664rne.21
	for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2008 23:26:20 -0700 (PDT)
In-Reply-To: <s5hbpxt7zui.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Fri, 2008-10-10 at 08:01 +0200, Takashi Iwai wrote:
> At Thu, 09 Oct 2008 15:17:58 -0500,
> Ted T. Logian wrote:
> > 
> > Sorry for the multiple posts, but once I rmmod snd-sbxfi, running mixer does
> > fine.  It seems if I have snd-sbxfi loaded and I run alsamixer, it locks the
> > entire system.
> 
> So, do you mean loading the driver itself doesn't lock up?  If so,
> it's better than I expected.
> 
> Did you run ever PCM playback/capture before that?  This is more
> dangerous :)
> 
> Also, please give your hardware details, as there are different models
> for X-Fi, and some are handled pretty differently.
> 
> [BTW, please stop top-posting, and avoid HTML mails for ML.  It's easy
>  to switch to normal (plain) mail mode on Gmail, just a click.]
> 
> 
> thanks,
> 
> Takashi


I think perhaps from uninstalling pulseaudio I got further.  I can use
mixer now, and it even has a "Master" device, but nothing else...

however, I do get a lock up later.

I get this from running aplay, too, if this helps...

aplay
BUG: unable to handle kernel NULL pointer dereference at 00000004
IP: [<c04fe489>] __list_add+0x6/0x4a
*pde = 7c8a4067
Oops: 0000 [#1] SMP
Modules linked in: bridge bnep rfcomm l2cap autofs4 sunrpc ipv6
nf_conntrack_ftp nf_conntrack_netbios_ns ipt_REJECT nf_conntrack_ipv4
xt_state nf_conntrack xt_tcpudp iptable_filter ip_tables x_tables fuse
dm_mirror dm_log dm_mod snd_hda_intel snd_usb_audio snd_sbxfi pl2303
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq hci_usb bluetooth
tuner_simple tuner_types snd_pcm_oss tda9887 snd_mixer_oss tda8290
snd_pcm snd_usb_lib snd_rawmidi snd_seq_device wm8775 gspca snd_timer
cx25840 tuner nvidia(P) snd_page_alloc snd_hwdep sr_mod e100 usbserial
cdrom snd soundcore i2c_i801 ivtv compat_ioctl32 i2c_algo_bit cx2341x
v4l2_common tveeprom videodev pcspkr joydev iTCO_wdt iTCO_vendor_support
i2c_core dcdbas v4l1_compat serio_raw mii sg ata_piix ata_generic
pata_acpi libata sd_mod scsi_mod ext3
jbd mbcache uhci_hcd ohci_hcd ehci_hcd [last unloaded: scsi_wait_scan]

Pid: 3031, comm: aplay Tainted: P          (2.6.26.5-45.fc9.i686 #1)
EIP: 0060:[<c04fe489>] EFLAGS: 00010046 CPU: 0
EIP is at __list_add+0x6/0x4a
EAX: f7b9f1f8 EBX: f7b9f1f8 ECX: 00000000 EDX: f3de5138
ESI: f3de5100 EDI: f7b9f100 EBP: f7322de4 ESP: f7322de0
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process aplay (pid: 3031, ti=f7322000 task=f28abe80 task.ti=f7322000)
Stack: f7b9f124 f7322dec c04fe4d7 f7322e00 f9cc32ee f28a1800 f7322e54
f709a910
       f7322e14 f9cc338a 00000000 f7322e54 f709a910 f7322e28 f9baedc2
f70f9100
       fffffff2 f709a800 f7322e64 f9baee9c f7322e54 00000000 f2847200
f709a920
Call Trace:
 [<c04fe4d7>] ? list_add+0xa/0xf
 [<f9cc32ee>] ? sbxfi_port_alloc+0x80/0x95 [snd_sbxfi]
 [<f9cc338a>] ? sbxfi_playback_open+0x13/0x82 [snd_sbxfi]
 [<f9baedc2>] ? snd_pcm_open_substream+0x3a/0x72 [snd_pcm]
 [<f9baee9c>] ? snd_pcm_open+0xa2/0x179 [snd_pcm]
 [<c0420db2>] ? default_wake_function+0x0/0xd
 [<f935a1b3>] ? snd_lookup_minor_data+0x3d/0x44 [snd]
 [<f9baefbf>] ? snd_pcm_playback_open+0x23/0x26 [snd_pcm]
 [<f935a4e3>] ? snd_open+0xc1/0x11e [snd]
 [<c0487c12>] ? chrdev_open+0x116/0x132
 [<c0484178>] ? __dentry_open+0x10e/0x1fc
 [<c04842ed>] ? nameidata_to_filp+0x1f/0x33
 [<c0487afc>] ? chrdev_open+0x0/0x132
 [<c048f1ec>] ? do_filp_open+0x33e/0x6b0
 [<f935a7fe>] ? snd_card_file_remove+0xce/0xd8 [snd]
 [<c0483ee8>] ? get_unused_fd_flags+0x64/0xc5
 [<c0483f89>] ? do_sys_open+0x40/0xb6
 [<c0484041>] ? sys_open+0x1e/0x26
 [<c0404c32>] ? syscall_call+0x7/0xb
 [<c0630000>] ? down_read+0x27/0x29
 =======================
Code: 6e c0 e8 cb 08 13 00 0f 0b 83 c4 0c eb fe 89 58 04 89 03 c7 42 04
00 02 20 00 c7 02 00 01 10 00 8b 5d fc c9 c3 55 89 e5 53 89 c3 <8b> 41
04 39 d0 74 14 51 50 52 68 f7 5a 6e c0 e8 93 08 13 00 0f
EIP: [<c04fe489>] __list_add+0x6/0x4a SS:ESP 0068:f7322de0
---[ end trace 0611fd70d756e2b7 ]---
Segmentation fault
