From: Jonathan Liu <net147@gmail.com>
Subject: Re: snd-usb-audio Buffer Sizes and Round Trip Latency
Date: Tue, 23 Oct 2018 22:59:48 +1100
Message-ID: <CANwerB2wCHRz4E45uqWRVsynhzcFHNDwkHiAefoG0eJ=dCYTKQ@mail.gmail.com>
References: <5fb8650f-5a55-d895-f7b3-bc8a3b1af31b@linux.intel.com>
 <Pine.LNX.4.44L0.1810221112460.1530-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C2642675B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 14:00:04 +0200 (CEST)
Received: by mail-lf1-f67.google.com with SMTP id o21-v6so920035lfe.0
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 05:00:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1810221112460.1530-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, 23 Oct 2018 at 02:40, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 22 Oct 2018, Pierre-Louis Bossart wrote:
>
> > On 10/17/18 7:58 AM, Jonathan Liu wrote:
> > > Hi,
> > >
> > > I want to start a discussion regarding round trip latency for class
> > > compliant USB audio interfaces on Linux. In particular, I am noticing
> > > with my USB 2.0 RME Babyface Pro audio interface that the round trip
> > > latency is considerably higher on Linux than on macOS High Sierra and
> > > Windows 10.
> > >
> > > I tested the round trip latency using a loopback audio cable and the
> > > ReaInsert plugin included with Reaper DAW (www.reaper.fm) that can be
> > > downloaded for Windows/macOS/Linux to calculate the additional delay.
> > >
> > > Here are the results for 48000 Hz, 24-bit on my RME Babyface Pro:
> > > ===
> > > block_size/periods block_size*periods + additional_delay ~ round_trip_latency
> > > round_trip_latency = (block_size*periods + additional_delay) / 48000 * 1000
>
> I'm with Pierre-Louis on this; I can't make heads or tails out of these
> formulas.
>
> To begin with, I'm accustomed to talking about frames, periods, and
> buffers.  What are "block"s?  Are they the same as buffers?
>
> What do these formulas mean?  Is the first supposed to be a definition
> of round_trip_latency?  If it isn't, then how do you define or measure
> round_trip_latency?
>
> What is additional_delay?  How is it measured or calculated?

See below.

>
> > > Linux 4.17.14, Class Compliant Mode (snd-usb-audio, ALSA backend):
> > > 16/2 32 + 80 ~ 2.333 ms
>
> What are these numbers?  Are these lines supposed to in the format
> expressed by the first formula above?  If they are, how come
> "block_size/periods" shows up as a pair of numbers "16/2" but
> "block_size*periods" shows up as a single number "32"?
>

To interpret "16/2 32 + 80 ~ 2.333 ms"
Block size: 16 samples
Periods: 2 (one period for playback + one period for recording when
determining round trip latency)
The minimum round trip latency is: 16 * 2 = 32 samples
However, I measured 112 samples round trip latency which is an
additional delay of 80 samples (32 + 80 = 112).
112 samples at 48000 Hz is 112 / 48000 * 1000 is approximately 2.333
ms measured round trip latency.

> > > 16/3 48 + 109 ~ 3.271 ms
> > > 32/2 64 + 129 ~ 4.021 ms
> > > 32/3 96 + 166 ~ 5.458 ms
> > > 64/2 128 + 205 ~ 6.938 ms
> > > 64/3 192 + 242 ~ 9.042 ms
> > > 128/2 256 + 352 ~ 12.667 ms
> > > 128/3 384 + 496 ~ 18.334 ms
> > > 256/2 512 + 650 ~ 24.208 ms
> > > 256/3 768 + 650 ~ 29.542 ms
> > > 512/2 1024 + 634 ~ 34.542 ms
> > > 512/3 1536 + 634 ~ 45.208 ms
> > > 1024/2 2048 + 650 ~ 56.208 ms
> > > 1024/3 3072 + 650 ~ 77.542 ms
> > > 2048/2 4096 + 633 ~ 98.521 ms
> > > 2048/3 6144 + 633 ~ 141.188 ms
> > >
> > > macOS High Sierra, Class Compliant Mode (Apple Driver):
> > > 16/2 32 + 205 ~ 4.938 ms
> > > 32/2 64 + 205 ~ 5.604 ms
> > > 64/2 128 + 205 ~ 6.938 ms
> > > 128/2 256 + 205 ~ 9.604 ms
> > > 256/2 512 + 205 ~ 14.938 ms
> > > 512/2 1024 + 205 ~ 25.604 ms
> > > 1024/2 2048 + 205 ~ 46.938 ms
> > > 2048/2 4096 + 205 ~ 89.604 ms

