From: Michael Brentson <michael.brentson@gmail.com>
Subject: Microphone array (playstation eye) unsupported rates
	by driver
Date: Sun, 12 Jun 2011 15:58:22 +0300
Message-ID: <BANLkTimsv244mACyXxdXmwO_T8qhF_wpTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2BEE724408
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Jun 2011 14:58:25 +0200 (CEST)
Received: by ewy6 with SMTP id 6so1362890ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2011 05:58:22 -0700 (PDT)
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

I am trying to use the microphone array of an Playstation Eye usb device.
The problem is that the only valid sample rate seems to be 16kHz, even
though the usb device(according to the vendor's site) should support
sampling rates up to 48kHz.

I would have two questions:

1. I would like to try to modify the driver to make 48kHz as a supported
rate. Could this be dangerous for the hardware, or if I will add an
unsupported rate in the driver, the device will simply not work?

2. I'm not familiar with the "under the hood" aspects of ALSA, and I've
started reading* Writing an ALSA Driver by Takashi Iwai.* From what I can
tell, I would have to modify the snd-usb-audio driver, is this a correct
assumption?(The data on which this assumption is made is presented below)*

arecord --list-devices
**** List of CAPTURE Hardware Devices ****
.....
card 2: CameraB409241 [USB Camera-B4.09.24.1], device 0: USB Audio [USB
Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

*
lsusb -s 1:3
Bus 001 Device 003: ID 1415:2000 Nam Tai E&E Products Ltd. or OmniVision
Technologies, Inc. Sony Playstation Eye

lsusb -t
....
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/6p, 480M
    |__ Port 4: Dev 3, If 0, Class=vend., Driver=ov534, 480M
    |__ Port 4: Dev 3, If 1, Class=audio, Driver=snd-usb-audio, 480M
    |__ Port 4: Dev 3, If 2, Class=audio, Driver=snd-usb-audio, 480M



Best Regards,
Michael
