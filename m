From: Tuukka Pasanen <pasanen.tuukka@gmail.com>
Subject: Rane SL-4 USB sound card
Date: Sat, 04 Jul 2015 12:38:54 +0300
Message-ID: <5597A9AE.2090002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 76D1C2605FA
 for <alsa-devel@alsa-project.org>; Sat,  4 Jul 2015 11:38:57 +0200 (CEST)
Received: by lagc2 with SMTP id c2so106986801lag.3
 for <alsa-devel@alsa-project.org>; Sat, 04 Jul 2015 02:38:57 -0700 (PDT)
Received: from iocaste.ilmi.fi (a91-154-252-31.elisa-laajakaista.fi.
 [91.154.252.31])
 by mx.google.com with ESMTPSA id j2sm2979481lag.10.2015.07.04.02.38.55
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 04 Jul 2015 02:38:55 -0700 (PDT)
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

Hello,
I've been hacking to get Rane SL-4 USB audio 
(http://dj.rane.com/products/sl4-for-serato-scratch-live) which have 4 
Input and 4 output channel to work with ALSA. After digging the lsusb 
and snoops I have separated endpoints for input (0x82) and output 
(0x06). They are just USB Isochronous I/O.
I have compiled kernel and tried to get USB-quirks to work with this but 
then I have to admit that even Reloop Play seems be very similar it 
doesn't do the trick (No error but card doesn't come up eather) nor 
using Ranel SL-1 approach which just shoots the error

[ 3555.009349] usb 1-5: Audio class v2 interfaces need an interface 
association
[ 3555.009373] snd-usb-audio: probe of 1-5:1.0 failed with error -5
[ 3555.009394] usb 1-5: cannot find UAC_HEADER
[ 3555.009401] snd-usb-audio: probe of 1-5:1.1 failed with error -5
[ 3555.009421] usb 1-5: cannot find UAC_HEADER
[ 3555.009427] snd-usb-audio: probe of 1-5:1.2 failed with error -5

If I need interface association how to do that? Trying to adjust mixer 
values in mixer_maps.c.

If someone have a time to give some guidance if this doable with Quirks 
or do I have to write some more specific driver? I attach lsusb below here.
HID device seems to be adjusting buffer size and 48 Khz and 96 Khz output.

Bus 001 Device 003: ID 1cc5:000f
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass       255
   bDeviceProtocol       255
   bMaxPacketSize0        64
   idVendor           0x1cc5
   idProduct          0x000f
   bcdDevice            1.00
   iManufacturer           1 Rane Corporation
   iProduct                2 Rane SL 4
   iSerial                 3 RH.01.00
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          235
     bNumInterfaces          4
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
       (Bus Powered)
     MaxPower              500mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol     32
       iInterface              4 SL 4 Audio
       ** UNRECOGNIZED:  09 24 01 00 02 0a 4b 00 00
       ** UNRECOGNIZED:  08 24 0a 05 01 01 00 00
       ** UNRECOGNIZED:  11 24 02 01 01 01 00 05 0a 00 00 00 00 05 00 00 00
       ** UNRECOGNIZED:  0c 24 03 02 02 06 00 01 05 00 00 00
       ** UNRECOGNIZED:  11 24 02 03 02 06 00 05 0a 00 00 00 00 0f 00 00 00
       ** UNRECOGNIZED:  0c 24 03 04 01 01 00 03 05 00 00 00
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      2
       bInterfaceProtocol     32
       iInterface              0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           1
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      2
       bInterfaceProtocol     32
       iInterface              0
       ** UNRECOGNIZED:  10 24 01 01 00 01 01 00 00 00 0a 00 00 00 00 05
       ** UNRECOGNIZED:  06 24 02 01 04 18
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x06  EP 6 OUT
         bmAttributes            5
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Data
         wMaxPacketSize     0x0208  1x 520 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      2
       bInterfaceProtocol     32
       iInterface              0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       1
       bNumEndpoints           1
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      2
       bInterfaceProtocol     32
       iInterface              0
       ** UNRECOGNIZED:  10 24 01 03 00 01 01 00 00 00 0a 00 00 00 00 0f
       ** UNRECOGNIZED:  06 24 02 01 04 18
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes           37
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Implicit feedback Data
         wMaxPacketSize     0x0208  1x 520 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        3
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      0 No Subclass
       bInterfaceProtocol      0 None
       iInterface              0
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.10
           bCountryCode            0 Not supported
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      28
          Report Descriptors:
            ** UNAVAILABLE **
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               1
Device Qualifier (for other device speed):
   bLength                10
   bDescriptorType         6
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass       255
   bDeviceProtocol       255
   bMaxPacketSize0        64
   bNumConfigurations      1
Device Status:     0x0000
   (Bus Powered)

Thanks you for your time and any tips would be nice.

Sincerely,
Tuukka
