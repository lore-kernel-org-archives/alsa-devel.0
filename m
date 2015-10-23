From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Roland/Edirol M-16DX
Date: Fri, 23 Oct 2015 10:27:51 +0200
Message-ID: <alpine.DEB.2.02.1510231017080.14239@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 98787261527
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:27:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 3A0CF1821B
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:27:54 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id P2P5bsQVBr0p for <alsa-devel@alsa-project.org>;
 Fri, 23 Oct 2015 10:27:53 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 218071806C
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:27:51 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id BACFE127
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:27:51 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id AD7ACA5
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:27:51 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by thoth.se.axis.com (Postfix) with ESMTP id AB3D034009
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:27:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


The Roland/Edirol M-16DX is a digital mixer which can also function as a =

18 channel capture / 2 channel playback USB 2.0 interface. The device has =

been added to quirks-table.h and has been reported as working with one =

problem: when playing back there's severe audio distortion at regular =

intervals (several seconds), which has been traced to the fact that the =

device utilizes the IN endpoint as an implicit feedback channel; see the =

output from lsusb -vvv from a 7 year old post by Lasse K=E4rkk=E4inen below =

for reference:

> Bus 007 Device 025: ID 0582:00c4 Roland Corp.
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               2.00
>    bDeviceClass          255 Vendor Specific Class
>    bDeviceSubClass         0
>    bDeviceProtocol       255
>    bMaxPacketSize0        64
>    idVendor           0x0582 Roland Corp.
>    idProduct          0x00c4
>    bcdDevice            0.00
>    iManufacturer           1 EDIROL
>    iProduct                2 M-16DX
>    iSerial                 0
>    bNumConfigurations      1
>    Configuration Descriptor:
>      bLength                 9
>      bDescriptorType         2
>      wTotalLength          167
>      bNumInterfaces          3
>      bConfigurationValue     1
>      iConfiguration          0
>      bmAttributes         0xc0
>        Self Powered
>      MaxPower                0mA
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        0
>        bAlternateSetting       0
>        bNumEndpoints           0
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass      1
>        bInterfaceProtocol      2
>        iInterface              0
>        ** UNRECOGNIZED:  06 24 f1 01 00 00
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        0
>        bAlternateSetting       1
>        bNumEndpoints           1
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass      2
>        bInterfaceProtocol      2
>        iInterface              0
>        ** UNRECOGNIZED:  07 24 01 01 00 01 00
>        ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 80 bb 00
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x02  EP 2 OUT
>          bmAttributes            5
>            Transfer Type            Isochronous
>            Synch Type               Asynchronous
>            Usage Type               Data
>          wMaxPacketSize     0x0038  1x 56 bytes
>          bInterval               1
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        1
>        bAlternateSetting       0
>        bNumEndpoints           0
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass      1
>        bInterfaceProtocol      2
>        iInterface              0
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        1
>        bAlternateSetting       1
>        bNumEndpoints           1
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass      2
>        bInterfaceProtocol      1
>        iInterface              0
>        ** UNRECOGNIZED:  07 24 01 07 00 01 00
>        ** UNRECOGNIZED:  0b 24 02 01 12 04 18 01 80 bb 00
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x81  EP 1 IN
>          bmAttributes           37
>            Transfer Type            Isochronous
>            Synch Type               Asynchronous
>            Usage Type               Implicit feedback Data
>          wMaxPacketSize     0x01f8  1x 504 bytes
>          bInterval               1
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        2
>        bAlternateSetting       0
>        bNumEndpoints           2
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass      1
>        bInterfaceProtocol      3
>        iInterface              0
>        ** UNRECOGNIZED:  06 24 f1 02 01 01
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x04  EP 4 OUT
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               1
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x83  EP 3 IN
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               1
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        2
>        bAlternateSetting       1
>        bNumEndpoints           2
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass      1
>        bInterfaceProtocol      3
>        iInterface              0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x04  EP 4 OUT
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               1
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x83  EP 3 IN
>          bmAttributes            3
>            Transfer Type            Interrupt
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               1

On Fri, 14 Nov 2008, Clemens confirmed this in a post:

> James Trevelyan wrote:
> > ...
> > However, what I did notice is that in all circumstances the windows
> > driver was capturing at the same time as playback, even when I was not
> > asking it to record.  This suggests to me that the comment in the driver
> > source about synchronising playback to capture has some relevance ...
> =

> Indeed.  The driver would have to send the data at the exact speed of
> the device's internal clock, and the only way to determine that clock's
> speed is to capture data.
> =

> So far I haven't found the time to rewrite the driver to support this
> synchronization mechanism.

I seem to recall reading posts not to long ago that refer to using an =

implicit feedback path; my question is, was this in fact implemented, =

meaning that a device like the M-16DX should function as expected also for =

playback?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
