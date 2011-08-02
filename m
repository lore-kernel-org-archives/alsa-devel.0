From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Wed, 3 Aug 2011 01:40:06 +0900
Message-ID: <20110802164005.GI25884@opensource.wolfsonmicro.com>
References: <65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C1361038A6
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 18:40:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hipqfn65k.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng-B29396 <B29396@freescale.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 02, 2011 at 06:13:11PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Like I've indicated several times now we should just get rid of the code
> > or hide it from the rest of the subsystem, it's being too cute for
> > vanishingly little value.  The register maps for these devices are
> > usually at most 255 registers so the memory savings are really not
> > meaningful.  I'm hoping the guys working with this device will find time
> > to look at fixing things, but if not I'd imagine we'll get to it at some
> > point in the release cycle.

> Well, there aren't so many drivers suffering from this bug, so a
> temporary fix would be easy like below (totally untested).

If we're going to do something like this I'd preserve the driver
interface that's there rather than fiddling with their reg_cache_sizes -
half the trouble here is that the meaning of that has become a bit
slippery, the current code used to be correct.

> @@ -421,7 +422,9 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
>  		return 0;
>  
>  	word_size = codec->driver->reg_word_size;
> -	for (i = 0; i < codec->driver->reg_cache_size; ++i) {
> +	if (codec->driver->reg_cache_step)
> +		step = codec->driver->reg_cache_step;
> +	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
>  		val = snd_soc_get_cache_val(codec->reg_def_copy, i,
>  					    word_size);
>  		if (!val)

I'm also really unhappy with handling this in the complex caches, I'd be
much more inclined to just disallow their use with devices with step
sizes than to add any complexity to them.
