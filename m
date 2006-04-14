From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001833]: oops in snd_mpu401_uart
Date: Fri, 14 Apr 2006 03:30:57 +0200
Message-ID: <bad7028ce267bbfa396cd9cd69fc8a6c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5579E176
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 03:30:58 +0200 (MEST)
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
Last Modified:              04-14-2006 03:30 CEST
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
 Raymond - 04-13-06 10:05 
----------------------------------------------------------------------
>I don't think so. There is only arts running when these errors occur. As I
know >in default configuration it use hw:0.0 only.

Switching from gnome to kde on Fedora Core 1. (alsa-1.0.11rc5)

With arts runing, I can run three instances of mplayer(-ao oss,-ao
arts,-ao alsa:device=hw=0,0) concurrently without any "vortex: FATAL:
ResManager: resource type 0 exhausted" in the system log.

I can even run "jackd -d alsa -o2 -i2 -S -p512" with some xrun messages
and another instance of mplayer -ao jack concurrently

It seem to me that arts is using OSS emulation

----------------------------------------------------------------------
 Raymond - 04-14-06 03:30 
----------------------------------------------------------------------
>> Also I try wine at home with my "Monster Sound 2" (lspci output in bug
0001726) >> on 32-bit kernel and here is dmesg output on first run:
>> vortex: FATAL: ResManager: resource type 0 exhausted.
>> vortex: FATAL: ResManager: resource type 3 exhausted.

>> Message "vortex: FATAL: ResManager: resource type 0 exhausted" appears
with and >> without surround patch. 

May be due to the variables 

u32 fixed_res[5] 

is used without initialisation


How do you load/unload the au8830 driver ?

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
