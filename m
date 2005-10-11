From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001378]: Surround Channel and Surround mixer doesn't work with a CM9761chip
Date: Tue, 11 Oct 2005 16:27:57 +0200
Message-ID: <e444485e8655ceba4f2897b93ce981b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7365518D
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2005 16:27:58 +0200 (MEST)
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
Last Modified:              10-11-2005 16:27 CEST
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
 midnight - 10-10-05 23:26 
----------------------------------------------------------------------
I've got an error when I use speaker-test -Dhw with more than 2 speakers
(-c 6)

Channels count (6) not available for playbacks: Argument invalide
Setting of hwparams failed: Argument invalide

----------------------------------------------------------------------
 tiwai - 10-11-05 16:27 
----------------------------------------------------------------------
Ah, you has to pass hw:0,1.
Anyway, the bug in surround51 is fixed on the latest CVS.  Try it first.

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
09-18-05 15:59 midnight       Note Edited: 0006270                         
09-24-05 14:34 midnight       Note Added: 0006370                          
10-05-05 19:04 tiwai          Note Added: 0006439                          
10-10-05 23:26 midnight       Note Added: 0006450                          
10-11-05 16:27 tiwai          Note Added: 0006451                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
