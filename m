From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Status of the Tascam US-122mkII???
Date: Sat, 19 Jun 2010 20:09:56 +0200
Message-ID: <20100619180956.GL17833@buzzloop.caiaq.de>
References: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>
	<20100619174259.GJ17833@buzzloop.caiaq.de>
	<AANLkTilfDBFqGH41TGF0H855CfCm8fOjGMW7lwH1tXi_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B1F6024613
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 20:10:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilfDBFqGH41TGF0H855CfCm8fOjGMW7lwH1tXi_@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jordan johnston <triplesquarednine@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't remove any addresses from Cc:)

On Sat, Jun 19, 2010 at 01:58:02PM -0400, jordan johnston wrote:
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       bNumEndpoints           4
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0

I just wanted to know whether they switched to class compliance
interfaces, but as you can see here, that's not the case.

> you will notice it is using usb 1.1 (i unbinded the usb2, as i am told
> it doesn't work with it)

How did you do this? And you modified the driver to match this device
ID, right?

> usb 4-1: new full speed USB device using uhci_hcd and address 3
> usb 4-1: New USB device found, idVendor=0644, idProduct=8021
> usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 4-1: Product: US-122 MKII
> usb 4-1: Manufacturer: TASCAM
> usb 4-1: SerialNumber: no serial number
> ALSA sound/usb/usx2y/usb_stream.c:603: status=-2
> ALSA sound/usb/usx2y/usb_stream.c:603: status=-2
> ALSA sound/usb/usx2y/us122l.c:365: us122l_start error -14
> snd-usb-us122l: probe of 4-1:1.1 failed with error -22
> usbcore: registered new interface driver snd-usb-us122l

Sorry, I can't help here. Maybe Karsten, die author of this driver,
has any clue (put to Cc: now). Otherwise, you would need to trace the
USB traffic using TASCAM's driver for Windows or MacOSX, and then
reverse-engineer the protocol ...

HTH,
Daniel
