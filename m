From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000851]: Ali M1535 controller, AC'97 0 does not respond
Date: Thu, 27 Jan 2005 21:46:07 +0100
Message-ID: <16e7e58b808753109e22018f4768cca8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9C4B7215
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2005 21:46:07 +0100 (MET)
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
Last Modified:              01-27-2005 21:46 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-05 21:46 omargosh       New Issue                                    
01-27-05 21:46 omargosh       Distribution              => Fedora FC3      
01-27-05 21:46 omargosh       Kernel Version            => 2.6.10          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
