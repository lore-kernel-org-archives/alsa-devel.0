From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000801]: Persistent "max-amp" level on hdspmixer inputs
Date: Fri, 8 Jul 2005 10:35:17 +0200
Message-ID: <e7734f23d456fe02a644045aa8de9ad1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C08BD18F
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:17 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=801> 
======================================================================
Reported By:                kme
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   801
Category:                   hdsp progs
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-10-2005 09:20 CET
Last Modified:              07-08-2005 10:35 CEST
======================================================================
Summary:                    Persistent "max-amp" level on hdspmixer inputs
Description: 
HDSPmixer shows constant "max-amp" (actually -6db or so) levels at all
times in the first 8 channels.  And when sound is played internally the
middle row meters (playback) show the left channel with maxed-out levels
while the right channel shows nothing.  Peak meters (yellow), however,
appear to work normally.

A screenshot of the mixer while playing a stereo soundfile routed to AN1+2
and Analog (headphones) only with NOTHING connected to the inputs can be
cound here:

http://www.esm.rochester.edu/kevine/hdsp_screenshot.jpg

Note that the outputs (bottom row) show proper levels as do the yellow
peak meters in playback (Out 1+2).  

Signal quality is unaffected.
======================================================================

----------------------------------------------------------------------
 slick - 01-31-05 22:27 
----------------------------------------------------------------------
Hello Thomas,

I tried ALSA 1.08 and the latest hdsp.c from the ALSA-CVS (including your
patch). Now the hdspmixer is working fine with my Multiface. 
Thanks a a lot.

----------------------------------------------------------------------
 charbonnel - 02-01-05 21:40 
----------------------------------------------------------------------
Fixed in cvs, the fix should appear in alsa > 1.0.8

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 09:20 kme            New Issue                                    
01-15-05 19:27 slick          Note Added: 0003212                          
01-15-05 19:28 slick          Issue Monitored: slick                       
01-15-05 19:32 slick          Note Added: 0003213                          
01-27-05 21:47 charbonnel     Note Added: 0003422                          
01-28-05 22:00 kme            Note Added: 0003436                          
01-31-05 22:27 slick          Note Added: 0003459                          
02-01-05 21:40 charbonnel     Status                   assigned => resolved
02-01-05 21:40 charbonnel     Resolution               open => fixed       
02-01-05 21:40 charbonnel     Note Added: 0003467                          
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
