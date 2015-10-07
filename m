From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Boss GT-001
Date: Wed, 7 Oct 2015 10:09:14 +0200
Message-ID: <alpine.DEB.2.02.1510071000020.17839@lnxricardw1.se.axis.com>
References: <1481883.Y22cmGKEIB@kamdesktop>
 <alpine.DEB.2.02.1510051635560.19610@lnxricardw1.se.axis.com>
 <1837042.8ri5iYFGVx@kamdesktop> <4761108.z7lHdDqPTH@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A3D432658CB
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 10:09:16 +0200 (CEST)
In-Reply-To: <4761108.z7lHdDqPTH@kamdesktop>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 'Clemens Ladisch' <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


On Tue, 6 Oct 2015, Keith A. Milner wrote:

> OK, so it seems that this hardware is substantially the same as the GT-10=
0 =

> which has previously (and recently) been raised as a problem on ALSA.
> =

> Clemens Ladisch wrote:
> > Aaron Spike wrote:
> > > On Sat, Jan 10, 2015 at 2:41 PM, Clemens Ladisch wrote:
> > > > There is something that cannot be derived from the descriptors.
> > > =

> > > In a nutshell, what would someone who knew what they were doing do in=
 this
> > > situation?
> > =

> > 1. Use some USB sniffer to find out what commands the Windows driver se=
nds.
> > 2. Reverse engineer the firmware.
> > =

> =

> I'm going to attempt to capture some USB data using this device in Window=
s. If =

> I do this, is there an accepted method for uploading the capture so it ca=
n be =

> posted here?
> =

> At this point, I'm not 100% sure what the capture format is going to be...

I just went down this road while researching the Zoom R16. There's a =

Windows application called USBPCap which can sniff an USB bus and dump =

packets in .pcap format. A reasonally recent version of Wireshark can then =

be used to analyze the data, as it supports the USBPCap output format from =

a certain version (FWIW, the version of Wireshark included with Debian =

Jessie works fine).

The corresponding dumps on Linux can be done by loading the usbmon module =

into the kernel. This allows Wireshark to sniff the USB buses.

I learned though that although Wireshark is happy reading the .pcap files =

produced by USBPCap, the resulting dumps can look quite different from =

what Wireshark sniffs in Linux, which initially took me aback. At least =

when it comes to USBPcap I think the reason is that the program actually =

sniffs the data halfway up (if not at the top of) the Windows protocol =

stack, meaning that there's data in the dump that does not actually occur =

on the wire. I'm not sure at what level usbmon sniffs, but it looks closer =

to what I'd expect on the physical cable.

In practice, all data is there in both cases, but it takes a bit of =

practice to actually compare the two successfully. Especially when it =

comes to isochronous packets (used for audio data transfer), the USBPcap =

format decodes the individual packets, whereas a dump generated via usbmon =

just delivered one large blob of data, which included both the isochronous =

packet headers and associated payload. Perhaps a more recent Wireshark =

might fare better; at the time the level of detail was sufficient for me =

so I didn't pursue it any further.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
