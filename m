From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: more sample formats?  too little place left.
Date: Mon, 3 Jun 2002 16:00:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002201c20b0f$6b7e75e0$0400a8c0@martijn>
References: <s5h3cw8gzvo.wl@alsa2.suse.de><007e01c208d2$31938120$0400a8c0@martijn> <s5hlm9wfper.wl@alsa2.suse.de>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > it seems that USB audio supports 24 bit sample in 3 bytes format.
> > > and additionally i've found there are 20bit and 18bit sample formats.
> > > the world is large...
> > >
> > > an arising problem is that the number of formats is limited to 32.
> > > already 26 format types are used.  the rest are only 6, and not enough
> > > if we put BE/LE and signed/unsigned for new formats, too.
> > >
> > > how can we solve this?  extend to 64bit?  no, it has too overhead.
> > > add a new field for special formats?
> > >
> > > perhaps we don't need all of them for such special formats.
> > > there are no unsigned types for such formats.
> > > but anyway the left resource is too small.
> >
> > are formats currently a bit in a 'supported formats' flag?
>
> yes.
>
> the problem is that the bitmask is defined as unsigned int, und
> limitied to 31 bits.
>
> if it's only in alsa driver, then it wouldn't be serious.
> but apparently alsa-lib defines also mask as an integer.
> theoretically, redefining this type won't cause any compatibility
> problems, though, as long as you link alsa-lib dynamically.
> (it's an obvious advantage of "complicated" alsa api :)

perhaps not using a bitmask, but having two ioctls, one giving
the number of supported formats, the other returning the format
description taking an index argument, not unlike the EASI interface
, might be better.

--martijn




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
