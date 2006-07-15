From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002284]: Bad detected soundcard (ATI)
	and Mic problems
Date: Sat, 15 Jul 2006 19:10:43 +0200
Message-ID: <024f98958343b9c998bf68e5a65899b9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47127197
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 19:10:43 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2284> 
======================================================================
Reported By:                stgraber
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2284
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper Drake
Kernel Version:             2.6.17.3
======================================================================
Date Submitted:             07-15-2006 18:51 CEST
Last Modified:              07-15-2006 19:10 CEST
======================================================================
Summary:                    Bad detected soundcard (ATI) and Mic problems
Description: 
I have an ATI soundcard on my laptop.
lspci : 0403: ATI Technologies Inc: Unknown device 437b (rev 01)
lspci : 0000:00:14.2 0403: 1002:437b (rev 01)

I compiled the latest alsa-driver from NG with --with-cards=hda-intel,
when loading I got this :
hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...

And I can try with any model=, 3stack give me input control in alsamixer,
but I have an awful background noise on my MIC and also sometimes echos.

If you want more informations about my soundcard, I'm here :)

PS : Works fine on Windows of course, ...
======================================================================

----------------------------------------------------------------------
 stgraber - 07-15-06 19:10 
----------------------------------------------------------------------
Ofc, I mean HG not NG

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-15-06 18:51 stgraber       New Issue                                    
07-15-06 18:51 stgraber       Distribution              => Ubuntu Dapper Drake
07-15-06 18:51 stgraber       Kernel Version            => 2.6.17.3        
07-15-06 19:10 stgraber       Note Added: 0011025                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
