From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Full support for Creamware Noah and SFP
Date: Wed, 10 Mar 2004 11:28:39 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403100909080.2498-100000@studcom.urz.uni-halle.de>
References: <1078875033.13147.42.camel@zauberwald.zeitgeist>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1078875033.13147.42.camel@zauberwald.zeitgeist>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Willie Sippel <willie@froq.net>
Cc: Hartmut Geissbauer <nwgbh@swissonline.ch>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Willie Sippel wrote:
> > But I'm not sure about, wether the NDA agrees in the basic alsa
> > principles. What are the developers of alsa are thinking about that
> > agreement?

AFAIK drivers for ATI hardware are developed in a similar way (ATI
gives specs under an NDA, the resulting driver is open source).

Takashi, is that right?

> I told Frank about the work you did on Noah support, and he was _very_
> impressed.

Well, there isn't much reason to be impressed, as the Noah conforms to
the USB audio specification, and the driver already implemented it.
(The only reason I had to make a change to the driver was that the
Noah and the driver, uh, didn't entirely agree on how to interpret a
minor detail of the spec.)

Tell him that NetBSD and OpenBSD have USB MIDI drivers, too.  :-)

Unlike the USB audio/MIDI parts, writing support for the vendor-
specific parts of the Noah and for the SFP PCI cards won't be a matter
of ten minutes, of course.

> It should work as follows:
> 1. Interested developers would sign the NDA.
> 2. Those developers would get the source and specs, and tell CW what
> parts need to become open to get the hardware working.

Well, I would be interested in this.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
