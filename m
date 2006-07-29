From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002312]: Kernel oops using Tascm
	us-122 in RawUSB mode
Date: Sat, 29 Jul 2006 12:21:46 +0200
Message-ID: <d0a89a2b8fbb7f1408919df5b096647e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3333F171
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 12:21:46 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2312> 
======================================================================
Reported By:                jaime
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   2312
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian Sid
Kernel Version:             2.6.17
======================================================================
Date Submitted:             07-29-2006 12:21 CEST
Last Modified:              07-29-2006 12:21 CEST
======================================================================
Summary:                    Kernel oops using Tascm us-122 in RawUSB mode
Description: 
jackd -d alsa -d hw:1,2 -S -P -n 2 -p 128 -r 44100
(run as root) gives kernel oops:

BUG: unable to handle kernel NULL pointer dereference at virtual address
00000030
printing eip:
d09c154f
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ipv6 button ac battery dm_mod loop mousedev tsdev
snd_usb_usx2y snd_usb_lib shpchp snd_intel8x0 snd_ac97_codec
snd_ac97_bus snd_rawmidi snd_seq_device snd_pcm snd_timer snd_hwdep snd
pci_hotplug psmouse analog i2c_sis96x soundcore parport_pc parport
serio_raw pcspkr floppy i2c_core gameport 8250_pnp snd_page_alloc evdev
sis_agp agpgart rtc ext3 jbd ide_cd cdrom ide_disk sis5513 generic
ide_core ohci_hcd ehci_hcd usbcore sis900 mii thermal processor fan
CPU:    0
EIP:    0060:[<d09c154f>]    Not tainted VLI
EFLAGS: 00010286   (2.6.17-1-486 #1)
EIP is at usX2Y_usbpcm_urbs_start+0xf/0x3f5 [snd_usb_usx2y]
eax: 00000000   ebx: b162dde4   ecx: cffef300   edx: cf63a2a0
esi: cf7f7ea0   edi: 00000000   ebp: cf63a2a0   esp: ce885db4
ds: 007b   es: 007b   ss: 0068
Process jackd (pid: 3645, threadinfo=ce884000 task=cfca2a50)
Stack: cf63a2a0 cbdf0960 00000000 00000022 d09c1337 0000ac44 b162dde4
ceced0c0
       00000000 cfca2a50 b0122a8c ce885de0 ce885de0 b162dde4 cf7f7ea0
00000000
       cf63a2a0 d09c19fb ce708c00 b162de88 cac62000 cf42e460 00000000
d09ac0e4
Call Trace:
<d09c1337> usX2Y_rate_set+0x1bf/0x1f6 [snd_usb_usx2y]  <b0122a8c>
autoremove_wake_function+0x0/0x2d
<d09c19fb> snd_usX2Y_usbpcm_prepare+0xc6/0x14b [snd_usb_usx2y]
<d099c6d5> snd_pcm_do_prepare+0x9/0x19 [snd_pcm]
<d099c324> snd_pcm_action_single+0x1d/0x40 [snd_pcm]  <d099c3bb>
snd_pcm_action_nonatomic+0x30/0x47 [snd_pcm]
<d099eb70> snd_pcm_common_ioctl1+0x4cb/0xc54 [snd_pcm]  <b01e956a>
n_tty_receive_buf+0xbe8/0xc34
<d099d69d> snd_pcm_hw_constraints_complete+0xe8/0x157 [snd_pcm]
<d099d6db> snd_pcm_hw_constraints_complete+0x126/0x157 [snd_pcm]
<d099fe8b> snd_pcm_hw_constraint_minmax+0x24/0x28 [snd_pcm]  <d099d704>
snd_pcm_hw_constraints_complete+0x14f/0x157 [snd_pcm]
<d099d890> snd_pcm_open+0x119/0x1bf [snd_pcm]  <b011262a>
default_wake_function+0x0/0xc
<b01a5fba> prio_tree_insert+0x12c/0x1ec  <b0136cf8>
vma_prio_tree_insert+0x17/0x2a
<d099f9b2> snd_pcm_playback_ioctl+0x0/0x1b [snd_pcm]  <d099f955>
snd_pcm_playback_ioctl1+0x32d/0x343 [snd_pcm]
<b013b9f3> do_mmap_pgoff+0x4b9/0x5e6  <d099f9b2> snd_pcm_playback_ioctl
+0x0/0x1b [snd_pcm]
<b015312e> do_ioctl+0x16/0x42  <b015333d> vfs_ioctl+0x1e3/0x1f1
<b0153395> sys_ioctl+0x4a/0x61  <b0102977> syscall_call+0x7/0xb
Code: 00 8d 83 d8 00 00 00 6a 00 b9 01 00 00 00 ba 03 00 00 00 e8 97 09
75 df 59 5b 5e c3 55 57 56 53 83 ec 34 89 04 24 89 c2 8b 40 04 <8b> 40
30 89 44 24 08 8b 0a 89 4c 24 0c 48 75 20 8b 81 c0 00 00
EIP: [<d09c154f>] usX2Y_usbpcm_urbs_start+0xf/0x3f5 [snd_usb_usx2y]
SS:ESP 0068:ce885db4



Please note that I'm just using standard debian-repository kernels for
the time being, so they're _not_ patched for rt-preempt. I didn't think
that this would cause this oops, but I could be very wrong.

BTW, the version of jack is 0.101.1, and I've already set
nrpacks to 1.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-06 12:21 jaime          New Issue                                    
07-29-06 12:21 jaime          Distribution              => Debian Sid      
07-29-06 12:21 jaime          Kernel Version            => 2.6.17          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
