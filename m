From: Jack Bates <muyyxo@nottheoilrig.com>
Subject: Re: USB dB data
Date: Tue, 5 Sep 2017 16:55:51 -0700
Message-ID: <60c1f178-e942-c528-68c5-f6e5d8248376@nottheoilrig.com>
References: <2cc03127-af37-613a-a3df-a1d6e6915d05@nottheoilrig.com>
 <s5hshg6x46i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nottheoilrig.com (mail.nottheoilrig.com [52.27.13.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 62B7726734C
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 01:55:54 +0200 (CEST)
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
 by mail.nottheoilrig.com (Postfix) with ESMTP id A5DCE204A2
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 23:55:52 +0000 (UTC)
In-Reply-To: <s5hshg6x46i.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/09/17 12:34 AM, Takashi Iwai wrote:
> On Wed, 30 Aug 2017 21:48:58 +0200,
> Jack Bates wrote:
>>
>> I confirmed with Wireshark that my USB sound card responds to GET_MIN
>> with 0x0000 and GET_MAX with 0x6300 .. The audio device class
>> definition [1] says the units are 1/256 dB (section 5.2.2.2.3: Mixer
>> Control) ... So by my calculation, the min and max are 0 and 99 dB
>> (0x6300 / 256 == 99) ... Why then does alsactl print:
>>
>>> range '0 - 99'
>>> dbmin 0
>>> dbmax 38
>>
>> (/usr/sbin/aslactl -f - store)
>>
>> I originally asked about this on the pulseaudio-discuss list [2]
>> because it uses "dB data" [3].
>>
>> The "0 - 99" makes sense -- it lines up with my calculation ... Where
>> does the 38 come from? (I expect it's obvious, I just haven't found
>> the explanation?)
>
> Hm, what shows /proc/asound/card*/usbmixer proc file?
> It contains some raw data.

It also shows dBmax=38 (it matches alsactl):

> nottheoilrig@debian:~$ cat /proc/asound/card2/usbmixer
> USB Mixer: usb_id=0x05a740fa, ctrlif=0, ctlerr=0
> Card: Bose Corporation Bose Revolve SoundLink at usb-0000:00:14.0-1, full speed
>   Unit: 2
>     Control: name="PCM Playback Volume", index=0
>     Info: id=2, control=2, cmask=0x0, channels=1, type="S16"
>     Volume: min=0, max=99, dBmin=0, dBmax=38
>   Unit: 2
>     Control: name="PCM Playback Switch", index=0
>     Info: id=2, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
>     Volume: min=0, max=1, dBmin=0, dBmax=0
> nottheoilrig@debian:~$

> Basically the driver simply interprets the USB descriptor min/max
> unless there are overriding mappings by quirk list.

How can I inspect the device's USB descriptor min/max (to confirm that 
38 *is* what's advertised)? I was using Wireshark to capture the GET_MAX 
request and response ([1] section 5.2.2.2.2: Get Mixer Unit Control 
Request) -- in which case the response data is 0x6300 ...

If the source behind the usbmixer proc file/dB data is the GET_MAX 
response, then how does 0x6300 turn into 38 dB? I haven't spotted any 
obvious quirks for usb_id=0x05a740fa (although I haven't read all of 
mixer.c) ... get_min_max_with_quirks() would seem to interpret it as 
1/256 dB [2] (as per the spec) but 0x6300 / 256 != 38 ...

[1] http://www.usb.org/developers/docs/devclass_docs/audio10.pdf
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/usb/mixer.c#n1046

Here's the lsusb output:

> Bus 001 Device 008: ID 05a7:40fa Bose Corp.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2 ?
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x05a7 Bose Corp.
>   idProduct          0x40fa
>   bcdDevice            1.00
>   iManufacturer           1
>   iProduct                2
>   iSerial                 3
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          156
>     bNumInterfaces          3
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower              500mA
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         0
>       bInterfaceCount         2
>       bFunctionClass          1 Audio
>       bFunctionSubClass       1 Control Device
>       bFunctionProtocol       0
>       iFunction               0
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
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               1.00
>         wTotalLength           43
>         bInCollection           1
>         baInterfaceNr( 0)       1
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             1
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bNrChannels             2
>         wChannelConfig     0x0003
>           Left Front (L)
>           Right Front (R)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                13
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 2
>         bSourceID               1
>         bControlSize            2
>         bmaControls( 0)      0x03
>         bmaControls( 0)      0x00
>           Mute Control
>           Volume Control
>         bmaControls( 1)      0x00
>         bmaControls( 1)      0x00
>         bmaControls( 2)      0x00
>         bmaControls( 2)      0x00
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
>         bDelay                  0 frames
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
>         tSamFreq[ 0]        48000
>         tSamFreq[ 1]        44100
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x81
>             Sampling Frequency
>             MaxPacketsOnly
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x00c0  1x 192 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.11
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength     126
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
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
