From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000780]: More laptops with LEDs (from: 0000667- How to integrate turning on and off LED:s on laptops)
Date: Wed, 9 Feb 2005 18:03:52 +0100
Message-ID: <0417dab067623da50401922dc358f612@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 694DC265
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 18:03:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=780> 
======================================================================
Reported By:                piesis
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   780
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-03-2005 12:39 CET
Last Modified:              02-09-2005 18:03 CET
======================================================================
Summary:                    More laptops with LEDs (from: 0000667- How to
integrate turning on and off LED:s on laptops)
Description: 
The previous issue
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0000667 is marked as
fixed and resolved, but it is not
good:
there seem to exist (many) more laptops utilizing this mute led feature,
therefore the list of machines with this quirk should stay somehow open
and updateable.

Not all machines currently available are included (only two so far);
New models will appear.

To begin with - my HP zv5000 has the same led (I used an amixer command in
lineakd to mute sound and turn on the led with that key).
If I'm not wrong, the respective PCI IDs are:

.vendor = 0x10de,
.device = 0x00da,
(from lspci:
0000:00:06.0 Class 0401: 10de:00da (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio
(rev a2))

The AC97 codec is AD1981B.

But there exists an equivalent laptop - Compaq r3000, so I will try to get
some info about IDs in those machines and post them here.

Final note about this issue in whole:
what is this "External Amp" used/intended for?
Because: if we mute the main output, then there is no signal to the amp -
it may safely be shut down? Or is this control pin used for something else
as well?

======================================================================

----------------------------------------------------------------------
 tiwai - 01-07-05 19:45 
----------------------------------------------------------------------
On some machines (e.g. Dell), EAPD really turns on/off the amplifier.

AFAIK, this pin doesn't have any effect (for sounds) except for turning
on/off mute LED on machines like yours.  So, with the quirk, "external
amplifier" mixer switch is removed indeed.

And, no, it's not specific to codecs.  It's specific to laptops.

----------------------------------------------------------------------
 tiwai - 01-07-05 19:49 
----------------------------------------------------------------------
The quirk is added to CVS now.  It'll appear in 1.0.8-final.

Now resolving this issue to FIXED.  If you find out the PCI sub IDs for
other laptops, please open another entry.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-05 12:39 piesis         New Issue                                    
01-03-05 12:39 piesis         Distribution              => Gentoo          
01-03-05 12:39 piesis         Kernel Version            => 2.6.9-gentoo-r9 
01-03-05 14:23 tiwai          Note Added: 0003061                          
01-04-05 00:17 piesis         Note Added: 0003077                          
01-07-05 19:45 tiwai          Note Added: 0003117                          
01-07-05 19:49 tiwai          Status                   new => resolved     
01-07-05 19:49 tiwai          Resolution               open => fixed       
01-07-05 19:49 tiwai          Assigned To               => tiwai           
01-07-05 19:49 tiwai          Note Added: 0003118                          
01-07-05 19:49 tiwai          Assigned To              tiwai =>            
02-09-05 18:03 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
