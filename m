From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Tue, 29 Jul 2008 20:53:05 +0200
Message-ID: <20080729205305.3ce547de.krzysztof.h1@poczta.fm>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>
	<4883632A.8090106@keyaccess.nl> <4887A28F.90506@keyaccess.nl>
	<20080724072620.4197510c.krzysztof.h1@poczta.fm>
	<48884BD4.3010308@keyaccess.nl> <s5hy73maula.wl%tiwai@suse.de>
	<488E1249.7020401@keyaccess.nl> <s5hd4kwdeso.wl%tiwai@suse.de>
	<488F25EE.4080104@keyaccess.nl> <s5hsktsbw3v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D91910390E
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 20:47:55 +0200 (CEST)
In-Reply-To: <s5hsktsbw3v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 29 Jul 2008 16:31:16 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 29 Jul 2008 16:15:10 +0200,
> Rene Herman wrote:
> > 
> > > At Mon, 28 Jul 2008 20:39:05 +0200,
> > > Rene Herman wrote:
> > >> On 28-07-08 17:37, Takashi Iwai wrote:
> > >>
> > >>> Well, I still prefer folding lines to fit 80-column - of course
> > >>> only if the result is somewhat reasonable and more readable.
> > >> Which it absolutely never is, because if it were, the original 
> > >> programmer would've already formatted it that way.
> > > 
> > > ... only if the original author respected the standard CodingStyle.
> > > Many old ALSA codes are not in that category.
> > > 
> > > Honestly, I don't mind much to keep them as they are now, even though
> > > checkpatch grumbles, if the author (or the heir) wants to keep it
> > > intentionally even after reading the CodingStyle text carefully...
> > 
> > I'm also definitely not speaking about things such as function headers 
> > which needlessly walk of to the far right, but specifically about stuff 
> > where the formatting _not_ inside 80 cols made things much easier to 
> > read. In this case, my specific comments were about:
> > 
> > 1) mixer element macros
> > 
> > Many spots in this patchset, but for IMO most clearly bad example:
> > 
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2008-July/009272.html
> > 
> > See the cmi8330 ones.
> 
> This kind of change isn't always bad.  The problem is that the
> expressions aren't consistent through the whole list.  If the same
> style is used for each element, e.g.
> 
> WSS_DOUBLE("LONG NAME HERE", 0,
> 	   LEFT_REG, RIGHT_REG,
> 	   0, 1, 2, 3),
> 
> then it'll be easier to compare each item than before.
> 
> A general problem of such macros or functions with many arguments is
> that you can loose easily the relationship of each argument, because
> they are listed just plainly.  Breaking lines properly could help a
> bit.
> 
> > Not only do these kind of changes muddy up a patch, they muddy up the 
> > result as well. Hate it...
> > 
> > 2) debug printks
> > 
> > For one example here, see:
> > 
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2008-July/008978.html
> > 
> > /snd_wss_debug
> > 
> > Bad, bad, triply bad.
> 
> This change is actually buggy.  Each second printk should have no
> KERN_* prefix.  KERN_* prefix is only for the beginning of the line.
> 
> A more better fix would be to rewrite this to use a loop, BTW.
> 

I'll undo some damage I have done.

> > 3) trivial switches, although I don't feel hugely strongly about those.
> > 
> > Example:
> > 
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2008-July/009314.html
> > 
> > /snd_wss_chip_id
> 
> This is really trivial and fine to keep in the old way.
> 

I like the new one - when case lines stand out from the code.

BTW, I am one of people who use only 80 character terminals. I just use xterm
and vim even in X11.

This set of patches has a gray area: the ad1848-lib and ad1848.h. All changes into
these files are killed by the end of set as the files are deleted. It is not worth 
to be picky about changes into them.

Regards,
Krzysztof

----------------------------------------------------------------------
Nie dla mieczakow!
Sprawdz >>> http://link.interia.pl/f1e93
