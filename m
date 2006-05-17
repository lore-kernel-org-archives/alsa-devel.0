From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001833]: oops in snd_mpu401_uart
Date: Wed, 17 May 2006 11:38:20 +0200
Message-ID: <72a36f16095d396cc402a7e751ab0786@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3B2FA1A0
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 11:38:21 +0200 (MEST)
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
Last Modified:              05-17-2006 11:38 CEST
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
 Raymond - 05-15-06 07:21 
----------------------------------------------------------------------
After the ALSA developer accept Alan's patch
"au88x0_mpu401.c-remove-enter_uart.diff", you should send the patch to
alsa-developer mailing list and cc perex , mjander.

Can mpu->private_data can be used for this purpose ?

The variable rmidi is redundant and can be replaced by vortex->rmidi

The only drawback is the error messages in mpu401_uart.c will not display
the mmio address since mpu->port and mpu->cport contains the offset

BTW, you may contact Zoltan Boszormenyi if they required other user to
confirm the bug. Zoltan need to upgrade alsa-driver to 1.0.11rc3 or later

http://lkml.org/lkml/2006/5/10/308

----------------------------------------------------------------------
 Raymond - 05-17-06 11:38 
----------------------------------------------------------------------
> It works fine for me; perhaps another au88x0 user could confirm also by 
> applying the diff (attached again)?

Using example from man amidi ( au8830 without any midi
keyboard/waveblaster)

amidi -S "F0 43 10 4C 00 00 7E 00 F7"

dmesg

07dd00ed mpu401 write 28800 00   mpu->mode=00
07dd01c0 mpu401 read  28804 80   mpu->mode=00
07dd01f0 mpu401 write 28804 ff   mpu->mode=00
07dd022f mpu401 read  28804 00   mpu->mode=00
07dd026b mpu401 read  28800 fe   mpu->mode=00
07dd029c mpu401 write 28800 00   mpu->mode=00
07dd02da mpu401 read  28804 80   mpu->mode=00
07dd0309 mpu401 write 28804 3f   mpu->mode=00
07dd0345 mpu401 read  28804 01   mpu->mode=00
07dd037f mpu401 read  28800 fe   mpu->mode=00
07e57670 mpu401 read  28804 81   mpu->mode=0a
07e576ff mpu401 write 28800 f0   mpu->mode=0a
07e57745 mpu401 read  28804 81   mpu->mode=0a
07e57776 mpu401 write 28800 43   mpu->mode=0a
07e577b5 mpu401 read  28804 81   mpu->mode=0a
07e577e4 mpu401 write 28800 10   mpu->mode=0a
07e57823 mpu401 read  28804 81   mpu->mode=0a
07e57853 mpu401 write 28800 4c   mpu->mode=0a
07e57893 mpu401 read  28804 81   mpu->mode=0a
07e578c3 mpu401 write 28800 00   mpu->mode=0a
07e57901 mpu401 read  28804 81   mpu->mode=0a
07e57931 mpu401 write 28800 00   mpu->mode=0a
07e5796e mpu401 read  28804 81   mpu->mode=0a
07e5799d mpu401 write 28800 7e   mpu->mode=0a
07e579db mpu401 read  28804 81   mpu->mode=0a
07e57a0b mpu401 write 28800 00   mpu->mode=0a
07e57a49 mpu401 read  28804 81   mpu->mode=0a
07e57a79 mpu401 write 28800 f7   mpu->mode=0a
07e57ab7 mpu401 read  28804 81   mpu->mode=0a
07e57ae7 mpu401 write 28800 fe   mpu->mode=0a
07eed4c0 mpu401 write 28800 00   mpu->mode=00
07eed55d mpu401 read  28804 81   mpu->mode=00
07eed58d mpu401 write 28804 ff   mpu->mode=00

amidi -p hw:0,0 -S F0411042110C000000000074F7 -r dump.syx -t 1
 
0 bytes read

dmesg

