From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000172]: Master volume control only controls front speakers
Date: Tue, 22 Feb 2005 09:59:50 +0100
Message-ID: <3f0e0f2bfd244edf318f818adf7317fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 915AD12A
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 09:59:50 +0100 (MET)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=172> 
======================================================================
Reported By:                gruberroland
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   172
Category:                   mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-31-2004 11:50 CEST
Last Modified:              02-22-2005 09:59 CET
======================================================================
Summary:                    Master volume control only controls front speakers
Description: 
The master volume control has no effect on the rear speakers.
The rear speakers can be controlled by "Sigmatel Surround" but not
completly muted.

I use "Sigmatel 4-Speaker Stereo" to get sound on all 4 speakers. The
speakers are plugged into both output plugs on the soundcard.

I tried all volume controls that are provided, there seems to be no master
control.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000154 Master volume only controls front outpu...
related to          0000919 Master volume doesn't control rear spea...
======================================================================

----------------------------------------------------------------------
 perex - 03-31-04 16:35 
----------------------------------------------------------------------
It's feature request. We haven't designed abstract mixer layer at the
moment,
but you are allowed to control fully hardware anyway. If you cannot mute
completely the rear speakers, then it's probably hardware problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-04 11:50 gruberroland   New Issue                                    
03-31-04 11:50 gruberroland   Kernel Version            => 2.4.25          
03-31-04 16:33 perex          Assigned To               => perex           
03-31-04 16:33 perex          Severity                 major => feature    
03-31-04 16:33 perex          Status                   new => assigned     
03-31-04 16:35 perex          Note Added: 0000725                          
10-22-04 16:44 perex          Relationship added       related to 0000154  
10-29-04 21:03 BMS            Issue Monitored: BMS                         
02-22-05 09:57 perex          Relationship added       related to 0000919  
02-22-05 09:59 perex          Project                  ALSA - driver => ALSA -
lib
02-22-05 09:59 perex          Category                 PCI - ens1371 => mixer
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
