From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002249]: intel8x0 doesn't include the
	PCI ID of my NVidia nForce 570 Sound card (it's the MCP55)
Date: Sat, 1 Jul 2006 10:17:39 +0200
Message-ID: <4d027a5a1604e66bd34838fd11a7f644@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 05DEE24D
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 10:17:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2249> 
======================================================================
Reported By:                cardoe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2249
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.17 w/ external drivers 1.0.12_rc1
======================================================================
Date Submitted:             07-01-2006 10:17 CEST
Last Modified:              07-01-2006 10:17 CEST
======================================================================
Summary:                    intel8x0 doesn't include the PCI ID of my NVidia
nForce 570 Sound card (it's the MCP55)
Description: 
intel8x0 doesn't include the PCI ID of my NVidia nForce 570 Sound card
(it's the MCP55)

So sound doesn't work and ALSA says I have no cards. 1 line patch makes
this all happen properly.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-06 10:17 cardoe         New Issue                                    
07-01-06 10:17 cardoe         File Added: intel-nforce-mcp55.patch              
     
07-01-06 10:17 cardoe         Distribution              => gentoo          
07-01-06 10:17 cardoe         Kernel Version            => 2.6.17 w/ external
drivers 1.0.12_rc1
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
