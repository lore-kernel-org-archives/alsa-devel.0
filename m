From: Michal Rydlo <michal.rydlo@gmail.com>
Subject: Re: AKAI EIE PRO
Date: Mon, 8 Sep 2014 23:43:32 +0200
Message-ID: <CAEK4Y+J8MbC8+ptqm_v7=-F+cvT1kAmq17ZNAR5tDuomfPWkNA@mail.gmail.com>
References: <952265838.110247052.1410089429353.JavaMail.root@zimbra61-e11.priv.proxad.net>
 <540C43E0.5020704@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
 [74.125.82.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A8642625EF
 for <Alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 23:43:54 +0200 (CEST)
Received: by mail-we0-f181.google.com with SMTP id x48so15843620wes.12
 for <Alsa-devel@alsa-project.org>; Mon, 08 Sep 2014 14:43:54 -0700 (PDT)
In-Reply-To: <540C43E0.5020704@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Alsa-devel@alsa-project.org, humbert.olivier.1@free.fr, Martin Svensson <martin.svensson@ztealmax.se>
List-Id: alsa-devel@alsa-project.org

Hello there!

On Sun, Sep 7, 2014 at 1:39 PM, Daniel Mack <daniel@zonque.org> wrote:
>
> On 09/07/2014 01:30 PM, humbert.olivier.1@free.fr wrote:
> > if that can help, we had an user on http://www.linuxmao.org with an EIE PRO.
> > Here you have his lsusb -v :
> >
> > Bus 001 Device 006: ID 09e8:0010 AKAI  Professional M.I. Corp.
> > Couldn't open device, some information will be missing
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.00
> >   bDeviceClass          255 Vendor Specific Class
> >   bDeviceSubClass       255 Vendor Specific Subclass
> >   bDeviceProtocol       255 Vendor Specific Protocol
>
> According to the tech specs, this should be a USB hub, but it isn't. Or
> is this just one of the sub-devices? What does 'lsusb -t' say, and does
> Linux see something like a mouse or mass storage device when connected
> to one of the hub ports?
>
> Assuming that's just the audio part ...
>
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x02  EP 2 OUT
> >         bmAttributes            5
> >           Transfer Type            Isochronous
> >           Synch Type               Asynchronous
> >           Usage Type               Data
> >         wMaxPacketSize     0x009c  1x 156 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0200  1x 512 bytes
> >         bInterval               4
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x04  EP 4 OUT
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0200  1x 512 bytes
> >         bInterval               4
>
> So at least, they're not trying to hide class-specific endpoint
> descriptors here, which what I've been hoping for.
>
> I guess someone has to trace the traffic spoken to this device by the
> Windows driver. I take it this thing doesn't work on OS X with a 3rd
> party driver?

I have analyzed the protocol more than a half year ago. I even tried to
create a linux driver around it but had to stop due to lack of time.
I hope I can continue working on it in November again.

I have published what I have done so far to github few seconds ago if
anyone wants to have a look or perhaps contribute.

https://github.com/mmm444/eie-pro-linux

I can write more text about the protocol if someone is interested.

Regards,

Michal
