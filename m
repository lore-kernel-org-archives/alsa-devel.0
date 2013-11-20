From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4] ASoC: simple-card: add Device Tree
 support
Date: Wed, 20 Nov 2013 16:24:03 +0000
Message-ID: <20131120162403.GA22479@e106331-lin.cambridge.arm.com>
References: <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
 <87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
 <20131115155028.GE24831@e106331-lin.cambridge.arm.com>
 <87li0m7d7c.wl%kuninori.morimoto.gx@renesas.com>
 <20131118113617.GC30853@e106331-lin.cambridge.arm.com>
 <87mwl1du71.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C1DB12608D8
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 17:24:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87mwl1du71.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Takashi Iwai <tiwai@suse.de>, Simon <horms@verge.net.au>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 19, 2013 at 02:03:21AM +0000, Kuninori Morimoto wrote:
> 
> Hi Mark Rutland
> 
> Thank you for your feedback
> 
> > > It means "if system doesn't support common clock".
> > > I will fix it
> > 
> > When you say "doesn't support common clock", you mean the code for that
> > platform is incompatible with the common clock framework? It seems very
> > messy to allow a Linux-internal implementation detail (which is expected
> > to change) to leak into a binding...
> 
> Some CPU doesn't support common clock, like PowerPC (?)
> This is Mark (Brown) comment
> 
> --------------------
> So, ideally.  However we have to consider the fact that the clock API
> isn't reliably available makes this harder than it should be.  Even
> among the DT using platforms at least PowerPC still uses a custom clock
> API.  We could just use this as a carrot to push people to convert
> though.
> ---------------------

I would be happier if we could unify the common clock infrastructure, it
would make this kind of thing a lot lessy messy. However, I'm not
against the system-clock-frequency property for now.

> 
> 
> > > > > +		of_property_read_u32(np,
> > > > > +				     "system-clock-frequency",
> > > > > +				     &dai->sysclk);
> > > > 
> > > > What it this isn't present?
> > > 
> > > If sysclk doesn't have common clock support
> > 
> > Huh? That's not what I asked.
> > 
> > What if the dt has neither a clock or a system-clock-frequency property?
> 
> OK, sorry for my English

Sorry for the confusion, I'll try to be less ambiguous in future :)

What I was trying to get at here is that if there is neither a clock or
a system-clock-frequency property in the device tree, dai->sysclk will
not have been initialised in this path. Is this a valid case, and will
dai->sysclk have a well-defined, sane value?

Thanks,
Mark.
