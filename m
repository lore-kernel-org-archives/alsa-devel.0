From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000865]: On this machine, sound only works if the modem driver is not loaded
Date: Mon, 31 Jan 2005 02:46:07 +0100
Message-ID: <3727e0b4482394b382ae9d63c7bb74c4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 611B31C5
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 02:46:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=865> 
======================================================================
Reported By:                hpa
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   865
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.741_FC3
======================================================================
Date Submitted:             01-31-2005 02:46 CET
Last Modified:              01-31-2005 02:46 CET
======================================================================
Summary:                    On this machine, sound only works if the modem
driver is not loaded
Description: 
On this machine, if the intel8x0 driver is loaded alone, all is well; if
the intel8x0m driver gets loaded, any attempt to use the sound card
results in no output, and messages such as:

codec_write 0: semaphore is not ready for register 0x2
codec_write 0: semaphore is not ready for register 0x4
codec_write 0: semaphore is not ready for register 0x26
codec_write 0: semaphore is not ready for register 0x26

Furthermore 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 02:46 hpa            New Issue                                    
01-31-05 02:46 hpa            Distribution              => Fedora Core 3   
01-31-05 02:46 hpa            Kernel Version            => 2.6.10-1.741_FC3
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
