From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001182]: Audigy Recording has crackles/distortion
Date: Fri, 30 Dec 2005 23:57:14 +0100
Message-ID: <b0c0002257dd47e787045063c5bf24fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7820168
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:57:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1182> 
======================================================================
Reported By:                netslayer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1182
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-11-2005 07:14 CEST
Last Modified:              12-30-2005 23:57 CET
======================================================================
Summary:                    Audigy Recording has crackles/distortion
Description: 
I have several audigy (emu10k1) cards that I use for recording tv with
mythtv. They worked perfectly in kernel 2.6.7 love sources and most likely
any with that alsa version. As soon as I upgraded to newer kernels such as
2.6.11 and I think 2.6.9 had the problem as well I get this problem. While
recording through the line in connector I get crackling/distortion
occurring on both left and right channels. This is not an audio cable or
ground problem, as now it has happened on all boxes I have after upgrading
kernels. 

I actually found it to be so bad that I switched audio cards on one of my
boxes and now that I did a network wide update for kernels I realized it
was a alsa bug.

I'm currently running 2.6.11 gentoo sources (previously called gentoo dev
sources) on all my boxes.

0000:00:09.0 Multimedia audio controller: Creative Labs SB Audigy (rev
03)
        Subsystem: Creative Labs SB0090 Audigy Player/OEM
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at a400
        Capabilities: [dc] Power Management version 2

Alsa history:
     Mon Jun  7 12:52:46 2004 >>> media-libs/alsa-lib-1.0.3b-r2
     Sun Jun 13 00:14:49 2004 >>> media-libs/alsa-oss-1.0.3a
     Sun Jun 13 00:15:28 2004 >>> media-sound/alsa-utils-1.0.3
     Sun Jun 13 15:08:34 2004 >>> media-sound/alsa-driver-1.0.5
     Sun Jun 13 17:18:23 2004 >>> media-sound/alsa-utils-1.0.5
     Sun Jun 13 17:21:12 2004 >>> media-libs/alsa-lib-1.0.5
     Sun Jun 13 17:23:14 2004 >>> media-libs/alsa-oss-1.0.5
     Sun Jun 13 21:15:59 2004 >>> media-sound/alsa-driver-1.0.5
     Mon May 30 21:27:33 2005 >>> media-sound/alsa-headers-1.0.8
     Mon May 30 21:30:57 2005 >>> media-libs/alsa-lib-1.0.8
     Mon May 30 21:31:42 2005 >>> media-sound/alsa-utils-1.0.8
     Mon May 30 21:38:14 2005 >>> media-libs/alsa-oss-1.0.8-r1

kernel history:
lrwxrwxrwx   1 root root   31 Jun  1 22:21 linux ->
/usr/src/linux-2.6.11-gentoo-r9
drwxr-xr-x  19 root root 1312 Jun  2 00:05 linux-2.6.11-gentoo-r9
drwxr-xr-x  19 root root 1216 Jun  1 22:30 linux-2.6.7-rc2-love2

2.6.7 worked perfectly!
======================================================================

----------------------------------------------------------------------
 netslayer - 06-12-05 20:29 
----------------------------------------------------------------------
Yes, CD and Aux are both muted. 

I capture on: Analog Mix, all others are at 0
Playback: Master, Bass, Treble, PCM, PCM Center, PCM Front, PCM LFE, PCM
Surr, Fron, Surround, Line and Audigy Analog/Digital Output Jack are all
on, the rest are muted or at 0.

Playback shouldn't make a difference though as it's the recorded content
that has the crackles.

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:57 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 07:14 netslayer      New Issue                                    
06-11-05 07:14 netslayer      File Added: Dateline NBC.mp3                    
06-11-05 07:14 netslayer      Distribution              => Gentoo          
06-11-05 07:14 netslayer      Kernel Version            => 2.6.11          
06-11-05 08:37 pzad           Note Added: 0004986                          
06-12-05 20:29 netslayer      Note Added: 0005000                          
12-30-05 23:57 rlrevell       Note Added: 0007305                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
