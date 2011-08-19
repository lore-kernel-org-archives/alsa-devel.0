From: Cyril Hrubis <metan.lists@gmail.com>
Subject: Re: TASCAM US-122mkII
Date: Fri, 19 Aug 2011 13:37:28 +0200
Message-ID: <20110819113727.GA9522@yumi>
References: <20110819100156.GA31665@yumi>
	<CACTFLANmONgmCtPKFpofJGQ72a5BSbZHkj5+e=yGfDrynDPrQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id EE18624647
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 13:37:26 +0200 (CEST)
Received: by fxh10 with SMTP id 10so2052390fxh.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2011 04:37:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACTFLANmONgmCtPKFpofJGQ72a5BSbZHkj5+e=yGfDrynDPrQA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > The good news is that I have 122mkII to play with, the bad news is that
> > it doesn't work with the snd_usb_122l driver.
> 
> IIRC, the 122mkII implements an entirely different USB protocol
> compared to its former version. Can you send your "lsusb -v" output?

Attached.

As far as I understand it, there are two endpoints for audio and two for
MIDI. The MIDI part seems to be initalized fine although I don't have
any MIDI device to test it.

And in the log from windows machine the audio part does some
intialization and then only buch of isochronous transfers.

-- 
Cyril Hrubis

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsusb.txt"

Bus 001 Device 005: ID 0644:8021 TEAC Corp. TASCAM US-122mkII
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0644 TEAC Corp.
  idProduct          0x8021 TASCAM US-122mkII
  bcdDevice            1.00
  iManufacturer           1 TASCAM
  iProduct                2 US-122 MKII
  iSerial                 3 no serial number
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           72
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              480mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           4
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x004e  1x 78 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x004e  1x 78 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--AqsLC8rIMeq19msA--
