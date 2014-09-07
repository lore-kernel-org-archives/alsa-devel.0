From: Daniel Mack <daniel@zonque.org>
Subject: Re: AKAI EIE PRO
Date: Sun, 07 Sep 2014 13:39:12 +0200
Message-ID: <540C43E0.5020704@zonque.org>
References: <952265838.110247052.1410089429353.JavaMail.root@zimbra61-e11.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D309726512B
 for <Alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 13:39:13 +0200 (CEST)
In-Reply-To: <952265838.110247052.1410089429353.JavaMail.root@zimbra61-e11.priv.proxad.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: humbert.olivier.1@free.fr, Alsa-devel@alsa-project.org
Cc: Martin Svensson <martin.svensson@ztealmax.se>
List-Id: alsa-devel@alsa-project.org

On 09/07/2014 01:30 PM, humbert.olivier.1@free.fr wrote:
> if that can help, we had an user on http://www.linuxmao.org with an EIE PRO.
> Here you have his lsusb -v :
> 
> Bus 001 Device 006: ID 09e8:0010 AKAI  Professional M.I. Corp. 
> Couldn't open device, some information will be missing
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass       255 Vendor Specific Subclass
>   bDeviceProtocol       255 Vendor Specific Protocol

According to the tech specs, this should be a USB hub, but it isn't. Or
is this just one of the sub-devices? What does 'lsusb -t' say, and does
Linux see something like a mouse or mass storage device when connected
to one of the hub ports?

Assuming that's just the audio part ...

>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x009c  1x 156 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               4
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x04  EP 4 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               4

So at least, they're not trying to hide class-specific endpoint
descriptors here, which what I've been hoping for.

I guess someone has to trace the traffic spoken to this device by the
Windows driver. I take it this thing doesn't work on OS X with a 3rd
party driver?


Daniel
