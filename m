From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001460]: no sound on Clevo 400a
Date: Tue, 11 Oct 2005 16:33:04 +0200
Message-ID: <339afe8cdaa56eaf19b92e1ad4e0b00f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A05E139
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2005 16:33:05 +0200 (MEST)
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
Last Modified:              10-11-2005 16:33 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001429 hda_codec: Unknown model for ALC880
======================================================================

----------------------------------------------------------------------
 drlizau - 10-10-05 12:21 
----------------------------------------------------------------------
I seem to have the same trouble with the same version of this controller in
an Itbox Sonoma C240.

00:1b.0 0403 Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition 
Audio Controller 04 00 CLEVO/KAPOK Computer 5401

Running Alsa 1.0.9b on a 2.6.12 Debian machine.

tiwai seems to have access to a series of model codes which can be tried
on the modprobe line.
can you point me to a copy of this list, as i would be quite happy to try
any combination to get this operational?

----------------------------------------------------------------------
 tiwai - 10-11-05 16:33 
----------------------------------------------------------------------
First of all, please elaborate what you mean "doesn't work".

The num_steps are harmless unless you access to the corresponding node
(i.e. try to adjust CD volume).  It seems that the device has no CD and no
corresponding ADC nodes.

As you can see in the log, the BIOS is broken.  Pass model=3stack option,
for example, to specify the model to use.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-05 16:02 imre           New Issue                                    
09-26-05 16:02 imre           Distribution              => Debian sid      
09-26-05 16:02 imre           Kernel Version            => 2.6.14-rc2-git5 
09-26-05 19:14 rlrevell       Relationship added       duplicate of 0001429
10-10-05 12:21 drlizau        Note Added: 0006448                          
10-10-05 12:24 drlizau        Issue Monitored: drlizau                     
10-11-05 16:33 tiwai          Note Added: 0006453                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
