From: =?UTF-8?Q?Johan_Aires_Rast=C3=A9n?= <johan@oljud.se>
Subject: Re: CM6206 S/PDIF trouble
Date: Tue, 15 Sep 2015 11:50:47 +0200
Message-ID: <CAMFLXsCQ=Qn99kngjBD89oSxkSf7aCbG8OHqRujS85kQfaWBPQ@mail.gmail.com>
References: <CACRpkdaS2av5UjMQYKJ8Ei7jyLz1JAAb5b3-QS8a1Hi-kopzNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A242606D6
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 11:50:48 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so19286727wic.1
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 02:50:48 -0700 (PDT)
In-Reply-To: <CACRpkdaS2av5UjMQYKJ8Ei7jyLz1JAAb5b3-QS8a1Hi-kopzNg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfgang Breyha <wbreyha@gmx.net>, Eric Lammerts <alsa-devel@lists.lammerts.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I think the PCM capture source is listed among playback controls for
Asus U7 too, so this might be a non-card specific issue. Unfortunately
I don't have it nearby so I can't verify.

I couldn't get digital in/out on my U7 either, is it working for any
usb sound card?

On 12 September 2015 at 17:01, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi ALSA folks,
>
> feel like an amateur around here. Anyways, I got this
> USB sound card named "TRIXES External Sound Card USB
> 6 Channel 5.1 Audio"
>
> Looks like so:
> http://www.amazon.co.uk/External-Sound-Card-Channel-Audio/dp/B003TO3KHY/ref=lh_ni_t?ie=UTF8&psc=1&smid=A2RCXAQDK3T42M#productDetails
>
> Here is the alsa-info.sh output (yeah on a machine with
> hardwired HDA in it too, sorry):
> http://www.alsa-project.org/db/?f=f52ce9edc11918d70bc0f230f3cbd5f984bea5b5
>
> The lsusb -v output is in the end of the mail, too.
>
> This is a 0d8c:0102
> "C-Media Electronics, Inc. CM106 Like Sound Device"
> Actually, and according to the drivers on the CD that
> comes with it, this is a CM6206-based card.
>
> It seems like a nice and cheap 5.1 card actually. But I
> wanted to use the digital S/PDIF (IEC958) input/output
> and that does not work at all.
>
> It appears very nicely in the pulseaudio UI thing in GNOME,
> one output/input for analog line and S/PDIF respectively.
>
> First problem: running alsamixer -c <card> the
> "PCM Capture Source" appear in the Playback controls.
> This seems like a bug, selecting "IEC958 In" with the arrow
> keys work fine. "Line" and "Mic" work fine too.
>
> In the Capture controls, S/PDIF appears as mutable but
> without any input level setting, I guess this is normal for
> digital in.
>
> Anyways: no samples go out on the digital out and no samples
> get taken from the digital in. The endpoints are just dead.
> With an S/PDIF device listinging on the out line, it says "no signal"
> and I have tested the same equipment with the S/PDIF out
> on my HDA audio card and that works just fine.
>
> Since the CM6206 has that quirky quirk in usb/quirks.c that
> set up it's internal registers to work as expected there is
> a CM6206 datasheet on the web these days and it says
> interesting things like it needs bit 15 set in the first control
> register to use S/PDIF as master and also has to set the
> output frequency in the next three bits (etc etc) so unless
> someone is onto this already I'll just start hacking at it.
>
> Since Eric was patching this relating to S/PDIF I was under
> the impression it was working for him though?
>
> Anyways,
>
> Yours,
> Linus Walleij
>
>
> Here is lsusb -v:
>
> Bus 003 Device 004: ID 0d8c:0102 C-Media Electronics, Inc. CM106 Like
> Sound Device
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0d8c C-Media Electronics, Inc.
>   idProduct          0x0102 CM106 Like Sound Device
>   bcdDevice            0.10
>   iManufacturer           0
>   iProduct                2 USB Sound Device
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          534
>     bNumInterfaces          4
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              500mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      1 Control Device
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               1.00
>         wTotalLength          200
>         bInCollection           2
>         baInterfaceNr( 0)       1
>         baInterfaceNr( 1)       2
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             1
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bNrChannels             8
>         wChannelConfig     0x063f
>           Left Front (L)
>           Right Front (R)
>           Center Front (C)
>           Low Freqency Enhancement (LFE)
>           Left Surround (LS)
>           Right Surround (RS)
>           Side Left (SL)
>           Side Right (SR)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             4
>         wTerminalType      0x0201 Microphone
>         bAssocTerminal          0
>         bNrChannels             2
>         wChannelConfig     0x0003
>           Left Front (L)
>           Right Front (R)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 8
>         bSourceID               4
>         bControlSize            1
>         bmaControls( 0)      0x01
>           Mute Control
>         bmaControls( 1)      0x02
>           Volume Control
>         bmaControls( 2)      0x02
>           Volume Control
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 9
>         bSourceID               4
>         bControlSize            1
>         bmaControls( 0)      0x01
>           Mute Control
>         bmaControls( 1)      0x02
>           Volume Control
>         bmaControls( 2)      0x02
>           Volume Control
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                25
>         bDescriptorType        36
>         bDescriptorSubtype      4 (MIXER_UNIT)
>         bUnitID                12
>         bNrInPins               3
>         baSourceID( 0)          1
>         baSourceID( 1)          9
>         baSourceID( 2)         11
>         bNrChannels             8
>         wChannelConfig     0x063f
>           Left Front (L)
>           Right Front (R)
>           Center Front (C)
>           Low Freqency Enhancement (LFE)
>           Left Surround (LS)
>           Right Surround (RS)
>           Side Left (SL)
>           Side Right (SR)
>         iChannelNames           0
>         bmControls         0x00
>         bmControls         0x00
>         bmControls         0x00
>         iMixer                  0
>         junk at descriptor end: 00 00 00 00 00 00 00 00 00
>       AudioControl Interface Descriptor:
>         bLength                16
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                13
>         bSourceID              12
>         bControlSize            1
>         bmaControls( 0)      0x01
>           Mute Control
>         bmaControls( 1)      0x02
>           Volume Control
>         bmaControls( 2)      0x02
>           Volume Control
>         bmaControls( 3)      0x02
>           Volume Control
>         bmaControls( 4)      0x02
>           Volume Control
>         bmaControls( 5)      0x02
>           Volume Control
>         bmaControls( 6)      0x02
>           Volume Control
>         bmaControls( 7)      0x02
>           Volume Control
>         bmaControls( 8)      0x02
>           Volume Control
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             3
>         wTerminalType      0x0301 Speaker
>         bAssocTerminal          0
>         bSourceID              13
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                13
>         bDescriptorType        36
>         bDescriptorSubtype      4 (MIXER_UNIT)
>         bUnitID                17
>         bNrInPins               2
>         baSourceID( 0)          9
>         baSourceID( 1)         11
>         bNrChannels             2
>         wChannelConfig     0x0003
>           Left Front (L)
>           Right Front (R)
>         iChannelNames           0
>         bmControls         0x00
>         iMixer                  0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID            10
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bSourceID               7
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      5 (SELECTOR_UNIT)
>         bUnitID                 7
>         bNrInPins               4
>         baSource( 0)            8
>         baSource( 1)           15
>         baSource( 2)           16
>         baSource( 3)            2
>         iSelector               0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             6
>         wTerminalType      0x0603 Line Connector
>         bAssocTerminal          0
>         bNrChannels             2
>         wChannelConfig     0x0003
>           Left Front (L)
>           Right Front (R)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                15
>         bSourceID               6
>         bControlSize            1
>         bmaControls( 0)      0x01
>           Mute Control
>         bmaControls( 1)      0x02
>           Volume Control
>         bmaControls( 2)      0x02
>           Volume Control
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                11
>         bSourceID               6
>         bControlSize            1
>         bmaControls( 0)      0x01
>           Mute Control
>         bmaControls( 1)      0x02
>           Volume Control
>         bmaControls( 2)      0x02
>           Volume Control
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             5
>         wTerminalType      0x0605 SPDIF interface
>         bAssocTerminal          0
>         bNrChannels             2
>         wChannelConfig     0x0003
>           Left Front (L)
>           Right Front (R)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 2
>         bSourceID              17
>         bControlSize            1
>         bmaControls( 0)      0x01
>           Mute Control
>         bmaControls( 1)      0x02
>           Volume Control
>         bmaControls( 2)      0x02
>           Volume Control
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                16
>         bSourceID               5
>         bControlSize            1
>         bmaControls( 0)      0x01
>           Mute Control
>         bmaControls( 1)      0x00
>         bmaControls( 2)      0x00
>         iFeature                0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                14
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             8
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            2 Discrete
>         tSamFreq[ 0]        44100
>         tSamFreq[ 1]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0310  1x 784 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x01
>             Sampling Frequency
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       2
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                14
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            2 Discrete
>         tSamFreq[ 0]        44100
>         tSamFreq[ 1]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x00c4  1x 196 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x01
>             Sampling Frequency
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       3
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                14
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             4
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            2 Discrete
>         tSamFreq[ 0]        44100
>         tSamFreq[ 1]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0188  1x 392 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x01
>             Sampling Frequency
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       4
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                14
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             6
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            2 Discrete
>         tSamFreq[ 0]        44100
>         tSamFreq[ 1]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0248  1x 584 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x01
>             Sampling Frequency
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       5
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x06  EP 6 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0188  1x 392 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x01
>             Sampling Frequency
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink          10
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                14
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            2 Discrete
>         tSamFreq[ 0]        44100
>         tSamFreq[ 1]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x85  EP 5 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x00c8  1x 200 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x01
>             Sampling Frequency
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.00
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      50
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0003  1x 3 bytes
>         bInterval               1
> Device Status:     0x0000
>   (Bus Powered)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
