From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [Alsa-devel] DSP2000 C-PORT and MIDI input
Date: Mon, 26 Apr 2004 18:12:14 +0200 (METDST)
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <Pine.HPX.4.33n.0404261625050.25756-100000@studcom.urz.uni-halle.de>
References: <408CD917.3070700@gmx.de>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-reply-to: <408CD917.3070700-Mmb7MZpHnFY@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: "Matthew Skinner, Sound and Music Tech Support" <matt-h1laINijYsWj7JPsHwAtPg@public.gmane.org>
Cc: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Lukas Degener wrote:
> Hi everybody and sorry for posting this to both, lad and alsa-dev,
> i was not sure which one fits better.

alsa-devel would be appropriate, but non-subscribers cannot post
there, so I'm keeping linux-audio-dev in the CCs.

> Concerning the issue with non-functional midi in on the DSP2000 c-port:
> Someone on lau(Clemens?) said the problem is a lack of information an
> how to enable some interrupts.

>From what I've heard, interrupts just don't happen.  The MIDI receiver
is part of the ICE1712 chip, so, apparently, the MIDI input isn't
enabled or in power saving mode or something like that.

MIDI input works with this driver on ICE1712-based cards from other
vendors, so this seems to be some Hoontech-specific configuration
issue.

> > Matthew Skinner, Sound and Music Tech Support wrote:
> >
> > > If you can program in c++ and want to get the midi io working
> > > on the cport then let me know what you need.

I need to know how exactly the box configuration registers(?) are to
be initialized for DSP* cards.  The driver currently fiddles with
three bits named MIDIIN, MIDI1, and MIDI2, but their function seems to
be more complex than the names imply.

And the driver doesn't actually know about the C-Port.  There are two
known EEPROM subdevice IDs: 0x1712/0x1412 for the DSP24, and
0x1712/0x1416 for the Media7.1.  I guess the C-Port uses one of these
IDs?  (Otherwise, this would explain why the C-Port isn't initialized
completely.)


Regards,
Clemens
