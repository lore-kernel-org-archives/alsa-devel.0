From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RME96 driver patch
Date: Mon, 6 Jan 2003 18:23:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301061822290.551-100000@pnote.perex-int.cz>
References: <20030106172447.GA19927@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA03662
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 18:26:24 +0100
In-Reply-To: <20030106172447.GA19927@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Anders Torger <torger@ludd.luth.se>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Jan 2003, Martin Langer wrote:

> On Sun, Jan 05, 2003 at 04:46:47PM +0100, Anders Torger wrote:
> > 
> > The rme32 driver is based on the rme96 driver, so I suppose Martin may 
> > be interested by this patch, but perhaps wait a while and see if 
> > someone complains on this patch. It works fine for me though, so far 
> > :-)
> 
> I have to wait, because my external AD/DA converter is ATM out of order. So
> I have no possiblity for controlling my card behaviour ...
> 
> But I have another related question:
> If the card is in slave mode without an input signal and I'm starting
> playing: Should the card jump into master mode therefore?

No, an error return code is sufficient. Users know that the card is in 
slave mode.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
