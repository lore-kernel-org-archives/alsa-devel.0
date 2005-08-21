From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001353]: Giga-byte GA-8I915G-MF (Rev.2) Worked with Realtek Driver
Date: Sun, 21 Aug 2005 16:37:52 +0200
Message-ID: <13d9365c850001c3acbe24c8214c6585@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 78D651F4
	for <alsa-devel@alsa-project.org>; Sun, 21 Aug 2005 16:37:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1353> 
======================================================================
Reported By:                hagi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1353
Category:                   PCI - hda-intel
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.8.12.4
======================================================================
Date Submitted:             08-21-2005 16:37 CEST
Last Modified:              08-21-2005 16:37 CEST
======================================================================
Summary:                    Giga-byte GA-8I915G-MF (Rev.2) Worked with Realtek
Driver
Description: 
I have got a new motherboard Giga-byte GA-8I915G-MF (Rev.2). Alsa knows
this board has Intel HD Audio but Realtek driver didn't seem to know this
device. I checked the subsystem vendor ID and device ID by inserting some
printk statement in hda_codec.c and hda_intel.c.

Subsystem vendor: 0x1458
Subsystem device: 0xaf12

Then I inserted the following line into alc880_cfg_tbl[]:

        { .pci_subvendor = 0x1458, .pci_subdevice = 0xaf12, .config =
ALC880_TEST },
 
This worked. Xmms player recogniezes CD and plays normally. I also found
noatun player plays MPEG-2 file normally.

As I don't have 8 ch speaker system, I am quite satisfied with this
examination.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-21-05 16:37 hagi           New Issue                                    
08-21-05 16:37 hagi           Kernel Version            => 2.6.8.12.4      
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
