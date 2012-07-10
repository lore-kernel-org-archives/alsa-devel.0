From: Gordon Dilan <gordon.dilan@gmail.com>
Subject: Usb audio - unsuported sampling rates
Date: Tue, 10 Jul 2012 08:25:31 +0300
Message-ID: <CADPOxSii6AGmyBmEYkBSs24Zd7fwasutf=HxTrB0xNqo4vuhXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 00CB7244D5
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 07:25:32 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so14901467obb.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2012 22:25:31 -0700 (PDT)
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

Hello,

I'm using an usb mic which(according to it's producer should support up to
48kHz sampling rate). The problem is ALSA allows me to use only 16 kHz for
this device. I do not want to resample the data, I want to sample it at
48kHz in order to be able to record some high pitch sounds 18-20kHz.

I would want to try to do any modifications necessary in order to try
support 48kHz, but I'm not sure where to start.

Some information:

cat /proc/asound/modules
...
 1 snd_usb_audio

arecord --list-devices
**** List of CAPTURE Hardware Devices ****
....
card 1: CameraB409241 [USB Camera-B4.09.24.1], device 0: USB Audio [USB
Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


when I try to use:  arecord -v -D hw:1,0 -f S16_LE -c 4 -r 48000 gigi.wav
I get this:

Recording WAVE 'gigi.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Channels 4
Warning: rate is not accurate (requested = 48000Hz, got = 16000Hz)
         please, try the plug plugin
Hardware PCM card 1 'USB Camera-B4.09.24.1' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 4
  rate         : 16000
  exact rate   : 16000 (16000/1)
  msbits       : 16
  buffer_size  : 8000
  period_size  : 2000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 2000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 8000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
  appl_ptr     : 0
  hw_ptr       : 0


Any sampling rate I would try higher or lower than 16kHz, I will always get
16000 kHz.

Some more information:
lsusb
Bus 001 Device 007: ID 1415:2000 Nam Tai E&E Products Ltd. or OmniVision
Technologies, Inc. Sony Playstation Eye

lsusb -t

/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/2p, 480M
    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
        |__ Port 2: Dev 7, If 0, Class=vend., Driver=ov534, 480M
        |__ Port 2: Dev 7, If 1, Class=audio, Driver=snd-usb-audio, 480M
        |__ Port 2: Dev 7, If 2, Class=audio, Driver=snd-usb-audio, 480M


At the moment I'm looking inside ALSA's source code to try to see from
where this limitation of 16000kHz for my device appears, but I have to
admit that I'm kind of lost.
Any pointers on what direction should I go to try make my desired rate
supported would be greatly appreciated!

Thank you and best regards,
Gordon
