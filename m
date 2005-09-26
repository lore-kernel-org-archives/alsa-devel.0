From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001460]: no sound on Clevo 400a
Date: Mon, 26 Sep 2005 16:02:17 +0200
Message-ID: <99562c62e4d5e2919fb19011c045afd3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8585F11D
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 16:02:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1460> 
======================================================================
Reported By:                imre
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1460
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian sid
Kernel Version:             2.6.14-rc2-git5
======================================================================
Date Submitted:             09-26-2005 16:02 CEST
Last Modified:              09-26-2005 16:02 CEST
======================================================================
Summary:                    no sound on Clevo 400a
Description: 
On my Clevo M400A the integrated soundcard doesn't work. When starting
alsa
the kernel logs the following:

hda_codec: num_steps = 0 for NID=0xb
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 20 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA sound/pci/hda/hda_intel.c:624: codec_mask = 0x3
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
hda_codec: num_steps = 0 for NID=0x8

and the last message is printed several times

Maybe this is the same issue that was reported in #1316
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-05 16:02 imre           New Issue                                    
09-26-05 16:02 imre           Distribution              => Debian sid      
09-26-05 16:02 imre           Kernel Version            => 2.6.14-rc2-git5 
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
