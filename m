From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001378]: Surround Channel and Surround mixer doesn't work with a CM9761chip
Date: Sun, 18 Sep 2005 12:05:18 +0200
Message-ID: <9ec6b8bd343fde7504a24ef9f76d476f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F56315C
	for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2005 12:05:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1378> 
======================================================================
Reported By:                midnight
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1378
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sid
Kernel Version:             2.6.12.5
======================================================================
Date Submitted:             08-30-2005 11:33 CEST
Last Modified:              09-18-2005 12:05 CEST
======================================================================
Summary:                    Surround Channel and Surround mixer doesn't work
with a CM9761chip
Description: 
The sound works fine on the center, LFE an front channels but I have no
sound on the rear channel. also, I can't change the volume of the surround
mixer in alsamixer (I can juste mute/unmute it).

I use the surround51 device to play my test sound and my test sound is a 6
channels one.

I use the via82xx module

thanks
======================================================================

----------------------------------------------------------------------
 tiwai - 09-13-05 18:27 
----------------------------------------------------------------------
Fixed on CVS version.  Please give a shot.

----------------------------------------------------------------------
 midnight - 09-18-05 12:05 
----------------------------------------------------------------------
With today's CVS version, the sound is ok for the front and rear speakers
but not for the center and LFE ones.

if I use speaker-test with the front or surround40 device (4 speakers) it
is ok.

but if I use "speaker-test -c6 -Dsurround5", there is always a noise on
the center and LFE speakers whatever the speaker selected. But no sound on
the front and rears speakers.

however, the value of the 0x64 register is OK when I use surround51
device.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 11:33 midnight       New Issue                                    
08-30-05 11:33 midnight       Distribution              => Debian Sid      
08-30-05 11:33 midnight       Kernel Version            => 2.6.12.5        
09-07-05 11:20 midnight       Note Added: 0006053                          
09-07-05 15:32 tiwai          Note Added: 0006054                          
09-08-05 01:10 midnight       Note Added: 0006069                          
09-08-05 18:58 tiwai          Note Added: 0006076                          
09-08-05 19:00 midnight       Note Added: 0006077                          
09-08-05 19:12 tiwai          Note Added: 0006080                          
09-08-05 19:58 midnight       Note Added: 0006081                          
09-08-05 20:42 tiwai          Note Added: 0006082                          
09-08-05 20:44 tiwai          Note Added: 0006083                          
09-08-05 23:20 midnight       Note Added: 0006084                          
09-09-05 12:47 tiwai          Note Added: 0006096                          
09-09-05 14:16 midnight       File Added: ac97#0-0                         
09-09-05 14:16 midnight       File Added: asound.state                     
09-09-05 14:21 midnight       Note Added: 0006097                          
09-09-05 14:29 tiwai          Note Added: 0006098                          
09-09-05 14:54 midnight       Note Added: 0006099                          
09-09-05 16:32 tiwai          Note Added: 0006100                          
09-09-05 19:50 midnight       Note Added: 0006104                          
09-09-05 20:14 tiwai          Note Added: 0006105                          
09-09-05 23:41 midnight       Note Added: 0006106                          
09-13-05 18:27 tiwai          Note Added: 0006155                          
09-18-05 12:05 midnight       Note Added: 0006270                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
