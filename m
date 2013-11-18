From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4] ASoC: simple-card: add Device Tree
 support
Date: Mon, 18 Nov 2013 11:36:18 +0000
Message-ID: <20131118113617.GC30853@e106331-lin.cambridge.arm.com>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
 <87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
 <20131115155028.GE24831@e106331-lin.cambridge.arm.com>
 <87li0m7d7c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 73E7A2615AE
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 12:36:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87li0m7d7c.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 18, 2013 at 12:42:23AM +0000, Kuninori Morimoto wrote:
> 
> Hi Mark Rutland
> 
> Thank you for your feedback
> 
> > > +- frame-master				: bool property. add this if subnode was frame master
> > > +- bitclock-master			: bool property. add this if subnode was bitclock master
> > 
> > s/was/is/
> 
> Oops, I will fix it on v5
> 
> > > +- bitclock-inversion			: bool property. add this if subnode has clock inversion
> > > +- frame-inversion			: bool property. add this if subnode has frame inversion
> > > +- clocks / system-clock-frequency	: specify subnode's clock if needed.
> > > +					  it can be specified via "clocks" if system has clock node,
> > > +                                          or "system-clock-frequency" if system doesn't have it.
> > 
> > What does "if system doesn't have it" mean? If it doesn't have a clock,
> > how does said non-existent clock have a frequency?
> 
> It means "if system doesn't support common clock".
> I will fix it

When you say "doesn't support common clock", you mean the code for that
platform is incompatible with the common clock framework? It seems very
messy to allow a Linux-internal implementation detail (which is expected
to change) to leak into a binding...

> 
> > > +static int
> > > +asoc_simple_card_sub_parse_of(struct device_node *np,
> > > +			      struct asoc_simple_dai *dai,
> > > +			      struct device_node **node)
> > > +{
> > > +	struct clk *clk;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * get node via "sound-dai = <&phandle port>"
> > > +	 * it will be used as xxx_of_node on soc_bind_dai_link()
> > > +	 */
> > > +	*node = of_parse_phandle(np, "sound-dai", 0);
> > > +	if (!*node)
> > > +		return -ENODEV;
> > > +
> > > +	/* get dai->name */
> > > +	ret = snd_soc_of_get_dai_name(np, &dai->name);
> > > +	if (ret < 0)
> > > +		goto parse_error;
> > > +
> > > +	/*
> > > +	 * bitclock-inversion, frame-inversion
> > > +	 * bitclock-master,    frame-master
> > > +	 * and specific "format" if it has
> > > +	 */
> > 
> > This comment looks confusing to me. I'm not sure it's all that helpful.
> > 
> > > +	dai->fmt = snd_soc_of_parse_daifmt(np, NULL);
> > 
> > As a general note, I'm surprised there isn't a helper that does all of
> > the above, from of_parse_phandle to here.
> 
> snd_soc_of_parse_daifmt() is the helper fucntion,
> and above comment is explaining it.
> Or, am I misunderstanding your review ?
> 

What I meant was that I am surprised there isn't a helper doing all of:
* of_parse_phandle
* snd_soc_of_get_dai_name
* snd_soc_of_parse_daifmt

It looks like a common pattern that could be factored out.

> > > +	/*
> > > +	 * dai->sysclk come from
> > > +	 *  "clolks = <&xxx>" or "system-clock-frequency = <xxx>"
> > 
> > s/clolks/clocks/
> 
> Grr, thank you
> 
> > > +	clk = of_clk_get(np, 0);
> > > +	if (IS_ERR(clk))
> > > +		of_property_read_u32(np,
> > > +				     "system-clock-frequency",
> > > +				     &dai->sysclk);
> > 
> > What it this isn't present?
> 
> If sysclk doesn't have common clock support

Huh? That's not what I asked.

What if the dt has neither a clock or a system-clock-frequency property?

> 
> > > +	/* simple-card assumes platform == cpu */
> > > +	*of_platform = *of_cpu;
> > 
> > Why? What does this imply?
> 
> This is the one of reason why this driver is "simple" card

The issue here is that I'm almost totally unfamiliar with audio
hardware, nor the ASoC bindings. If this makes sense to you and Mark
Brown then I'm happy to continue not understanding either. :)

Thanks,
Mark.
