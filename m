From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000728]: periodic noise in audio output
Date: Tue, 21 Dec 2004 19:01:13 +0100
Message-ID: <184e2a5a6ae07532f0a02228b788baf7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 53CCE245
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2004 19:01:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=728> 
======================================================================
Reported By:                virtualman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   728
Category:                   SPARC - cs4231
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-16-2004 23:12 CET
Last Modified:              12-21-2004 19:01 CET
======================================================================
Summary:                    periodic noise in audio output
Description: 
I am having a periodic crackling noise in my audio output. I sounds like
the audio signal was not continuous at block boundaries.

I installed alsa-drivers (1.0.7) on a gentoo system. Therefore a number of
patches have been applied.

My audio hardware is a CS4231 on a Sun Ultra 10, the driver module
therefore is snd-sun-cs4231.

======================================================================

----------------------------------------------------------------------
 tiwai - 12-21-04 19:01 
----------------------------------------------------------------------
Does this happen on every application?  Or on certain ones (e.g. with OSS
emulation)?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-16-04 23:12 virtualman     New Issue                                    
12-21-04 19:01 tiwai          Note Added: 0002905                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
