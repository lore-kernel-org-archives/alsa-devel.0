From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [2.6 patch] sound drivers select'ing ISAPNP must depend on PNP
 && ISA
Date: Tue, 19 Jul 2005 22:50:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507192232230.4182__32067.0951427475$1121807434$gmane$org@be1.lrz>
References: <Pine.LNX.4.58.0507171702030.12446@be1.lrz> <20050719163640.GK5031@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 49F15175
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 22:50:04 +0200 (MEST)
In-Reply-To: <20050719163640.GK5031@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: Bodo Eggert <7eggert@gmx.de>, perex@suse.cz, akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Jul 2005, Adrian Bunk wrote:
> On Sun, Jul 17, 2005 at 05:07:48PM +0200, Bodo Eggert wrote:

> > In sound/isa/Kconfig, select ISAPNP and depend on ISAPNP are intermixed, 
> > resulting in funny behaviour. (Soundcarts get selectable if other 
> > soundcards are selected).
> > 
> > This patch changes the "depend on ISAPNP"s to select.
> >...
> 
> I like the idea of this patch, but it brings to more drivers to a 
> violation of the "if you select something, you have to ensure that the 
> dependencies of what you select are fulfilled" rule causing link errors 
> with invalid .config's.

That should be mentioned in kconfig-language.txt. OTOH, the build system
should automatically propagate the dependencies. I asume that should be
easy, except for having the time to implement that.


BTW: How can you select something to be at least a module?
BTW2: In bool options, depending on FOO seems to be equal to depending on 
      FOO!=n. Is this assumption correct?

-- 
Top 100 things you don't want the sysadmin to say:
49. What's this switch for anyways...?


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
