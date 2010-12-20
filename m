From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: clean up cache accesser
Date: Mon, 20 Dec 2010 16:54:21 +0000
Message-ID: <20101220165421.GE14986@sirena.org.uk>
References: <s5hei9czeep.wl%tiwai@suse.de>
	<20101220152709.GJ26706@rakim.wolfsonmicro.main>
	<s5h4oa8zbe4.wl%tiwai@suse.de> <s5h1v5czb5m.wl%tiwai@suse.de>
	<s5hzks0xwjy.wl%tiwai@suse.de> <s5hy67kxwir.wl%tiwai@suse.de>
	<s5hwrn4xwdc.wl%tiwai@suse.de>
	<1292862469.29185.7.camel@dplaptop.localdomain>
	<s5hsjxsxugd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E7E07103906
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 17:54:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsjxsxugd.wl%tiwai@suse.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 05:47:13PM +0100, Takashi Iwai wrote:

> Yes, this would be safer.  I didn't put it since I wasn't sure whether
> BUG() content is also expanded at each caller.  If yes, it would
> bloat.   (Alternatively we may use snd_BUG_ON() -- it's built in only
> when CONFIG_SND_DEBUG is set.)

That's entirely up to the compiler - inline is purely advice and may
well be completely ignored by the compile (and of course functions that 
aren't marked inline may be inlined if it decides that's useful).

I'd be inclined to just not mark the functions inline.

> Anyway, such a check should have been done rather at initialization.

One reason for making it a BUG() is that if we get far enough for the
check to go off when doing actual register lookups we've hit a definite
bug in the code.
