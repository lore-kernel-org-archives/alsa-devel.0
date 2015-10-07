From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Boss GT-001
Date: Wed, 7 Oct 2015 17:20:39 +0200
Message-ID: <alpine.DEB.2.02.1510071709440.30181@lnxricardw1.se.axis.com>
References: <1481883.Y22cmGKEIB@kamdesktop> <4761108.z7lHdDqPTH@kamdesktop>
 <alpine.DEB.2.02.1510071000020.17839@lnxricardw1.se.axis.com>
 <3067439.4bLxTPZOO7@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id DB8B82614A7
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 17:20:41 +0200 (CEST)
In-Reply-To: <3067439.4bLxTPZOO7@kamdesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Keith A. Milner" <maillist@superlative.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 7 Oct 2015, Keith A. Milner wrote:

> The data I'm getting from Wireshark via USBMon seems OK from my initial
> viewing. Incidentally, Wireshark can sniff directly from usbmon interface=
s and
> exposes them as capture interfaces (at least with the version I have).

Same here. I might have been unclear in my previous message, but that is =

what I meant.

> The isochronous data appears as follows:
> =

> "54","24.767751000","host","7.14","USB","192","URB_ISOCHRONOUS

Yes, these are the isochronous packet headers.

> in","eeffffff 00000000 70000000 00000000 eeffffff 70000000...",""
       -------- -------- -------- --------
         tag ?   offset   length   status  and again (next header)

My understanding is that the isochronous data is sent one packet per frame =

on the wire (interval: 1 ms for full speed, 125 =B5s (actually called a =

microframe) for high speed) but delivering the data one packet at a time =

to the USB application would result in a lot of packet transfers, so =

isochronous data is lumped together and delivered at some more or less =

regular interval to the higher layers. So at USB API (or Wireshark) layer =

you get these 'isochronous' packets which list a bunch of headers followed =

by the corresponding data as a single 'packet', even though it's been =

assembled from several distinct ones. The 'offset' fields are relative to =

the end of the headers in the resulting packet, where the actual =

isochronous data starts.

> Wireshark also appears to decode them quite nicely.  I've pasted one of t=
he
> GET DESCRIPTOR responses below.
> ...
> DESCRIPTOR Response CONFIGURATION
> =

> Frame 9: 240 bytes on wire (1920 bits), 240 bytes captured (1920 bits) on
> interface 0
> ...
>     iInterface: 0
> UNKNOWN DESCRIPTOR
>     bLength: 6
>     bDescriptorType: 0x24 (unknown)
> INTERFACE DESCRIPTOR (1.1): class Vendor Specific
>     bLength: 9
>     bDescriptorType: 0x04 (INTERFACE)
> ...

Actually, you should be able to get the configuration information directly =

in Linux by using 'lsusb -v'. It lists the 'Unknown descriptors' in their =

entirety in hex (prefixed by 'UNRECOGNIZED:') so that you can decode them =

separately without having to examine the actual binary packet content in =

Wireshark.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
