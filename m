From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002272]: bt87x does not work with
	osprey230
Date: Tue, 11 Jul 2006 15:14:31 +0200
Message-ID: <2e56cd6d81e559c250b21c5494d6f731@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39F80237
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 15:14:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2272> 
======================================================================
Reported By:                lucabe
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2272
Category:                   PCI - bt87x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             all, up to 2.6.18-rc1
======================================================================
Date Submitted:             07-11-2006 15:14 CEST
Last Modified:              07-11-2006 15:14 CEST
======================================================================
Summary:                    bt87x does not work with osprey230
Description: 
The osprey 230 card is detected, but the captured analog audio is distorted
(with kernel 2.6.18-rc1) or silence (with kernel 2.6.8).

alsamixer shows 3 inputs: "TV Tuner", "Mic/Line", and "FM", but the card
does not have any tuner or radio device

This happens on x86 systems (I tried some different P4 or celeron
machines) with the kernel provided by Debian Sarge (2.6.8), but also with
very recent kernels. I just tried with a 2.6.18-rc1 kernel compiled from
scratch.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-06 15:14 lucabe         New Issue                                    
07-11-06 15:14 lucabe         Distribution              => Debian          
07-11-06 15:14 lucabe         Kernel Version            => all, up to 2.6.18-rc1
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
