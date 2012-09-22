From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd_usb changes broke audio
Date: Sat, 22 Sep 2012 12:22:15 +0200
Message-ID: <505D9157.6070400@gmail.com>
References: <CAMRX0_iPdK15wtn2YP4-K+GtRbe59KCeB4giqKFnROpx51bGpg@mail.gmail.com>
 <505ABA82.6040108@gmail.com>
 <CAMRX0_hpL_Z5gKoG=hjqe-c6Rn=7u4aHLikg3UVLUD0WEqub1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id ED979261613
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 12:22:19 +0200 (CEST)
Received: by bkuw5 with SMTP id w5so1720589bku.38
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 03:22:19 -0700 (PDT)
In-Reply-To: <CAMRX0_hpL_Z5gKoG=hjqe-c6Rn=7u4aHLikg3UVLUD0WEqub1A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nate Garner <nathanegarner@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(Cc: ALSA list, please don't drop it on replies!)

On 22.09.2012 10:21, Nate Garner wrote:
> output of lsusb -v (assuming you just want the sound card related part.
> if you need more let me know):

Ok, thanks - more stuff below.

> Bus 009 Device 003: ID 041e:3040 Creative Technology, Ltd SoundBlaster
> Live! 24-bit External SB0490
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x041e Creative Technology, Ltd
>   idProduct          0x3040 SoundBlaster Live! 24-bit External SB0490
>   bcdDevice            1.00
>   iManufacturer           1 Creative Technology
>   iProduct                2 SB Live! 24-bit External?
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          979
>     bNumInterfaces          3
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              308mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      1 Control Device
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               1.00
>         wTotalLength           76
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
>         bNrChannels             6
>         wChannelConfig     0x003f
>           Left Front (L)
>           Right Front (R)
>           Center Front (C)
>           Low Freqency Enhancement (LFE)
>           Left Surround (LS)
>           Right Surround (RS)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                14
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 2
>         bSourceID               1
>         bControlSize            1
>         bmaControls( 0)      0x03
>           Mute Control
>           Volume Control
>         bmaControls( 1)      0x00
>         bmaControls( 2)      0x00
>         bmaControls( 3)      0x00
>         bmaControls( 4)      0x00
>         bmaControls( 5)      0x00
>         bmaControls( 6)      0x00
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             3
>         wTerminalType      0x0301 Speaker
>         bAssocTerminal          0
>         bSourceID               2
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             4
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
>         bUnitID                 5
>         bSourceID               4
>         bControlSize            1
>         bmaControls( 0)      0x02
>           Volume Control
>         bmaControls( 1)      0x00
>         bmaControls( 2)      0x00
>         iFeature                0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             6
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bSourceID               5
>         iTerminal               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval              10
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
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        44100
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x00b4  1x 180 bytes
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
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        44100
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x010e  1x 270 bytes
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
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             4
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        44100
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0168  1x 360 bytes
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
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             4
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        44100
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x021c  1x 540 bytes
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
>         bNrChannels             6
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        44100
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x021c  1x 540 bytes
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
>       bAlternateSetting       6
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
>         bNrChannels             6
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        44100
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x032a  1x 810 bytes
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
>       bAlternateSetting       7
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
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x00c0  1x 192 bytes
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
>       bAlternateSetting       8
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
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0120  1x 288 bytes
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
>       bAlternateSetting       9
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
>         bNrChannels             4
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0180  1x 384 bytes
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
>       bAlternateSetting      10
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
>         bNrChannels             4
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0240  1x 576 bytes
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
>       bAlternateSetting      11
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
>         bNrChannels             6
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0240  1x 576 bytes
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
>       bAlternateSetting      12
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
>         bNrChannels             6
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0360  1x 864 bytes
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
>       bAlternateSetting      13
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
>         tSamFreq[ 0]        96000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0180  1x 384 bytes
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
>       bAlternateSetting      14
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
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        96000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0240  1x 576 bytes
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
>         bTerminalLink           6
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
>         tSamFreq[ 0]        44100
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x00b4  1x 180 bytes
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
>         bTerminalLink           6
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        44100
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x010e  1x 270 bytes
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
>         bTerminalLink           6
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
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
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
>       bInterfaceNumber        2
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
>         bTerminalLink           6
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0126  1x 294 bytes
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
>         bTerminalLink           6
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
>         tSamFreq[ 0]        96000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0184  1x 388 bytes
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
>       bAlternateSetting       6
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           6
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        96000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0246  1x 582 bytes
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
> Device Status:     0x0000
>   (Bus Powered)
> 
> Nothing in dmesg looks relevent. Errors.log contains:
> localhost pulseaudio[900]: [pulseaudio] bluetooth-util.c:
> org.bluez.Manager.ListAdapters() failed:
> org.freedesktop.DBus.Error.Spawn.ChildExited: Launch helper exited with
> unknown return code 1
> 
> nothing else obvious I can see.

Are you sure you there's no "not enough bandwidth" message anywhere? And
is your device connected to the host directly or via a hub?


Thanks,
Daniel



> 
> On Wed, Sep 19, 2012 at 11:41 PM, Daniel Mack <zonque@gmail.com
> <mailto:zonque@gmail.com>> wrote:
> 
>     (Cc the ALSA list - please don't drop it in replies)
> 
>     On 20.09.2012 02:16, Nate Garner wrote:
>     > I recently updated my kernel from 3.5.3 to 3.5.4. Upon rebooting, I no
>     > longer got any audio through my external sound card, but my headphones
>     > worked. I noticed in the kernel change log that you made some
>     changes to
>     > snd-usb, and thought that might be the culprit. I hope you're the
>     right
>     > person to report this too, if not, feel free to ignore.
>     > Relevant info:
>     > Distro: arch linux, x86_64
>     > sound card: creative labs model SB0490 (soundblaser Live! 24-bit
>     > external (link here
>     >
>     <http://support.creative.com/Products/ProductDetails.aspx?catID=1&subCatID=206&prodID=10702&prodName=Live!%2024-bit%20External&subCatName=Live!&CatName=Sound+Blas&VARSET=prodfaq:PRODFAQ_10702,VARSET=CategoryID:1>)
>     > alsa version 1.0.26
>     > pulseaudio version 2.1
> 
>     Argh! I believed we finally fixed all the regressions.
> 
>     Are there any messages in the logs or in dmesg that look releated? Can
>     you send the output of "lsusb -v", please?
> 
> 
>     Daniel
> 
> 
