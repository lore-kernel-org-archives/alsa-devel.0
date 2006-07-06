From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002261]: No sound with hda-intel ALC883
Date: Thu, 6 Jul 2006 22:14:36 +0200
Message-ID: <bdf9c898727787d7a0823684a2153042@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EE44E263
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 22:14:36 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2261> 
======================================================================
Reported By:                lodp2
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2261
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Kubuntu Dapper
Kernel Version:             2.6.15-25
======================================================================
Date Submitted:             07-06-2006 22:14 CEST
Last Modified:              07-06-2006 22:14 CEST
======================================================================
Summary:                    No sound with hda-intel ALC883
Description: 
I'm getting no sound on internal speakers, headphone and line jacks on my
Acer Aspire 1652 Z, which has a HDA-Intel card (Realtek ALC883 (ALC882?)
chip). What DOES work is recording, both internal mic and external. I
tried all model options I found for ALC883 in ALSA-Configuration.txt
(3stack-dig, 6stck-dig, auto, no option).

I frequently checked the settings in alsamixer (using alsamixergui), tried
muting/unmuting IEC958, Front, Line. Always tested using aplay *.wav.

I would have tried the latest HG version, but I ran into problems getting
it installed: I did a "./hgcompile --with-cards=hda-intel" and "sudo make
install", which both went through fine -- only "cat /proc/asound/version"
still tells me I've got version 1.0.12rc1, compiled two days ago. I would
appreciate any pointers, as I'm relatively new to this whole business..
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-06 22:14 lodp2          New Issue                                    
07-06-06 22:14 lodp2          Distribution              => Kubuntu Dapper  
07-06-06 22:14 lodp2          Kernel Version            => 2.6.15-25       
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
