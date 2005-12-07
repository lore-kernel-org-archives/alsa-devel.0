From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001622]: ASUS A8V-MX onboard sound does not work
Date: Wed, 7 Dec 2005 11:24:17 +0100
Message-ID: <ee05b7214df37ac99a6746f86c120322@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4DB9D169
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2005 11:24:17 +0100 (MET)
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


The issue 0001557 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1622> 
======================================================================
Reported By:                m_yates
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1622
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12 (also reproduced using 2.6.15-rc2)
======================================================================
Date Submitted:             12-05-2005 18:59 CET
Last Modified:              12-06-2005 20:16 CET
======================================================================
Summary:                    ASUS A8V-MX onboard sound does not work
Description: 
Onboard sound plays for a second, then freezes on Asus A8V-MX mainboard. 
Here is sound output from lspci:

matt@duster:~$ lspci | grep Multimedia
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 70)

Here is alsa version (version that came with Ubuntu 5.10):

||/ Name           Version        Description
+++-==============-==============-============================================
ii  alsa-base      1.0.9b-4       ALSA driver configuration files

Here are the sound modules:

root@duster:/home/matt# lsmod | grep snd
snd_seq_dummy 4484 0
snd_seq_oss 32128 0
snd_seq_midi 9920 0
snd_seq_midi_event 8064 2 snd_seq_oss,snd_seq_midi
snd_seq 52032 6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_via82xx 29472 1
gameport 16392 1 snd_via82xx
snd_ac97_codec 87000 1 snd_via82xx
snd_pcm_oss 51232 0
snd_mixer_oss 17664 1 snd_pcm_oss
snd_pcm 91020 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer 24200 2 snd_seq,snd_pcm
snd_page_alloc 11408 2 snd_via82xx,snd_pcm
snd_mpu401_uart 7936 1 snd_via82xx
snd_rawmidi 27040 2 snd_seq_midi,snd_mpu401_uart
snd_seq_device 9488 5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
snd 55784 13
snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu40
1_uart,snd_rawmidi,snd_seq_device
soundcore 10912 1 snd

Asus lists the audio chip as "Realtek ALC653", alsamixer shows "Realtek
ALC655 rev 1". 
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001557 Sounds play only for a very short time ...
======================================================================

----------------------------------------------------------------------
 tiwai - 12-06-05 15:53 
----------------------------------------------------------------------
It sounds like rather a problem of interrupt routing, most likely related
with ACPI.  Try to boot with pci=noacpi or acpi=off boot option.

----------------------------------------------------------------------
 m_yates - 12-06-05 18:21 
----------------------------------------------------------------------
I tried pci=noacpi and acpi=off and still have the same problem.  I tried
searching for IRQ related information, but I'm not sure what I am looking
for.  The Asus motherboard manual is confusing, but lists IRQ for AC'97 as
"shared" under heading "C".  I'm not sure what that means.  Here is the
full output of "lspci":

0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0204
0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1204
0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2204
0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3204
0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4204
0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7204
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800
South]
0000:00:0f.0 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 07)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 90)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 90)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 90)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 90)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)
0000:00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3287
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 70)
0000:00:11.7 Host bridge: VIA Technologies, Inc.: Unknown device 287e
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 7c)
0000:00:13.0 PCI bridge: VIA Technologies, Inc.: Unknown device 287b
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: VIA Technologies, Inc.: Unknown
device 3108 (rev 01)
0000:02:00.0 PCI bridge: VIA Technologies, Inc.: Unknown device 287c
0000:02:00.1 PCI bridge: VIA Technologies, Inc.: Unknown device 287d

Here is also an IRQ related thing I noticed in "dmesg":

[   50.914237] via82xx: Assuming DXS channels with 48k fixed sample rate.
[   50.914240]          Please try dxs_support=5 option
[   50.914243]          and report if it works on your machine.
[   50.914245]          For more details, read ALSA-Configuration.txt.
[   50.914260] PCI: Via IRQ fixup for 0000:00:11.5, from 10 to 6
[   50.914404] PCI: Setting latency timer of device 0000:00:11.5 to 64


Any ideas you have would be greatly appreciated.  This post is also an
inadvertantly duplicated bug post from:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1557  I found that
after I posted.

----------------------------------------------------------------------
 m_yates - 12-06-05 20:16 
----------------------------------------------------------------------
AFter more searching, I found that the onboard sound shares IRQ 22 with the
USB 2 controller.  Here is the output of /proc/interupts:

           CPU0
  0:     242124    IO-APIC-edge  timer
  1:        612    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          0    IO-APIC-edge  rtc
 12:      27058    IO-APIC-edge  i8042
 14:      18343    IO-APIC-edge  ide0
 20:          0   IO-APIC-level  uhci_hcd:usb1
 21:          0   IO-APIC-level  uhci_hcd:usb3
 22:          8   IO-APIC-level  uhci_hcd:usb2, ehci_hcd:usb5, VIA8237
 23:        988   IO-APIC-level  uhci_hcd:usb4, eth0
NMI:        113
LOC:     242096
ERR:          0
MIS:          0

I went into BIOS and disable USB 2.  I rebooted with USB disabled and
"acpi=off".  Here is /proc/interrupts:

           CPU0
  0:      19709    IO-APIC-edge  timer
  1:         38    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          0    IO-APIC-edge  rtc
 12:       2386    IO-APIC-edge  i8042
 14:       8012    IO-APIC-edge  ide0
 20:          0   IO-APIC-level  uhci_hcd:usb1
 22:          8   IO-APIC-level  VIA8237
 23:        243   IO-APIC-level  eth0
NMI:         62
LOC:      19675
ERR:          0
MIS:          0

But I still get the same problem.  Sound plays for a second and quits.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-05 18:59 m_yates        New Issue                                    
12-05-05 18:59 m_yates        Distribution              => Ubuntu 5.10     
12-05-05 18:59 m_yates        Kernel Version            => 2.6.12 (also
reproduced using 2.6.15-rc2)
12-06-05 15:53 tiwai          Note Added: 0006926                          
12-06-05 18:21 m_yates        Note Added: 0006931                          
12-06-05 20:16 m_yates        Note Added: 0006937                          
12-07-05 01:09 Dakkus         Issue Monitored: Dakkus                      
12-07-05 11:24 perex          Relationship added       has duplicate 0001557
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
