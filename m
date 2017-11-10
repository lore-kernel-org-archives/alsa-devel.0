From: Luigi Tarenga <luigi.tarenga@gmail.com>
Subject: C-Media CM6533 limited sample rate
Date: Fri, 10 Nov 2017 12:20:21 +0100
Message-ID: <CAKkO-Eh96_VQpQVyMCqbBkm3tgmxB26jm7ufpBRHrA8CqyugSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 939E6266A73
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 12:20:22 +0100 (CET)
Received: by mail-ua0-f181.google.com with SMTP id j14so6549934uag.11
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 03:20:22 -0800 (PST)
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

hello everybody,
I bought on Amazon a cheap usb soundcard based on CM6533 chip.
For a amateur radio project I need a microphone able to sample at 96Khz
and from the datasheet the CM6533 can sample up to this rate.
Actually I have 2 different project, the first an echolink node that would live
happily with a sample rate of 8Khz and another of a software modem that
would work better with a sample rate of 96Khz.
Unfortunately it seems I can't set this sample rate with arecord or sox.
Actually I can only sample at 44100 or 48000 and only in stereo mode.
The datasheet say the chip support PCM at 8K/11.025K/16K/22.05K/32K/
44.1K/48K/96K Hz with 16 or 24 bit depth.
(the datasheet can be found here
https://www.cmedia.com.tw/support/download_center/25 )

with arecord the error I get is:
$  arecord -D hw:2,0 -vv -f S16_LE -c 2 -r 96000 -t raw -d 10 > /dev/null
Recording raw data 'stdin' : Signed 16 bit Little Endian, Rate 96000 Hz, Stereo
Warning: rate is not accurate (requested = 96000Hz, got = 48000Hz)
         please, try the plug plugin
Hardware PCM card 2 'USB Advanced Audio Device' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 6755399441055744000
  appl_ptr     : 0
  hw_ptr       : 0
#+                                                 | 00%^CAborted by
signal Interrupt...

same error if I try 8000 Hz. note that another problem is that I have
to use 2 channel for sampling while I would prefer to sample in mono
since I would have to convert it anyway with an alsa plugin or in
userspace and waste some cpu cicle. If I try to sample in mono:

$  arecord -D hw:2,0 -vv -f S16_LE -c 1 -r 8000 -t raw -d 10 > /dev/null
Recording raw data 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
arecord: set_params:1324: Channels count non available


my software version:
$ uname -a
Linux bullet 4.13.11-1-ARCH #1 SMP PREEMPT Thu Nov 2 10:25:56 CET 2017
x86_64 GNU/Linux

$ pacman -Q|grep alsa
alsa-lib 1.1.4.1-2
alsa-tools 1.1.3-1
alsa-utils 1.1.4-1
zita-alsa-pcmi 0.2.0-3


lsusb give this output:

lsusb -v -d 0d8c:0024

Bus 003 Device 007: ID 0d8c:0024 C-Media Electronics, Inc.
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        16
  idVendor           0x0d8c C-Media Electronics, Inc.
  idProduct          0x0024
  bcdDevice            1.11
  iManufacturer           1
  iProduct                2
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          393
    bNumInterfaces          4
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
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0
      iInterface              0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           95
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
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
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               5
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               6
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 5
        bSourceID               8
        bControlSize            1
        bmaControls( 0)      0x01
          Mute Control
        bmaControls( 1)      0x02
          Volume Control
        bmaControls( 2)      0x02
          Volume Control
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID               2
        bControlSize            1
        bmaControls( 0)      0x01
          Mute Control
        bmaControls( 1)      0x02
          Volume Control
        bmaControls( 2)      0x02
          Volume Control
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 7
        bSourceID               2
        bControlSize            1
        bmaControls( 0)      0x01
          Mute Control
        bmaControls( 1)      0x02
          Volume Control
        bmaControls( 2)      0x02
          Volume Control
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 8
        bNrInPins               2
        baSourceID( 0)          1
        baSourceID( 1)          7
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        bmControls         0x00
        iMixer                  0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x89  EP 9 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               4
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
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        44100
        tSamFreq[ 1]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x00c4  1x 196 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
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
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        44100
        tSamFreq[ 1]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0126  1x 294 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
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
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        88200
        tSamFreq[ 1]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0184  1x 388 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
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
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        88200
        tSamFreq[ 1]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0246  1x 582 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
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
        bTerminalLink           4
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        44100
        tSamFreq[ 1]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x00c4  1x 196 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      77
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval              32


>From the output it seems it's reported support for only 44.1Khz or 48Khz.

I'm trying to find out what could be the problem, is the snd_usb_audio
driver that
stick with a safe defaults? is the firmware on the chip that limit the hardware
capabilities and when queried by the driver it report only 2 sample rates?
The datasheet make few example of usb audio topology configured via
firmware so maybe there is a configuration (actually undocumented)
that limit the
microphone sampe rate to only those 2 (just guessing).
Reading the driver source (snd_usb_audio) I undestand that there are some quirks
to customize the capabilities of different usb audio card, do you
think adding a quirk
for this chip and trying to overcome the firmware configuration and
adding support
for other sample rate can be a solution? If someone could help me going on track
to modify the source I can try to prepare a patch to add quirks for this chip or
if someone is interested in investigating into the problem I can
sponsor a soundcard
for testing and debugging (I'ts not much I know, very few dollars).
If the firmware is the culprit of the problem does anyone know if
there is alternative
firmware available and the eeprom is still writeable after the OEM
have wrote on it?

many thanks
Luigi
