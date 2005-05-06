From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001090]: Support for new Prodigy 7.1 LT
Date: Sat, 7 May 2005 01:38:29 +0200
Message-ID: <d2838d0b594c0fcedea8229fe101dfa4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5CC9D22E
	for <alsa-devel@alsa-project.org>; Sat,  7 May 2005 01:38:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1090> 
======================================================================
Reported By:                Demosthenes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1090
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Ubuntu (Hoary Hedgehog)
Kernel Version:             2.6.10
======================================================================
Date Submitted:             05-06-2005 17:34 CEST
Last Modified:              05-07-2005 01:38 CEST
======================================================================
Summary:                    Support for new Prodigy 7.1 LT
Description: 
Could you please try to add support for the Audiotrak Prodigy 7.1 LT, as
far as I am aware this card is essentially the same as the Produgy 7.1 but
low profile and with a couple of physical changes such as no digital in.

ALSA does not detect the card currently and when I try to load the
snd-1724 module it fails with an EEPROM error.

I have tried compiling a new kernel with the subdevice id for the Prodigy
7.1 in aureon.h changed to correspond to my device (as detailed here for
another card
http://linux.derkeiler.com/Newsgroups/comp.os.linux.hardware/2004-10/0340.html).
Alsa then detects the card and I can load modules and change volumes in
alsamixer but I haven't been able to produce any sound.

Hopefully support will be easy to add as this card is almost exactly the
same as the Prodigy 7.1 (and Aureon Space etc.) which already have
support.

I would be very happy to give any further information needed.
======================================================================

----------------------------------------------------------------------
 ungod - 05-06-05 22:48 
----------------------------------------------------------------------
And have you tried loading the driver with "model=prodigy71" (instead of
altering the code)

----------------------------------------------------------------------
 Demosthenes - 05-07-05 01:38 
----------------------------------------------------------------------
The output of 'lspci -d 1412:1724 -nvx' is:

0000:02:06.0 0401: 1412:1724 (rev 01)
        Subsystem: 3132:4154
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at d000 [size=32]
        I/O ports at d100 [size=128]
        Capabilities: [80] Power Management version 1
00: 12 14 24 17 05 00 10 02 01 00 01 04 00 20 00 00
10: 01 d0 00 00 01 d1 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 32 31 54 41
30: 00 00 00 00 80 00 00 00 00 00 00 00 03 01 00 00

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 17:34 Demosthenes    New Issue                                    
05-06-05 17:35 Demosthenes    Distribution              => Ubuntu (Hoary
Hedgehog)
05-06-05 17:35 Demosthenes    Kernel Version            => 2.6.10          
05-06-05 22:44 ungod          Note Added: 0004597                          
05-06-05 22:48 ungod          Note Added: 0004598                          
05-07-05 01:38 Demosthenes    Note Added: 0004600                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