>
> What are the USB parameters for these tests?  How many bytes/frame?
> What is the endpoint's maxpacket size?  What is the speed of the USB
> bus?
>

How would I determine the USB parameters and bytes/frame?

USB port is Intel USB 3.0 port. Device is USB 2.0 high speed (480 Mbps).

Here is the lsusb output:
Bus 001 Device 004: ID 2a39:3fb0
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x2a39
  idProduct          0x3fb0
  bcdDevice            0.01
  iManufacturer           1 RME
  iProduct                2 Babyface Pro (71964099)
  iSerial                 3 EF72ADBCCECA4C8
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x01a7
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         4
      bFunctionClass          1 Audio
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
        bCategory               8
        wTotalLength       0x0055
        bmControls           0x00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID                1
        bmAttributes            3 Internal programmable clock
        bmControls           0x03
          Clock Frequency Control (read/write)
        bAssocTerminal          0
        iClockSource            0
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID              1
        bNrChannels            12
        bmChannelConfig    0x00000000
        iChannelNames           0
        bmControls         0x0000
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bCSourceID              1
        bNrChannels            12
        bmChannelConfig    0x00000000
        iChannelNames           0
        bmControls         0x0000
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        bCSourceID              1
        bmControls         0x0000
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               5
        bCSourceID              1
        bmControls         0x0000
        iTerminal               0
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
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           3
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig    0x00000003
          Front Left (FL)
          Front Right (FR)
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
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0096  1x 150 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           3
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels            12
        bmChannelConfig    0x00000000
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
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0384  1x 900 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
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
        bTerminalLink           6
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels            12
        bmChannelConfig    0x00000000
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
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0384  1x 900 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           6
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig    0x00000003
          Front Left (FL)
          Front Right (FR)
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
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0096  1x 150 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 MIDI Streaming
      bInterfaceProtocol      0
      iInterface              2 Babyface Pro (71964099)
      MIDIStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength       0x0061
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                 3
        bNrInputPins            1
        baSourceID( 0)          2
        BaSourcePin( 0)         1
        iJack                   4 Port 1
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 2
        iJack                   4 Port 1
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                 7
        bNrInputPins            1
        baSourceID( 0)          6
        BaSourcePin( 0)         1
        iJack                   5 Port 2
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 6
        iJack                   5 Port 2
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 1
        iJack                   4 Port 1
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                 4
        bNrInputPins            1
        baSourceID( 0)          1
        BaSourcePin( 0)         1
        iJack                   4 Port 1
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 5
        iJack                   5 Port 2
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                 8
        bNrInputPins            1
        baSourceID( 0)          5
        BaSourcePin( 0)         1
        iJack                   5 Port 2
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 6
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         2
          baAssocJackID( 0)       1
          baAssocJackID( 1)       5
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 6
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         2
          baAssocJackID( 0)       3
          baAssocJackID( 1)       7
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      0
Device Status:     0x0e00
  (Bus Powered)

