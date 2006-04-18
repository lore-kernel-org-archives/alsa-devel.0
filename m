From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001833]: oops in snd_mpu401_uart
Date: Tue, 18 Apr 2006 05:32:05 +0200
Message-ID: <0b5591ac3435314bc9f49d49b6cf1d96@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 371581AA
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 05:32:05 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1833> 
======================================================================
Reported By:                ponchick
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1833
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             gentoo-sources-2.6.15-r4
======================================================================
Date Submitted:             02-09-2006 08:33 CET
Last Modified:              04-18-2006 05:32 CEST
======================================================================
Summary:                    oops in snd_mpu401_uart
Description: 
I don't know what exactly happend but when I run wine or winecfg it
segfaulted. dmesg shows following:
Unable to handle kernel paging request at 0000000010228800 RIP:
<ffffffff884ca00c>{:snd_mpu401_uart:mpu401_write_mmio+0}
PGD 6e57067 PUD 0
Oops: 0002 [1] PREEMPT SMP
CPU 1
Modules linked in: snd_rtctimer snd_seq_midi snd_pcm_oss snd_mixer_oss
snd_seq_oss snd_seq_midi_event snd_seq snd_au8830 snd_ac97_codec snd_pcm
snd_timer snd_page_alloc snd_ac97_bus snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore nvidia sky2
Pid: 11110, comm: wine-preloader Tainted: P      2.6.15-gentoo-r4 #1
RIP: 0010:[<ffffffff884ca00c>]
<ffffffff884ca00c>{:snd_mpu401_uart:mpu401_write_mmio+0}
RSP: 0018:ffff81003564f8f0  EFLAGS: 00010046
RAX: 0000000000000013 RBX: ffff81003cb4e580 RCX: 0000000000000000
RDX: 0000000010228800 RSI: 0000000000000000 RDI: ffff81003cb4e580
RBP: ffff81003eb60740 R08: 0000000000000000 R09: ffff8100279794c0
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81003cb4fe00
R13: 0000000000000001 R14: ffff81003cb4e5f8 R15: 0000000000000246
FS:  000000005556c000(006b) GS:ffffffff8057b880(0063)
knlGS:00000000556cb920
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 0000000010228800 CR3: 00000000375ad000 CR4: 00000000000006e0
Process wine-preloader (pid: 11110, threadinfo ffff81003564e000, task
ffff810002178440)
Stack: ffffffff884ca19f ffff81003ffef500 0000000000000046
ff00000000000286
       ffff81003cb4e580 ffff81003eb60740 ffff81003cb4fe00
ffff81003eb606c0
       0000000000000000 ffff81003d7c3bd0
Call Trace:<ffffffff884ca19f>{:snd_mpu401_uart:snd_mpu401_uart_cmd+65}
       <ffffffff884ca2f4>{:snd_mpu401_uart:snd_mpu401_uart_input_open+73}
       <ffffffff884c36b3>{:snd_rawmidi:snd_rawmidi_kernel_open+644}
       <ffffffff885471f0>{:snd_seq_midi:midisynth_subscribe+53}
       <ffffffff80397b49>{_spin_lock+27}
<ffffffff8851fcc2>{:snd_seq:subscribe_port+214}
       <ffffffff8851ff8f>{:snd_seq:snd_seq_port_connect+433}
       <ffffffff8851a9c8>{:snd_seq:snd_seq_ioctl_subscribe_port+226}
       <ffffffff8851c19a>{:snd_seq:snd_seq_kernel_client_ctl+92}
       <ffffffff8852eb1b>{:snd_seq_oss:snd_seq_oss_midi_open+267}
       <ffffffff8852eb83>{:snd_seq_oss:snd_seq_oss_midi_open_all+35}
       <ffffffff8852b89a>{:snd_seq_oss:snd_seq_oss_open+1152}
       <ffffffff8852d20c>{:snd_seq_oss:snd_seq_oss_event_input+0}
       <ffffffff8852b90a>{:snd_seq_oss:free_devinfo+0}
<ffffffff8018075f>{__link_path_walk+3332}
       <ffffffff80397b0c>{__lock_text_start+20}
<ffffffff8852b034>{:snd_seq_oss:odev_open+52}
       <ffffffff884ac6e4>{:soundcore:soundcore_open+513}
<ffffffff8017ab11>{chrdev_open+454}
       <ffffffff8017a94b>{chrdev_open+0}
<ffffffff80171031>{__dentry_open+310}
       <ffffffff8017118d>{nameidata_to_filp+34}
<ffffffff801711d6>{filp_open+58}
       <ffffffff801713d4>{get_unused_fd+234}
<ffffffff80171533>{do_sys_open+81}
       <ffffffff8011e57f>{sysenter_do_call+27}

Code: 40 88 32 c3 0f b6 06 0f b6 c0 c3 48 83 ec 28 4c 89 64 24 10
RIP <ffffffff884ca00c>{:snd_mpu401_uart:mpu401_write_mmio+0} RSP
<ffff81003564f8f0>
CR2: 0000000010228800
 <6>note: wine-preloader[11110] exited with preempt_count 1

