From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001460]: no sound on Clevo 400a
Date: Thu, 24 Nov 2005 18:18:25 +0100
Message-ID: <b3910773d50025dab0763d75b9e839f4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 50FEC1C2
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 18:18:25 +0100 (MET)
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
Last Modified:              11-24-2005 18:18 CET
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
duplicate of        0001563 No Sound on Cybersystem S28 (hda_codec:...
======================================================================

----------------------------------------------------------------------
 imre - 11-23-05 21:38 
----------------------------------------------------------------------
Applied the patch in issue #1563 on 2.6.15-rc2
Some errors gone, but news accours.
alsamixer works now, but still no sound.

ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 20 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA sound/pci/hda/hda_intel.c:630: codec_mask = 0x3
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...

ALSA sound/pci/hda/hda_intel.c:1091: azx_pcm_prepare: bufsize=0x10000,
fragsize=0x1000, format=0x11
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x6,
stream=0x5, channel=0, format=0x11
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x2,
stream=0x5, channel=0, format=0x11
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x5,
stream=0x5, channel=0, format=0x11
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x3,
stream=0x5, channel=0, format=0x11
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x4,
stream=0x5, channel=0, format=0x11
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x2,
stream=0x0, channel=0, format=0x0
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x5,
stream=0x0, channel=0, format=0x0
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x3,
stream=0x0, channel=0, format=0x0
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x4,
stream=0x0, channel=0, format=0x0
ALSA sound/pci/hda/hda_codec.c:567: hda_codec_setup_stream: NID=0x6,
stream=0x0, channel=0, format=0x0

----------------------------------------------------------------------
 imre - 11-24-05 18:18 
----------------------------------------------------------------------
I recompiled my kernel with the latest alsa-cvs.
I works now. Thanks for all help.

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
10-13-05 11:43 drlizau        Note Added: 0006476                          
10-18-05 07:52 drlizau        Note Edited: 0006476                         
11-23-05 20:31 rlrevell       Relationship added       duplicate of 0001563
11-23-05 21:38 imre           Note Added: 0006835                          
11-24-05 18:18 imre           Note Added: 0006843                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
