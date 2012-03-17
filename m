From: David Alexander <lidxv0n@gmail.com>
Subject: trying to get an eleven rack to work
Date: Sat, 17 Mar 2012 19:17:41 -0400
Message-ID: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E5F32103F93
	for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2012 00:17:42 +0100 (CET)
Received: by iakh37 with SMTP id h37so8190201iak.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 16:17:41 -0700 (PDT)
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

Hi.

I bought and would like to get an eleven rack interface to work.  It
is a usb gutiar amp emulator/audio interface.  It is a avid/digi
device that normal uses asio vendor specific drivers.

When I plug it under Linux I get the following:

ls -l /proc/asound/card1
total 0
-r--r--r-- 1 root root 0 2012-03-17 18:57 id
-r--r--r-- 1 root root 0 2012-03-17 18:57 midi0
-r--r--r-- 1 root root 0 2012-03-17 18:57 usbbus
-r--r--r-- 1 root root 0 2012-03-17 18:57 usbid

lsusb -v for the device returns:

Bus 001 Device 003: ID 0dba:b011
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x0dba
  idProduct          0xb011
  bcdDevice           20.01
  iManufacturer           1 Digidesign
  iProduct                2 Eleven Rack
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          419
bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0
      iInterface              3 Eleven Rack DFU
      Device Firmware Upgrade Interface Descriptor:
        bLength                             7
        bDescriptorType                    33
        bmAttributes                        1
          Will Not Detach
Manifestation Intolerant
          Upload Unsupported
          Download Supported
        wDetachTimeout                   2000 milliseconds
        wTransferSize                    1032 bytes
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         1
      bInterfaceCount         4
      bFunctionClass        255 Vendor Specific Class
      bFunctionSubClass       0
      bFunctionProtocol      32
      iFunction               2 Eleven Rack
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol     32
      iInterface              2 Eleven Rack
      ** UNRECOGNIZED:  09 24 01 00 02 0a ae 00 01
      ** UNRECOGNIZED:  11 24 02 00 01 01 00 80 06 00 00 00 00 00 00 00 00
      ** UNRECOGNIZED:  0c 24 03 03 01 06 00 40 80 00 00 00
      ** UNRECOGNIZED:  11 24 02 02 01 06 00 80 08 00 00 00 00 00 00 00 00
      ** UNRECOGNIZED:  0c 24 03 01 01 01 00 41 80 00 00 00
      ** UNRECOGNIZED:  10 24 09 20 ff ff 01 00 06 00 00 00 00 00 01 00
      ** UNRECOGNIZED:  1a 24 04 40 02 20 02 06 00 00 00 00 00 00 00
00 00 0c 30 c3 0c 30 c3 00 00 00
      ** UNRECOGNIZED:  16 24 04 41 01 02 08 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
      ** UNRECOGNIZED:  0a 24 0b 80 03 81 82 83 03 00
      ** UNRECOGNIZED:  08 24 0a 81 03 03 00 00
      ** UNRECOGNIZED:  08 24 0a 82 00 05 00 00
      ** UNRECOGNIZED:  08 24 0a 83 00 05 00 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
 bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 MIDI Streaming
      bInterfaceProtocol      0
      iInterface              0
      MIDIStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           67
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 1
        iJack                   4 Rig
      MIDIStreaming Interface Descriptor:
        bLength                 6
bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 2
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                 3
        bNrInputPins            1
        baSourceID( 0)          2
        BaSourcePin( 0)         1
        iJack                   4 Rig
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                 4

bNrInputPins            1
        baSourceID( 0)          1
        BaSourcePin( 0)         1
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 5
        iJack                   5 External
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 6
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                 7
        bNrInputPins            1
        baSourceID( 0)          6
        BaSourcePin( 0)         1
        iJack                   5 External
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                 8
        bNrInputPins            1
        baSourceID( 0)          5
        BaSourcePin( 0)         1
        iJack                   0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
        MIDIStreaming Endpoint Descriptor:
          bLength                 6
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         2
          baAssocJackID( 0)       1
          baAssocJackID( 1)       5
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
        MIDIStreaming Endpoint Descriptor:
          bLength                 6
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         2
          baAssocJackID( 0)       3
          baAssocJackID( 1)       7
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol     32
      iInterface              0
    Interface Descriptor:
      bLength                 9
bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol     32
      iInterface              0
      ** UNRECOGNIZED:  10 24 01 00 00 01 01 00 00 00 06 00 00 00 00 00
      ** UNRECOGNIZED:  06 24 02 01 04 20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x01a0  1x 416 bytes
        bInterval               1
    Interface Descriptor:
bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol     32
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol     32
      iInterface              0
      ** UNRECOGNIZED:  10 24 01 01 00 01 01 00 00 00 08 00 00 00 00 00
      ** UNRECOGNIZED:  06 24 02 01 04 20
Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x01a0  1x 416 bytes
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


I am completely new to this, but if someone can point me in the right
direction...I would appreciate it,    I have just started trying to
learn about this and my limited understanding is that it would require
some additional coding in the quirks code for the snd-usb-audio
driver.   How can I determine what the quirks are?  Does there exist
any documentation or how-tos that I can look for on this?  Any help or
suggestions are appreciated.

sincerely,
David Alexander