I use standalone alsa-driver (kernel one is out of date and doesn't
support au8830 on 64-bit platforms) with gentoo-sources-2.6.14-r5,
gentoo-sources-2.6.15-r1 and gentoo-sources-2.6.15-r4. 
======================================================================

----------------------------------------------------------------------
 ponchick - 04-18-06 05:11 
----------------------------------------------------------------------
> How do you load/unload the au8830 driver ?

I use '/etc/init.d/alsasound restart'. It kill processes that use sound
devices, save mixer state, do rmmod then do modprobe for
alsa/oss-emulation modules and restore mixer levels.

----------------------------------------------------------------------
 Raymond - 04-18-06 05:32 
----------------------------------------------------------------------
1) 15-pin MPU401/Game port connector
2) 26-pin Waveblaster 2 connector
3) 32/64 voices Wavetable Synth (au8820/au8830) not yet implemented
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1593

http://lists.nongnu.org/archive/html/openvortex-dev/2003-04/msg00063.html

Can we use 15-pin to keyboard and 26-pin to waveblaster 2 card
concurrently ?

if not, how do we select to use (1) and (2) ?

Some au8820/au8830 seem do not have 26-pin connector 

Do we need to disable gameport when using 15 pin midi connector ?

Are the nameing convention consistent with other cards such as emu10k1,
ice1724, ens1371 , ... ?


MPU401_UART can be accessed

a) MMIO (default)
b) Legacy port 0x330.      ( need patch to use 300h, 310h, 320h)
c) It may also accessed with index and data IO ports (PCI BAR1) by writing
offset to index and read/write through data

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-06 08:33 ponchick       New Issue                                    
02-09-06 08:33 ponchick       Distribution              => gentoo          
02-09-06 08:33 ponchick       Kernel Version            =>
gentoo-sources-2.6.15-r4
02-09-06 09:12 Raymond        Note Added: 0007971                          
02-09-06 09:32 Raymond        Note Added: 0007973                          
02-09-06 11:57 ponchick       Note Added: 0007975                          
02-09-06 12:32 Raymond        Note Added: 0007976                          
02-09-06 12:35 Raymond        Note Edited: 0007976                         
02-10-06 03:06 Raymond        Note Added: 0007982                          
02-10-06 03:11 rlrevell       Note Added: 0007983                          
02-10-06 03:49 Raymond        Note Added: 0007984                          
02-10-06 05:08 ponchick       Note Added: 0007986                          
02-10-06 05:36 Raymond        Note Added: 0007988                          
02-10-06 06:03 Raymond        Note Added: 0007990                          
02-10-06 10:09 ponchick       Note Added: 0007997                          
02-10-06 11:30 Raymond        Note Added: 0008001                          
02-12-06 03:32 Raymond        Note Added: 0008024                          
02-12-06 14:14 Raymond        Note Deleted: 0007990                        
02-13-06 07:08 Raymond        Note Edited: 0008024                         
02-13-06 16:44 Raymond        Note Edited: 0008001                         
02-14-06 10:41 Raymond        Note Edited: 0008024                         
02-16-06 04:40 Raymond        Note Added: 0008084                          
02-16-06 06:33 ponchick       Note Added: 0008086                          
02-16-06 09:57 Raymond        Note Added: 0008089                          
02-16-06 10:16 ponchick       Note Added: 0008091                          
02-16-06 10:38 Raymond        Note Added: 0008092                          
02-16-06 10:40 Raymond        Note Edited: 0008092                         
02-16-06 13:08 Raymond        Note Edited: 0008089                         
02-25-06 13:15 Raymond        Note Added: 0008189                          
03-21-06 18:02 Raymond        Note Edited: 0008089                         
04-06-06 19:13 Raymond        Note Added: 0009126                          
04-06-06 19:23 rlrevell       Note Added: 0009127                          
04-11-06 05:09 Raymond        Note Added: 0009226                          
04-11-06 06:08 ponchick       Note Added: 0009227                          
04-11-06 09:06 Raymond        Note Added: 0009230                          
04-12-06 10:28 Raymond        Note Added: 0009240                          
04-12-06 11:36 ponchick       Note Added: 0009241                          
04-12-06 15:16 Raymond        Note Added: 0009243                          
04-13-06 07:16 Raymond        Note Added: 0009253                          
04-13-06 10:05 Raymond        Note Added: 0009255                          
04-13-06 10:37 Raymond        Note Edited: 0009253                         
04-14-06 03:30 Raymond        Note Added: 0009279                          
04-17-06 22:57 gineera        Note Added: 0009322                          
04-18-06 04:53 ponchick       Note Added: 0009323                          
04-18-06 05:11 ponchick       Note Added: 0009324                          
04-18-06 05:32 Raymond        Note Added: 0009325                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
