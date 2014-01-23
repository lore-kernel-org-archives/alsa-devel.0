From: Studio65 <studio65@gmx.de>
Subject: Kernel Patch: MOTU Micro Lite (5x5 MIDI USB Interface)
Date: Thu, 23 Jan 2014 19:32:32 +0100
Message-ID: <1390501952.5647.4.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 14C57265287
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 19:31:11 +0100 (CET)
Received: from [192.168.1.3] ([85.179.49.139]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M08ia-1VIxf82fc4-00uKWe for
 <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 19:31:10 +0100
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

Hello Alsa Team,

may I try to explain my/our problem as short as possible.

We have been truing to hack a kernel patch to get a MOTU Micro Lite (5x5
MIDI USB Interface) to run within a Debian "wheezy" with RT Kernel.

We did get the five channels appear in #qjackctl or #patchage.
we tried to receive input from #vkeybd
and get output to #gmidimonitor

while on the Hardware we connected:
MOTU Midi In 1 <--> Motu Midi Out 1
MOTU Midi In 2 <--> Motu Midi Out 2
MOTU Midi In 3 <--> Motu Midi Out 3
MOTU Midi In 4 <--> Motu Midi Out 4
MOTU Midi In 5 <--> Motu Midi Out 5

########################################################################################################################
Here is some Logs:
Output of #tail -f /var/log/messages http://pastebin.com/R6xppq7k
-----------------------------------------------------------------------
Jan  5 02:31:40 debian kernel: [24513.648043] usb 2-2: new full-speed USB device number 8 using ohci_hcd
Jan  5 02:31:40 debian kernel: [24513.869063] usb 2-2: New USB device found, idVendor=07fd, idProduct=0001
Jan  5 02:31:40 debian kernel: [24513.869068] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Jan  5 02:31:40 debian kernel: [24513.869072] usb 2-2: Product: micro lite
Jan  5 02:31:40 debian kernel: [24513.869074] usb 2-2: Manufacturer: Mark of the Unicorn
Jan  5 02:31:40 debian kernel: [24513.872194] created 16 output and 16 input ports
Jan  5 02:38:04 debian kernel: [24897.727180] usb 2-2: USB disconnect, device number 8
Jan  5 02:38:14 debian kernel: [24907.724039] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:38:24 debian kernel: [24917.724024] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:38:34 debian kernel: [24927.724032] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:38:44 debian kernel: [24937.724038] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:38:54 debian kernel: [24947.724025] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:39:04 debian kernel: [24957.724031] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:39:14 debian kernel: [24967.724026] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:39:24 debian kernel: [24977.724021] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:39:34 debian kernel: [24987.724029] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:39:44 debian kernel: [24997.724030] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:39:54 debian kernel: [25007.724034] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:40:04 debian kernel: [25017.724034] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:40:14 debian kernel: [25027.724026] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:40:24 debian kernel: [25037.724037] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:40:34 debian kernel: [25047.724041] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
Jan  5 02:40:44 debian kernel: [25057.724021] ALSA rawmidi.c:185 >rawmidi drain error (avail = 1678, buffer_size = 4096)
------------------------------------------------------------------------------------------------------------------------
########################################################################################################################

Output of #lsusb -vv http://pastebin.com/Du0N6hCa
------------------------------------------------------------------------------------------------------------------------
nathanael@debian:~$ lsusb -vv

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            3.02
  iManufacturer           3 
  iProduct                2 
  iSerial                 1 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12

Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            3.02
  iManufacturer           3 
  iProduct                2 
  iSerial                 1 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255

Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            3.02
  iManufacturer           3 
  iProduct                2 
  iSerial                 1 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12

Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            3.02
  iManufacturer           3 
  iProduct                2 
  iSerial                 1 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255

Bus 004 Device 002: ID 04b4:0033 Cypress Semiconductor Corp. Mouse
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x04b4 Cypress Semiconductor Corp.
  idProduct          0x0033 Mouse
  bcdDevice            1.00
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      61
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
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10

Bus 002 Device 009: ID 07fd:0001 Mark of the Unicorn FastLane Quad MIDI Interface
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         3 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x07fd Mark of the Unicorn
  idProduct          0x0001 FastLane Quad MIDI Interface
  bcdDevice            1.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          107
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol    255 
      iInterface              0 
      ** UNRECOGNIZED:  0b 24 01 01 05 00 02 05 00 01 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol    255 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol    255 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol    255 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol    255 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1

------------------------------------------------------------------------------------------------------------------------
########################################################################################################################


Greets, Regards and all the good stuff...
Nathanael


Studio65


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
