From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Re: RME96 driver patch
Date: Mon, 6 Jan 2003 18:51:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301061851.44248.torger@ludd.luth.se>
References: <Pine.LNX.4.33.0301061822290.551-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA04050
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 18:52:16 +0100
In-Reply-To: <Pine.LNX.4.33.0301061822290.551-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Martin Langer <martin-langer@gmx.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 06 January 2003 18.23, Jaroslav Kysela wrote:
> On Mon, 6 Jan 2003, Martin Langer wrote:
> > On Sun, Jan 05, 2003 at 04:46:47PM +0100, Anders Torger wrote:
> > > The rme32 driver is based on the rme96 driver, so I suppose
> > > Martin may be interested by this patch, but perhaps wait a while
> > > and see if someone complains on this patch. It works fine for me
> > > though, so far
> > >
> > > :-)
> >
> > I have to wait, because my external AD/DA converter is ATM out of
> > order. So I have no possiblity for controlling my card behaviour
> > ...
> >
> > But I have another related question:
> > If the card is in slave mode without an input signal and I'm
> > starting playing: Should the card jump into master mode therefore?
>
> No, an error return code is sufficient. Users know that the card is
> in slave mode.

In the case of the RME96 driver, this is no error, the card works with 
slave mode active and no input signal. As stated in a previous mail, 
I'm quite sure that it runs in master mode until the cards get a signal 
to synch with. This is how RME9652 works (hardware and driver), and I 
like that behaviour, so I have that in the RME96 driver as well.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
