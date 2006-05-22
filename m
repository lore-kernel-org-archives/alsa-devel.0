From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000057]: Kernel device in bad state after suspend/resume
Date: Mon, 22 May 2006 12:23:37 +0200
Message-ID: <55fe585f608a435936159d6d646ee650@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5BCBE164
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2006 12:23:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=57> 
======================================================================
Reported By:                daenzer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   57
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-13-2004 01:55 CET
Last Modified:              05-22-2006 12:23 CEST
======================================================================
Summary:                    Kernel device in bad state after suspend/resume
Description: 
If a process has the kernel device open during a suspend/resume cycle,
playing sound fails afterwards with

pcm_write:1084: write error: File descriptor in bad state

until the process dies, then it works again.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001442 snapper: no sound after resume
======================================================================

----------------------------------------------------------------------
 daenzer - 11-17-05 11:06 
----------------------------------------------------------------------
The behaviour has changed with kernel 2.6.14: I no longer get the write
error, the process that was playing sound during suspend/resume just
hangs, apparently in a system call. It can be resumed with kill -STOP;
kill -CONT or by starting another sound app (via dmix), but playback is
then distorted (sounds like the frames are played in the wrong order)
until the PCM device is closed.

Also, after suspend/resume, I have to disable and then re-enable the
speakers and change the volume(!) before I can hear anything from the
speakers.

----------------------------------------------------------------------
 piem - 05-22-06 12:23 
----------------------------------------------------------------------
I confirm the behavior got worst with recent 2.6.1x kernels. On 2.6.16-1,
when the machine goes to sleep while running jackd (using oss emulation),
the machine crashes on wake up with the following message:

eth0: Pause is disabled
BUG: soft lockup detected on CPU#0!
NIP: D2600F14 LR: D2601848 CTR: D260589C
REGS: cdf33c40 TRAP: 0901   Tainted: GF      (2.6.16-1-powerpc)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22022424  XER: 20000000
TASK = c3a26690[26272] 'jackd' THREAD: cdf32000
GPR00: 00000000 CDF33CF0 C3A26690 CF39DE00 20004144 00000000 00000000
D2603018
GPR08: 00000000 CF92FC00 C3F20000 CE9C0000 00000000
NIP [D2600F14] snd_pcm_common_ioctl1+0xe38/0x1288 [snd_pcm]
LR [D2501848] snd_pcm_capture_ioctl1+0x4e4/0x53c [snd_pcm]
Call Trace:
[CDF33CF0] [D2600F48] snd_pcm_common_ioctl1+0xe6c/0x1288 [snd_pcm]
(unreliable)
[CDF33E10] [D2601848] snd_pcm_capture_ioctl1+0x4e4/0x53c [snd_pcm]
[CDF33E40] [D26018E4] snd_pcm_kernel_capture_ioctl+0x28/0x4c [snd_pcm]
[CDF33E60] [D263A754] snd_pcm_oss_read3+0x54/0x118 [snd_pcm_oss]
[CDF33E90] [D263A920] snd_pcm_oss_read2+0x108/0x148 [snd_pcm_oss]
[CDF33EC0] [D263C41C] snd_pcm_oss_read+0x15c/0x1bc [snd_pcm_oss]
[CDF33EF0] [C0077C68] vfs_read+0xe8/0x1c0
[CDF33F10] [C00789D8] sys_read+0x4c/0x94
[CDF33F40] [C000FEF4] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfede564
    LR = 0xfede54c
Instruction dump:
8343005c 81230000 817a0098 82e90000 800b0000 2f800000 418e03c8 3bf701c8
7c00f828 3000ffff 7c00f92d 40a2fff4 <2f800000> 40bc000c 7fe3fb78 48007369

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 01:55 daenzer        New Issue                                    
02-26-04 19:30 daenzer        Note Added: 0000363                          
02-26-04 19:39 tiwai          Note Added: 0000364                          
02-26-04 22:47 daenzer        Note Added: 0000374                          
05-14-04 15:12 tiwai          Note Added: 0001111                          
09-29-05 20:55 jdthood        Relationship added       has duplicate 0001442
09-29-05 23:52 Johannes Berg  Issue Monitored: Johannes Berg                    
09-29-05 23:59 Johannes Berg  Note Added: 0006427                          
10-05-05 18:40 tiwai          Note Added: 0006432                          
10-12-05 21:02 Johannes Berg  Note Added: 0006474                          
11-17-05 11:06 daenzer        Note Added: 0006748                          
05-22-06 12:23 piem           Note Added: 0009908                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
