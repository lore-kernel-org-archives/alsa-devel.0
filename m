From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: Mixer regression with usb soundcard
Date: Mon, 18 Dec 2017 14:44:44 +0100
Message-ID: <20171218134444.GA18133@kroah.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 17, 2017 at 06:56:05PM +0000, Mauro Santos wrote:
> I believe this is the right place to report this problem, but if it
> isn't please point me in the right direction.

Adding the developer of that patch, and the sound maintainer and
developers to the thread.

> I have noticed that after the update from kernel 4.14.5 to 4.14.6
> alsamixer does not show the usual volume controls for my usb soundcard.
> 
> Reverting 3884d12e17ab770aa0f5d4bc65bfbfd006f417fa ALSA: usb-audio: Add
> check return value for usb_string() (from linux-stable) makes the
> controls come back again with kernel 4.14.6.
> 
> Amixer shows a difference between the good and bad case.
> 
> Good amixer output (4.14.5):
> Simple mixer control 'PCM',0
>   Capabilities: pvolume pswitch pswitch-joined
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 110
>   Mono:
>   Front Left: Playback 0 [0%] [-55.00dB] [on]
>   Front Right: Playback 0 [0%] [-55.00dB] [on]
> Simple mixer control 'PCM Capture Source',0
>   Capabilities: enum
>   Items: 'Line' 'IEC958 In'
>   Item0: 'Line'
> Simple mixer control 'Line',0
>   Capabilities: cvolume cswitch cswitch-joined
>   Capture channels: Front Left - Front Right
>   Limits: Capture 0 - 104
>   Front Left: Capture 20 [19%] [-30.00dB] [off]
>   Front Right: Capture 20 [19%] [-30.00dB] [off]
> 
> Bad amixer output (4.14.6):
> Simple mixer control 'PCM',0
>   Capabilities: pvolume pswitch pswitch-joined enum
>   Items: 'Line' 'IEC958 In'
>   Item0: 'Line'
>   Item1: 'Line'
> Simple mixer control 'Line',0
>   Capabilities: cvolume cswitch cswitch-joined
>   Capture channels: Front Left - Front Right
>   Limits: Capture 0 - 104
>   Front Left: Capture 20 [19%] [-30.00dB] [off]
>   Front Right: Capture 20 [19%] [-30.00dB] [off]
> 
> The output of lsusb -v for the affected sound card is attached.
> 
> -- 
> Mauro Santos

> Bus 001 Device 006: ID 1852:7022 GYROCOM C&C Co., LTD 
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0         8
>   idVendor           0x1852 GYROCOM C&C Co., LTD
>   idProduct          0x7022 
>   bcdDevice            0.01
>   iManufacturer           1 HiFimeDIY Audio
>   iProduct                2 HiFimeDIY DAC
>   iSerial                 0 
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          428
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
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 
>       bInterfaceProtocol      0 
>       iInterface              0 
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.00
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      58
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
>         wMaxPacketSize     0x0012  1x 18 bytes
>         bInterval              32
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      1 Control Device
>       bInterfaceProtocol      0 
>       iInterface              3 SABRE 24/96 DAC_DigiT
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               1.00
>         wTotalLength           92
>         bInCollection           2
>         baInterfaceNr( 0)       2
>         baInterfaceNr( 1)       3
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             1
>         wTerminalType      0x0603 Line Connector
>         bAssocTerminal          0
>         bNrChannels             2
>         wChannelConfig     0x0003
>           Left Front (L)
>           Right Front (R)
>         iChannelNames           0 
>         iTerminal               0 
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
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             9
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bNrChannels             2
>         wChannelConfig     0x0003
>           Left Front (L)
>           Right Front (R)
>         iChannelNames           0 
>         iTerminal               0 
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             3
>         wTerminalType      0x0605 SPDIF interface
>         bAssocTerminal          0
>         bSourceID              16
>         iTerminal               0 
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             7
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bSourceID              11
>         iTerminal               0 
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                14
>         bSourceID               1
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
>         bSourceID               9
>         bControlSize            1
>         bmaControls( 0)      0x01
>           Mute Control
>         bmaControls( 1)      0x02
>           Volume Control
>         bmaControls( 2)      0x02
>           Volume Control
>         iFeature                0 
>       AudioControl Interface Descriptor:
>         bLength                 8
>         bDescriptorType        36
>         bDescriptorSubtype      5 (SELECTOR_UNIT)
>         bUnitID                11
>         bNrInPins               2
>         baSource( 0)           14
>         baSource( 1)            5
>         iSelector               0 
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
>         bTerminalLink           7
>         bDelay                  0 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                26
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            6 Discrete
>         tSamFreq[ 0]         8000
>         tSamFreq[ 1]        16000
>         tSamFreq[ 2]        32000
>         tSamFreq[ 3]        44100
>         tSamFreq[ 4]        48000
>         tSamFreq[ 5]        96000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
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
>           bLockDelayUnits         2 Decoded PCM samples
>           wLockDelay              2 Decoded PCM samples
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
>         bTerminalLink           7
>         bDelay                  0 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                26
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            6 Discrete
>         tSamFreq[ 0]         8000
>         tSamFreq[ 1]        16000
>         tSamFreq[ 2]        32000
>         tSamFreq[ 3]        44100
>         tSamFreq[ 4]        48000
>         tSamFreq[ 5]        96000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
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
>           bLockDelayUnits         2 Decoded PCM samples
>           wLockDelay              2 Decoded PCM samples
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0 
>       iInterface              0 
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
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
>         bTerminalLink           9
>         bDelay                  0 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                26
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            6 Discrete
>         tSamFreq[ 0]         8000
>         tSamFreq[ 1]        16000
>         tSamFreq[ 2]        32000
>         tSamFreq[ 3]        44100
>         tSamFreq[ 4]        48000
>         tSamFreq[ 5]        96000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
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
>           bLockDelayUnits         2 Decoded PCM samples
>           wLockDelay              2 Decoded PCM samples
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
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
>         bTerminalLink           9
>         bDelay                  0 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                26
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bSubframeSize           3
>         bBitResolution         24
>         bSamFreqType            6 Discrete
>         tSamFreq[ 0]         8000
>         tSamFreq[ 1]        16000
>         tSamFreq[ 2]        32000
>         tSamFreq[ 3]        44100
>         tSamFreq[ 4]        48000
>         tSamFreq[ 5]        96000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
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
>           bLockDelayUnits         2 Decoded PCM samples
>           wLockDelay              2 Decoded PCM samples
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
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
>         bTerminalLink           9
>         bDelay                  0 frames
>         wFormatTag           8193 IEC1937_AC-3
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             3 (FORMAT_TYPE_III)
>         bNrChannels             2
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
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
>           bLockDelayUnits         2 Decoded PCM samples
>           wLockDelay              2 Decoded PCM samples
> Device Status:     0x0000
>   (Bus Powered)


This is odd, Takashi, I thought we fixed up the problem that if the
string was invalid, the code would continue to go on, it's not a "real"
error.  Did that not get marked for the stable trees?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
