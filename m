From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002146]: No sound for 'SigmaTel ID 7634' Codec
Date: Tue, 23 May 2006 16:57:11 +0200
Message-ID: <b0a3a9fe33fd0156047d1d908643aba0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B81ED175
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 16:57:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2146> 
======================================================================
Reported By:                ig88b
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2146
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16-gentoo-r3
======================================================================
Date Submitted:             05-23-2006 03:17 CEST
Last Modified:              05-23-2006 16:57 CEST
======================================================================
Summary:                    No sound for 'SigmaTel ID 7634' Codec
Description: 
No sound in the same manner as
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2115

However, none of the 'model=' options work for me and this appears to be a
different (unsupported?) codec.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-23-06 15:06 
----------------------------------------------------------------------
It's really an unknown codec.

Possibly it's compatible with other STAC92xx, so try to add the
corresponding id (0x83847634) to snd_hda_preset_sigmatel[] table in
pci/hda/patch_sigmatel.c.

----------------------------------------------------------------------
 ig88b - 05-23-06 16:57 
----------------------------------------------------------------------
I tried these two lines (not at the same time):

{ .id = 0x83847634, .name = "STAC92XX", .patch = patch_stac927x },
{ .id = 0x83847634, .name = "STAC92XX", .patch = patch_stac922x },

and it gave me the following error when trying to run alsamixer after the
modules had been loaded: 

"alsamixer: function snd_mixer_load failed: Invalid argument"

Also, the following is now in dmesg

ACPI: PCI interrupt for device 0000:00:1b.0 disabled
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: num_steps = 0 for NID=0x18

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 03:17 ig88b          New Issue                                    
05-23-06 03:17 ig88b          Distribution              => Gentoo          
05-23-06 03:17 ig88b          Kernel Version            => 2.6.16-gentoo-r3
05-23-06 03:56 ig88b          Issue Monitored: ig88b                       
05-23-06 15:06 tiwai          Note Added: 0009935                          
05-23-06 16:57 ig88b          Note Added: 0009939                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
