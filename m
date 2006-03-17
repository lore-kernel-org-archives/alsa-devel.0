From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001938]: EPIPE on Audigy with surround sound when seeking in 6 channel sound file
Date: Fri, 17 Mar 2006 20:36:45 +0100
Message-ID: <5e23820851815926df7174121b999bbf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 67CB01B0
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 20:36:45 +0100 (MET)
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
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1938
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sid with custom x86-64 kernel
Kernel Version:             2.6.16-rc6
======================================================================
Date Submitted:             03-17-2006 20:31 CET
Last Modified:              03-17-2006 20:36 CET
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
 bambam - 03-17-06 20:36 
----------------------------------------------------------------------
I've just checked and this doesn't have to be a 6 channel sound file. You
get Broken pipe also with a stereo file provided you output it to a
surround device.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 20:31 bambam         New Issue                                    
03-17-06 20:31 bambam         Distribution              => Debian sid with
custom x86-64 kernel
03-17-06 20:31 bambam         Kernel Version            => 2.6.16-rc6      
03-17-06 20:36 bambam         Note Added: 0008656                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
