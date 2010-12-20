From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: clean up cache accesser
Date: Mon, 20 Dec 2010 17:09:00 +0000
Message-ID: <1292864940.29185.19.camel@dplaptop.localdomain>
References: <s5hei9czeep.wl%tiwai@suse.de>
	<20101220152709.GJ26706@rakim.wolfsonmicro.main>
	<s5h4oa8zbe4.wl%tiwai@suse.de> <s5h1v5czb5m.wl%tiwai@suse.de>
	<s5hzks0xwjy.wl%tiwai@suse.de> <s5hy67kxwir.wl%tiwai@suse.de>
	<s5hwrn4xwdc.wl%tiwai@suse.de>
	<1292862469.29185.7.camel@dplaptop.localdomain>
	<s5hsjxsxugd.wl%tiwai@suse.de> <20101220165421.GE14986@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33D3E103906
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 18:08:18 +0100 (CET)
In-Reply-To: <20101220165421.GE14986@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-20 at 16:54 +0000, Mark Brown wrote:
> On Mon, Dec 20, 2010 at 05:47:13PM +0100, Takashi Iwai wrote:
> 
> > Yes, this would be safer.  I didn't put it since I wasn't sure whether
> > BUG() content is also expanded at each caller.  If yes, it would
> > bloat.   (Alternatively we may use snd_BUG_ON() -- it's built in only
> > when CONFIG_SND_DEBUG is set.)
> 
> That's entirely up to the compiler - inline is purely advice and may
> well be completely ignored by the compile (and of course functions that 
> aren't marked inline may be inlined if it decides that's useful).

One way to enforce the expansion of inline functions on gcc is to use
__attribute__ ((always_inline)).  Generally it is best left up to the
compiler to perform the inling if it so deems necessary.

> One reason for making it a BUG() is that if we get far enough for the
> check to go off when doing actual register lookups we've hit a definite
> bug in the code.

By performing the check at *_init, it will be impossible for the code to
ever reach any of the read()/write() functions if an unsupported word
size has been passed in.  The downside is that we depend on the
implementers of the *_init functions to perform this check.

Thanks,
Dimitrios
