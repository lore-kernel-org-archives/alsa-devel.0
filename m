From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [RFC PATCH] ASoC AC97/I2S for SH7760
Date: Wed, 9 May 2007 07:25:03 +0200
Message-ID: <20070509052503.GA32573@roarinelk.homelinux.net>
References: <20070508174027.GB28884@roarinelk.homelinux.net>
	<20070509005255.GB19043@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070509005255.GB19043@linux-sh.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>, alsa-devel@alsa-project.org, linuxsh-dev@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Paul,

thank you for the review!

On Wed, May 09, 2007 at 09:52:55AM +0900, Paul Mundt wrote:
> On Tue, May 08, 2007 at 07:40:27PM +0200, Manuel Lauss wrote:
> > diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
> > new file mode 100644
> > index 0000000..157268c
> > --- /dev/null
> > +++ b/sound/soc/sh/hac.c
> [snip]
> > + * dont forget to set IPSEL/OMSEL register bits (in your board code) to
> > + * enable HAC output pins!
> > + */
> Yuck.. I suppose this is a good argument for a demux API..

Yes. Give me some time and I'll hack something up.
 
> > +struct hac_priv {
> > +	unsigned long mmio;	/* HAC base address */
> > +} hac_cpu_data[] = {
> > +#if defined(CONFIG_CPU_SUBTYPE_SH7760)
> > +	{
> > +		.mmio	= 0xFE240000,
> > +	},
> > +	{
> > +		.mmio	= 0xFE250000,
> > +	},
> > +#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
> > +	{
> > +		.mmio	= 0xFFE40000,
> > +	},
> > +#else
> > +#error "Unsupported SuperH SoC"
> > +#endif
> > +};
> 
> Platform device resources, please.

It's not that easy with asoc: first it does not pass any
information to the ac97_read/write functions, and I haven't
yet found a way to pass information from the probe() callbacks
to the asoc core, hence this hack.
In general, ASoC does not anticipate devices like the 7760 with
2 independent audio units.
 
> > diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
> > new file mode 100644
> > index 0000000..79642e0
> > --- /dev/null
> > +#ifdef SSI_DEBUG
> > +#define MSG(x...)	printk(KERN_INFO "sh4-i2s: " x)
> > +#else
> > +#define MSG(x...)	do {} while (0)
> > +#endif
> > +
> pr_debug()?

Okay, gone.

> This can also go in to a platform device resource. You'll want the
> private data there anyways in case you decide to do something more
> interesting with the clock.

the SSI depends on a board-specific clocksource; my board can change
this clock depending on requested sample rate, which is nice to work
around an oops triggered by ALSA when it mmap()s buffers...

Thanks again
	Manuel Lauss

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
