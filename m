From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
	support to quirks-table
Date: Mon, 10 Mar 2014 23:33:01 -0700
Message-ID: <0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
 <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
 <531DDD04.5050902@ladisch.de>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.cyrusharmon.org (unknown [206.125.171.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 674A92608EC
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 07:33:03 +0100 (CET)
In-Reply-To: <531DDD04.5050902@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Mar 10, 2014, at 8:40 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Cyrus Harmon wrote:
>> The attached patch provides support for the Steinberg UR44 USB Audio
>> Interface. It=92s nothing more than Clemens=92 patch to support the UR22,
>> with the device ID modified for the UR44. The patch was tested with
>> kernel versions 3.12.11 and 3.12.12 and I have primarily used it with
>> a PREEMPT RT-patched 3.12.12-rt kernel.
> =

> In theory, kernel 3.11 and later should support this device without
> a quirk entry.  I guess it actually does not?

I had to rebuild an unpatched kernel on this box to convince myself that th=
e stock 3.12.12 (ft-patched) kernel doesn=92t recognize this device and, fo=
rtunately for my sanity at least, no, the stock kernel doesn=92t support th=
is device.

> I should note that on one of the systems that I used to test the patch
>> I was never able to achieve xrun-free JACK performance at -p256 -n3 as
>> I would invariably see xruns roughly once every minute.
> =

> This sounds as if the playback stream needs to be synchronized to the
> recording stream.

Interesting. I=92m not quite sure what that means and why the performance w=
ould be different between the two boxes, but if there=92s a way to get the =
latency down, I would be thrilled.

> What is the output of "lsusb -v" for this device?

Here=92s the output of lsusb -v (as seen by my patched kernel):

Bus 002 Device 003: ID 0499:150e Yamaha Corp. =

Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 =

  bDeviceProtocol       255 =

  bMaxPacketSize0        64
  idVendor           0x0499 Yamaha Corp.
  idProduct          0x150e =

  bcdDevice            2.00
  iManufacturer           1 Yamaha Corporation
  iProduct                2 Steinberg UR44
  iSerial                 0 =

  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          442
    bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0 =

    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      ** UNRECOGNIZED:  0a 24 01 00 01 34 00 02 01 02
      ** UNRECOGNIZED:  0c 24 02 01 01 01 00 02 03 00 00 00
      ** UNRECOGNIZED:  09 24 03 02 01 03 00 01 00
      ** UNRECOGNIZED:  0c 24 02 03 03 06 00 02 03 00 00 00
      ** UNRECOGNIZED:  09 24 03 04 01 01 00 03 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 =

      bInterfaceProtocol      0 =

      iInterface              0 =

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      ** UNRECOGNIZED:  07 24 01 01 01 01 00
      ** UNRECOGNIZED:  0e 24 02 01 06 03 18 02 44 ac 00 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x007e  1x 126 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      ** UNRECOGNIZED:  07 24 01 01 01 01 00
      ** UNRECOGNIZED:  0e 24 02 01 06 03 18 02 88 58 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00ea  1x 234 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      ** UNRECOGNIZED:  07 24 01 01 01 01 00
      ** UNRECOGNIZED:  0e 24 02 01 06 03 18 02 10 b1 02 00 ee 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x01c2  1x 450 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 =

      bInterfaceProtocol      0 =

      iInterface              0 =

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      ** UNRECOGNIZED:  07 24 01 04 01 01 00
      ** UNRECOGNIZED:  0e 24 02 01 06 03 18 02 44 ac 00 80 bb 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x007e  1x 126 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      ** UNRECOGNIZED:  07 24 01 04 01 01 00
      ** UNRECOGNIZED:  0e 24 02 01 06 03 18 02 88 58 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00ea  1x 234 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      ** UNRECOGNIZED:  07 24 01 04 01 01 00
      ** UNRECOGNIZED:  0e 24 02 01 06 03 18 02 10 b1 02 00 ee 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x01c2  1x 450 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 =

      bInterfaceProtocol    255 =

      iInterface              0 =

      ** UNRECOGNIZED:  07 24 01 00 01 24 00
      ** UNRECOGNIZED:  06 24 02 02 01 00
      ** UNRECOGNIZED:  09 24 03 02 01 01 01 01 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 =

      ** UNRECOGNIZED:  07 24 01 00 01 24 00
      ** UNRECOGNIZED:  06 24 02 02 01 00
      ** UNRECOGNIZED:  09 24 03 02 01 01 01 01 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 =

  bDeviceProtocol         0 =

  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0001
  Self Powered


Thanks,

Cyrus
