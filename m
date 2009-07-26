From: Artem Makhutov <artem@makhutov.org>
Subject: Huawei K3715 UMTS stick and alsa
Date: Mon, 27 Jul 2009 00:43:00 +0200
Message-ID: <20090726224300.GA26953@titan.makhutov-it.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bane.moelleritberatung.de (bane.moelleritberatung.de
	[77.37.2.25]) by alsa0.perex.cz (Postfix) with ESMTP id 82267103804
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jul 2009 00:43:02 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

i am wondering if it is possible to write a quirk in usbquirks.h for a Huawei
K3715 UMTS stick to make the audio interfaces available in linux.

This two interfaces are used for audio (I have sniffed in Windows):

bEndpointAddress     0x83  EP 3 IN
bEndpointAddress     0x02  EP 2 OUT

I have attached a lsusb -vv.

The payload of this interfaces is 320 bytes. Here is an example payload data.
What kind of audio could this be?

93 06 1D 01 BD F6 17 EA 94 E3 DA DB 1C E2 E1 FA 23 0C 13 0B FD 08 78 11 51 17 02 13 C4 04 F5 F2 CA EC 03 F9 5F 09 1E 15 4D 1B B2 0A B7 F5 3D EE A4 E2 62 E5 D2 FA 23 07 26 05 B2 09 6A 20 D8 22 97 0B 77 F7 3F EE C0 E8 48 E1 11 DB 55 E7 E9 05 AC 24 57 28 FF 1B D5 0E 45 07 DC 06 26 07 FE FC 17 ED C8 E0 3F D4 3D E0 8B 03 75 13 0F 04 D3 F2 FF F4 31 08 A2 09 A6 01 FF FA 14 01 49 10 D3 1A 63 25 27 1F C5 00 4C E8 15 E0 0A D8 E3 DE 53 F0 D5 F2 BD F9 F5 10 8B 26 F1 20 55 0C 3E 00 56 FA C8 F5 E8 F0 39 ED F5 F1 F7 00 66 13 7F 1A 67 0F 70 01 D1 FC 71 01 63 09 61 05 0B F7 7F EB 6E E8 CA F6 D2 07 BF 0B 75 FC 70 F0 10 F5 44 06 ED 08 0B 05 92 FE 2F FD 95 0B 40 16 05 22 A7 16 A5 FA 08 E9 52 E5 B5 D9 1F E3 F7 FB 9C 02 6E 03 EF 09 76 1C E1 19 50 06 02 F6 20 F0 8A F0 99 EE 7E E6 42 EB EF 01 AA 1C FF 20 73 14 F0
  06 D4 01 41 05 F4 07 EF 00 2E EF D8 E4 12 E2 55 F5 DE 03 C3 09 EF 04 A4 FB 93 F9 77 FE F9 03 CC 07 14 07 BF 0B CF 16 26 1A 6B 16 CC 05 CC F7 FA ED D9 E1 DA D5 

Thanks, Artem

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsusb-huawei.txt"

Bus 002 Device 005: ID 12d1:1001 Huawei Technologies Co., Ltd. E620 USB Modem
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x12d1 Huawei Technologies Co., Ltd.
  idProduct          0x1001 E620 USB Modem
  bcdDevice            0.00
  iManufacturer           2 HUAWEI Technology
  iProduct                1 HUAWEI Mobile
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          131
    bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               5
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval              32
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval              32
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval              32
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval              32
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval              32
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval              32
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--OXfL5xGRrasGEqWY--
