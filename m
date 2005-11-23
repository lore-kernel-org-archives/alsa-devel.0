From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001460]: no sound on Clevo 400a
Date: Wed, 23 Nov 2005 20:31:31 +0100
Message-ID: <0a8c3c3148ad5a300fb1f08af3641bc7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4CCAD1B4
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 20:31:31 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001563.
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
Last Modified:              11-23-2005 20:31 CET
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

----------------------------------------------------------------------
 drlizau - 10-18-05 07:52 
----------------------------------------------------------------------
'doesn't work'
alsaconf identifies card and configures it
no sound is heard whether kscd playing a cd or xmms playing an ogg file
(alsa-oss is installed) out of headphones, speakers, line out. Mute on or
off, no difference.
everything says it should work, but no sound is produced

kernel finds the device
ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link [LNKA] -> GSI 7 (level, low)
-> IRQ 7
PCI: Setting latency timer of device 0000:00:1b.0 to 64

but there is no mention of hda_codec or ALSA in the kernel log

rmmod snd_hda_intel
modprobe snd_hda_intel model=3stack

still gives no sound



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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
