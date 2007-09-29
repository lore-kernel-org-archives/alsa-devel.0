From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Alsa 1.0.15rc2 and oops with Dell M1210
Date: Fri, 28 Sep 2007 23:52:01 -0300
Message-ID: <200709282352.01789.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id CAE6724635
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Sep 2007 04:52:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5BBD117904
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 23:52:07 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id tGjU8rd10dY4 for <alsa-devel@alsa-project.org>;
	Fri, 28 Sep 2007 23:52:04 -0300 (BRT)
Received: from [192.168.2.2] (200-103-138-174.ctame705.dsl.brasiltelecom.net.br
	[200.103.138.174])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 32EB6178EC
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 23:52:03 -0300 (BRT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have some reports of problems with Alsa 1.0.15rc2 and Dell M1210 (dell-m82 
model). The following oops happens:

Sep 27 19:28:34 dru kernel: Unable to handle kernel paging request at
ffff81107b70f3a0 RIP: 
Sep 27 19:28:34 dru kernel:  [<ffffffff88108751>]
:snd_hda_intel:snd_hda_input_mux_info+0x31/0x50
Sep 27 19:28:34 dru kernel: PGD 8063 PUD 0 
Sep 27 19:28:34 dru kernel: Oops: 0000 [1] SMP 
Sep 27 19:28:34 dru kernel: CPU 0 
Sep 27 19:28:34 dru kernel: Modules linked in: ipv6 video thermal sbs fan
container snd_seq_dummy button snd_seq_oss snd_seq_midi_event snd_seq do
ck battery ac ide_cd binfmt_misc loop ntfs nls_utf8 nls_cp437 vfat fat
dm_mirror dm_mod usb_storage ide_core hidp l2cap usbmouse usbhid ff_memless
 usbkbd hci_usb bluetooth cpufreq_ondemand cpufreq_conservative
cpufreq_powersave acpi_cpufreq freq_table processor nvram pcspkr snd_usb_lib
snd_r
awmidi snd_seq_device b44 snd_pcm_oss snd_mixer_oss ssb pcmcia pcmcia_core
uhci_hcd ehci_hcd usbcore mii ohci1394 ieee1394 i2c_i801 i2c_core evdev
 snd_hda_intel snd_pcm snd_timer snd_page_alloc snd_hwdep joydev tsdev
mmc_block sdhci mmc_core snd soundcore iTCO_wdt iTCO_vendor_support sg sr_m
od ext3 jbd scsi_wait_scan sd_mod ahci ata_piix libata scsi_mod
Sep 27 19:28:34 dru kernel: Pid: 3466, comm: alsactl Not tainted
2.6.22.9-laptop-1mdv #1
Sep 27 19:28:34 dru kernel: RIP: 0010:[<ffffffff88108751>] 
[<ffffffff88108751>] :snd_hda_intel:snd_hda_input_mux_info+0x31/0x50
Sep 27 19:28:34 dru kernel: RSP: 0018:ffff81007aa65d48  EFLAGS: 00010206
Sep 27 19:28:34 dru kernel: RAX: 0000000ffffffff0 RBX: ffff81007b734d80 RCX:
00000000ffffffff
Sep 27 19:28:34 dru kernel: RDX: 0000000000000000 RSI: ffff81007aa65d88 RDI:
ffff81007aa65de0
Sep 27 19:28:34 dru kernel: RBP: ffff81007aa65d88 R08: ffff81007b70f3a8 R09:
000000000000000a
Sep 27 19:28:34 dru kernel: R10: 0000000000000000 R11: 0000000000000246 R12:
ffff81007c44a968
Sep 27 19:28:34 dru kernel: R13: ffff81007c44a800 R14: ffff81007adbaf40 R15:
00007fff95ccbdb0
Sep 27 19:28:34 dru kernel: FS:  00002ad615cc6e50(0000)
GS:ffffffff8053e000(0000) knlGS:0000000000000000
Sep 27 19:28:34 dru kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Sep 27 19:28:34 dru kernel: CR2: ffff81107b70f3a0 CR3: 000000007a926000 CR4:
00000000000006e0
Sep 27 19:28:34 dru kernel: Process alsactl (pid: 3466, threadinfo
ffff81007aa64000, task ffff81007c659860)
Sep 27 19:28:34 dru kernel: Stack:  00007fff95ccbdb0 ffffffff880b3835
0000000000000000 00007fff95ccbdb0
Sep 27 19:28:34 dru kernel:  00000000c1105511 ffff81007c44a800 
ffff81007adbaf40
ffffffff880b4d88
Sep 27 19:28:34 dru kernel:  0000000000000001 0000000000000000 
0000000000000000
0000000000000000
Sep 27 19:28:34 dru kernel: Call Trace:
Sep 27 19:28:34 dru kernel:  [<ffffffff880b3835>]
:snd:snd_ctl_elem_info+0x55/0x150
Sep 27 19:28:34 dru kernel:  [<ffffffff880b4d88>]
:snd:snd_ctl_ioctl+0x648/0x8b0
Sep 27 19:28:34 dru kernel:  [<ffffffff802aa045>] do_ioctl+0x35/0xe0
Sep 27 19:28:34 dru kernel:  [<ffffffff802aa310>] vfs_ioctl+0x220/0x2c0
Sep 27 19:28:34 dru kernel:  [<ffffffff802aa445>] sys_ioctl+0x95/0xb0
Sep 27 19:28:34 dru kernel:  [<ffffffff8020a28e>] system_call+0x7e/0x83
Sep 27 19:28:34 dru kernel: 
Sep 27 19:28:34 dru kernel: 
Sep 27 19:28:34 dru kernel: Code: 49 8b 74 00 08 e8 95 bd 21 f8 31 c0 48 83 c4
08 c3 0f 1f 80 
Sep 27 19:28:34 dru kernel: RIP  [<ffffffff88108751>]
:snd_hda_intel:snd_hda_input_mux_info+0x31/0x50
Sep 27 19:28:34 dru kernel:  RSP <ffff81007aa65d48>
Sep 27 19:28:34 dru kernel: CR2: ffff81107b70f3a0

I have a better report on a i386 kernel, unfortunately it's tainted:

BUG: unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
f8f89ed8
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: snd_usb_audio snd_usb_lib snd_rawmidi snd_seq_device
iwl3945 mac80211 cfg80211 b44 mmc_block nvidia(P) snd_hda_intel snd_pcm
ohci1394 snd_timer ssb pcmcia sdhci pcmcia_core mii ieee1394 mmc_core
joydev ipw3945 ieee80211 ehci_hcd snd_page_alloc snd_hwdep uhci_hcd
ieee80211_crypt snd intel_agp i2c_i801 tsdev usbcore soundcore sg
agpgart evdev i2c_core iTCO_wdt iTCO_vendor_support sr_mod reiserfs
scsi_wait_scan sd_mod ahci ata_piix libata scsi_mod
CPU:    0
EIP:    0060:[<f8f89ed8>]    Tainted: P       VLI
EFLAGS: 00010246   (2.6.22.7-laptop-1mdv #1)
EIP is at snd_hda_input_mux_info+0x38/0x50 [snd_hda_intel]
eax: f6764a4c   ebx: 00000000   ecx: ffffffff   edx: f6269de4
esi: 00000000   edi: f6269e3c   ebp: f6269db0   esp: f6269da4
ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Process alsactl (pid: 2318, ti=f6268000 task=c237a550 task.ti=f6268000)
Stack: f66da5c0 00000000 f6269de4 f6269db8 f8f995e4 f6269f48 f8edd1eb
00000000
       bf979c70 f64fcac0 f66b6c00 f66b6d4c f8cf0000 f66b6d4c c0199456
00000000
       00000001 00000002 00000000 00000000 75706e49 6f532074 65637275
00000000
Call Trace:
 [<c010529a>] show_trace_log_lvl+0x1a/0x30
 [<c010535b>] show_stack_log_lvl+0xab/0xd0
 [<c0105551>] show_registers+0x1d1/0x2d0
 [<c0105768>] die+0x118/0x240
 [<c0121399>] do_page_fault+0x199/0x630
 [<c0313e6a>] error_code+0x72/0x78
 [<f8f995e4>] stac92xx_mux_enum_info+0x14/0x20 [snd_hda_intel]
 [<f8edd1eb>] snd_ctl_ioctl+0x80b/0xc30 [snd]
 [<c018f308>] do_ioctl+0x28/0xb0
 [<c018f5af>] vfs_ioctl+0x21f/0x2a0
 [<c018f689>] sys_ioctl+0x59/0x70
 [<c01041ba>] sysenter_past_esp+0x6b/0xa1
 =======================
Code: 08 8d 7a 58 89 1c 24 c7 42 40 03 00 00 00 c7 42 48 01 00 00 00 8b
08 89 4a 50 8b 4a 54 8b 18 8d 73 ff 39 d9 0f 43 ce 8b 74 c8 04 <ac> aa
84 c0 75 fa 8b 1c 24 31 c0 8b 74 24 04 8b 7c 24 08 89 ec
EIP: [<f8f89ed8>] snd_hda_input_mux_info+0x38/0x50 [snd_hda_intel]
SS:ESP 0068:f6269da4

Accordingly to one of the reporters, when changing the model to 5stack the 
oops doesn't happens anymore and everything works flawlessly. At first I 
thought that the problem could be the different pin cfgs of dell-m82 compared 
to the old and replaced dell model. I was in contact with one of the 
reporters, but unfortunately reverting only the pin cfg didn't work (if the 
report was correct the module now didn't break with an oops but sound didn't 
work either). So I'm out of ideas, failed to see why stac92xx_mux_enum_info 
received uinfo == NULL (where uinfo comes from?) and passed it to 
snd_hda_input_mux_info.

--
[]'s
Herton
