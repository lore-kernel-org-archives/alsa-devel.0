From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Tascam US-122L - Corrupt USB descriptor
Date: Wed, 13 Apr 2016 11:02:32 +0200
Message-ID: <alpine.DEB.2.02.1604131049290.9999@lnxricardw1.se.axis.com>
References: <3d5a5368f3a43ffc0114daf09c306d7e.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 55AF82604D6
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 11:02:39 +0200 (CEST)
In-Reply-To: <3d5a5368f3a43ffc0114daf09c306d7e.squirrel@mungewell.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Simon Wood <simon@mungewell.org>
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On Wed, 13 Apr 2016, Simon Wood wrote:

> Hi all,
> I have been struggling for the past few days to get a Tascam US-122L (USB
> sound-card/midi interface) working, despite reading numerous forum
> postings I have only been able to get the midi portion working.
> =

> I note that the USB descriptor seems to be corrupt. It declares 2
> interfaces, but then describes 3 separate with the same interface number
> for the last 2... could it be that this is confusing the Linux USB stack?
> =

> I have attached a copy of the descriptor and an annotated 'lsusb -vv'.
> ...

My experience of lsusb is that it can get confused and report errors when =

there in fact aren't any, especially with vendor specific classes which it =

really can only guess at.

> =

>   Configuration Descriptor:
> --
> 00000010  _____ 09 02 48 00 02 01  00 80 f0 ______________  |....H.......=
....|
> --
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           72
>     bNumInterfaces          2					<------- 2 interfaces
>     bConfigurationValue     1
>     iConfiguration          0 =

>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              480mA
> =

> =

>     Interface Descriptor:					<------ that's 1
> --
> 00000010  _________________________________ 09 04 00 00 00  |....H.......=
....|
> 00000020  ff 00 00 00 ____________________________________  |............=
....|
> --
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0 =

>       bInterfaceProtocol      0 =

>       iInterface              0 =

> =

>     Interface Descriptor:					<------ that's 2
> --
> 00000020  ___________ 09 04 01 00  00 ff 00 00 00 ________  |............=
....|
> --
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0 =

>       bInterfaceProtocol      0 =

>       iInterface              0 =

> =

>     Interface Descriptor:					<------ that's 3, err wait...
> --
> 00000020  _______________________________________ 09 04 01  |............=
....|
> 00000030  01 04 ff 00 00 00 ______________________________  |..........N.=
....|
> --
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1					<------ interface duplicate!!
>       bAlternateSetting       1
>       bNumEndpoints           4

My knowledge of USB is sketchy since I rarely work with it on this level =

(I was working on some quirks for the Zoom R16 a while ago), but I note =

that bAlternateSetting is 1, which I think means that the device offers =

two specific ways of implementing interface no. 1. Actually, IIRC, =

alternate setting 0 normally means an interface which essentially is =

disabled, and it would certainly seem so here as the two first interface =

descriptors have 0 endpoints, whereas the one here has 4.

My wild guess is that this interface 1 / altsetting 1 represents the =

actual device in normal operation, as has 4 endpoints ...

>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0 =

>       bInterfaceProtocol      0 =

>       iInterface              0 =

> =

>       Endpoint Descriptor:
> ...
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x004e  1x 78 bytes
> ...
>       Endpoint Descriptor:
> ...
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x004e  1x 78 bytes
>  ...
>       Endpoint Descriptor:
> ...
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0009  1x 9 bytes
> ...
>       Endpoint Descriptor:
> ...
>         bDescriptorType         5
>         bEndpointAddress     0x04  EP 4 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               4
>         bRefresh                0
>         bSynchAddress           0

... the two first of which are the audio interface (which uses isochronous =

data transfers), and the other two are MIDI (bulk).

I think (but could be wrong so don't take my word for it) it's a bit =

unusual that both MIDI and audio are represented by a single interface, =

but it certainly seems to be the case here.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