> > I couldn't figure out how to analyze your data, not sure what the extra
> > delays mean nor how you conclude that Linux is worse than MacOS or
> > Windows10 for small buffers?
> >
> > At any rate, I looked into this some time back but had to put the work
> > on the back burner due to other priorities. What I do remember is that
> > there is a built-in latency due to the fact that on playback the driver
> > submits a number of zero-filled URBs and will only add valid audio data
> > when the first URB is retired, which means you get a constant startup
> > latency you will never be able to catch up.
>
> In theory the number of zero-filled URBs could be reduced, maybe even
> eliminated.
>
> > I also vaguely remember that at some point the buffer/period sizes don't
> > matter, each period will be broken up in a series of URBs and hence you
> > will have more wake-ups than what is configured by the period size. In
> > short I would look into the way the data is spread on multiple URBs and
> > check how latency is impacted by the software design.
>
> Agreed.
>
> > the last thing I have in mind is that for latency analysis and
> > comparisons, using simple devices make sense. Latency can be affected by
> > extra processing that might be enabled in the USB device depending on
> > user configurations or parameters. Ideally to focus on the ALSA/xHCI
> > interaction/latency we'd want to look at really dumb devices with just
> > an input and output terminal and no processing.
> >
> > -Pierre
> >
> > >
> > > macOS High Sierra, PC Mode (RME Driver v3.08):
> > > 16/2 32 + 59 ~ 1.896 ms
> > > 32/2 64 + 59 ~ 2.563 ms
> > > 64/2 128 + 59 ~ 3.896 ms
> > > 128/2 256 + 59 ~ 6.563 ms
> > > 256/2 512 + 59 ~ 11.596 ms
> > > 512/2 1024 + 59 ~ 22.563 ms
> > > 1024/2 2048 + 59 ~ 43.896 ms
> > > 2048/2 4096 + 59 ~ 86.563 ms
> > >
> > > Windows 10, PC Mode (RME Driver 1.099):
> > > 48/2 96 + 63 ~ 3.313 ms
> > > 64/2 128 + 63 ~ 3.979 ms
> > > 96/2 192 + 63 ~ 5.313 ms
> > > 128/2 256 + 63 ~ 6.646 ms
> > > 256/2 512 + 63 ~ 11.979 ms
> > > 512/2 1024 + 63 ~ 22.646 ms
> > > 1024/2 2048 + 63 ~ 43.979 ms
> > > 2048/2 4096 + 63 ~ 86.646 ms
> > > ===
> > >
> > > Some things in particular I noticed on Linux:
> > > - additional_delay varies a bit if I close and open the audio device again
> > > - additional_delay seems to increase as the block_size increases. I
> > > can make the additional_delay stay about the same rather than
> > > increasing by setting MAX_PACKS and MAX_PACKS_HS to 1 in
> > > sound/usb/card.h. In Linux versions before 3.13 there was a nrpacks
> > > parameter for snd-usb-audio to control this but it was removed with
> > > commit https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v3.13&id=976b6c064a957445eb0573b270f2d0282630e9b9
> > > - additional_delay is not constant as block_size is increased like on
> > > macOS and Windows
>
> Perhaps this additional_delay is caused by the zero-filled URBs
> mentioned earlier.
>
> We can't say anything about the effect of setting MAX_PACKS to 1
> without knowing how the driver is currently fitting packets into frames
> and URBs.  In any case, you should be able to reduce the number of
> packets in each URB simply by reducing the period size, since the
> driver strives to keep each URB not much larger than a period (as I
> recall -- it's been a long time since I worked on this (2013)).
>
> > > I made a patch to snd-usb-audio to expose the snd-usb-audio constants
> > > as runtime adjustable module parameters
> > > (/sys/module/snd_usb_audio/parameters/) for testing (takes effect when
> > > the device is disconnected+reconnected and logs the parameter values
> > > to dmesg):
> > > https://aur.archlinux.org/cgit/aur.git/plain/parameters.patch?h=snd-usb-audio-lowlatency-dkms
> > >
> > > The patch is used in my Arch Linux AUR package for convenience (using
> > > DKMS to avoid having to recompile entire kernel):
> > > https://aur.archlinux.org/packages/snd-usb-audio-lowlatency-dkms/
> > >
> > > Can snd-usb-audio be improved so the additional_delay is always the
> > > same when closing/opening/reconfiguring the audio device and does not
> > > increase as the block_size increases?
> > >
> > > I noticed using USB audio on Linux at lower latencies (block_size <=
> > > 128) is more prone to audio dropouts under load compared to macOS and
> > > Windows, even with CPU power management disabled (writing 0 to
> > > /dev/cpu_dma_latency). What can be done about this?
>
> You can reduce the CPU load.  :-)
>
> Seriously, how can you compare loads between different operating
> systems?
>
> Also, note the Linux's scheduler has a number of adjustable parameters,
> which I am not familiar with.
>
> Alan Stern
>

Regards,
Jonathan
