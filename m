From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000636]: Setting volume controls to 0 does not turn off speakers completely
Date: Tue, 9 Nov 2004 09:26:07 +0100
Message-ID: <b627bb2ecdccc8fd9310af1ae3b3739d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 29F85248
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 09:26:08 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=636> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   636
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.9-rc2-mm4-VP-S7-noACPI-UMP
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-08-2004 18:41 CET
Last Modified:              11-09-2004 09:26 CET
======================================================================
Summary:                    Setting volume controls to 0 does not turn off
speakers completely
Description: 
On my Compaq R3070 laptop setting Master and Master Mono controls to 0 does
not result in no sound out. I still get audio at a low level.
======================================================================

----------------------------------------------------------------------
 Mark Knecht - 11-08-04 23:17 
----------------------------------------------------------------------
>Which ALSA version? (/proc/asound/version)

flash mark $ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15
07:17:53 2004 UTC).
Compiled on Oct  5 2004 for kernel 2.6.9-rc2-mm4-VP-S7-UMP-noACPI.
flash mark $

>Which AC'97 codec? (see alsamixer)

How to tell? The chip at the top is listed as Analog Devices AD1981B

>Does the Mute control work?

Yes, mute completely cuts the sound. Volume at 0 just makes it very quiet,
but not off.

----------------------------------------------------------------------
 Clemens Ladisch - 11-09-04 09:26 
----------------------------------------------------------------------
The AD1981B's datasheet says that the maximum attenuation is 46.5 dB (which
conforms to the AC'97 specification).
To mute, use Mute.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-04 18:41 Mark Knecht    New Issue                                    
11-08-04 18:41 Mark Knecht    Distribution              => Gentoo          
11-08-04 18:41 Mark Knecht    Kernel Version            =>
2.6.9-rc2-mm4-VP-S7-noACPI-UMP
11-08-04 19:04 Clemens LadischNote Added: 0002312                          
11-08-04 23:17 Mark Knecht    Note Added: 0002314                          
11-09-04 09:26 Clemens LadischStatus                   assigned => resolved
11-09-04 09:26 Clemens LadischResolution               open => not an issue
11-09-04 09:26 Clemens LadischNote Added: 0002316                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
