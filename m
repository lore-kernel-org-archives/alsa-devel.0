From: mikp <mikpolniak@roadrunner.com>
Subject: ATI HDMI with 780/sb700 chipset: no audio
Date: Sun, 30 Mar 2008 14:27:50 -0400
Message-ID: <20080330142750.092062f5.mikpolniak@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta10.adelphia.net (mta10.adelphia.net [68.168.78.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CC6424479
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Mar 2008 20:27:52 +0200 (CEST)
Received: from slack7.homefree.net ([76.180.122.198]) by mta10.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
	id <20080330182808.ERN10451.mta10.adelphia.net@slack7.homefree.net>
	for <alsa-devel@alsa-project.org>; Sun, 30 Mar 2008 14:28:08 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am trying to get HDMI audio from a ECS 780G mainboard with sb700 and built-in graphics Chipset: "ATI Radeon HD 3200 Graphics" (ChipID = 0x9610). The HDMI video is working with the xf86-video-ati driver.

aplay -l

**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA ATI HDMI], device 0: HDA Generic [HDA Generic]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI_1 [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

and from hwinfo:

31: PCI 14.2: 0403 Audio device
  [Created at pci.301]
  UDI: /org/freedesktop/Hal/devices/pci_1002_4383
  Unique ID: 5Dex.2J+_taPgpb9
  SysFS ID: /devices/pci0000:00/0000:00:14.2
  SysFS BusID: 0000:00:14.2
  Hardware Class: sound
  Model: "Elitegroup SBx00 Azalia"
  Vendor: pci 0x1002 "ATI Technologies Inc"
  Device: pci 0x4383 "SBx00 Azalia"
  SubVendor: pci 0x1019 "Elitegroup Computer Systems"
  SubDevice: pci 0x2816
  Driver: "HDA Intel"
  Driver Modules: "snd_hda_intel"
  Memory Range: 0xfe7f4000-0xfe7f7fff (rw,non-prefetchable)
  IRQ: 16 (13305 events)
  Module Alias: "pci:v00001002d00004383sv00001019sd00002816bc04sc03i00"
  Driver Info #0:
    Driver Status: snd_hda_intel is active
    Driver Activation Cmd: "modprobe snd_hda_intel"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

cat /proc/asound/card1/codec\#0

Codec: ATI ATI RS690/780 HDMI
Address: 0
Vendor Id: 0x1002791a
Subsystem Id: 0x791a00
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x40]: 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x0894: OUT Detect R/L
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02

running alsamixer -c1  i can unmute the IEC958, but i get no HDMI audio.
Note the "...Digital Out at Int HDMI"  _not_ SPDIF Out at Int HDMI.

In order to get the 'card1 with IEC958' to show up i had to add my pci-id to  alsa-driver-hg20080323/sound/pci/hda/hda_intel.c

  /* ATI HDMI */
    { PCI_DEVICE(0x1002, 0x4383), .driver_data = AZX_DRIVER_ATIHDMI },
        


The original hda_intel.c has

 { 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI },


Any help getting this working appreciated.  
Thanks.
