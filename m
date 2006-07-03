From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002255]: The ATIIXP only supports up
	to 6 channel audio, and does not route correctly with the ALC850
Date: Mon, 3 Jul 2006 18:57:45 +0200
Message-ID: <44052a7100124b5390b15d1191d1f220@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51A96220
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Jul 2006 18:57:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2255> 
======================================================================
Reported By:                rapsure
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2255
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.17.3
======================================================================
Date Submitted:             07-03-2006 18:53 CEST
Last Modified:              07-03-2006 18:57 CEST
======================================================================
Summary:                    The ATIIXP only supports up to 6 channel audio, and
does not route correctly with the ALC850
Description: 
Because the ATIIXP driver only supports up to 6 channel audio this causes
it to not be able to route the audio correctly when the ALC850 is used for
the AC97 decoding. This is fairly bad because the audio can't be fixed
with changing the routes in the .asoundrc. It would be nice to see this
fixed.
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-03-06 18:57 
----------------------------------------------------------------------
Please describe the exact problem (steps to reproduce, actual behavior,
expected behavior, etc)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-06 18:53 rapsure        New Issue                                    
07-03-06 18:53 rapsure        Distribution              => Gentoo          
07-03-06 18:53 rapsure        Kernel Version            => 2.6.17.3        
07-03-06 18:57 rlrevell       Note Added: 0010802                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
