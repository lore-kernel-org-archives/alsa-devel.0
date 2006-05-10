From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001833]: oops in snd_mpu401_uart
Date: Wed, 10 May 2006 14:44:59 +0200
Message-ID: <0bea532c589a92db99bd49c966fb4424@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0074B15A
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 14:44:59 +0200 (MEST)
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
Last Modified:              05-10-2006 14:44 CEST
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
 rlrevell - 05-10-06 12:43 
----------------------------------------------------------------------
For the 10000th time, DO NOT POST PATCHES HERE - POST THEM TO THE MAILING
LIST!!!!!!!!!!!!!!!!!!!!!!!

----------------------------------------------------------------------
 tiwai - 05-10-06 14:44 
----------------------------------------------------------------------
To clarify:  There are some reasons that BTS is unsuitable for reviewing
patches.

- the patch pasted in the web form is broken to be applied  -- Never ever
do it
- the patch file uploaded cannot be easily pasted back to the form with
comments after review  So, the only action I can do is to take it or
reject it.

 From these reasons, I ask you to post patches to ALSA devel ML instead of
hanging around BTS.  Otherwise they will never get merged.

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
