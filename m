From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002097]: ALC850 is 8-channel but intel8x0 only seems to support 6 channels
Date: Sat, 6 May 2006 23:55:38 +0200
Message-ID: <c84f1c954781224d95d221bc8477f909@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CFE2D177
	for <alsa-devel@alsa-project.org>; Sat,  6 May 2006 23:55:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2097> 
======================================================================
Reported By:                ellismartinp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2097
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 5
Kernel Version:             2.6.15 (2096)
======================================================================
Date Submitted:             05-05-2006 14:17 CEST
Last Modified:              05-06-2006 23:55 CEST
======================================================================
Summary:                    ALC850 is 8-channel but intel8x0 only seems to
support 6 channels
Description: 
I have on-board Nforce4 with AC97 CODEC.  This is feeding a Creative 7.1
amp & speakers via analogue.  In Windows XP I get all 8 channels and can
test them individually.

Under Linux I can get ALSA to play on 6 speakers (not the side ones) by
duplicating front to rear but I can't see any way of testing if all
individual channels work and I can't see any way of enabling the remaining
two speakers.

Help please?!

There must be millions of Nforce4 boards out there running 7.1 sound just
dying to go to Linux.
======================================================================

----------------------------------------------------------------------
 ellismartinp - 05-06-06 00:52 
----------------------------------------------------------------------
OK, so I figured out how to use speaker-test (thanks to another post here)
and have now got 5.1 surround working fine.

But I'd like to be able to use 7.1 so an 8-channel intel8x0 driver would
be very much appreciated.

** Incidentally, I tried upgrading Alsa to the 1.0.11 suite and
speaker-test started complaining of buffer issues (buffer too small) and
broken pipes when run with -Dsurround51 so I reverted to the 1.0.11rc2
currently shipping with Fedora Core 5. **

----------------------------------------------------------------------
 ellismartinp - 05-06-06 23:55 
----------------------------------------------------------------------
OK - so I got stuck in and now have a working 8-channel intel8x0 (together
with a small add-in to ac97_patch.c) - based on the 1.0.11 driver set.

speaker-test -c8 -Dsurround71
now gives me 8 channels of lovely pink noise, one by one, on the correct
speakers!

The patch for ac97 is based on a good look at the ALC850 datasheet.

The changes to intel8x0 are based on intelligent guesswork and I have no
idea what impact they might have on chipsets other than NFORCE4.  All I
can say is that they work on my Gigabyte K8N-Pro SLI (NFORCE4).

I'll put the modded files up here as soon as I've tidied them up and am
completely happy with them, together with some notes on how alsamixer
needs to be set up.

(... now, can't resist ... Woohoo!!!!! I still have the touch).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-05-06 14:17 ellismartinp   New Issue                                    
05-05-06 14:17 ellismartinp   Distribution              => Fedora Core 5   
05-05-06 14:17 ellismartinp   Kernel Version            => 2.6.15 (2096)   
05-06-06 00:52 ellismartinp   Note Added: 0009633                          
05-06-06 23:55 ellismartinp   Note Added: 0009638                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
