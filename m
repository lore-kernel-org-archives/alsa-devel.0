From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000569]: Software mixing to rear channel
Date: Mon, 14 Feb 2005 19:33:30 +0100
Message-ID: <6f5d3e45ee596077467dd116ffc488ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7EE6C19D
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:33:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=569> 
======================================================================
Reported By:                pmatil
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   569
Category:                   PCI - cs46xx
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Debian GNU/Linux
Kernel Version:             2.4.22
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-06-2004 15:22 CEST
Last Modified:              02-14-2005 19:33 CET
======================================================================
Summary:                    Software mixing to rear channel
Description: 
I don't know how to explain it, but since Terratec DMX Xfire 1024 has two
stereo outputs (front and rear), it would be nice if there was a
slider/button/etc. from which I could set same output to front and rear
(eg. same signal), so my 4-channel amp. gets all 4-channels in and I get
sound from all 4 speakers instead of the amp. mixing front to rear.
Separated volume sliders for front and rear would be nice too.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000579 multi+route distort sound
======================================================================

----------------------------------------------------------------------
 tiwai - 10-12-04 14:50 
----------------------------------------------------------------------
You can do this by creating a new pcm in ~/.asoundrc.
See an example in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=579.

----------------------------------------------------------------------
 tiwai - 01-13-05 17:03 
----------------------------------------------------------------------
4-channel output is enabled in the recent version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-06-04 15:22 pmatil         New Issue                                    
10-06-04 15:22 pmatil         Distribution              => Debian GNU/Linux
10-06-04 15:22 pmatil         Kernel Version            => 2.4.22          
10-12-04 14:50 tiwai          Note Added: 0002098                          
10-22-04 16:56 perex          Relationship added       related to 0000579  
01-13-05 17:03 tiwai          Status                   new => resolved     
01-13-05 17:03 tiwai          Resolution               open => fixed       
01-13-05 17:03 tiwai          Assigned To               => tiwai           
01-13-05 17:03 tiwai          Note Added: 0003186                          
01-13-05 17:03 tiwai          Assigned To              tiwai =>            
02-14-05 19:33 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
