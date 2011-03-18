From: "Keith A. Milner" <maillist@superlative.org>
Subject: USB Quirks for Boss JS-8
Date: Fri, 18 Mar 2011 17:56:53 +0000
Message-ID: <201103181756.53155.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C8B3C103A1F
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 18:56:56 +0100 (CET)
Received: by wwj40 with SMTP id 40so4189641wwj.20
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 10:56:56 -0700 (PDT)
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

Hi,
I'm looking at developing a quirk for the Boss JS-8. The lsusb is as follows:

Bus 001 Device 003: ID 0582:0109 Roland Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol       255 
  bMaxPacketSize0        64
  idVendor           0x0582 Roland Corp.
  idProduct          0x0109 
  bcdDevice            0.01
  iManufacturer           1 BOSS
  iProduct                2 JS-8
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
      ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0070  1x 112 bytes
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
      ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0070  1x 112 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  06 24 f1 02 02 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
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
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            8 Mass Storage
  bDeviceSubClass         6 SCSI
  bDeviceProtocol        80 Bulk (Zip)
  bMaxPacketSize0        64
  bNumConfigurations      0
Device Status:     0x0001
  Self Powered

I wasn't entirely sure about the quirk syntax as the two interfaces are at EP 
4 and EP5. Does this mean I need to ignore the (non-existant) lower 
interfaces? Here's what I came up with:

{
        /* Boss JS-8 Jam Station  */
        USB_DEVICE(0x0582, 0x0109),
        .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
                /* .vendor_name = "BOSS", */
                /* .product_name = "JS-8", */
                .ifnum = QUIRK_ANY_INTERFACE,
                .type = QUIRK_COMPOSITE,
                .data = (const struct snd_usb_audio_quirk[]) {
                        {
                                .ifnum = 0,
                                .type = QUIRK_IGNORE_INTERFACE
                        },
                        {
                                .ifnum = 1,
                                .type = QUIRK_IGNORE_INTERFACE
                        },
                        {
                                .ifnum = 2,
                                .type = QUIRK_IGNORE_INTERFACE
                        },
                        {
                                .ifnum = 3,
                                .type = QUIRK_IGNORE_INTERFACE
                        },
                        {
                                .ifnum = 4,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = 5,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = -1
                        }
                }
        }
},


regards,


-- 
Keith A. Milner
