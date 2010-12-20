From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: clean up cache accesser
Date: Mon, 20 Dec 2010 17:04:30 +0000
Message-ID: <1292864670.29185.15.camel@dplaptop.localdomain>
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
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0142103905
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 18:03:41 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-20 at 17:47 +0100, Takashi Iwai wrote:
> At Mon, 20 Dec 2010 16:27:49 +0000,
> Dimitris Papastamos wrote:
> > 
> > On Mon, 2010-12-20 at 17:05 +0100, Takashi Iwai wrote:
> > > +static inline bool set_cache_val(void *base, unsigned int idx,
> > > +				unsigned int val, unsigned int word_size)
> > > +{
> > > +	if (word_size == 1) {
> > > +		u8 *cache = base;
> > > +		if (cache[idx] == val)
> > > +			return true;
> > > +		cache[idx] = val;
> > > +	} else {
> > > +		u16 *cache = base;
> > > +		if (cache[idx] == val)
> > > +			return true;
> > > +		cache[idx] = val;
> > > +	}
> > > +	return false;
> > > +}
> > 
> > If word_size is anything other than 1 byte, the above else will try to
> > handle it and assume it is 16 bits.  I'd expect for an explicit check
> > for word_size == 2.  A switch statement would perhaps be preferred for
> > legibility.  It'd perhaps be wise to simply die via BUG() or similar if
> > an unsupported word size was passed in.
> 
> Yes, this would be safer.  I didn't put it since I wasn't sure whether
> BUG() content is also expanded at each caller.  If yes, it would
> bloat.   (Alternatively we may use snd_BUG_ON() -- it's built in only
> when CONFIG_SND_DEBUG is set.)
> 
> Anyway, such a check should have been done rather at initialization.

I'd expect macro expansion to happen before inline function expansion.

I'll send in a patch to perform this check at init time once yours has
been merged.

Thanks,
Dimitrios
