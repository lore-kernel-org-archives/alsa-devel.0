From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002249]: intel8x0 doesn't include the
	PCI ID of my NVidia nForce 570 Sound card (it's the MCP55)
Date: Thu, 13 Jul 2006 03:03:24 +0200
Message-ID: <b9cf86de33b10842f357968f80fd6360@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8599B195
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Jul 2006 03:03:24 +0200 (MEST)
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
Last Modified:              07-13-2006 03:03 CEST
======================================================================
Summary:                    intel8x0 doesn't include the PCI ID of my NVidia
nForce 570 Sound card (it's the MCP55)
Description: 
intel8x0 doesn't include the PCI ID of my NVidia nForce 570 Sound card
(it's the MCP55)

So sound doesn't work and ALSA says I have no cards. 1 line patch makes
this all happen properly.
======================================================================

----------------------------------------------------------------------
 cardoe - 07-13-06 03:03 
----------------------------------------------------------------------
So... just kidding... This seemed to work ONCE and has not worked since. I
get the following error to dmesg...

ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/intel8x0.c:561:
codec_semaphore: semap hore is not ready [0x21][0x21212121]

That is repeated a whole lot. "alsa-driver-1.0.12_rc1-r1 includes my
patch.

Then when it decides it's going to stop repeating that I get...

ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/ac97/ac97_codec.c:1928:
AC'97 0 does not respond - RESET
ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/intel8x0.c:561:
codec_semaphore: semaphore is not ready [0x21][0x21212121]
ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/intel8x0.c:561:
codec_semaphore: semaphore is not ready [0x21][0x21212121]
ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/ac97/ac97_codec.c:1937:
AC'97 0 access is not valid [0xffffffff], removing mixer.
ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/intel8x0.c:2137:
Unable to initialize codec #0
Intel ICH: probe of 0000:00:06.1 failed with error -5

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-06 10:17 cardoe         New Issue                                    
07-01-06 10:17 cardoe         File Added: intel-nforce-mcp55.patch              
     
07-01-06 10:17 cardoe         Distribution              => gentoo          
07-01-06 10:17 cardoe         Kernel Version            => 2.6.17 w/ external
drivers 1.0.12_rc1
07-13-06 03:03 cardoe         Note Added: 0010986                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
