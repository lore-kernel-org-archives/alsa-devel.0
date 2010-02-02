From: Jani Frilander <j.frilander@gmail.com>
Subject: Zoom R16 (USB), will a quirk make it work
Date: Tue, 2 Feb 2010 07:46:36 +0200
Message-ID: <e53c6f621002012146n71ac0f7enb7e9f6e9c3b098d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CA972447F
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 06:46:37 +0100 (CET)
Received: by ewy23 with SMTP id 23so2395539ewy.4
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 21:46:36 -0800 (PST)
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

Hi.

I have a Zoom R16 which audio interface part doesn't work with linux.

lsusb -v:
Bus 001 Device 004: ID 1686:00dd ZOOM Corporation
Device Descriptor:
 bLength                18
 bDescriptorType         1
 bcdUSB               2.00
 bDeviceClass          255 Vendor Specific Class
 bDeviceSubClass         0
 bDeviceProtocol       255
 bMaxPacketSize0        64
 idVendor           0x1686 ZOOM Corporation
 idProduct          0x00dd
 bcdDevice            0.02
 iManufacturer           1 ZOOM Corporation
 iProduct                2 R16
 iSerial                 3 0
 bNumConfigurations      1
 Configuration Descriptor:
   bLength                 9
   bDescriptorType         2
   wTotalLength          259
   bNumInterfaces          4
   bConfigurationValue     1
   iConfiguration          0
   bmAttributes         0x80
     (Bus Powered)
   MaxPower              480mA
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        0
     bAlternateSetting       0
     bNumEndpoints           0
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass      1
     bInterfaceProtocol      0
     iInterface              0
     ** UNRECOGNIZED:  0b 24 01 00 01 35 00 03 01 02 03
     ** UNRECOGNIZED:  0c 24 02 05 01 01 00 02 03 00 00 00
     ** UNRECOGNIZED:  09 24 03 08 01 03 00 05 00
     ** UNRECOGNIZED:  0c 24 02 09 01 02 00 08 00 00 00 00
     ** UNRECOGNIZED:  09 24 03 0c 01 01 00 09 00
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        1
     bAlternateSetting       0
     bNumEndpoints           0
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass      2
     bInterfaceProtocol      0
     iInterface              0
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        1
     bAlternateSetting       1
     bNumEndpoints           1
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass      2
     bInterfaceProtocol      0
     iInterface              0
     ** UNRECOGNIZED:  07 24 01 05 01 01 00
     ** UNRECOGNIZED:  14 24 02 01 02 04 18 04 44 ac 00 80 bb 00 88
58 01 00 77 01
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x03  EP 3 OUT
       bmAttributes            9
         Transfer Type            Isochronous
         Synch Type               Adaptive
         Usage Type               Data
       wMaxPacketSize     0x006c  1x 108 bytes
       bInterval               1
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        2
     bAlternateSetting       0
     bNumEndpoints           0
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass      2
     bInterfaceProtocol      0
     iInterface              0
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        2
     bAlternateSetting       1
     bNumEndpoints           1
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass      2
     bInterfaceProtocol      0
     iInterface              0
     ** UNRECOGNIZED:  07 24 01 0c 01 01 00
     ** UNRECOGNIZED:  14 24 02 01 08 04 18 04 44 ac 00 80 bb 00 88
58 01 00 77 01
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x84  EP 4 IN
       bmAttributes           13
         Transfer Type            Isochronous
         Synch Type               Synchronous
         Usage Type               Data
       wMaxPacketSize     0x01a0  1x 416 bytes
       bInterval               1
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        3
     bAlternateSetting       0
     bNumEndpoints           2
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass      3
     bInterfaceProtocol      0
     iInterface              0
     ** UNRECOGNIZED:  07 24 01 00 01 41 00
     ** UNRECOGNIZED:  06 24 02 01 01 00
     ** UNRECOGNIZED:  06 24 02 02 02 00
     ** UNRECOGNIZED:  09 24 03 01 03 01 02 01 00
     ** UNRECOGNIZED:  09 24 03 02 04 01 01 01 00
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x01  EP 1 OUT
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0040  1x 64 bytes
       bInterval               0
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x82  EP 2 IN
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0040  1x 64 bytes
       bInterval               0
Device Qualifier (for other device speed):
 bLength                10
 bDescriptorType         6
 bcdUSB               2.00
 bDeviceClass          255 Vendor Specific Class
 bDeviceSubClass         0
 bDeviceProtocol       255
 bMaxPacketSize0        64
 bNumConfigurations      1
Device Status:     0x0001
 Self Powered

I have added following lines to usbquirks.h:
/* Zoom R16 */
{
        .match_flags = USB_DEVICE_ID_MATCH_DEVICE,
        .idVendor = 0x1686,
        .idProduct = 0x00dd,
        .bInterfaceClass = USB_CLASS_AUDIO,
},

But it doesn't work.

If I try to play a
file with mplayer:

$ mplayer -msglevel ao=9 -ao alsa:device=hw=2 piisi.mp3
MPlayer UNKNOWN-4.4.1 (C) 2000-2009 MPlayer Team
mplayer: could not connect to socket
mplayer: No such file or directory
Failed to open LIRC support. You will not be able to use your remote control.

Playing piisi.mp3.
Audio only file format detected.
==========================================================================
Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
AUDIO: 44100 Hz, 2 ch, s16le, 128.0 kbit/9.07% (ratio: 16000->176400)
Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3)
==========================================================================
Trying preferred audio driver 'alsa', options 'device=hw=2'
alsa-init: requested format: 44100 Hz, 2 channels, 9
alsa-init: using ALSA 1.0.20
alsa-init: setup for 1/2 channel(s)
alsa-init: using device hw:2
alsa-init: pcm opened in blocking mode
[AO_ALSA] Format s16le is not supported by hardware, trying default.
[AO_ALSA] Unable to set format: Invalid argument
Failed to initialize audio driver 'alsa:device=hw=2'
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video

$ cat /proc/asound/cards
 0 [Audigy         ]: Audigy - SB Audigy 1 [SB0090]
                     SB Audigy 1 [SB0090] (rev.3, serial:0x511102) at
0x9c00, irq 17
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                     HDA NVidia at 0xfe024000 irq 27
 2 [R16            ]: USB-Audio - R16
                     ZOOM Corporation R16 at usb-0000:00:0b.1-6, high speed

$ ls /dev/snd/
by-id      controlC2  midiC0D0  midiC2D0  pcmC0D2c  pcmC1D0p  seq
by-path    hwC0D0     midiC0D1  pcmC0D0c  pcmC0D2p  pcmC1D1p  timer
controlC0  hwC0D2     midiC0D2  pcmC0D0p  pcmC0D3p  pcmC2D0c
controlC1  hwC1D0     midiC0D3  pcmC0D1c  pcmC1D0c  pcmC2D0p

What can i do to make it work? I have a wireshark log of a winxp session.
Does it help a bit?

http://sites.google.com/site/zoomr16linux/zoomwire.bz2

Thanks for any advice.

Sincerely, Jani Frilander
