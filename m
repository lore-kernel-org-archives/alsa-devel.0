From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001202]: No sound  through speakers, only headphones
Date: Wed, 22 Jun 2005 16:35:14 +0200
Message-ID: <70020055c72ba674d10fc72ee54e1a45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0BD601FD
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 16:35:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1202> 
======================================================================
Reported By:                viroid
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1202
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369
======================================================================
Date Submitted:             06-18-2005 04:47 CEST
Last Modified:              06-22-2005 16:35 CEST
======================================================================
Summary:                    No sound  through speakers, only headphones
Description: 
I cannot get any audio output from the internal speakers on the laptop, I
did however hear output through headphones; I tried that after reading a
few issues on here.  I've muted headphones, phone, and line from the
alsamixer, I've only recently started using linux and I don't really know
what else to try. 
======================================================================

----------------------------------------------------------------------
 tiwai - 06-22-05 12:16 
----------------------------------------------------------------------
What happens if you unmute/adjust "Headphone" volume?
Also, turn on "External Amplifier".

----------------------------------------------------------------------
 viroid - 06-22-05 16:35 
----------------------------------------------------------------------
When I umute the headphones I nearly went deaf because the volume was at
max..

Good news though, umuting the External Amp corrected the problem, thanks
again for your help!  I really appreciate you taking the time to address
my issue.

...Chris

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-05 04:47 viroid         New Issue                                    
06-18-05 04:47 viroid         Distribution              => Fedora Core 4   
06-18-05 04:47 viroid         Kernel Version            => 2.6.11-1.1369   
06-21-05 12:58 tiwai          Note Added: 0005110                          
06-22-05 05:12 viroid         Note Added: 0005118                          
06-22-05 12:16 tiwai          Note Added: 0005126                          
06-22-05 16:35 viroid         Note Added: 0005134                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
