From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [2.6 patch] sound drivers select'ing ISAPNP must depend on PNP
 && ISA
Date: Sun, 24 Jul 2005 11:39:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507241112150.5658@be1.lrz>
References: <Pine.LNX.4.58.0507171702030.12446@be1.lrz> <20050719163640.GK5031@stusta.de>
 <Pine.LNX.4.58.0507192232230.4182@be1.lrz> <20050723164801.GE3160@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28C2F1B4
	for <alsa-devel@alsa-project.org>; Sun, 24 Jul 2005 11:38:39 +0200 (MEST)
In-Reply-To: <20050723164801.GE3160@stusta.de>
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

On Sat, 23 Jul 2005, Adrian Bunk wrote:
> On Tue, Jul 19, 2005 at 10:50:53PM +0200, Bodo Eggert wrote:

> > OTOH, the build system
> > should automatically propagate the dependencies. I asume that should be
> > easy, except for having the time to implement that.
> >...
> 
> There are nontrivial problems:
> E.g. what should happen if you select option A that depends on (B || C)?

You should in effect depend on ($original_depends) && (B || C). You'll 
just need to append all (recursive) dependencies in the selecting option.


last_length:=-1; /* impossible value */
while |options_with_unresolved_selects| > 0 do begin
	if |options_with_unresolved_selects| == last_length
	then goto circular_recursion_detected;
	last_length:=|options_with_unresolved_selects|;

	for i in options_with_unresolved_selects do begin
		for s in i->unresolved_selects do
			if 0 == |s->unresolved_selects|
			then begin
				add(i->depends, s->depends)
				delete_from(i->unresolved_selects, s)
			end
		if 0 == |i->unresolved_selects|
		then delete_from(options_with_unresolved_selects, i);
	end
end

> There's one opinion that options should be either select'able _or_ user 
> visible.

That would only result in ugly workarounds. Think about the kernel 
libraries. You'll want to manually select them, and you'll want to 
automatically select them, and you want both to be visible.

-- 
Funny quotes:
22. When everything's going your way, you're in the wrong lane and and going
    the wrong way.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
