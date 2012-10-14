From: Pete Leigh <pete.leigh@gmail.com>
Subject: Support for Roland VG-99
Date: Sun, 14 Oct 2012 02:34:41 +0100
Message-ID: <CABn3OEHiYV2oZQZJ0Dgf=vjpT+PH+GFz3Bx1QOidBjL6b51kZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0447a10fc8947004cbfaece5
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B358261727
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2012 03:34:42 +0200 (CEST)
Received: by mail-ia0-f179.google.com with SMTP id k25so2792573iah.38
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2012 18:34:41 -0700 (PDT)
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

--f46d0447a10fc8947004cbfaece5
Content-Type: text/plain; charset=ISO-8859-1

Hi,

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

--f46d0447a10fc8947004cbfaece5
Content-Type: application/octet-stream; name=vg99-quirk
Content-Disposition: attachment; filename=vg99-quirk
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h89hb8190

ewogICAgVVNCX0RFVklDRSgweDA1ODIsIDB4MDBiMiksCgkuZHJpdmVyX2luZm8gPSAodW5zaWdu
ZWQgbG9uZykgJiAoY29uc3Qgc3RydWN0IHNuZF91c2JfYXVkaW9fcXVpcmspIHsKCQkudmVuZG9y
X25hbWUgPSAiUm9sYW5kIiwKCQkucHJvZHVjdF9uYW1lID0gIlZHLTk5IiwKCQkuaWZudW0gPSBR
VUlSS19BTllfSU5URVJGQUNFLAoJCS50eXBlID0gUVVJUktfQ09NUE9TSVRFLAoJCS5kYXRhID0g
KGNvbnN0IHN0cnVjdCBzbmRfdXNiX2F1ZGlvX3F1aXJrW10pIHsKCQkJewoJCQkJLmlmbnVtID0g
MCwKCQkJCS50eXBlID0gUVVJUktfQVVESU9fRklYRURfRU5EUE9JTlQsCgkJCQkuZGF0YSA9ICYg
KGNvbnN0IHN0cnVjdCBhdWRpb2Zvcm1hdCkgewoJCQkJCS5mb3JtYXRzID0gU05EUlZfUENNX0ZN
VEJJVF9TMjRfM0xFLAoJCQkJCS5jaGFubmVscyA9IDIsCgkJCQkJLmlmYWNlID0gMCwKCQkJCQku
YWx0c2V0dGluZyA9IDEsCgkJCQkJLmFsdHNldF9pZHggPSAxLAoJCQkJCS5hdHRyaWJ1dGVzID0g
MCwKCQkJCQkuZW5kcG9pbnQgPSAweDAxLAoJCQkJCS5lcF9hdHRyID0gMHgwOSwKCQkJCQkucmF0
ZXMgPSBTTkRSVl9QQ01fUkFURV9DT05USU5VT1VTLAoJCQkJCS5yYXRlX21pbiA9IDQ0MTAwLAoJ
CQkJCS5yYXRlX21heCA9IDQ0MTAwLAoJCQkJfQoJCQl9LAoJCQl7CgkJCQkuaWZudW0gPSAxLAoJ
CQkJLnR5cGUgPSBRVUlSS19BVURJT19GSVhFRF9FTkRQT0lOVCwKCQkJCS5kYXRhID0gJiAoY29u
c3Qgc3RydWN0IGF1ZGlvZm9ybWF0KSB7CgkJCQkJLmZvcm1hdHMgPSBTTkRSVl9QQ01fRk1UQklU
X1MyNF8zTEUsCgkJCQkJLmNoYW5uZWxzID0gMiwKCQkJCQkuaWZhY2UgPSAxLAoJCQkJCS5hbHRz
ZXR0aW5nID0gMSwKCQkJCQkuYWx0c2V0X2lkeCA9IDEsCgkJCQkJLmF0dHJpYnV0ZXMgPSBVQUNf
RVBfQ1NfQVRUUl9GSUxMX01BWCwKCQkJCQkuZW5kcG9pbnQgPSAweDgyLAoJCQkJCS5lcF9hdHRy
ID0gMHgwNSwKCQkJCQkucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV9DT05USU5VT1VTLAoJCQkJCS5y
YXRlX21pbiA9IDQ0MTAwLAoJCQkJCS5yYXRlX21heCA9IDQ0MTAwLAoJCQkJfQoJCQl9LAoJCQl7
CgkJCQkuaWZudW0gPSAyLAoJCQkJLnR5cGUgPSBRVUlSS19NSURJX0ZJWEVEX0VORFBPSU5ULAoJ
CQkJLmRhdGEgPSAmIChjb25zdCBzdHJ1Y3Qgc25kX3VzYl9taWRpX2VuZHBvaW50X2luZm8pIHsK
CQkJCQkub3V0X2NhYmxlcyA9IDB4MDAwNywKCQkJCQkuaW5fY2FibGVzICA9IDB4MDAwNwoJCQkJ
fQoJCQl9LAoJCQl7CgkJCQkuaWZudW0gPSAtMQoJCQl9CgkJfQoJfQp9LAo=
--f46d0447a10fc8947004cbfaece5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--f46d0447a10fc8947004cbfaece5--