02e5d106 mpu401 write 28800 00   mpu->mode=00
02e5d1bd mpu401 read  28804 80   mpu->mode=00
02e5d1ee mpu401 write 28804 ff   mpu->mode=00
02e5d22a mpu401 read  28804 00   mpu->mode=00
02e5d265 mpu401 read  28800 fe   mpu->mode=00
02e5d294 mpu401 write 28800 00   mpu->mode=00
02e5d2cf mpu401 read  28804 80   mpu->mode=00
02e5d2fc mpu401 write 28804 3f   mpu->mode=00
02e5d337 mpu401 read  28804 01   mpu->mode=00
02e5d370 mpu401 read  28800 fe   mpu->mode=00
02ee2237 mpu401 read  28800 d1   mpu->mode=07
02ee22c7 mpu401 read  28800 d1   mpu->mode=07
02ee2303 mpu401 read  28800 d1   mpu->mode=07
02ee233f mpu401 read  28800 d1   mpu->mode=07
02ee2378 mpu401 read  28800 d1   mpu->mode=07
02ee23b2 mpu401 read  28800 d1   mpu->mode=07
02ee23eb mpu401 read  28800 d1   mpu->mode=07
02ee2425 mpu401 read  28800 d1   mpu->mode=07
02ee245f mpu401 read  28800 d1   mpu->mode=07
02ee2498 mpu401 read  28800 d1   mpu->mode=07
02ee24d2 mpu401 read  28800 d1   mpu->mode=07
02ee250c mpu401 read  28800 d1   mpu->mode=07
02ee2545 mpu401 read  28800 d1   mpu->mode=07
02ee257f mpu401 read  28800 d1   mpu->mode=07
02ee25b8 mpu401 read  28800 d1   mpu->mode=07
02ee25f3 mpu401 read  28800 d1   mpu->mode=07
02ee262c mpu401 read  28800 d1   mpu->mode=07
02ee2667 mpu401 read  28800 d1   mpu->mode=07
02ee26a0 mpu401 read  28800 d1   mpu->mode=07
02ee26d9 mpu401 read  28800 d1   mpu->mode=07
02ee2713 mpu401 read  28800 d1   mpu->mode=07
02ee274c mpu401 read  28800 d1   mpu->mode=07
02ee2786 mpu401 read  28800 d1   mpu->mode=07
02ee27c0 mpu401 read  28800 d1   mpu->mode=07
02ee27fa mpu401 read  28800 d1   mpu->mode=07
02ee2833 mpu401 read  28800 d1   mpu->mode=07
02ee286d mpu401 read  28800 d1   mpu->mode=07
02ee28a6 mpu401 read  28800 d1   mpu->mode=07
02ee28e0 mpu401 read  28800 d1   mpu->mode=07
02ee2919 mpu401 read  28800 d1   mpu->mode=07
02ee2953 mpu401 read  28800 d1   mpu->mode=07
02ee298c mpu401 read  28800 d1   mpu->mode=07
02ee29c6 mpu401 read  28800 d1   mpu->mode=07
02ee29ff mpu401 read  28800 d1   mpu->mode=07
02ee2a38 mpu401 read  28800 d1   mpu->mode=07
02ee2a73 mpu401 read  28800 d1   mpu->mode=07
02ee2aac mpu401 read  28800 d1   mpu->mode=07
02ee2ae6 mpu401 read  28800 d1   mpu->mode=07
02ee2b1f mpu401 read  28800 d1   mpu->mode=07
02ee2b59 mpu401 read  28800 d1   mpu->mode=07
02ee2b92 mpu401 read  28800 d1   mpu->mode=07
02ee2bcc mpu401 read  28800 d1   mpu->mode=07
02ee2c05 mpu401 read  28800 d1   mpu->mode=07
02ee2c3f mpu401 read  28800 d1   mpu->mode=07
02ee2c79 mpu401 read  28800 d1   mpu->mode=07
02ee2cb2 mpu401 read  28800 d1   mpu->mode=07
02ee2cec mpu401 read  28800 d1   mpu->mode=07
02ee2d25 mpu401 read  28800 d1   mpu->mode=07
02ee2d5f mpu401 read  28800 d1   mpu->mode=07
02ee2d99 mpu401 read  28800 d1   mpu->mode=07
02ee2dd3 mpu401 read  28800 d1   mpu->mode=07
02ee2e0c mpu401 read  28800 d1   mpu->mode=07
02ee2e45 mpu401 read  28800 d1   mpu->mode=07
02ee2e7f mpu401 read  28800 d1   mpu->mode=07
02ee2eb8 mpu401 read  28800 d1   mpu->mode=07
02ee2ef2 mpu401 read  28800 d1   mpu->mode=07
02ee2f2b mpu401 read  28800 d1   mpu->mode=07
02ee2f66 mpu401 read  28800 d1   mpu->mode=07
02ee2fa1 mpu401 read  28800 d1   mpu->mode=07
02ee2fdb mpu401 read  28800 d1   mpu->mode=07
02ee3014 mpu401 read  28800 d1   mpu->mode=07
02ee304f mpu401 read  28800 d1   mpu->mode=07
02ee3088 mpu401 read  28800 d1   mpu->mode=07
02ee30c3 mpu401 read  28800 d1   mpu->mode=07
02ee30fd mpu401 read  28804 81   mpu->mode=07
02ee480c mpu401 read  28804 81   mpu->mode=07
02ee48ad mpu401 read  28804 81   mpu->mode=0f
02ee48db mpu401 write 28800 f0   mpu->mode=0f
02ee491e mpu401 read  28804 81   mpu->mode=0f
02ee4949 mpu401 write 28800 41   mpu->mode=0f
02ee4982 mpu401 read  28804 81   mpu->mode=0f
02ee49ac mpu401 write 28800 10   mpu->mode=0f
02ee49e7 mpu401 read  28804 81   mpu->mode=0f
02ee4a11 mpu401 write 28800 42   mpu->mode=0f
02ee4a49 mpu401 read  28804 81   mpu->mode=0f
02ee4a73 mpu401 write 28800 11   mpu->mode=0f
02ee4aac mpu401 read  28804 81   mpu->mode=0f
02ee4ad7 mpu401 write 28800 0c   mpu->mode=0f
02ee4b11 mpu401 read  28804 81   mpu->mode=0f
02ee4b3b mpu401 write 28800 00   mpu->mode=0f
02ee4b74 mpu401 read  28804 81   mpu->mode=0f
02ee4b9e mpu401 write 28800 00   mpu->mode=0f
02ee4bd7 mpu401 read  28804 81   mpu->mode=0f
02ee4c01 mpu401 write 28800 00   mpu->mode=0f
02ee4c3a mpu401 read  28804 81   mpu->mode=0f
02ee4c64 mpu401 write 28800 00   mpu->mode=0f
02ee4c9c mpu401 read  28804 81   mpu->mode=0f
02ee4cc6 mpu401 write 28800 00   mpu->mode=0f
02ee4cff mpu401 read  28804 81   mpu->mode=0f
02ee4d29 mpu401 write 28800 74   mpu->mode=0f
02ee4d62 mpu401 read  28804 81   mpu->mode=0f
02ee4d8d mpu401 write 28800 f7   mpu->mode=0f
02ee4dde mpu401 read  28804 81   mpu->mode=0f
03157859 mpu401 read  28804 81   mpu->mode=0f
0315795c mpu401 read  28804 81   mpu->mode=0f
033cda41 mpu401 read  28804 81   mpu->mode=0f
033cdb45 mpu401 read  28804 81   mpu->mode=0f
03643b29 mpu401 read  28804 81   mpu->mode=0f
03643c22 mpu401 read  28804 81   mpu->mode=0f
038bb510 mpu401 read  28804 81   mpu->mode=0f
038bb61b mpu401 read  28804 81   mpu->mode=0f
03b306ab mpu401 read  28804 81   mpu->mode=0f
03b31ca1 mpu401 read  28804 81   mpu->mode=0a
03b31d0d mpu401 write 28800 fe   mpu->mode=0a
03bc6a6b mpu401 write 28800 00   mpu->mode=00
03bc6b10 mpu401 read  28804 81   mpu->mode=00
03bc6b40 mpu401 write 28804 ff   mpu->mode=00

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
04-18-06 06:04 Raymond        Note Edited: 0009325                         
04-19-06 05:42 Raymond        Issue Monitored: alien999999999                   

