From: FirebUntU <info@firebuntu.com>
Subject: Re: Trouble about Roland UA-11 UA-33 UA-55 and
 snd-usb-audio module
Date: Thu, 15 Nov 2012 23:40:27 +0100
Message-ID: <50A56F5B.2090004@firebuntu.com>
References: <50A349A5.6010403@firebuntu.com> <50A34C36.7080506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BC1E265B7D
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 23:40:34 +0100 (CET)
Received: from [62.19.188.233] (port=47541 helo=[192.168.1.4])
 by n23.mail01.mtsvc.net with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
 (Exim 4.72) (envelope-from <info@firebuntu.com>) id 1TZ86q-0002Ho-6e
 for alsa-devel@alsa-project.org; Thu, 15 Nov 2012 17:40:33 -0500
In-Reply-To: <50A34C36.7080506@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Which is a wiki.
I know.

I have only the DUO-CAPTURE unit, UA-11.

Unfortunately, I can be useful  to you just for that .

So these are the lsusb output in both modes:

UA-11 in *Standard mode* (EXT switch to *)
DUO-CAPTURE 0582:012b
=========================================

Bus 003 Device 004: ID 0582:012b Roland Corp.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass          255 Vendor Specific Class
   bDeviceSubClass         0
   bDeviceProtocol       255
   bMaxPacketSize0        64
   idVendor           0x0582 Roland Corp.
   idProduct          0x012b
   bcdDevice            1.00
   iManufacturer           1 Roland
   iProduct                2 DUO-CAPTURE
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          115
     bNumInterfaces          2
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
       (Bus Powered)
     MaxPower               96mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      2
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
       ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
           Usage Type               Data
         wMaxPacketSize     0x0120  1x 288 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      2
       bInterfaceProtocol      1
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
       ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            5
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Data
         wMaxPacketSize     0x0120  1x 288 bytes
         bInterval               1
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled
