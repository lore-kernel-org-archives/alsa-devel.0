From: Anders Torger <torger@ludd.luth.se>
Subject: Re: RME96 driver patch
Date: Mon, 6 Jan 2003 18:45:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301061845.12968.torger@ludd.luth.se>
References: <200301051646.47991.torger@ludd.luth.se> <20030106172447.GA19927@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA03966
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 18:45:46 +0100
In-Reply-To: <20030106172447.GA19927@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: martin-langer@gmx.de, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 06 January 2003 18.24, Martin Langer wrote:
> On Sun, Jan 05, 2003 at 04:46:47PM +0100, Anders Torger wrote:
> > The rme32 driver is based on the rme96 driver, so I suppose Martin
> > may be interested by this patch, but perhaps wait a while and see
> > if someone complains on this patch. It works fine for me though, so
> > far
> >
> > :-)
>
> I have to wait, because my external AD/DA converter is ATM out of
> order. So I have no possiblity for controlling my card behaviour ...
>
> But I have another related question:
> If the card is in slave mode without an input signal and I'm starting
> playing: Should the card jump into master mode therefore?

No, (I think) that is not necessary. I think it will go master 
automatically (without changing the flag), since there is no clock to 
synch against. If a cable with a valid signal is inserted while 
playing, the sample rate will change to that on the input. I'm quite 
sure that this is how it works, although I can't remember that I have 
explicitly verified it.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
