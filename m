From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000667]: How to integrate turning on and off LED:s on laptops
Date: Wed, 24 Nov 2004 12:22:07 +0100
Message-ID: <31e0d1a62a428a24d092f94c064ea87c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C8AC92AA
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 12:22:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=667> 
======================================================================
Reported By:                linus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   667
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-23-2004 15:27 CET
Last Modified:              11-24-2004 12:22 CET
======================================================================
Summary:                    How to integrate turning on and off LED:s on laptops
Description: 
This machine, an HP Compaq NC6000 (also on other models
such as NC8000) has a mute LED that
turns on and off when mute is activated/deactivated.
It is accomplished by way of the "External Amplifier"
setting - this has been wired to a LED instead of an
amplifier, so the "mute" function should (theoretically)
activate/deactivate the "External Amplifier" when muting
is selected for the device. The chip used is AD1981B.

This script shows how it is done:

if ( amixer sget "External Amplifier"|grep off > /dev/null )
then
           # Toggles the LED, no actual volume change
           amixer set "External Amplifier" unmute > /dev/null
           # Toggles the audio level
           amixer set "Master" unmute > /dev/null
else
           amixer set "External Amplifier" mute > /dev/null
           amixer set "Master" mute > /dev/null
fi

The question of how this is to be implemented remains. Is
this an issue for ALSA or shall it be handled on a higher,
user-space level? I also have a bug open in GNOME for the
same thing, I need to decide how to finally resolve this
and need input from the ALSA team on the best solution.

(See http://bugzilla.gnome.org/show_bug.cgi?id=157748)
======================================================================

----------------------------------------------------------------------
 linus - 11-23-04 21:28 
----------------------------------------------------------------------
OK sounds reasonable, but given that it will only affect some specific
platforms using this chip, how do you reasonably distinguish between
them?
The one way I found (as illustrated in the GNOME bug) was to query the
ASPI
DSDT for the model name and brand. Is this a reasonable thing for an ALSA

module to do or do you suggest some other approach? (E.g. do you know
some
other "magic numbers" closer to ALSA that could be queried?)

----------------------------------------------------------------------
 tiwai - 11-24-04 12:22 
----------------------------------------------------------------------
I guess checking the PCI subsystem IDs would suffice.
Brand-laptops should have unique pci sub IDs.

The only question is: is the LED designed _only_ for mute?  Or is it
supposed to be generic?  In the latter case, we shouldn't restrict its use
in the driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 15:27 linus          New Issue                                    
11-23-04 15:27 linus          Distribution              => Fedora Core 3   
11-23-04 15:27 linus          Kernel Version            => 2.6.9           
11-23-04 15:41 tiwai          Note Added: 0002516                          
11-23-04 21:28 linus          Note Added: 0002528                          
11-24-04 12:22 tiwai          Note Added: 0002549                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
