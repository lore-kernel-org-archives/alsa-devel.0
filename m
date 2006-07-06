From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002170]: No S/PDIF controls on STAC
	9200
Date: Thu, 6 Jul 2006 19:46:53 +0200
Message-ID: <581c1962336f39405e3bedec07d919e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8339B132
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 19:46:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2170> 
======================================================================
Reported By:                mini
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2170
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-29-2006 12:34 CEST
Last Modified:              07-06-2006 19:46 CEST
======================================================================
Summary:                    No S/PDIF controls on STAC 9200
Description: 
I know this laptop (Dell XPS M1710) has S/PDIF out, but there is no ALSA
control for it in alsamixer.
======================================================================

----------------------------------------------------------------------
 mini - 07-02-06 23:54 
----------------------------------------------------------------------
Same effect with 1.0.11...

Note that this guy:

http://lkml.org/lkml/2006/3/12/16

*does* have S/PDIF at Node 0x08-0x09... and it seems my pin configs are
identical... what am I doing wrong?

----------------------------------------------------------------------
 tiwai - 07-06-06 19:46 
----------------------------------------------------------------------
The BIOS on your device disables the SPDIF output pin.  So, it's correct
that the driver doesn't activate SPDIF controls.  Possibly BIOS update
might help.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-06 12:34 mini           New Issue                                    
05-29-06 12:34 mini           Distribution              => Ubuntu Dapper   
05-29-06 12:34 mini           Kernel Version            => 2.6.15          
07-02-06 23:54 mini           Note Added: 0010795                          
07-06-06 19:46 tiwai          Note Added: 0010873                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
