From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001938]: EPIPE on Audigy with surround sound when seeking in 6 channel sound file
Date: Fri, 31 Mar 2006 13:46:40 +0200
Message-ID: <ee91357491aba2f2e559e4c40897565f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 156D1C1
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 13:46:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1938> 
======================================================================
Reported By:                bambam
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1938
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Debian sid with custom x86-64 kernel
Kernel Version:             2.6.16-rc6
======================================================================
Date Submitted:             03-17-2006 20:31 CET
Last Modified:              03-31-2006 13:46 CEST
======================================================================
Summary:                    EPIPE on Audigy with surround sound when seeking in
6 channel sound file
Description: 
Seeking in a 6 channel sound or video file using a surround device gives
EPIPE (Broken pipe). This happens with both mplayer and vlc. My soundcard
is an Audigy 1 (SB0090). I'm running a 64-bit kernel with 32-bit
userspace. I've tried libs and modules from CVS two days ago with no
success.

======================================================================

----------------------------------------------------------------------
 bambam - 03-30-06 21:04 
----------------------------------------------------------------------
Please find below the backtrace you were asking for on the ML:

ALSA lib pcm.c:6300:(snd_pcm_mmap_commit) commit offset (0) doesn't match
with appl_ptr (363520) % buf_size (16384)
mplayer: error.c:139: snd_err_msg_default: Assertion `0' failed.

Program received signal SIGABRT, Aborted.
[Switching to Thread -159897888 (LWP 28220)]
0xffffe405 in ?? ()
(gdb) bt
#0  0xffffe405 in ?? ()
#1  0xf72046d1 in raise () from /lib/tls/i686/cmov/libc.so.6
#2  0xf7205f9b in abort () from /lib/tls/i686/cmov/libc.so.6
#3  0xf71fd695 in __assert_fail () from /lib/tls/i686/cmov/libc.so.6
#4  0xf7c26a4c in snd_err_msg_default (file=0x0, line=0, function=0x0,
err=0,
    fmt=0x0) at error.c:139
#5  0xf7c470d0 in snd_pcm_mmap_commit (pcm=0x888bff0, offset=0,
frames=5120)
    at pcm.c:6299
#6  0xf7c6525f in snd_pcm_multi_mmap_commit (pcm=0x0, offset=0,
size=5120)
    at pcm_multi.c:654
#7  0xf7c46fd7 in snd_pcm_mmap_commit (pcm=0x6e3c, offset=0, frames=5120)
    at pcm.c:6308
#8  0xf7c52b8b in snd_pcm_mmap_write_areas (pcm=0x888e3f0,
areas=0xffffb0e0,
    offset=0, size=5120) at pcm_mmap.c:123
#9  0xf7c46da5 in snd_pcm_write_areas (pcm=0x888e3f0, areas=0xffffb0e0,
    offset=0, size=5120, func=0xf7c52aa0 <snd_pcm_mmap_write_areas>)
    at pcm.c:6495
#10 0xf7c51bff in snd_pcm_mmap_writei (pcm=0x888e3f0, buffer=0x0, size=0)
    at pcm_mmap.c:186
#11 0xf7c3cf55 in snd_pcm_writei (pcm=0x888e3f0, buffer=0xf5bcb020,
size=28220)
    at pcm_local.h:401
#12 0x080ff34f in play ()
#13 0xf5bcb020 in ?? ()
---Type <return> to continue, or q <return> to quit---
#14 0x00001555 in ?? ()
#15 0x00000000 in ?? ()
(gdb)

----------------------------------------------------------------------
 bambam - 03-31-06 13:46 
----------------------------------------------------------------------
The patch from the ML fixes the problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 20:31 bambam         New Issue                                    
03-17-06 20:31 bambam         Distribution              => Debian sid with
custom x86-64 kernel
03-17-06 20:31 bambam         Kernel Version            => 2.6.16-rc6      
03-17-06 20:36 bambam         Note Added: 0008656                          
03-17-06 21:07 bambam         Note Added: 0008659                          
03-17-06 21:53 bambam         Note Added: 0008662                          
03-18-06 01:07 rlrevell       Note Added: 0008667                          
03-18-06 01:11 bambam         Note Added: 0008668                          
03-18-06 14:44 bambam         Note Added: 0008671                          
03-20-06 12:25 tiwai          Note Added: 0008715                          
03-21-06 00:29 bambam         Note Added: 0008733                          
03-21-06 17:30 tiwai          Status                   new => resolved     
03-21-06 17:30 tiwai          Resolution               open => fixed       
03-21-06 17:30 tiwai          Assigned To               => tiwai           
03-21-06 17:30 tiwai          Note Added: 0008747                          
03-21-06 20:09 bambam         Status                   resolved => feedback
03-21-06 20:09 bambam         Resolution               fixed => reopened   
03-21-06 20:09 bambam         Note Added: 0008759                          
03-21-06 20:10 tiwai          Status                   feedback => resolved
03-21-06 20:10 tiwai          Resolution               reopened => fixed   
03-21-06 20:10 tiwai          Note Added: 0008760                          
03-24-06 16:55 bambam         Status                   resolved => feedback
03-24-06 16:55 bambam         Resolution               fixed => reopened   
03-24-06 16:55 bambam         Note Added: 0008921                          
03-24-06 17:06 tiwai          Note Added: 0008922                          
03-24-06 17:29 bambam         Note Added: 0008923                          
03-24-06 17:34 tiwai          Note Added: 0008925                          
03-24-06 17:36 tiwai          Status                   feedback => resolved
03-24-06 17:36 tiwai          Resolution               reopened => fixed   
03-24-06 17:36 tiwai          Note Added: 0008926                          
03-24-06 17:38 tiwai          Note Added: 0008927                          
03-24-06 17:39 tiwai          Status                   resolved => feedback
03-24-06 17:39 tiwai          Resolution               fixed => reopened   
03-24-06 17:39 tiwai          Note Added: 0008928                          
03-24-06 18:07 bambam         Note Added: 0008931                          
03-24-06 20:11 bambam         File Added: strace.tar.bz2                    
03-24-06 20:12 bambam         Note Added: 0008935                          
03-24-06 20:47 bambam         Note Added: 0008936                          
03-25-06 13:16 bambam         Note Added: 0008946                          
03-27-06 02:05 bambam         Note Added: 0008981                          
03-29-06 18:56 tiwai          Status                   feedback => resolved
03-29-06 18:56 tiwai          Resolution               reopened => fixed   
03-29-06 18:56 tiwai          Note Added: 0009004                          
03-29-06 23:30 rhardy         Issue Monitored: rhardy                      
03-30-06 10:30 bambam         Status                   resolved => feedback
03-30-06 10:30 bambam         Resolution               fixed => reopened   
03-30-06 10:30 bambam         Note Added: 0009026                          
03-30-06 11:41 tiwai          Status                   feedback => resolved
03-30-06 11:41 tiwai          Resolution               reopened => fixed   
03-30-06 11:41 tiwai          Note Added: 0009029                          
03-30-06 21:04 bambam         Status                   resolved => feedback
03-30-06 21:04 bambam         Resolution               fixed => reopened   
03-30-06 21:04 bambam         Note Added: 0009038                          
03-31-06 13:46 bambam         Note Added: 0009044                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
