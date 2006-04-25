From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002069]: No sound on via SPDIF out, very low volume on analog out (MSI K8NGM2-FID with ACL880)
Date: Tue, 25 Apr 2006 20:43:18 +0200
Message-ID: <831e1457980bc3236008cdb4df11a4d2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A185612C
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 20:43:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2069> 
======================================================================
Reported By:                gtmkramer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2069
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.16-1.2069_FC4smp
======================================================================
Date Submitted:             04-25-2006 20:43 CEST
Last Modified:              04-25-2006 20:43 CEST
======================================================================
Summary:                    No sound on via SPDIF out, very low volume on analog
out (MSI K8NGM2-FID with ACL880)
Description: 
On my new MSI K8NGM2-FID motherboard with a Realtek ACL880 a get only sound
from the analog output (although the volume is very low).

The codec is not properly recognized:
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...

I've tried with various model= settings to no avail.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 20:43 gtmkramer      New Issue                                    
04-25-06 20:43 gtmkramer      File Added: codec.tar.gz                     
04-25-06 20:43 gtmkramer      Distribution              => Fedora Core 4   
04-25-06 20:43 gtmkramer      Kernel Version            => 2.6.16-1.2069_FC4smp
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
