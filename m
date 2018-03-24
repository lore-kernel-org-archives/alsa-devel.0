From: "Keith A. Milner" <maillist@superlative.org>
Subject: Roland SD50 issues
Date: Sat, 24 Mar 2018 13:09:01 +0000
Message-ID: <2005387.sWoL80Yf0Y@kamdesktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3402614.p8Mv6t11HV"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id EB68A266E07
 for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2018 14:09:04 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id i189so10420391wmf.0
 for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2018 06:09:04 -0700 (PDT)
Received: from kamdesktop.localnet
 (f.5.a.d.2.f.9.c.2.0.3.4.c.3.9.e.f.a.9.2.a.0.e.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:be0a:29af:e93c:4302:c9f2:da5f])
 by smtp.gmail.com with ESMTPSA id s19sm16015464wmb.23.2018.03.24.06.09.02
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 24 Mar 2018 06:09:02 -0700 (PDT)
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

This is a multi-part message in MIME format.

--nextPart3402614.p8Mv6t11HV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

In my occasional, but ongoing, quest to try to debug some of the non-
functioning audio on newer Roland/Boss devices, I've managed to get hold of a 
Roland SD-50 to do some comparisons.

The lsusb -v and the aplay -L output for the SD-50 are attached.

This device works with jack if I use a sample rate of 44100, buffer size 256, 
3 periods/buffer. I can record and playback with no obvious issues.

However, I can't seem to get this device working directly with ALSA. If I try 
playing back via audacity, the meter bars move, but there's no audio output.

If I try aplay as follows:
aplay -Dplughw:CARD=SD50  /usr/share/sounds/alsa/Front_Center.wav

It pauses for a second as if it's playing, but I get no audio output. If I use 
the -v flag for aplay I get the following:
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit Little 
Endian, Rate 48000 Hz, Mono
Plug PCM: Rate conversion PCM (44100, sformat=S16_LE)
Converter: linear-interpolation
Protocol version: 10002
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125011
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 24000
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 6755399441055744000
Slave: Route conversion PCM (sformat=S24_3LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 22051
  period_size  : 5513
  period_time  : 125011
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5513
  period_event : 0
  start_threshold  : 16539
  stop_threshold   : 22051
  silence_threshold: 0
  silence_size : 0
  boundary     : 6206804711446675456
Slave: Hardware PCM card 2 'SD-50' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S24_3LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 24
  buffer_size  : 22051
  period_size  : 5513
  period_time  : 125011
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5513
  period_event : 0
  start_threshold  : 16539
  stop_threshold   : 22051
  silence_threshold: 0
  silence_size : 0
  boundary     : 6206804711446675456
  appl_ptr     : 0
  hw_ptr       : 0


I'm trying to work out why I'm unable to get any audio output with ALSA 
directly, whilst it happily works with Jack. Any pointers are gratefully 
received.

Cheers,

Keith



--nextPart3402614.p8Mv6t11HV
Content-Disposition: attachment; filename="SD50_lsusb.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="SD50_lsusb.txt"

Bus 003 Device 002: ID 0582:0114 Roland Corp. SD-50
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol       255 
  bMaxPacketSize0        64
  idVendor           0x0582 Roland Corp.
  idProduct          0x0114 SD-50
  bcdDevice            1.00
  iManufacturer           1 Roland
  iProduct                2 SD-50
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          167
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              480mA
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
        wMaxPacketSize     0x0140  1x 320 bytes
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
        wMaxPacketSize     0x0140  1x 320 bytes
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
      ** UNRECOGNIZED:  06 24 f1 02 03 03
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
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
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)
--nextPart3402614.p8Mv6t11HV
Content-Disposition: attachment; filename="SD50_aplay.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="SD50_aplay.txt"

 sysdefault:CARD=SD50
    SD-50, USB Audio
    Default Audio Device
front:CARD=SD50,DEV=0
    SD-50, USB Audio
    Front speakers
surround40:CARD=SD50,DEV=0
    SD-50, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=SD50,DEV=0
    SD-50, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=SD50,DEV=0
    SD-50, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=SD50,DEV=0
    SD-50, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=SD50,DEV=0
    SD-50, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=SD50,DEV=0
    SD-50, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=SD50,DEV=0
    SD-50, USB Audio
    Direct sample mixing device
dsnoop:CARD=SD50,DEV=0
    SD-50, USB Audio
    Direct sample snooping device
hw:CARD=SD50,DEV=0
    SD-50, USB Audio
    Direct hardware device without any conversions
plughw:CARD=SD50,DEV=0
    SD-50, USB Audio
    Hardware device with all software conversions
--nextPart3402614.p8Mv6t11HV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart3402614.p8Mv6t11HV--
