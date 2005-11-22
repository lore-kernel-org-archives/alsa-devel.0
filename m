From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000790]: no sound with azx driver in Realtek integrated sound chip
Date: Tue, 22 Nov 2005 19:28:32 +0100
Message-ID: <13b5ce750059c9fd15fe6c4325345a62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CA0161B0
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 19:28:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=790> 
======================================================================
Reported By:                theoneandonlysm
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   790
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Slackware 10 (-current)
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-07-2005 01:38 CET
Last Modified:              11-22-2005 19:28 CET
======================================================================
Summary:                    no sound with azx driver in Realtek integrated sound
chip
Description: 
Using the CVS checkout on 01/05/05 at 8:00 EDT, I compiled the alsa drivers
with kernel 2.6.10 . Running alsaconf (provided by slackware), it was able
to detect the azx module as the correct driver and modified by
/etc/modprobe.conf as needed. Although alsamixer and kmix show all the
channels and devices for the sound chip, I get no sound output.

Dmesg states:
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA /home/sandeep/alsa_cvs/alsa-driver/pci/azx/patch_realtek.c:953:
hda_codec: Unknown model for ALC880

I'm guessing there is just something specifically not included in the
driver needed by this chip.

lsmod:
Module                  Size  Used by
snd_pcm_oss            59168  0
snd_mixer_oss          19840  1 snd_pcm_oss
snd_azx                12640  2
snd_hda_codec          46208  1 snd_azx
snd_pcm                96260  4 snd_pcm_oss,snd_azx,snd_hda_codec
snd_timer              23556  1 snd_pcm
snd                    58628  9
snd_pcm_oss,snd_mixer_oss,snd_azx,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          8452  2 snd_azx,snd_pcm

lspci:
00:00.0 Host bridge: Intel Corp.: Unknown device 2580 (rev 04)
00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2582 (rev
04)
00:02.1 Display controller: Intel Corp.: Unknown device 2782 (rev 04)
00:1b.0 Class 0403: Intel Corp.: Unknown device 2668 (rev 03)
00:1c.0 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 0 (rev
03)
00:1d.0 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03)
00:1d.1 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03)
00:1d.2 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03)
00:1d.3 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03)
00:1d.7 USB Controller: Intel Corp. I/O Controller Hub USB2 (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI
Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corp. I/O Controller Hub LPC (rev 03)
00:1f.1 IDE interface: Intel Corp. I/O Controller Hub PATA (rev 03)
00:1f.2 IDE interface: Intel Corp. I/O Controller Hub SATA cc=ide (rev
03)
00:1f.3 SMBus: Intel Corp. I/O Controller Hub SMBus (rev 03)
02:01.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
02:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001563 No Sound on Cybersystem S28 (hda_codec:...
has duplicate       0001582 hda_codec: Unknown model for ALC880, tr...
has duplicate       0001453 2.6.14-rc2 &quot;Unknown model for ALC8...
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-05 19:00 
----------------------------------------------------------------------
It's a bug of kmix.

Unmute and raise "Front" volume.

----------------------------------------------------------------------
 rlrevell - 11-22-05 19:28 
----------------------------------------------------------------------
User reports problem fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-05 01:38 theoneandonlysmNew Issue                                    
01-07-05 01:38 theoneandonlysmDistribution              => Slackware 10
(-current)
01-07-05 01:38 theoneandonlysmKernel Version            => 2.6.10          
01-07-05 17:50 tiwai          Note Added: 0003102                          
01-08-05 02:20 theoneandonlysmNote Added: 0003126                          
01-08-05 02:21 theoneandonlysmNote Edited: 0003126                         
01-13-05 20:49 tiwai          Note Added: 0003202                          
03-20-05 21:00 theoneandonlysmNote Added: 0004100                          
03-29-05 19:00 tiwai          Note Added: 0004253                          
11-22-05 19:15 rlrevell       Relationship added       has duplicate 0001563
11-22-05 19:18 rlrevell       Relationship added       has duplicate 0001582
11-22-05 19:19 rlrevell       Relationship added       has duplicate 0001453
11-22-05 19:28 rlrevell       Status                   new => resolved     
11-22-05 19:28 rlrevell       Resolution               open => fixed       
11-22-05 19:28 rlrevell       Assigned To               => rlrevell        
11-22-05 19:28 rlrevell       Note Added: 0006796                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
