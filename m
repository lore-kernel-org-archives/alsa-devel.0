From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] sound drivers select'ing ISAPNP must depend on PNP && ISA
Date: Sat, 23 Jul 2005 18:48:01 +0200
Message-ID: <20050723164801.GE3160@stusta.de>
References: <Pine.LNX.4.58.0507171702030.12446@be1.lrz> <20050719163640.GK5031@stusta.de> <Pine.LNX.4.58.0507192232230.4182@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7D9D7188
	for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2005 18:48:07 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507192232230.4182@be1.lrz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bodo Eggert <7eggert@gmx.de>
Cc: perex@suse.cz, akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 19, 2005 at 10:50:53PM +0200, Bodo Eggert wrote:
> On Tue, 19 Jul 2005, Adrian Bunk wrote:
> > On Sun, Jul 17, 2005 at 05:07:48PM +0200, Bodo Eggert wrote:
> 
> > > In sound/isa/Kconfig, select ISAPNP and depend on ISAPNP are intermixed, 
> > > resulting in funny behaviour. (Soundcarts get selectable if other 
> > > soundcards are selected).
> > > 
> > > This patch changes the "depend on ISAPNP"s to select.
> > >...
> > 
> > I like the idea of this patch, but it brings to more drivers to a 
> > violation of the "if you select something, you have to ensure that the 
> > dependencies of what you select are fulfilled" rule causing link errors 
> > with invalid .config's.
> 
> That should be mentioned in kconfig-language.txt. OTOH, the build system
> should automatically propagate the dependencies. I asume that should be
> easy, except for having the time to implement that.
>...

There are nontrivial problems:
E.g. what should happen if you select option A that depends on (B || C)?

There's one opinion that options should be either select'able _or_ user 
visible.

The current policy in the kernel is not 100% dogmatic regarding this 
issue, but it shouldn't be violated without a good reason.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
