From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002107]: audigy 2 ZS SB0350 gives no sound
Date: Mon, 8 May 2006 23:36:41 +0200
Message-ID: <092fc69f319c5c8e930bd14f230e8869@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2B97181
	for <alsa-devel@alsa-project.org>; Mon,  8 May 2006 23:36:41 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2107> 
======================================================================
Reported By:                peter_scott
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2107
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2111
======================================================================
Date Submitted:             05-08-2006 23:36 CEST
Last Modified:              05-08-2006 23:36 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-06 23:36 peter_scott    New Issue                                    
05-08-06 23:36 peter_scott    Distribution              => Fedora Core 5   
05-08-06 23:36 peter_scott    Kernel Version            => 2.6.16-1.2111   
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
