From: Daniel Mack <daniel@zonque.org>
Subject: Re: Zoom R16
Date: Sun, 24 Nov 2013 14:03:35 +0100
Message-ID: <20131124130335.GA23126@tamtam.fritz.box>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 055E2261676
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:50:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jason Mancine <jason@mancine.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 22, 2013 at 01:12:17PM -0500, Jason Mancine wrote:
> Hello, I am looking for some assistance in getting the Zoom R16 working for
> playback.  Please let me know if this is the right forum for this...
> 
> The device is recognized, but I just can't figure out which interface is
> which, and how to configure them in quirks-table.h.   Any help would be
> appreciated.

Please try with a recent kernel and see if something like this in
quirks-table.h helps you:

{
        .match_flags = USB_DEVICE_ID_MATCH_VENDOR |
                       USB_DEVICE_ID_MATCH_INT_CLASS,
        .idVendor = 0x1686,
        .bInterfaceClass = USB_CLASS_VENDOR_SPEC,
        .driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
                .ifnum = QUIRK_ANY_INTERFACE,
                .type = QUIRK_AUTODETECT
        }
},



Daniel


> To start, the output of lsusb -v for the device is this:
>  ---
> 
> Bus 001 Device 010: ID 1686:00dd ZOOM Corporation
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass         0
>   bDeviceProtocol       255
>   bMaxPacketSize0        64
>   idVendor           0x1686 ZOOM Corporation
>   idProduct          0x00dd
>   bcdDevice            0.02
>   iManufacturer           1
>   iProduct                2 R16
>   iSerial                 3 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          259
>     bNumInterfaces          4
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              480mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol      0
>       iInterface              0
>       ** UNRECOGNIZED:  0b 24 01 00 01 35 00 03 01 02 03
>       ** UNRECOGNIZED:  0c 24 02 05 01 01 00 02 03 00 00 00
>       ** UNRECOGNIZED:  09 24 03 08 01 03 00 05 00
>       ** UNRECOGNIZED:  0c 24 02 09 01 02 00 08 00 00 00 00
>       ** UNRECOGNIZED:  09 24 03 0c 01 01 00 09 00
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol      0
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol      0
>       iInterface              0
>       ** UNRECOGNIZED:  07 24 01 05 01 01 00
>       ** UNRECOGNIZED:  14 24 02 01 02 04 18 04 44 ac 00 80 bb 00 88 58 01
> 00 77 01
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x006c  1x 108 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol      0
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      2
>       bInterfaceProtocol      0
>       iInterface              0
>       ** UNRECOGNIZED:  07 24 01 0c 01 01 00
>       ** UNRECOGNIZED:  14 24 02 01 08 04 18 04 44 ac 00 80 bb 00 88 58 01
> 00 77 01
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x84  EP 4 IN
>         bmAttributes           13
>           Transfer Type            Isochronous
>           Synch Type               Synchronous
>           Usage Type               Data
>         wMaxPacketSize     0x01a0  1x 416 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      3
>       bInterfaceProtocol      0
>       iInterface              0
>       ** UNRECOGNIZED:  07 24 01 00 01 41 00
>       ** UNRECOGNIZED:  06 24 02 01 01 00
>       ** UNRECOGNIZED:  06 24 02 02 02 00
>       ** UNRECOGNIZED:  09 24 03 01 03 01 02 01 00
>       ** UNRECOGNIZED:  09 24 03 02 04 01 01 01 00
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
> Device Qualifier (for other device speed):
>   bLength                10
>   bDescriptorType         6
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass         0
>   bDeviceProtocol       255
>   bMaxPacketSize0        64
>   bNumConfigurations      1
> Device Status:     0x0001
>   Self Powered
> 
> ---
> 
> This is the quirk that Clemens provided on the linux-audio mail list...the
> device is recognized, but no capture/playback:
> 
> {
>         /* ZOOM R16 in USB 2.0 mode */
>         USB_DEVICE(0x1686, 0x00dd),
>         .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk)
> {
>                 .ifnum = QUIRK_ANY_INTERFACE,
>                 .type = QUIRK_COMPOSITE,
>                 .data = (const struct snd_usb_audio_quirk[]) {
>                         {
>                                 .ifnum = 0,
>                                 .type = QUIRK_IGNORE_INTERFACE
>                         },
>                         {
>                                 .ifnum = 1,
>                                 .type = QUIRK_AUDIO_STANDARD_INTERFACE
>                         },
>                         {
>                                 .ifnum = 2,
>                                 .type = QUIRK_AUDIO_STANDARD_INTERFACE
>                         },
>                         {
>                                 .ifnum = 3,
>                                 .type = QUIRK_MIDI_STANDARD_INTERFACE
>                         },
>                         {
>                                 .ifnum = .1
>                         },
>                 }
>         }
> },
> 
> 
> 
> 
> 
> Now....despite there being no #4 interface in lsusb, if I append the
> following to the above quirk I get all 8 channels of capture working.  I am
> more confused than ever. :)
> 
>       {
>             .ifnum = 4,
>             .type = QUIRK_AUDIO_FIXED_ENDPOINT,
>             .data = & (const struct audioformat) {
>                .formats = SNDRV_PCM_FMTBIT_S24_LE,
>                .channels = 8,
>                .iface = 1,
>                .altsetting = 1,
>                .altset_idx = 1,
>                .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
>                 .endpoint = 0x84,
>                 .ep_attr = 13,
>                 .rates = SNDRV_PCM_RATE_44100 |
>                     SNDRV_PCM_RATE_48000 |
>                     SNDRV_PCM_RATE_88200 |
>                   SNDRV_PCM_RATE_96000,
>                .rate_min = 44100,
>                .rate_max = 96000,
>                .nr_rates = 4,
>                .rate_table = (unsigned int[]) {
>                      44100, 48000, 88200, 96000
>                }
>             }
>          },
> 
> 
> Obviously, this is not the correct solution and I can't make playback work
> by adding additional .ifnums.    I am quite certain that interface 1 is
> capture and 2 is playback but if I add the same info to either of those
> sections my entire system freezes when I plug in the device.
> 
> Thanks,
> jason
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
