From: Pete Leigh <pete.leigh@gmail.com>
Subject: Fwd: Support for Roland VG-99 (working code,
	but could use help)
Date: Tue, 16 Oct 2012 00:59:39 +0100
Message-ID: <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id D60612650F0
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 01:59:40 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c10so8585954ieb.38
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 16:59:39 -0700 (PDT)
In-Reply-To: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I tried posting this  a couple of days ago, but no response... I'm
wondering if the (text) attachment stopped people from seeing it, or
if there's something else I missed?

It's just a request to look over the lsusb output and new quirks-table
entry included, with a view to getting this added to a release.

Since the initial post, I've done more testing (I'm using a kernel
based on 3.4.11-1.rt19.1.fc17.ccrma.x86_64.rt) and everything seems to
work fine (including midi in, which I wasn't sure of at the time of
posting) apart from one apparently cosmetic issue -  the device name
no longer shows up in lsusb output, though it did before applying the
quirk. (?)

I'll include the quirk entry as text rather than an attachment this time.

If I actually need to go through the process of generating a patch and
sending mail via git, as per the developer page on the alsa-project
site, could someone let me know, and I'll give it a go (it's something
I was hoping to avoid, I admit!)

Thanks,

- Pete.


---------- Forwarded message ----------

The VG-99 is a guitar processor with a usb interface which offers
2x16bit 44100 pcm in and out streams  in its basic usb mode, and
2x24bit 44100 in/out + midi in the advanced mode connection mode.

Basic mode works fine with usb snd driver, but the device isn't
recognised when set to advanced mode (this is done under USB on page 2
of the "system" config menu)

I've used the lsusb -v output (below) to guess at an addition to
sound/usb/quirks-table.h to try and get this working. On initial
(brief) testing, audio in/out at 24bits (as shown by jackd output) and
midi (out, at least) are all working.

I'll attach the quirk, and would be pleased if someone could look at
it, and the lsusb output, and fix up any deficiencies (it's purely
voodoo here :-D) and maybe get it or something like it into the
official source... please let me know if changes need to be tested.

Cheers,

- Pete.

Here's the lsusb output:

Bus 001 Device 007: ID 0582:00b2 Roland Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0
  bDeviceProtocol       255
  bMaxPacketSize0         8
  idVendor           0x0582 Roland Corp.
  idProduct          0x00b2
  bcdDevice            1.00
  iManufacturer           1 Roland
  iProduct                2 VG-99
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          167
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                2mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      2
      iInterface              0
      ** UNRECOGNIZED:  06 24 f1 01 00 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      2
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 01 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0120  1x 288 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      1
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2
      bInterfaceProtocol      1
      iInterface              0
      ** UNRECOGNIZED:  07 24 01 07 00 01 00
      ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0120  1x 288 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3
      bInterfaceProtocol      0
      iInterface              0
      ** UNRECOGNIZED:  06 24 f1 02 02 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered

------------------------------------

And the quirk entry:

{
    USB_DEVICE(0x0582, 0x00b2),
        .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
                .vendor_name = "Roland",
                .product_name = "VG-99",
                .ifnum = QUIRK_ANY_INTERFACE,
                .type = QUIRK_COMPOSITE,
                .data = (const struct snd_usb_audio_quirk[]) {
                        {
                                .ifnum = 0,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = & (const struct audioformat) {
                                        .formats = SNDRV_PCM_FMTBIT_S24_3LE,
                                        .channels = 2,
                                        .iface = 0,
                                        .altsetting = 1,
                                        .altset_idx = 1,
                                        .attributes = 0,
                                        .endpoint = 0x01,
                                        .ep_attr = 0x09,
                                        .rates = SNDRV_PCM_RATE_CONTINUOUS,
                                        .rate_min = 44100,
                                        .rate_max = 44100,
                                }
                        },
                        {
                                .ifnum = 1,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = & (const struct audioformat) {
                                        .formats = SNDRV_PCM_FMTBIT_S24_3LE,
                                        .channels = 2,
                                        .iface = 1,
                                        .altsetting = 1,
                                        .altset_idx = 1,
                                        .attributes = UAC_EP_CS_ATTR_FILL_MAX,
                                        .endpoint = 0x82,
                                        .ep_attr = 0x05,
                                        .rates = SNDRV_PCM_RATE_CONTINUOUS,
                                        .rate_min = 44100,
                                        .rate_max = 44100,
                                }
                        },
                        {
                                .ifnum = 2,
                                .type = QUIRK_MIDI_FIXED_ENDPOINT,
                                .data = & (const struct
snd_usb_midi_endpoint_info) {
                                        .out_cables = 0x0007,
                                        .in_cables  = 0x0007
                                }
                        },
                        {
                                .ifnum = -1
                        }
                }
        }
},
