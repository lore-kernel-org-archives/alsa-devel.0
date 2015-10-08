From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Boss GT-001
Date: Thu, 8 Oct 2015 09:02:22 +0200
Message-ID: <alpine.DEB.2.02.1510080849080.30181@lnxricardw1.se.axis.com>
References: <1481883.Y22cmGKEIB@kamdesktop> <4761108.z7lHdDqPTH@kamdesktop>
 <4797815.2qQzYzeTe7@kamdesktop> <4911294.P8gonaEuuA@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 080D926043B
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 09:02:25 +0200 (CEST)
In-Reply-To: <4911294.P8gonaEuuA@kamdesktop>
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


On Thu, 8 Oct 2015, Keith A. Milner wrote:

> On Thursday 08 Oct 2015 01:51:20 Keith A. Milner wrote:
> > On Tuesday 06 Oct 2015 20:58:01 Keith A. Milner wrote:
> > > OK, so it seems that this hardware is substantially the same as the G=
T-100
> > > which has previously (and recently) been raised as a problem on ALSA.
> > =

> > I'm getting somewhere...
> > =

> > With the following quirk I am getting audio playback with aplay. I have=
 what
> > seems like correct MIDI interfaces working (although not fully tested).
> > =

> > However, recording does not seem to work.
> =

> I should add that, by "does not seem to work", the interface is seen, but =

> nothing records. When using audacity, for instance, the playhead seems to=
 get =

> stuck and doesn't advance.

How does it look in Wireshark? Does the isochronous transfer for the =

capture direction start?

Actually, looking at your lsusb -v dump of the GT-001, I notice the =

following:

     Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0d  EP 13 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0070  1x 112 bytes
        bInterval               1

      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8e  EP 14 IN
        bmAttributes           37
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Implicit feedback Data
        wMaxPacketSize     0x0070  1x 112 bytes
        bInterval               1

When the Isochronous Synch Type is Asynchronous, there must be a feedback =

channel where the USB device reports back information so that it can =

adjust the output sampling rate =

(http://wiki.osdev.org/Universal_Serial_Bus#Asynchronous_Endpoints).

I might be barking up the wrong tree here as I'm new to this, but it looks =

as if endpoint 0x8e is providing the feedback data, and there doesn't seem =

to be any other isochronous endpoint defined in the lsusb dump which could =

be used for the actual capture cdata.

I'm not sure what 'Implicit feedback Data' means exactly though - is the =

feedback data multiplexed with the capture data perhaps?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
