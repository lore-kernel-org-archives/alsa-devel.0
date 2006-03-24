From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001938]: EPIPE on Audigy with surround sound when seeking in 6 channel sound file
Date: Fri, 24 Mar 2006 17:29:18 +0100
Message-ID: <d7d1a5e313ddbcc712b63f120eeead46@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E76491CD
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 17:29:18 +0100 (MET)
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
Last Modified:              03-24-2006 17:29 CET
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
 tiwai - 03-24-06 17:06 
----------------------------------------------------------------------
Let's separate to two bugs.  The 100% CPU should be fixed by the patch. 
The EPIPE should be fixed by the patch to pcm_hw.c.

Anyway, please try 1.0.11rc4 and recheck whether both problems still exist
or are solved.

----------------------------------------------------------------------
 bambam - 03-24-06 17:29 
----------------------------------------------------------------------
This issue with bug id #1938 is about sound_pcm_writei returning EPIPE in
mixed 64/32 bit environment and this is the bug number that pcm_direct.c
log refers to. I've tried today's CVS which I understnd contains all the
changes in rc4 and this bug still exists.
There is another bug with id #1584 regarding 100% CPU load with dmix
device on mixed 64/32 bit systems where I added a note. I will check later
if it has been solved because I requires the builtin soundcard to be
reenabled in the BIOS.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
