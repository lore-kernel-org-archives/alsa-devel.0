From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: M-Audio FastTrack C400
Date: Wed, 18 Apr 2012 11:12:39 +1000
Message-ID: <CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B1750104452
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 03:12:39 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so5050562wgb.20
	for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2012 18:12:39 -0700 (PDT)
In-Reply-To: <4F8DF29B.9090907@rauros.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chris-alsa@rauros.net
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

So this looks reasonably familiar,

int0 is DFU
int1 is mixer
int2 is audio out
int3 is audio in
int4 is midi
int5 is HID

Quirk should look like the fast track ultra basically. maybe the mixer is
less broken in this device?

Should we start with just QUIRK_STANDARD_AUDIO_INTERFACE or copy the whole
data section from the Ultra quirk?

This has isosyncronous feedback for clock control needs current sound tree
usb-audio tree

Grant



On Wed, Apr 18, 2012 at 8:45 AM, Chris Cavey <chris-alsa@rauros.net> wrote:

>  Will to help with development, may need pointers to get started and
> willing to test things. I am mostly concerned with simple playback.
> Recording, DSP, and Midi can all come later if at all.
>
> As requested the output of sudo lsusb -v -d 0763:2030"
>
> Bus 002 Device 003: ID 0763:2030 Midiman
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2 ?
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x0763 Midiman
>   idProduct          0x2030
>   bcdDevice            1.01
>   iManufacturer           1 M-Audio
>   iProduct                2 Fast Track C400
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          455
>     bNumInterfaces          6
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
>       bInterfaceClass       254 Application Specific Interface
>       bInterfaceSubClass      1 Device Firmware Update
>       bInterfaceProtocol      0
>       iInterface              6 Fast Track C400 DFU
>       Device Firmware Upgrade Interface Descriptor:
>         bLength                             9
>         bDescriptorType                    33
>         bmAttributes                        1
>           Will Not Detach
>           Manifestation Intolerant
>           Upload Unsupported
>           Download Supported
>         wDetachTimeout                   2000 milliseconds
>         wTransferSize                    1024 bytes
>         bcdDFUVersion                   1.10
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         1
>       bInterfaceCount         4
>       bFunctionClass        255 Vendor Specific Class
>       bFunctionSubClass       0
>       bFunctionProtocol      32
>       iFunction               2 Fast Track C400
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol     32
>       iInterface              2 Fast Track C400
>       ** UNRECOGNIZED:  09 24 01 00 02 0a a3 00 00
>       ** UNRECOGNIZED:  09 24 0b 80 02 81 82 03 00
>       ** UNRECOGNIZED:  08 24 0a 81 03 03 03 00
>       ** UNRECOGNIZED:  08 24 0a 82 00 05 03 00
>       ** UNRECOGNIZED:  11 24 02 00 01 01 00 80 06 00 00 00 00 00 00 00 00
>       ** UNRECOGNIZED:  0c 24 03 01 01 01 00 02 80 00 00 00
>       ** UNRECOGNIZED:  11 24 02 02 03 06 00 80 04 00 00 00 00 00 00 00 00
>       ** UNRECOGNIZED:  0c 24 03 03 03 06 00 40 80 00 00 00
>       ** UNRECOGNIZED:  11 24 09 20 00 00 02 02 00 04 00 00 00 00 00 00 00
>       ** UNRECOGNIZED:  15 24 04 40 03 02 00 43 04 00 00 00 00 00 ff ff ff
> ff 0f 00 00
>       ** UNRECOGNIZED:  10 24 04 42 02 02 00 01 00 00 00 00 00 ff 00 00
>       ** UNRECOGNIZED:  10 24 07 43 02 00 42 fd 03 00 00 fd 03 00 00 00
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol     32
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol     32
>       iInterface              4 Line
>       ** UNRECOGNIZED:  10 24 01 00 00 01 01 00 00 00 06 00 00 00 00 00
>       ** UNRECOGNIZED:  06 24 02 01 03 18
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes           37
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Implicit feedback Data
>         wMaxPacketSize     0x00ea  1x 234 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       2
>       bNumEndpoints           1
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol     32
>       iInterface              4 Line
>       ** UNRECOGNIZED:  10 24 01 00 00 01 d0 00 00 00 02 00 00 00 00 00
>       ** UNRECOGNIZED:  06 24 02 03 02 10
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes           37
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Implicit feedback Data
>         wMaxPacketSize     0x004e  1x 78 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol     32
>       iInterface              4 Line
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol     32
>       iInterface              4 Line
>       ** UNRECOGNIZED:  10 24 01 00 00 01 01 00 00 00 04 00 00 00 00 00
>       ** UNRECOGNIZED:  06 24 02 01 03 18
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x009c  1x 156 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        4
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      3 MIDI Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       MIDIStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               1.00
>         wTotalLength           35
>       MIDIStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (MIDI_IN_JACK)
>         bJackType               1 Embedded
>         bJackID                 1
>         iJack                   0
>       MIDIStreaming Interface Descriptor:
>         bLength                 6
>         bDescriptorType        36
>         bDescriptorSubtype      2 (MIDI_IN_JACK)
>         bJackType               2 External
>         bJackID                 2
>         iJack                   0
>       MIDIStreaming Interface Descriptor:
>         bLength                 8
>         bDescriptorType        36
>         bDescriptorSubtype      3 (MIDI_OUT_JACK)
>       Warning: Descriptor too short
>         bJackType               1 Embedded
>         bJackID                 3
>         bNrInputPins            1
>         baSourceID( 0)          2
>         BaSourcePin( 0)         1
>         iJack                   8
>       MIDIStreaming Interface Descriptor:
>         bLength                 8
>         bDescriptorType        36
>         bDescriptorSubtype      3 (MIDI_OUT_JACK)
>       Warning: Descriptor too short
>         bJackType               2 External
>         bJackID                 4
>         bNrInputPins            1
>         baSourceID( 0)          1
>         BaSourcePin( 0)         1
>         iJack                 105
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x07  EP 7 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
>         MIDIStreaming Endpoint Descriptor:
>           bLength                 5
>           bDescriptorType        37
>           bDescriptorSubtype      1 (GENERAL)
>           bNumEmbMIDIJack         1
>           baAssocJackID( 0)       1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x87  EP 7 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
>         MIDIStreaming Endpoint Descriptor:
>           bLength                 5
>           bDescriptorType        37
>           bDescriptorSubtype      1 (GENERAL)
>           bNumEmbMIDIJack         1
>           baAssocJackID( 0)       3
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        5
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      1 Keyboard
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      63
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x86  EP 6 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval               8
> Device Qualifier (for other device speed):
>   bLength                10
>   bDescriptorType         6
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2 ?
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   bNumConfigurations      1
> Device Status:     0x0000
>   (Bus Powered)
>
>
> On 04/17/2012 09:15 AM, Grant Diffey wrote:
>
> start with an lsusb -v -d (vid:pid) pasted here
>
> On Tue, Apr 17, 2012 at 10:37 PM, Chris Cavey <chris-alsa@rauros.net>wrote:
>
>> I'd love to be able to help ALSA support this USB sound device. I've
>> currently got the device working in a VM on my Ubuntu 12.04 workstation.
>> I believe I can capture USB packets. Would this be helpful to anyone?
>> Any pointers on where to get started?
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
>
>
