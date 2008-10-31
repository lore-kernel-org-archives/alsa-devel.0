From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Realtek ALC268,
	Acer 4315 ?Use mic port as independent output?
Date: Fri, 31 Oct 2008 21:55:43 +1300
Message-ID: <490AC80F.7020704@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id E087F24478
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 09:57:17 +0100 (CET)
Received: from [192.168.1.100]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K9L00HVMI4VK000@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 31 Oct 2008 21:55:44 +1300 (NZDT)
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
Cc: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

Greetings,

I have acer 4315 laptop with realtek alc268 codec.
(It also has hda modem which I don't use.)

Looking at the datasheet, the codec has 2 PCM outs, but alsa hda driver
with model=acer shows only one.

I want to know if I can enable the 2nd output, and use the external mic
jack as a second line out?

I can see that PCM2/LOUT2 connects to HP-OUT (widget 0x15), while
PCM1/LOUT1 connects to several pins 0x[14,15,16,18,1A]

How do I go about testing this.  Does the hda model=test enable *every*
widget and PCM and allow change of pin direction etc?

BTW I want to use the 2nd output as the secondar  "preview" (prelisten?)
headphone output for my  audio player (pytone), while main output is
going to speakers.

TIA for any advice

--
Eliot

!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 1025:0133


!!Modprobe options (Sound related)
!!--------------------------------

snd-hda-intel: enable=1 index=0 model=acer
snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-usb-audio: index=-2
snd-usb-usx2y: index=-2
snd-usb-caiaq: index=-2
snd-cmipci: mpu_port=0x330 fm_port=0x388


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : 0,-1,-1,-1,-1,-1,-1,-1
model : acer,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC268
Address: 0
Vendor Id: 0x10ec0268
Subsystem Id: 0x10250133
Revision Id: 0x100003
No Modem Function Group found

!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC268 Analog [ALC268 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC268 Analog [ALC268 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
