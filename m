From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000079]: Dell Inspiron 8500 ICH4 no sound through internal speakers, headphone ok.
Date: Thu, 10 Mar 2005 15:24:35 +0100
Message-ID: <c0ea38477c2e5ee20a3ffcd5ca7049da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 62B8D157
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 15:24:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=79> 
======================================================================
Reported By:                rocco
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   79
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.3
======================================================================
Date Submitted:             02-22-2004 21:40 CET
Last Modified:              03-10-2005 15:24 CET
======================================================================
Summary:                    Dell Inspiron 8500 ICH4 no sound through internal
speakers, headphone ok.
Description: 
Alsa from kernel tree 2.6.3. Internal speakers of the laptop are not
working, when pluggin in something in the headphone output sound is
working. Mixer volume looks ok.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-10-04 17:57 
----------------------------------------------------------------------
now the switch is renamed to 'External Amplifier'.
it's a bit more obvious than before :)

about the default value: could you check again the default
EAPD value?  stop once alsa service, then remove /etc/asound.state
(or make backup), and start alsa again.

----------------------------------------------------------------------
 jdthood - 03-10-05 15:24 
----------------------------------------------------------------------
> stop once alsa service, then remove /etc/asound.state
> (or make backup), and start alsa again.

Submitter: What is the default External Amplifier state now?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-04 21:40 rocco          New Issue                                    
02-26-04 13:00 rocco          Note Added: 0000346                          
03-01-04 20:13 tiwai          Note Added: 0000424                          
03-10-04 17:57 tiwai          Note Added: 0000565                          
03-10-05 15:24 jdthood        Note Added: 0003864                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
