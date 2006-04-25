From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002071]: Driver only working partial on LG S1 notebook (+ possible resolution)
Date: Tue, 25 Apr 2006 23:18:34 +0200
Message-ID: <48d217d19cc89099c88dd54b4c3fed4c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 628C3173
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 23:18:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2071> 
======================================================================
Reported By:                Tharit
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2071
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             gentoo-sources-2.6.16-r3
======================================================================
Date Submitted:             04-25-2006 23:18 CEST
Last Modified:              04-25-2006 23:18 CEST
======================================================================
Summary:                    Driver only working partial on LG S1 notebook (+
possible resolution)
Description: 
I have an LG S1 notebook with an Intel HD Audio controller ( ACL880).
Using alsa-driver 1.0.11 I don't get sound from my internal speakers ( no
master volume control, many other mixer controls missing), but the
line-out/headphone jack works.
I've figured out that there is support for the LG M1 notebook (which has
the same specs as mine afaik), so I just replaced the "lg" model
pci_subdevice id inside alsa-kernel/pci/hda/patch_realtek.c with the one
reported by lspci.
With this modification the internal speakers work fine, are getting muted
when plugging in headphones etc... and I get all mixer controls I
expected.

I've attached the relevant output from lspci.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 23:18 Tharit         New Issue                                    
04-25-06 23:18 Tharit         Distribution              => gentoo          
04-25-06 23:18 Tharit         Kernel Version            =>
gentoo-sources-2.6.16-r3
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
