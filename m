From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000790]: no sound with azx driver in Realtek integrated sound chip
Date: Tue, 22 Nov 2005 19:32:04 +0100
Message-ID: <a1a6c284eb3a97e5fa795dba9317cf58@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5AA841B4
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 19:32:04 +0100 (MET)
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


The issue 0001563 has been removed as a DUPLICATE OF the following issue.
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
has duplicate       0001582 hda_codec: Unknown model for ALC880, tr...
======================================================================

----------------------------------------------------------------------
 tiwai - 01-07-05 17:50 
----------------------------------------------------------------------
Try to pass the module option "model=3stack".  This is the configuration
for systems with 3 jacks.  There are also, 5stack, 3stack-digout,
5stack-digout and w810.

Please show the output of lspci -nv (needed for the sound entry only), and
suitable configuration for your machine.  The PCI "subsystem" IDs should
be listed in patch_realtek.c with the corresponding model.

----------------------------------------------------------------------
 theoneandonlysm - 01-08-05 02:21 
----------------------------------------------------------------------
Great! Sound output works after passing model="3stack" or "5stack"; the
5stack option matches my device.

However, even after turning all the volumes up to 100, the sound output is
relatively soft, and I can hear a faint buzz in the background.(Actually,
turning up the headphone volume has no effect, I used the "front"
control). Also, the audio port on the front of my machine does not output
any sound.

lspci -nv:
00:1b.0 Class 0403: 8086:2668 (rev 03)
        Subsystem: 103c:2a09
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at cfdb8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]

I am running in kde 3.3.2 with aRts enabled. Is there any other
information I can provide?



----------------------------------------------------------------------
 tiwai - 01-13-05 20:49 
----------------------------------------------------------------------
Maybe the connection of headphone is different from the predefined one.
Anyway I'll add your device to 5stack model as a temporary solution.

Could you check whether surround outputs and line/mic inputs work as
expected?

I'm not sure what's wrong with the volume.  Basically there are no many
volume controls for this output route...

----------------------------------------------------------------------
 theoneandonlysm - 03-20-05 21:00 
----------------------------------------------------------------------
Using drivers 1.0.9rc1 solves a lot of issues. Thanks!

Sound output is much more crisp and volume control works for "front" and
"side" controls. Also, the problem from the cvs versions causing knotify
to hang is no longer present.

However, KDE (kmix) still identifies the "main" audio control as the
headphone slider, which has no effect on changing the volume. Furthermore,
the headphone jack at the front of my computer still doesn't produce any
sound output

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
11-22-05 19:29 rlrevell       Relationship deleted     has duplicate 0001453
11-22-05 19:32 rlrevell       Relationship deleted     has duplicate 0001563
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