04-19-06 05:42 Raymond        Note Added: 0009349                          
04-20-06 04:27 Raymond        Issue Monitored: penguinparty                    
04-20-06 04:27 Raymond        Note Added: 0009364                          
04-20-06 05:05 Raymond        Note Edited: 0009325                         
04-20-06 08:55 alien999999999 Note Added: 0009366                          
04-20-06 09:27 Raymond        Note Added: 0009367                          
04-20-06 10:25 Raymond        Note Edited: 0009367                         
04-21-06 08:11 alien999999999 Note Added: 0009408                          
04-21-06 16:41 rlrevell       Note Added: 0009414                          
04-21-06 18:00 Raymond        Note Added: 0009420                          
04-21-06 18:13 Raymond        Note Added: 0009422                          
04-21-06 18:23 Raymond        Note Added: 0009425                          
04-21-06 18:28 Raymond        Note Added: 0009426                          
04-21-06 18:54 rlrevell       Note Added: 0009427                          
04-22-06 02:56 Raymond        Note Edited: 0009422                         
04-22-06 02:57 Raymond        Note Edited: 0009425                         
04-22-06 06:58 Raymond        Note Edited: 0009426                         
04-24-06 03:20 Raymond        Note Added: 0009447                          
04-24-06 05:43 ponchick       Note Added: 0009448                          
04-24-06 11:34 Raymond        Note Added: 0009450                          
04-25-06 10:08 Raymond        Note Added: 0009485                          
04-25-06 23:30 gineera        Note Added: 0009496                          
04-26-06 04:26 Raymond        Note Added: 0009500                          
04-26-06 04:33 Raymond        Note Added: 0009501                          
04-26-06 04:35 Raymond        Note Edited: 0009501                         
04-26-06 04:50 Raymond        Note Added: 0009502                          
04-26-06 05:06 Raymond        Note Added: 0009503                          
04-26-06 07:13 Raymond        Note Edited: 0009501                         
04-26-06 16:38 Raymond        Note Added: 0009515                          
04-26-06 17:20 Raymond        Note Added: 0009518                          
04-26-06 17:34 Raymond        Note Edited: 0009518                         
04-26-06 18:41 Raymond        Issue Monitored: perex                       
04-26-06 18:41 Raymond        Note Added: 0009521                          
04-27-06 13:36 Raymond        Note Added: 0009529                          
05-01-06 10:58 Raymond        Note Added: 0009554                          
05-01-06 18:12 Raymond        Note Edited: 0009554                         
05-02-06 04:38 ponchick       Note Added: 0009555                          
05-02-06 06:52 Raymond        Issue Monitored: tiwai                       
05-02-06 06:52 Raymond        Note Added: 0009556                          
05-02-06 06:54 Raymond        Note Edited: 0009556                         
05-02-06 17:55 tiwai          Note Added: 0009561                          
05-03-06 11:23 Raymond        Note Added: 0009583                          
05-03-06 11:29 ponchick       Note Added: 0009584                          
05-03-06 15:23 Raymond        Issue Monitored: mjander                     
05-03-06 15:23 Raymond        Note Added: 0009593                          
05-03-06 18:31 Raymond        Note Added: 0009596                          
05-04-06 05:08 Raymond        Note Edited: 0009596                         
05-04-06 07:11 Raymond        Note Edited: 0009596                         
05-04-06 12:18 Raymond        Note Added: 0009614                          
05-05-06 04:35 Raymond        Note Edited: 0009529                         
05-05-06 07:10 ponchick       Note Added: 0009623                          
05-05-06 15:20 Raymond        Note Added: 0009625                          
05-06-06 04:05 ponchick       Note Added: 0009635                          
05-06-06 05:10 Raymond        Note Added: 0009636                          
05-06-06 05:22 Raymond        Note Edited: 0009636                         
05-07-06 19:17 Raymond        Note Added: 0009642                          
05-07-06 19:21 Raymond        Note Edited: 0009642                         
05-07-06 19:23 rlrevell       Note Added: 0009643                          
05-09-06 13:26 Raymond        Note Added: 0009655                          
05-09-06 17:24 Raymond        Note Added: 0009663                          
05-10-06 03:49 ponchick       Note Added: 0009700                          
05-10-06 10:17 Raymond        Note Added: 0009705                          
05-10-06 10:52 Raymond        Note Added: 0009707                          
05-10-06 11:11 Raymond        Note Edited: 0009707                         
05-10-06 12:43 rlrevell       Note Added: 0009709                          
05-10-06 14:44 tiwai          Note Added: 0009713                          
05-14-06 13:46 Raymond        Note Edited: 0009707                         
05-14-06 15:16 Raymond        Note Added: 0009808                          
05-15-06 05:37 ponchick       Note Added: 0009812                          
05-15-06 07:21 Raymond        Note Added: 0009813                          
05-17-06 11:38 Raymond        Note Added: 0009846                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
