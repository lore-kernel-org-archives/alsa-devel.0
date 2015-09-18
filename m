From: maillist@superlative.org
Subject: Boss GT-001
Date: Fri, 18 Sep 2015 21:03:15 +0100
Message-ID: <1481883.Y22cmGKEIB@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f194.google.com (mail-wi0-f194.google.com
 [209.85.212.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 93D24265DB0
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 22:03:17 +0200 (CEST)
Received: by wicmn1 with SMTP id mn1so7913117wic.3
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 13:03:17 -0700 (PDT)
Received: from kamdesktop.localnet ([2001:8b0:be0a:29af::201])
 by smtp.gmail.com with ESMTPSA id le3sm425434wjb.25.2015.09.18.13.03.16
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 18 Sep 2015 13:03:16 -0700 (PDT)
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

I recently got access to a Boss GT-001. This is a small USB audio Interface 
for guitar with onboard FX which doesn't work with ALSA under Linux Mint 17 
(running kernel 3.16.0-38-generic).

I've not tried it with the latest ALSA development branch, but scanning the 
recent ALSA Dev archives, I can't see anything which might fix this.

# lsusb
...
Bus 001 Device 011: ID 0582:0187 Roland Corp

(detailed lsusb output is towards the bottom of this email)

The unit is moderately quirky compared to most audio devices. This unit 
includes on-board Boss guitar amp emulations and effects and the USB 
connection allows you to simultaneously record both the "wet" (with effects) 
and "dry" (without effects) signal. Thus the USB carries two separate stereo 
pairs to the computer.

 It also allows "re-amping" which allows  you to apply effects to the output 
signal. The way this seems to do this is by having two separate stereo pair 
outputs from the computer one of which is processed via the onboard effects, 
and one of which is not.

This is all just background, but the upshot of this is that the unit is a 2x 
stereo pair in, and 2x stereo pair out. However, this not only does not show 
up properly under Linux, but it will not play or record anything.

ALSA sees it thusly:
# aplay -l
...
card 4: GT001 [GT-001], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

PLaying a CD-format file:
# aplay hw:4 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:1233: Sample format not available
Available formats:
- S32_LE

# aplay hw:4 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

No audio is output

For input:
# arecord -l
card 4: GT001 [GT-001], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

The unit also supports MIDI which is used for both control of the unit itself 
via a PC editing application (editing settings, changing patches, etc.) and 
for simple DAW control. There are three USB MIDI ports for this which, on 
Windows, are labelled "GT-001", "GT-001 DAW CTRL" and "GT-001 CTRL"

On Linux these show up as follows:
# amidi -l
IO  hw:4,0,0  GT-001 MIDI 1
IO  hw:4,0,1  GT-001 MIDI 2
IO  hw:4,0,2  GT-001 MIDI 3

Any advice and pointers to get this working would be appreciated.

Dmesg output:
[17530.759008] usb 1-1: new high-speed USB device number 12 using ehci-pci
[17530.893299] usb 1-1: New USB device found, idVendor=0582, idProduct=0187
[17530.893303] usb 1-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[17530.893305] usb 1-1: Product: GT-001
[17530.893307] usb 1-1: Manufacturer: BOSS
[17530.894412] snd-usb-audio: probe of 1-1:1.0 failed with error -5
[17530.927591] usb 1-1: Unable to change format on ep #8e: already in use
[17530.927614] usb 1-1: Unable to change format on ep #8e: already in use
[17530.927764] usb 1-1: Unable to change format on ep #8e: already in use
[17530.927945] usb 1-1: Unable to change format on ep #8e: already in use
[17530.928161] usb 1-1: Unable to change format on ep #8e: already in use
[17530.928600] usb 1-1: Unable to change format on ep #8e: already in use
[17530.928620] usb 1-1: Unable to change format on ep #8e: already in use
[17530.928693] usb 1-1: Unable to change format on ep #8e: already in use
[17530.928832] usb 1-1: Unable to change format on ep #8e: already in use
[17530.928958] usb 1-1: Unable to change format on ep #8e: already in use
[17530.929350] usb 1-1: Unable to change format on ep #8e: already in use
[17530.929377] usb 1-1: Unable to change format on ep #8e: already in use
[17530.929500] usb 1-1: Unable to change format on ep #8e: already in use
[17530.929743] usb 1-1: Unable to change format on ep #8e: already in use
[17530.929988] usb 1-1: Unable to change format on ep #8e: already in use
[17530.930577] usb 1-1: Unable to change format on ep #8e: already in use
[17530.930617] usb 1-1: Unable to change format on ep #8e: already in use
[17530.930808] usb 1-1: Unable to change format on ep #8e: already in use
[17530.931064] usb 1-1: Unable to change format on ep #8e: already in use
[17530.931213] usb 1-1: Unable to change format on ep #8e: already in use
[17531.330778] usb 1-1: Unable to change format on ep #8e: already in use
[17531.334500] usb 1-1: Unable to change format on ep #8e: already in use

lsusb output:
lsusb -vv -d 0582:0187

Bus 001 Device 011: ID 0582:0187 Roland Corp. 
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol       255 
  bMaxPacketSize0        64
  idVendor           0x0582 Roland Corp.
  idProduct          0x0187 
  bcdDevice            0.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          176
    bNumInterfaces          4
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
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
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
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      2 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 04 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0d  EP 13 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0070  1x 112 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      1 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      1 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 07 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 04 04 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8e  EP 14 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0070  1x 112 bytes
        bInterval               1
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
      ** UNRECOGNIZED:  06 24 f1 02 03 03
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
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
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
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1

Cheers,

Keith
