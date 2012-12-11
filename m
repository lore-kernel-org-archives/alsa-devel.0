From: Florian Beginn <the.lexxis@gmail.com>
Subject: Denon DN-X 1600 Support
Date: Tue, 11 Dec 2012 19:54:58 +0100
Message-ID: <CAFwW9qdUA54LS135_+=u6WX=o2XNaeVwPqZE0bE_WkPQGbW3Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id BEA812615D8
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 19:54:58 +0100 (CET)
Received: by mail-la0-f51.google.com with SMTP id e4so2988462lag.38
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 10:54:58 -0800 (PST)
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

i just made my first steps fiddling with the alsa-driver and got my
DN-X 1600 working. It's a dj-mixer connected via usb, offering 8
channel input/output and midi. Samplerate can be set to either 44.1,
48 or 96khz. It seems to not answer properly on samplerate requests
from snd_usb_ctl_msg() so i hardcoded it to 96khz. Regrettably, this
is a pretty ugly workaround and somehow broke midi capability,
although audio is running fine.
I'd be happy if one of you could help me work out how to do this right/better.

Find attached the patches and all information i could gather.

P.S. I'm not used to git (well, any VCS) and hope the diff format is ok for you.

--- a/sound/usb/clock.c	2012-01-25 08:56:49.000000000 +0100
+++ b/sound/usb/clock.c	2012-12-11 17:33:47.685196544 +0100
@@ -255,6 +255,14 @@
 	int err, crate;
 	int clock = snd_usb_clock_find_source(chip, fmt->clock);

+	/*
+	* Denon DN-X 1600 won't respond when asked for samplerate.
+	* Currently hardcoded to only work with 96khz
+	*/
+
+	if (chip->usb_id == USB_ID(0x154e, 0x500e) && rate == 96000)
+		return 0;
+		
 	if (clock < 0)
 		return clock;


--- a/sound/usb/format.c	2012-12-07 17:11:00.000000000 +0100
+++ b/sound/usb/format.c	2012-12-11 17:42:14.069181583 +0100
@@ -281,6 +281,21 @@
 	int nr_triplets, data_size, ret = 0;
 	int clock = snd_usb_clock_find_source(chip, fp->clock);

