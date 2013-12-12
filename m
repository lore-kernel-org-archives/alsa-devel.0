From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Subject: Volume issues: Logitech S-150 USB Digital Speaker /
 "usb_audio: Warning! Unlikely big volume range"
Date: Thu, 12 Dec 2013 02:35:29 +0100
Message-ID: <20131212013529.GE5606@Linus-Debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="b5gNqxB1S1yM7hjW"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 65E2F260376
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 02:35:33 +0100 (CET)
Received: from localhost ([89.244.72.206]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MLgZ5-1VrCAS1An5-000xIg for
 <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 02:35:33 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi!

I'm currently trying to use a Logitech S-150 USB Digital Speaker.
Unfortunately, the volume range is way off, i.e. only 1% and 2%
settings in the alsamixer are actually usable for general
playback.

dmesg:
-----
[ 9850.768093] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[ 9850.948103] usb 1-1: New USB device found, idVendor=1130, idProduct=1620
[ 9850.948123] usb 1-1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[ 9850.948138] usb 1-1: Product: USB  AUDIO
[ 9852.353857] hidraw: raw HID events driver (C) Jiri Kosina
[ 9852.397038] usb_audio: Warning! Unlikely big volume range (=17152), cval->res is probably wrong.
[ 9852.397054] usb_audio: [2] FU [PCM Playback Volume] ch = 2, val = 0/17152/1<6>[ 9852.399123] usbcore: registered new interface driver snd-usb-audio
[ 9852.412386] usbcore: registered new interface driver usbhid
[ 9852.412400] usbhid: USB HID core driver
[ 9852.562358] input: USB  AUDIO   as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.2/input/input12
[ 9852.563157] hid-generic 0003:1130:1620.0001: input,hidraw0: USB HID v1.10 Device [USB  AUDIO  ] on usb-0000:00:1d.0-1/input2
-----

lsusb -d 1130:1620 (for lsusb -vvv, see attachment)
-----
Bus 001 Device 002: ID 1130:1620 Tenx Technology, Inc.
-----

The detected vendor does not seem to match, so all in all
looks like a kernel bug?

If you need any additional information or someone testing a
kernel patch, just let me know.

Cheers, Linus


PS: My current workaround is to use more fine grained settings via
amixer.

--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=lsusb-vvv

sudo lsusb -vvv -d 1130:1620

Bus 001 Device 005: ID 1130:1620 Tenx Technology, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x1130 Tenx Technology, Inc.
  idProduct          0x1620
  bcdDevice            1.40
  iManufacturer           0
  iProduct                2 USB  AUDIO
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          135
    bNumInterfaces          3
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
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0
      iInterface              0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           40
        bInCollection           1
        baInterfaceNr( 0)       1
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x01
          Mute Control
        bmaControls( 1)      0x02
          Volume Control
        bmaControls( 2)      0x02
          Volume Control
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
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
          wDescriptorLength      31
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)
--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--b5gNqxB1S1yM7hjW--
