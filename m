From: Gordon Dilan <gordon.dilan@gmail.com>
Subject: Re: Usb audio - unsuported sampling rates
Date: Tue, 10 Jul 2012 21:57:38 +0300
Message-ID: <CADPOxSis1apDxiFn6A6g-Rdi22sOgeMqCe+vOsDXy3odvjALAg@mail.gmail.com>
References: <CADPOxSii6AGmyBmEYkBSs24Zd7fwasutf=HxTrB0xNqo4vuhXg@mail.gmail.com>
	<4FFBD182.9040503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id AC246244AF
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 20:57:39 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so342335yhn.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2012 11:57:39 -0700 (PDT)
In-Reply-To: <4FFBD182.9040503@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Daniel,

Thank you very much for your reply !!!

Please see below.



On Tue, Jul 10, 2012 at 9:53 AM, Daniel Mack <zonque@gmail.com> wrote:

> Hi,
>
> On 10.07.2012 07:25, Gordon Dilan wrote:
> > I'm using an usb mic which(according to it's producer should support up
> to
> > 48kHz sampling rate). The problem is ALSA allows me to use only 16 kHz
> for
> > this device. I do not want to resample the data, I want to sample it at
> > 48kHz in order to be able to record some high pitch sounds 18-20kHz.
> >
> > I would want to try to do any modifications necessary in order to try
> > support 48kHz, but I'm not sure where to start.
>
> [...]
>
> > Some more information:
> > lsusb
> > Bus 001 Device 007: ID 1415:2000 Nam Tai E&E Products Ltd. or OmniVision
> > Technologies, Inc. Sony Playstation Eye
> >
> > lsusb -t
>
> Please also provide the output of 'lsusb -v'.
>

I've appended the output at the end of this mail.
Since the output is long, I've also put it on pastebin:
http://pastebin.com/tpY1thht


> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/2p, 480M
> >     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
> >         |__ Port 2: Dev 7, If 0, Class=vend., Driver=ov534, 480M
> >         |__ Port 2: Dev 7, If 1, Class=audio, Driver=snd-usb-audio, 480M
> >         |__ Port 2: Dev 7, If 2, Class=audio, Driver=snd-usb-audio, 480M
> >
> >
> > At the moment I'm looking inside ALSA's source code to try to see from
> > where this limitation of 16000kHz for my device appears, but I have to
> > admit that I'm kind of lost.
> > Any pointers on what direction should I go to try make my desired rate
> > supported would be greatly appreciated!
>
> The device is queried for its supported sample rates during probe using
> class-specific commands. If it doesn't return all rates that are
> actually supported, we need to add a quirk and override this list.
>
> The list of known sample rates is included in
> /proc/asound/card1/stream0. What does that show for you?
>
>
cat /proc/asound/card1/stream0
OmniVision Technologies, Inc. USB Camera-B4.09.24.1 at
usb-0000:00:1a.0-1.2, hi : USB Audio

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 4
    Endpoint: 4 IN (ASYNC)
    Rates: 16000
    Data packet interval: 1000 us


>
>
> Daniel
>

I mention that while trying to record using arecord I see in
/var/logs/messages: "kernel: [20914.414286] ALSA clock.c:242 current rate
177346 is different from the runtime rate 16000"
The current rate reported here varies for each call of arecord. Eg it can
be: 676371, 508390, 139882 etc. The values reported are too high to be
real.

lsusb -v

Bus 001 Device 008: ID 1415:2000 Nam Tai E&E Products Ltd. or OmniVision
Technologies, Inc. Sony Playstation Eye
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x1415 Nam Tai E&E Products Ltd. or OmniVision
Technologies, Inc.
  idProduct          0x2000 Sony Playstation Eye
  bcdDevice            2.00
  iManufacturer           1 OmniVision Technologies, Inc.
  iProduct                2 USB Camera-B4.09.24.1
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          142
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
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
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
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
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
        wTotalLength           42
        bInCollection           1
        baInterfaceNr( 0)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Microphone
        bAssocTerminal          2
        bNrChannels             4
        wChannelConfig     0x0000
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          1
        bSourceID               3
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 3
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x00
        bmaControls( 1)      0x02
          Volume Control
        bmaControls( 2)      0x02
          Volume Control
        bmaControls( 3)      0x02
          Volume Control
        bmaControls( 4)      0x02
          Volume Control
        iFeature                0
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
        bTerminalLink           2
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             4
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0300  1x 768 bytes
        bInterval               4
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
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)



Once again thank you,
Gordon
