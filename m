From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000851]: Ali M1535 controller, AC'97 0 does not respond
Date: Fri, 28 Jan 2005 22:40:50 +0100
Message-ID: <0bed6202862b9969f1718db09d007ff0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CC4CA1C9
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2005 22:40:50 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=851> 
======================================================================
Reported By:                omargosh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   851
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora FC3
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-27-2005 21:46 CET
Last Modified:              01-28-2005 22:40 CET
======================================================================
Summary:                    Ali M1535 controller, AC'97 0 does not respond
Description: 
My Ali5451 rev 1 based card (embedded in an Ali M1535 controller) is not
detected.

dmesg shows:

PCI: Found IRQ 9 for device 0000:00:04.0
AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0x0], removing mixer.
ali mixer creating error.
ALI 5451: probe of 0000:00:04.0 failed with error -5
======================================================================

----------------------------------------------------------------------
 omargosh - 01-28-05 22:40 
----------------------------------------------------------------------
I've been playing around with the ali5451.c code trying to see
why the codec does not respond. As a test I put a printk in
the oss/ac97_codec.c to print out what it found for vendor
id codes (below is a dmesg using the oss trident module).
Its interesting to note that the oss/trident module continues
to work even without being ablt to identify the codec id's
where-as the alsa/ali5451 module will give up. The fact that
the codec returns only 0 for it's ids may be specific only
to the M1535 chipset. I'm willing to try any suggestions to
tweak around with the code...

Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version
0.14.10j-2.6, 15:30:31 Jan 28 2005
PCI: Found IRQ 9 for device 0000:00:04.0
trident: ALi Audio Accelerator found at IO 0x1000, IRQ 9
ac97_codec: AC97  codec, id(0,0):  (Unknown)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-05 21:46 omargosh       New Issue                                    
01-27-05 21:46 omargosh       Distribution              => Fedora FC3      
01-27-05 21:46 omargosh       Kernel Version            => 2.6.10          
01-28-05 22:40 omargosh       Note Added: 0003437                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
