From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: RME96 driver patch
Date: Mon, 6 Jan 2003 18:52:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301061851560.551-100000@pnote.perex-int.cz>
References: <200301061851.44248.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA04105
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 18:55:32 +0100
In-Reply-To: <200301061851.44248.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Martin Langer <martin-langer@gmx.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Jan 2003, Anders Torger wrote:

> On Monday 06 January 2003 18.23, Jaroslav Kysela wrote:
> > On Mon, 6 Jan 2003, Martin Langer wrote:
> > > On Sun, Jan 05, 2003 at 04:46:47PM +0100, Anders Torger wrote:
> > > > The rme32 driver is based on the rme96 driver, so I suppose
> > > > Martin may be interested by this patch, but perhaps wait a while
> > > > and see if someone complains on this patch. It works fine for me
> > > > though, so far
> > > >
> > > > :-)
> > >
> > > I have to wait, because my external AD/DA converter is ATM out of
> > > order. So I have no possiblity for controlling my card behaviour
> > > ...
> > >
> > > But I have another related question:
> > > If the card is in slave mode without an input signal and I'm
> > > starting playing: Should the card jump into master mode therefore?
> >
> > No, an error return code is sufficient. Users know that the card is
> > in slave mode.
> 
> In the case of the RME96 driver, this is no error, the card works with 
> slave mode active and no input signal. As stated in a previous mail, 
> I'm quite sure that it runs in master mode until the cards get a signal 
> to synch with. This is how RME9652 works (hardware and driver), and I 
> like that behaviour, so I have that in the RME96 driver as well.

If hardware supports this behaviour, then it's also ok for me.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
