From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000667]: How to integrate turning on and off LED:s on laptops
Date: Wed, 24 Nov 2004 15:07:51 +0100
Message-ID: <76af051f8fd022af2f76ae6a36d55fb7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1F74A2DB
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 15:07:52 +0100 (MET)
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
Last Modified:              11-24-2004 15:07 CET
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
 linus - 11-24-04 14:27 
----------------------------------------------------------------------
The LED is indeed for muting only. It has an image of a crossed-over
speaker.

The LED sits behind a muting button, which produce an extended key code,
through the keyboard API.

I will try to look into PCI ID:s and see if that will be unique enough to
use for this kind of things.

----------------------------------------------------------------------
 linus - 11-24-04 15:07 
----------------------------------------------------------------------
This is the PCI info for this ICH4 controller. (I submitted this new
info to linux' pci.ids PCI ID list too.)

00:1f.5 Class 0401: 8086:24c5 (rev 03)
        Subsystem: 103c:0890

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 3000 [size=256]
        I/O ports at 3880 [size=64]
        Memory at a0100000 (32-bit, non-prefetchable) [size=512]
        Memory at a0180000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 15:27 linus          New Issue                                    
11-23-04 15:27 linus          Distribution              => Fedora Core 3   
11-23-04 15:27 linus          Kernel Version            => 2.6.9           
11-23-04 15:41 tiwai          Note Added: 0002516                          
11-23-04 21:28 linus          Note Added: 0002528                          
11-24-04 12:22 tiwai          Note Added: 0002549                          
11-24-04 13:00 IceRAM         Note Added: 0002555                          
11-24-04 13:07 tiwai          Note Added: 0002558                          
11-24-04 14:27 linus          Note Added: 0002562                          
11-24-04 15:07 linus          Note Added: 0002567                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
