From: Dave Maley <dmaley@nc.rr.com>
Subject: Re: Re: rmedigicontrol error w/ 2.6.11 based kernels
Date: Fri, 17 Jun 2005 17:38:16 -0400
Message-ID: <1119044296.19620.64.camel@kodos.rdu.redhat.com>
References: <1118985708.4845.7.camel@homer> <20050617185440.GA3067@tuba>
	 <1119035061.19620.42.camel@kodos.rdu.redhat.com>
	 <20050617212503.GA3272@tuba>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8865315E
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 23:38:18 +0200 (MEST)
In-Reply-To: <20050617212503.GA3272@tuba>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: postmaster@robertvetter.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-06-17 at 23:25 +0200, Martin Langer wrote:
> On Fri, Jun 17, 2005 at 03:04:21PM -0400, Dave Maley wrote:
> > On Fri, 2005-06-17 at 20:54 +0200, Martin Langer wrote:
> > > On Fri, Jun 17, 2005 at 01:21:48AM -0400, Dave Maley wrote:
> > > > Hello.  I've been happily using rmedigicontrol for a while now (thanks
> > > > for the great app) but have run into a problem when running 2.6.11 based
> > > > kernels.  My audio workstation runs Fedora Core 3 and w/ the 2.6.9 and
> > > > 2.6.10 based kernels rmedigicontrol works great.  However when I run 1
> > > > of the 2.6.11 based kernels I get this error:
> > > > 
> > > > [dave@homer DOWNLOADS]$ rmedigicontrol
> > > > rmedigicontrol: control.c:1686: snd_ctl_elem_info_get_items: Assertion
> > > > `obj->type == SND_CTL_ELEM_TYPE_ENUMERATED' failed.
> > > > Aborted
> > > 
> > > There was a change in the mixer (enumerates) and I forgot to change
> > > rmedigicontrol, too. But this patch removes 
> > > "snd_ctl_elem_value_get_enumerated()" for the rme32/rme96 cards now.
> > > The patch is only tested with a rme32 card here.
> > 
> > Thanks much for the quick response.  I'll test this patch w/ my digi96/8
> > PST card and let you know how things go.
> 
> Please try this patch instead. The former one is wrong. Sorry.

No problem at all.  I'll hopefully get this tested once home this
evening ...

Thanks again!

~Dave

> 
> 
> martin
-- 
"A fool and his money are soon parted. I would pay anyone a lot of
money to explain that to me."
-Homer J Simpson



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
