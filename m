From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 18:15:33 +0200
Message-ID: <43e8c7320802220815y332a82f4kac19999cc15fd276@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BEC97A.3030507@ladisch.de>
	<43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>
	<47BED4C2.4020501@ladisch.de>
	<43e8c7320802220619x4dfc049cv1f38a6fb8b1cb7a8@mail.gmail.com>
	<47BEDF9E.3000907@ladisch.de>
	<43e8c7320802220651r25ac78d7pecca63f3e1d48249@mail.gmail.com>
	<47BEEF4D.4050507@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 444AF2439D
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 17:15:37 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so334976tia.8
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 08:15:36 -0800 (PST)
In-Reply-To: <47BEEF4D.4050507@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

According to dmesg, the device is running at high speed:

usb 1-6: new high speed USB device using ehci_hcd and address 20
usb 1-6: configuration #1 chosen from 1 choice
usbcore: registered new interface driver snd-usb-audio

So, if I convert the freq using the high speed formula, I get a value
within the acceptable range, that would actually have an effect.

regarding the 'invalid freq' message, it seems to appear about 30
times per second:
vader:~# dmesg -c
[...play about 10 sec of audio]
vader:~# dmesg | wc -l
331
(during those 10 seconds, there were only 'invalid freq' messages generated)


vader:~# lsusb -s 1:20 -v

Bus 001 Device 020: ID 041e:3f04 Creative Technology, Ltd
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x041e Creative Technology, Ltd
  idProduct          0x3f04
  bcdDevice            1.00
  iManufacturer           1 E-MU Systems, Inc.
  iProduct                2 E-MU 0404 | USB
  iSerial                 3 E-MU-B0-3F04-07D70C0C-07E7D-STATION02
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength         1832
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                2mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         4
      bFunctionClass        255 Vendor Specific Class
      bFunctionSubClass     255 Vendor Specific Subclass
      bFunctionProtocol     255 Vendor Specific Protocol
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  0b 24 01 00 01 bf 00 03 01 02 03
      ** UNRECOGNIZED:  0c 24 02 01 01 01 00 04 33 00 00 00
      ** UNRECOGNIZED:  11 24 06 04 01 02 01 00 02 00 02 00 02 00 02 00 00
      ** UNRECOGNIZED:  0c 24 02 02 01 06 00 02 03 00 00 00
      ** UNRECOGNIZED:  0c 24 02 03 02 06 00 02 03 00 00 00
      ** UNRECOGNIZED:  0f 24 08 0e 03 e3 01 03 04 33 00 00 01 1f 00
      ** UNRECOGNIZED:  0e 24 04 0b 02 04 0e 04 33 00 00 00 00 00
      ** UNRECOGNIZED:  11 24 04 05 03 04 02 0e 04 33 00 00 00 00 00 00 00
      ** UNRECOGNIZED:  0f 24 08 0c 01 e3 01 05 04 33 00 00 01 07 00
      ** UNRECOGNIZED:  0f 24 08 0d 02 e3 01 0c 04 33 00 00 01 03 00
      ** UNRECOGNIZED:  0f 24 08 0f 04 e3 01 0d 04 33 00 00 01 07 00
      ** UNRECOGNIZED:  09 24 03 08 01 03 00 0f 00
      ** UNRECOGNIZED:  09 24 03 07 02 03 00 0f 00
      ** UNRECOGNIZED:  09 24 03 09 02 06 00 0f 00
      ** UNRECOGNIZED:  09 24 03 0a 01 01 00 0b 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0112  1x 274 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x008e  1x 142 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x012a  1x 298 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x009a  1x 154 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 88 58 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x021a  1x 538 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       6
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 88 58 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0112  1x 274 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       7
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x024a  1x 586 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       8
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x012a  1x 298 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       9
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 10 b1 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x021a  1x 538 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      10
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 00 ee 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x024a  1x 586 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      11
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0220  1x 544 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      12
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0118  1x 280 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      13
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0250  1x 592 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      14
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0130  1x 304 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      15
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 88 58 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0220  1x 544 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      16
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0250  1x 592 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      17
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 20
      ** UNRECOGNIZED:  0b 24 02 03 02 02 10 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00b8  1x 184 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      18
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 20
      ** UNRECOGNIZED:  0b 24 02 03 02 02 10 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00c8  1x 200 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0112  1x 274 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x008e  1x 142 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x012a  1x 298 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       4
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x009a  1x 154 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       5
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 88 58 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x021a  1x 538 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       6
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 88 58 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0112  1x 274 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       7
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x024a  1x 586 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       8
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x012a  1x 298 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       9
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 10 b1 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x021a  1x 538 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting      10
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 00 ee 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x024a  1x 586 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting      11
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0220  1x 544 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting      12
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0118  1x 280 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting      13
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0250  1x 592 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting      14
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0130  1x 304 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting      15
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 88 58 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0220  1x 544 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting      16
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 0a 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 03 18 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0250  1x 592 bytes
        bInterval               3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 00 01 25 00
      ** UNRECOGNIZED:  06 24 02 01 01 00
      ** UNRECOGNIZED:  06 24 02 02 02 00
      ** UNRECOGNIZED:  09 24 03 01 03 01 02 01 00
      ** UNRECOGNIZED:  09 24 03 02 04 01 01 01 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0001
  Self Powered



On Fri, Feb 22, 2008 at 5:50 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > I got these results:
>  >
>  > invalid freq 3145728
>
>  How often does this message appear?
>
>  To convert to Hz, multiply by 1000/65536 (full speed)
>  or 8000/65536 (high speed).
>
>  3145728 * 1000/65536 = 48000
>
>  > freqn=393216, freqmax=401408
>
>  These values would be correct for high speed.
>
>  Is this device running at full speed or high speed?
>  Please show the output of "lsusb -v" for this device.
>
>
>  Regards,
>  Clemens
>
