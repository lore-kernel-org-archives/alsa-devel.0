From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002107]: audigy 2 ZS SB0350 gives no
	sound
Date: Tue, 18 Jul 2006 14:23:44 +0200
Message-ID: <f46515f4977e18e639901bb0b15aef0b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D4B319A
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:23:44 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2107> 
======================================================================
Reported By:                peter_scott
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2107
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2111
======================================================================
Date Submitted:             05-08-2006 23:36 CEST
Last Modified:              07-18-2006 14:23 CEST
======================================================================
Summary:                    audigy 2 ZS SB0350 gives no sound
Description: 
I have an Audigy 2 ZS Model SB0350 card with a chip marked CA0102-ICT,
installed in a PC running Fedora Core 5 with a 2.6.16-1.2111 kernel.

The already-existing-in-the-kernel emu10k1 sound module provides no sound
for me (should it?), so I tried downloading and building emu10k1 in the
alsa-driver and installing it according to the instructions in the
"INSTALL" file in the source directory.

But (of course?) it did not work.  Well, after all, the emu10k1 is already
in the FC5 kernel.  Is there any way to get this sound card to work?

I try "system-config-soundcard" (alsaconf is not included in alsa-utils
for FC5) to test the card.

I was led to believe that Audigy 2 ZS cards generally will work on linux
systems, but I've also since read others write that not all Audigy 2 ZS
cards run the same hardware.  It's a PCI card.  I am a little suspicious
of the "CA0102-ICT" text on the chip.

Any thoughts or predictions would be most welcome.  Maybe it should have a
"ca0102" driver?
======================================================================

----------------------------------------------------------------------
 L0cKd0wN - 07-06-06 07:35 
----------------------------------------------------------------------
Im not sure if this is relevant or not, but im using FC5 kernel
2.6.17-1.2145_FC5 i686 and have lost sound from my Creative Labs Audigy 2
ZS Platinum card as well.  In earlier kernel builds (the version that was
shipped on the FC5 dvd) I had sound, but with my recent update, I have
lost it.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-06 23:36 peter_scott    New Issue                                    
05-08-06 23:36 peter_scott    Distribution              => Fedora Core 5   
05-08-06 23:36 peter_scott    Kernel Version            => 2.6.16-1.2111   
07-06-06 07:33 L0cKd0wN       Note Added: 0010854                          
07-06-06 07:34 L0cKd0wN       Issue Monitored: L0cKd0wN                    
07-06-06 07:35 L0cKd0wN       Note Edited: 0010854                         
07-18-06 14:23 jcdutton       Status                   new => assigned     
07-18-06 14:23 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
