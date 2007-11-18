From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: Re: [CONF] All C-Media Codecs based 5.1 Channel USB-
 Headsets
Date: Sun, 18 Nov 2007 05:38:17 +0100
Message-ID: <473FC1B9.8040704@googlemail.com>
References: <472D7698.2080700@googlemail.com> <s5htznzv9og.wl%tiwai@suse.de>
	<4730B527.7050707@googlemail.com>
Reply-To: thomas.schorpp@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by alsa0.perex.cz (Postfix) with ESMTP id B3FB02460E
	for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2007 09:55:24 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so1469652fka
	for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2007 00:55:24 -0800 (PST)
In-Reply-To: <4730B527.7050707@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

thomas schorpp wrote:
> Takashi Iwai wrote:
>> At Sun, 04 Nov 2007 08:36:56 +0100,
>> thomas schorpp wrote:
>>> Report to devlist as requested from USB-Audio.conf header:
>>
>> Thanks for the report.
>>
>>> 1. all this headsets with windriver inf files + manual showing 
>>> c-media driver must have the cm106x series 7.1 channel usb-codec in. 
>>> there's no other from c-media for the design of 5.1 channel usb 
>>> headsets available at this time, see:
>>>
>>> http://www.cmedia.com.tw/?q=en/usb_audio
>>>
>>> 2. the headset interface shows up with 8 channels in lsusb -v , 1 
>>> 8-ch pcm in /proc,
>>>  and must be driven with surround7.1 pcm plug instead of surround5.1 
>>> or it will not work. speaker-test program works with -c6 
>>> -Dsurround7.1, test with -c8 works too, but shows that no SideL/R 
>>> -speakers connected/routed/downmixed ( Speedlink Medusa 5.1 Mobile 
>>> USB Headset, cm106L)
>>
>> OK, and what about surround40?  Does it work as is (I don't expect so,
>> though)?
> 
> seems to work fine if i specify default:1 as "stereo playback device" in 
> Xine-UI, tested yesterday, well it is a headphone, so it is hard to 
> locate speakers but you get double the volume from parallel speaker 
> drive, 5.1 CH is lower volume ;)
> for stereo playback we must assure LFE+Center is off, respectively or 
> stereo maybe eliminated acoustically. for Xine it sounds not like, but 
> for VLC, but thats real subjective.
> the headset has 3 speakers per ear, i dont know the LFE+Center circuits...
> so plug:surround40 is a good idea.
> 
>>
>> For adding the proper configuration, please check the content of
>> /proc/asound/cards.  It gives the name string.  
> 
> the "name" is from the drivers "id" parm, right?
>> If the proc entry is like:
>>
>>  0 [Foo   ]: FOO - FOO BAR
>>              FOO BAR DEVICE (Blah 0.0)
>>
>> then "FOO BAR" is the name string that we need to pass.
>> (FYI, "FOO" is the driver string, "Foo" is the ID string and "FOO BAR
>> DEVICE (Blah 0.0)" is the longname string.)
>>
>> Now add the following to ~/.asoundrc:
>>
>> USB-Audio."FOO BAR".pcm.surround51 {
>>     @args [ CARD ]
>>     @args.CARD { type string }
>>     type route
>>     ttable.0.0 1
>>     ttable.1.1 1
>>     ttable.2.4 1
>>     ttable.3.5 1
>>     ttable.4.2 1
>>     ttable.5.3 1
>>     slave {
>>         pcm {
>>             type hw
>>             card $CARD
>>             device 0
>>         }
>>         channels 8
>>     }
>> }
> 
> will try it tomorrow, thx.


tom1:/etc# cat /proc/asound/cards
 0 [V8237          ]: VIA8237 - VIA 8237
                      VIA 8237 with ALC850 at 0xa800, irq 22
 1 [Audio          ]: USB-Audio - USB Audio
                      USB Audio at usb-0000:00:10.3-1, full speed
 2 [AiptekDV3500   ]: USB-Audio - DV 3500
                       DV 3500 at usb-0000:00:10.1-2, full speed

USB-Audio."USB Audio".pcm.surround51 {
        @args [ CARD ]
        @args.CARD { type string }
        type route
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.4 1
        ttable.3.5 1
        ttable.4.2 1
        ttable.5.3 1
        slave {
                pcm {
                        type hw
                        card $CARD
                        device 0
                }
                channels 8
        }
}

hm. this seems to change nothing here, wether with VLC or 
vdr with -a '/usr/bin/ac3dec -6 -D surround71:CARD=Audio' 
(ac3dec with my "enable -6 with DD2.0 input patch from alsa bugzilla).

speaker-test -Dsurround51:CARD=Audio -c 6 -t wav still err "no conf avail.".

speaker-test -Dsurround71:CARD=Audio -c 6 -t wav is fine.

speaker-test -Ddefault:CARD=Audio -c 6 -t wav aligns speakers wrongly with or 
without /etc/asound.conf

anyway. i'm fully satisfied. :) if You want me to test more, drop me a note.

> 
>>
>> Also, /proc/asound/card*/stream* files would be helpful to understand
> 
> tom1:~# cat /proc/asound/card1/stream*
> USB Audio at usb-0000:00:10.3-1, full speed : USB Audio
> 
> Playback:
>  Status: Stop
>  Interface 1
>    Altset 1
>    Format: 0x2
>    Channels: 8
>    Endpoint: 6 OUT (ADAPTIVE)
>    Rates: 44100, 48000
> 
> Capture:
>  Status: Stop
>  Interface 2
>    Altset 1
>    Format: 0x2
>    Channels: 2
>    Endpoint: 5 IN (ASYNC)
>    Rates: 44100, 48000
> 
> running vdr -a '/usr/bin/ac3dec -6 -D plug:surround71:1' on 5.1 media 
> playback gives:
> 
> tom1:~# cat /proc/asound/card1/stream*
> USB Audio at usb-0000:00:10.3-1, full speed : USB Audio
> 
> Playback:
>  Status: Running
>    Interface = 1
>    Altset = 1
>    URBs = 2 [ 8 2 ]
>    Packet Size = 768
>    Momentary freq = 48000 Hz (0x30.0000)
>  Interface 1
>    Altset 1
>    Format: 0x2
>    Channels: 8
>    Endpoint: 6 OUT (ADAPTIVE)
>    Rates: 44100, 48000
> 
> Xine cdda with default:1 as stereo device setup:
> 
> Playback:
>  Status: Running
>    Interface = 1
>    Altset = 1
>    URBs = 3 [ 8 8 6 ]
>    Packet Size = 768
>    Momentary freq = 48000 Hz (0x30.0000) <-- ??? should be 44.1kHz
>  Interface 1
>    Altset 1
>    Format: 0x2
>    Channels: 8
>    Endpoint: 6 OUT (ADAPTIVE)
>    Rates: 44100, 48000
> 
> VLC cdda has the best sound output so far:
> 
> Playback:
>  Status: Running
>    Interface = 1
>    Altset = 1
>    URBs = 3 [ 8 8 8 ] <----------XXX ?
>    Packet Size = 768
>    Momentary freq = 44100 Hz (0x2c.199a) <--- XXX
>  Interface 1
>    Altset 1
>    Format: 0x2
>    Channels: 8
>    Endpoint: 6 OUT (ADAPTIVE)
>    Rates: 44100, 48000
> 
> 
>> more, at best, together with lsusb -vv output.
> 
> tom1:~# lsusb -vv -d 0d8c:0006
> 
> Bus 005 Device 002: ID 0d8c:0006 C-Media Electronics, Inc.
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               1.10
>  bDeviceClass            0 (Defined at Interface level)
>  bDeviceSubClass         0
>  bDeviceProtocol         0
>  bMaxPacketSize0         8
>  idVendor           0x0d8c C-Media Electronics, Inc.
>  idProduct          0x0006
>  bcdDevice            0.10
>  iManufacturer           0
>  iProduct                2 USB Audio
>  iSerial                 0
>  bNumConfigurations      1
>  Configuration Descriptor:
>    bLength                 9
>    bDescriptorType         2
>    wTotalLength          340
>    bNumInterfaces          4
>    bConfigurationValue     1
>    iConfiguration          0
>    bmAttributes         0xa0
>      (Bus Powered)
>      Remote Wakeup
>    MaxPower              500mA
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        0
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      1 Control Device
>      bInterfaceProtocol      0
>      iInterface              0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      1 (HEADER)
>        bcdADC               1.00
>        wTotalLength          187
>        bInCollection           2
>        baInterfaceNr( 0)       1
>        baInterfaceNr( 1)       2
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      2 (INPUT_TERMINAL)
>        bTerminalID             1
>        wTerminalType      0x0101 USB Streaming
>        bAssocTerminal          0
>        bNrChannels             8
>        wChannelConfig     0x063f
>          Left Front (L)
>          Right Front (R)
>          Center Front (C)
>          Low Freqency Enhancement (LFE)
>          Left Surround (LS)
>          Right Surround (RS)
>          Side Left (SL)
>          Side Right (SR)
>        iChannelNames           0
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      2 (INPUT_TERMINAL)
>        bTerminalID             4
>        wTerminalType      0x0201 Microphone
>        bAssocTerminal          0
>        bNrChannels             2
>        wChannelConfig     0x0003
>          Left Front (L)
>          Right Front (R)
>        iChannelNames           0
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                 8
>        bSourceID               4
>        bControlSize            1
>        bmaControls( 0)      0x40
>          Automatic Gain
>        bmaControls( 1)      0x02
>          Volume
>        bmaControls( 2)      0x02
>          Volume
>        iFeature                0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                 9
>        bSourceID               4
>        bControlSize            1
>        bmaControls( 0)      0x01
>          Mute
>        bmaControls( 1)      0x02
>          Volume
>        bmaControls( 2)      0x02
>          Volume
>        iFeature                0
>      AudioControl Interface Descriptor:
>        bLength                25
>        bDescriptorType        36
>        bDescriptorSubtype      4 (MIXER_UNIT)
>        bUnitID                12
>        bNrInPins               3
>        baSourceID( 0)          1
>        baSourceID( 1)          9
>        baSourceID( 2)         11
>        bNrChannels             8
>        wChannelConfig     0x063f
>          Left Front (L)
>          Right Front (R)
>          Center Front (C)
>          Low Freqency Enhancement (LFE)
>          Left Surround (LS)
>          Right Surround (RS)
>          Side Left (SL)
>          Side Right (SR)
>        iChannelNames           0
>        bmControls         0x00
>        bmControls         0x00
>        bmControls         0x00
>        iMixer                  0
>        junk at descriptor end: 00 00 00 00 00 00 00 00 00
>      AudioControl Interface Descriptor:
>        bLength                16
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                13
>        bSourceID              12
>        bControlSize            1
>        bmaControls( 0)      0x03
>          Mute
>          Volume
>        bmaControls( 1)      0x00
>        bmaControls( 2)      0x00
>        bmaControls( 3)      0x00
>        bmaControls( 4)      0x00
>        bmaControls( 5)      0x00
>        bmaControls( 6)      0x00
>        bmaControls( 7)      0x00
>        bmaControls( 8)      0x00
>        iFeature                0
>      AudioControl Interface Descriptor:
>        bLength                 9
>        bDescriptorType        36
>        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>        bTerminalID             3
>        wTerminalType      0x0301 Speaker
>        bAssocTerminal          0
>        bSourceID              13
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                 2
>        bSourceID              12
>        bControlSize            1
>        bmaControls( 0)      0x00
>        bmaControls( 1)      0x02
>          Volume
>        bmaControls( 2)      0x02
>          Volume
>        iFeature                0
>      AudioControl Interface Descriptor:
>        bLength                 9
>        bDescriptorType        36
>        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>        bTerminalID            10
>        wTerminalType      0x0101 USB Streaming
>        bAssocTerminal          0
>        bSourceID               7
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      5 (SELECTOR_UNIT)
>        bUnitID                 7
>        bNrInPins               4
>        baSource( 0)            8
>        baSource( 1)           15
>        baSource( 2)           16
>        baSource( 3)            2
>        iSelector               0
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      2 (INPUT_TERMINAL)
>        bTerminalID             6
>        wTerminalType      0x0603 Line Connector
>        bAssocTerminal          0
>        bNrChannels             2
>        wChannelConfig     0x0003
>          Left Front (L)
>          Right Front (R)
>        iChannelNames           0
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                15
>        bSourceID               6
>        bControlSize            1
>        bmaControls( 0)      0x00
>        bmaControls( 1)      0x02
>          Volume
>        bmaControls( 2)      0x02
>          Volume
>        iFeature                0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                11
>        bSourceID               6
>        bControlSize            1
>        bmaControls( 0)      0x01
>          Mute
>        bmaControls( 1)      0x02
>          Volume
>        bmaControls( 2)      0x02
>          Volume
>        iFeature                0
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      2 (INPUT_TERMINAL)
>        bTerminalID             5
>        wTerminalType      0x0605 SPDIF interface
>        bAssocTerminal          0
>        bNrChannels             2
>        wChannelConfig     0x0003
>          Left Front (L)
>          Right Front (R)
>        iChannelNames           0
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                16
>        bSourceID               5
>        bControlSize            1
>        bmaControls( 0)      0x01
>          Mute
>        bmaControls( 1)      0x00
>        bmaControls( 2)      0x00
>        iFeature                0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>      AudioStreaming Interface Descriptor:
>        bLength                 7
>        bDescriptorType        36
>        bDescriptorSubtype      1 (AS_GENERAL)
>        bTerminalLink           1
>        bDelay                  1 frames
>        wFormatTag              1 PCM
>      AudioStreaming Interface Descriptor:
>        bLength                14
>        bDescriptorType        36
>        bDescriptorSubtype      2 (FORMAT_TYPE)
>        bFormatType             1 (FORMAT_TYPE_I)
>        bNrChannels             8
>        bSubframeSize           2
>        bBitResolution         16
>        bSamFreqType            2 Discrete
>        tSamFreq[ 0]        44100
>        tSamFreq[ 1]        48000
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x06  EP 6 OUT
>        bmAttributes            9
>          Transfer Type            Isochronous
>          Synch Type               Adaptive
>          Usage Type               Data
>        wMaxPacketSize     0x0300  1x 768 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>        AudioControl Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType        37
>          bDescriptorSubtype      1 (EP_GENERAL)
>          bmAttributes         0x01
>            Sampling Frequency
>          bLockDelayUnits         0 Undefined
>          wLockDelay              0 Undefined
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        2
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        2
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>      AudioStreaming Interface Descriptor:
>        bLength                 7
>        bDescriptorType        36
>        bDescriptorSubtype      1 (AS_GENERAL)
>        bTerminalLink          10
>        bDelay                  1 frames
>        wFormatTag              1 PCM
>      AudioStreaming Interface Descriptor:
>        bLength                14
>        bDescriptorType        36
>        bDescriptorSubtype      2 (FORMAT_TYPE)
>        bFormatType             1 (FORMAT_TYPE_I)
>        bNrChannels             2
>        bSubframeSize           2
>        bBitResolution         16
>        bSamFreqType            2 Discrete
>        tSamFreq[ 0]        44100
>        tSamFreq[ 1]        48000
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x85  EP 5 IN
>        bmAttributes            5
>          Transfer Type            Isochronous
>          Synch Type               Asynchronous
>          Usage Type               Data
>        wMaxPacketSize     0x00c8  1x 200 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>        AudioControl Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType        37
>          bDescriptorSubtype      1 (EP_GENERAL)
>          bmAttributes         0x01
>            Sampling Frequency
>          bLockDelayUnits         0 Undefined
>          wLockDelay              0 Undefined
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        3
>      bAlternateSetting       0
>      bNumEndpoints           1
>      bInterfaceClass         3 Human Interface Devices
>      bInterfaceSubClass      0 No Subclass
>      bInterfaceProtocol      0 None
>      iInterface              0
>        HID Device Descriptor:
>          bLength                 9
>          bDescriptorType        33
>          bcdHID               1.00
>          bCountryCode            0 Not supported
>          bNumDescriptors         1
>          bDescriptorType        34 Report
>          wDescriptorLength      50
>         Report Descriptors:
>           ** UNAVAILABLE **
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x81  EP 1 IN
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0003  1x 3 bytes
>        bInterval              32
> Device Status:     0x0000
>  (Bus Powered)
> tom1:~#                                                                    
>>
>>
>> Takashi
>>
> 
> thx
> y
> tom
> 

y
tom
