From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001851]: No support for C-Media CMI9761 chip
Date: Tue, 2 May 2006 22:30:44 +0200
Message-ID: <1b3bd4d8f2eaf859b3f5b8fd14b3d1bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2525D185
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 22:30:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1851> 
======================================================================
Reported By:                duffymcdrew
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1851
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.12-10-386
======================================================================
Date Submitted:             02-17-2006 04:55 CET
Last Modified:              05-02-2006 22:30 CEST
======================================================================
Summary:                    No support for C-Media CMI9761 chip
Description: 
Recently installed Ubunut onto a new machine, and the sound is not working
at all.  I have an ASUS P4V8X-MX motherboard with an onboard VIA 8237 card
/ C-Media Electronics CMI9761 chip. Finally realized that ALSA soes not
support the CMI9761 chip.  Requesting a driver for this chipset.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-06 18:02 
----------------------------------------------------------------------
There is no driver for CM9761, and never be.  CM9761 is an AC97 codec chip,
not the sound core chip.  The driver you use is snd-via82xx.

Anyway, you're using too old version to debug.  Use ALSA 1.0.11.

----------------------------------------------------------------------
 nouguisa - 05-02-06 22:30 
----------------------------------------------------------------------
tiwai, I don't agree with you : look inside the
/usr/src/sound/pci/ac97/ac97_patch.c source file. At the end of the file
there is specific code for the CMI9761 chip. A driver is available on the
C-media site for windows and concerning linux it redirects the user to the
alsa site ... but it seems that no detailed information concerning the
chip configuration is made available to the community from the
manufacturer.
Regards - nouguisa

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-06 04:55 duffymcdrew    New Issue                                    
02-17-06 04:55 duffymcdrew    Distribution              => Ubuntu          
02-17-06 04:55 duffymcdrew    Kernel Version            => 2.6.12-10-386   
04-30-06 11:59 nouguisa       Note Added: 0009546                          
05-02-06 18:02 tiwai          Note Added: 0009563                          
05-02-06 22:30 nouguisa       Note Added: 0009579                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