+	/*
+	* Denon DN-X 1600 won't respond when asked for samplerate.
+	* Currently hardcoded to only work with 96khz
+	*/
+	if (chip->usb_id == USB_ID(0x154e, 0x500e))
+	{
+		fp->nr_rates = 1;
+		fp->rate_min = 96000;
+		fp->rate_max = 96000;
+		fp->rates = SNDRV_PCM_RATE_96000;
+		fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
+		fp->rate_table[0] = 96000;
+		return 0;
+	}
+
 	if (clock < 0) {
 		snd_printk(KERN_ERR "%s(): unable to find clock source (clock %d)\n",
 				__func__, clock);


--- a/sound/usb/pcm.c	2012-01-25 08:56:49.000000000 +0100
+++ b/sound/usb/pcm.c	2012-12-11 17:57:11.579301294 +0100
@@ -198,6 +198,13 @@
 	if (!(fmt->attributes & UAC_EP_CS_ATTR_PITCH_CONTROL))
 		return 0;

+	/*
+	* Denon DN-X 1600 doesn't properly handle this -> bail out, too
+	*/
+
+	if (chip->usb_id == USB_ID(0x154e, 0x500e))
+		return 0;
+
 	switch (altsd->bInterfaceProtocol) {
 	case UAC_VERSION_1:
 	default:




cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.25.

lsusb
(...)
Bus 002 Device 003: ID 154e:500e D&M Holdings, Inc. (Denon/Marantz)

lsusb -t
(...)
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/2p, 480M
    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
        |__ Port 2: Dev 3, If 0, Class=audio, Driver=snd-usb-audio, 480M
        |__ Port 2: Dev 3, If 1, Class=audio, Driver=snd-usb-audio, 480M
        |__ Port 2: Dev 3, If 2, Class=audio, Driver=snd-usb-audio, 480M
        |__ Port 2: Dev 3, If 3, Class=audio, Driver=snd-usb-audio, 480M
        |__ Port 2: Dev 3, If 4, Class=audio, Driver=snd-usb-audio, 480M
        |__ Port 2: Dev 3, If 5, Class=HID, Driver=usbhid, 480M
(...)

lsusb -v
(...)
Bus 002 Device 003: ID 154e:500e D&M Holdings, Inc. (Denon/Marantz)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x154e D&M Holdings, Inc. (Denon/Marantz)
  idProduct          0x500e
  bcdDevice            0.01
  iManufacturer           1
  iProduct                2
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          385
    bNumInterfaces          6
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         3
      bFunctionClass        255 Vendor Specific Class
      bFunctionSubClass       0
      bFunctionProtocol      32
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32
      iInterface              0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory               0
        wTotalLength           92
        bmControl            0x01
          Latency control Control (read-only)
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID              7
        bNrChannels             8
        bmChannelConfig   0x000000ff
          Front Left (FL)
          Front Right (FR)
          Front Center (FC)
          Low Frequency Effects (LFE)
          Back Left (BL)
          Back Right (BR)
          Front Left of Center (FLC)
          Front Right of Center (FRC)
        bmControls    0x0555
          Copy Protect Control (read-only)
          Connector Control (read-only)
          Overload Control (read-only)
          Cluster Control (read-only)
          Underflow Control (read-only)
          Overflow Control (read-only)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               1
        bCSourceID              7
        bmControls         0x0155
          Copy Protect Control (read-only)
          Connector Control (read-only)
          Overload Control (read-only)
          Underflow Control (read-only)
          Overflow Control (read-only)
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bCSourceID              7
        bNrChannels             8
        bmChannelConfig   0x000000ff
          Front Left (FL)
          Front Right (FR)
          Front Center (FC)
          Low Frequency Effects (LFE)
          Back Left (BL)
          Back Right (BR)
          Front Left of Center (FLC)
          Front Right of Center (FRC)
        bmControls    0x0555
          Copy Protect Control (read-only)
          Connector Control (read-only)
          Overload Control (read-only)
          Cluster Control (read-only)
          Underflow Control (read-only)
          Overflow Control (read-only)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        bCSourceID              7
        bmControls         0x0155
          Copy Protect Control (read-only)
          Connector Control (read-only)
          Overload Control (read-only)
          Underflow Control (read-only)
          Overflow Control (read-only)
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID                5
        bmAttributes         0x02 Internal variable Clock
        bmControls           0x03
          Clock Frequency Control (read/write)
        bAssocTerminal          0
        iClockSource            0
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID                6
        bmAttributes         0x02 Internal variable Clock
        bmControls           0x03
          Clock Frequency Control (read/write)
        bAssocTerminal          0
        iClockSource            0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype     11 (CLOCK_SELECTOR)
        bUnitID                 7
        bNrInPins               2
        baCSourceID( 0)         5
        baCSourceID( 1)         6
        bmControls           0x01
          Clock Selector Control (read-only)
        iClockSelector          0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels             8
        bmChannelConfig   0x000000ff
          Front Left (FL)
          Front Right (FR)
          Front Center (FC)
          Low Frequency Effects (LFE)
          Back Left (BL)
          Back Right (BR)
          Front Left of Center (FLC)
          Front Right of Center (FRC)
        iChannelNames           0
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x15
          Pitch Control (read-only)
          Data Overrun Control (read-only)
          Data Underrun Control (read-only)
          bLockDelayUnits         1 Milliseconds
          wLockDelay              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           4
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels             8
        bmChannelConfig   0x000000ff
          Front Left (FL)
          Front Right (FR)
          Front Center (FC)
          Low Frequency Effects (LFE)
          Back Left (BL)
          Back Right (BR)
          Front Left of Center (FLC)
          Front Right of Center (FRC)
        iChannelNames           0
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x15
          Pitch Control (read-only)
          Data Overrun Control (read-only)
          Data Underrun Control (read-only)
          bLockDelayUnits         1 Milliseconds
          wLockDelay              0
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         3
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       0
      bFunctionProtocol       0
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
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
        wTotalLength            9
        bInCollection           1
        baInterfaceNr( 0)       4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
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
        wTotalLength           97
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 1
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                17
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 2
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                18
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
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                19
        bNrInputPins            1
        baSourceID( 0)         18
        BaSourcePin( 0)         1
        iJack                   0
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
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                20
        bNrInputPins            1
        baSourceID( 0)         17
        BaSourcePin( 0)         1
        iJack                   0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 6
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         2
          baAssocJackID( 0)       1
          baAssocJackID( 1)      17
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 6
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         2
          baAssocJackID( 0)       3
          baAssocJackID( 1)      19
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      34
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
