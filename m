From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000664]: ac97_quirk with SIS 7012 [ALC202] don't permit to have sound from the headphones, only internal speakers work.
Date: Sat, 16 Jul 2005 16:42:57 +0200
Message-ID: <865ce354c02c190cedea094c7cfd2b35@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6944210A
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 16:42:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=664> 
======================================================================
Reported By:                ignition
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   664
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               GNU/Linux Slackware 10.0
Kernel Version:             2.4.28
======================================================================
Date Submitted:             11-22-2004 18:29 CET
Last Modified:              07-16-2005 16:42 CEST
======================================================================
Summary:                    ac97_quirk with SIS 7012 [ALC202] don't permit to
have sound from the headphones, only internal speakers work.
Description: 
module: intel8x0
card: SiS SI7012
chip: Realtek ALC202 rev 0

All ok but when I plug a jack from the headphones (or hi-fi system), there
is no sound.
And when I plug a jack halfway, I hear mono sound with bad quality from
internal speaker AND from the headphones.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000014 No sound from external speakers (laptop)
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 15:41 
----------------------------------------------------------------------
This issue wasn't actually resolved.

----------------------------------------------------------------------
 jdthood - 07-16-05 16:42 
----------------------------------------------------------------------
> All ok but when I plug a jack from the headphones (or hi-fi system),
> there is no sound.  And when I plug a jack halfway, I hear mono sound
> with bad quality from internal speaker AND from the headphones.

Switch off "Headphone Jack Sense"?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-04 18:29 ignition       New Issue                                    
11-22-04 18:29 ignition       File Added: report                           
11-22-04 18:29 ignition       Distribution              => GNU/Linux Slackware
10.0
11-22-04 18:29 ignition       Kernel Version            => 2.4.28          
11-22-04 18:48 tiwai          Relationship added       duplicate of 0000014
11-22-04 18:48 tiwai          Duplicate ID             0 => 14             
11-22-04 18:48 tiwai          Status                   new => resolved     
11-22-04 18:48 tiwai          Resolution               open => duplicate   
11-22-04 18:48 tiwai          Assigned To               => tiwai           
11-22-04 18:48 tiwai          Note Added: 0002510                          
11-22-04 18:51 ignition       Issue Monitored: ignition                    
11-22-04 18:52 ignition       Issue End Monitor: ignition                    
12-06-04 14:58 dale           Issue Monitored: dale                        
01-20-05 18:52 jorge2         Issue Monitored: jorge2                      
03-23-05 15:41 jdthood        Status                   resolved => feedback
03-23-05 15:41 jdthood        Resolution               duplicate => reopened
03-23-05 15:41 jdthood        Note Added: 0004163                          
06-14-05 21:16 graf_eichbaum  Issue Monitored: graf_eichbaum                    
07-16-05 16:42 jdthood        Note Added: 0005497                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
