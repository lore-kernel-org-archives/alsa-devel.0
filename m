From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ASoC AC97/I2S for SH7760
Date: Wed, 09 May 2007 11:25:19 +0100
Message-ID: <1178706319.3740.22.camel@a10072.wolfsonmicro.main>
References: <20070508174027.GB28884@roarinelk.homelinux.net>
	<20070509005255.GB19043@linux-sh.org>
	<20070509052503.GA32573@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C0802442F
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 12:25:21 +0200 (CEST)
In-Reply-To: <20070509052503.GA32573@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>, linuxsh-dev@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-05-09 at 07:25 +0200, Manuel Lauss wrote:

> 
> It's not that easy with asoc: first it does not pass any
> information to the ac97_read/write functions, and I haven't
> yet found a way to pass information from the probe() callbacks
> to the asoc core, hence this hack.
> In general, ASoC does not anticipate devices like the 7760 with
> 2 independent audio units.

Fwiw, this is on my todo list for after the next merge. Sadly, I'm
struggling for free time to add ac97 private data atm. 


>  
> > > diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
> > > new file mode 100644
> > > index 0000000..79642e0
> > > --- /dev/null
> > > +#ifdef SSI_DEBUG
> > > +#define MSG(x...)	printk(KERN_INFO "sh4-i2s: " x)
> > > +#else
> > > +#define MSG(x...)	do {} while (0)
> > > +#endif
> > > +
> > pr_debug()?
> 
> Okay, gone.

This should also apply to the other supported platforms. Now on my todo
list.

Everything else looks fine.

Thanks

Liam
