From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVu?= <tronic+8nhy@trn.iki.fi>
Subject: Roland/Edirol M-16DX
Date: Thu, 24 Jul 2008 05:17:43 +0300
Message-ID: <4887E647.4050406@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jenni2.rokki.sonera.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id CC64F2435B
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 04:28:18 +0200 (CEST)
Received: from trn.iki.fi (88.195.48.158) by jenni2.rokki.sonera.fi (8.5.014)
	id 487B43600059E3AE for alsa-devel@alsa-project.org;
	Thu, 24 Jul 2008 05:28:18 +0300
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 8016F45B7F546
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 05:28:17 +0300 (EEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 05:28:17 +0300 (EEST)
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

Repost, as I got no responses to the original.

This device doesn't seem to be supported yet. Does Roland make the
specifications available, etc? The device is not compatible with USB
Audio, but rather uses Vendor Specific Class. lsusb -vvv is attached
below and if you need more information, I can debug the device on Linux
and on Vista.

Bus 007 Device 025: ID 0582:00c4 Roland Corp.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass          255 Vendor Specific Class
   bDeviceSubClass         0
   bDeviceProtocol       255
   bMaxPacketSize0        64
   idVendor           0x0582 Roland Corp.
   idProduct          0x00c4
   bcdDevice            0.00
   iManufacturer           1 EDIROL
   iProduct                2 M-16DX
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          167
     bNumInterfaces          3
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xc0
       Self Powered
     MaxPower                0mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      2
       iInterface              0
       ** UNRECOGNIZED:  06 24 f1 01 00 00
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       1
       bNumEndpoints           1
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      2
       bInterfaceProtocol      2
       iInterface              0
       ** UNRECOGNIZED:  07 24 01 01 00 01 00
       ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 80 bb 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            5
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Data
         wMaxPacketSize     0x0038  1x 56 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      2
       iInterface              0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           1
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      2
       bInterfaceProtocol      1
       iInterface              0
       ** UNRECOGNIZED:  07 24 01 07 00 01 00
       ** UNRECOGNIZED:  0b 24 02 01 12 04 18 01 80 bb 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes           37
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Implicit feedback Data
         wMaxPacketSize     0x01f8  1x 504 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      3
       iInterface              0
       ** UNRECOGNIZED:  06 24 f1 02 01 01
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x04  EP 4 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       1
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      3
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x04  EP 4 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               1
