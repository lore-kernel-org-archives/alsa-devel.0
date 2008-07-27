From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cs4232: fix crash during chip PNP detection
Date: Sun, 27 Jul 2008 18:45:04 +0200
Message-ID: <20080727184504.072f591e.krzysztof.h1@poczta.fm>
References: <20080723130320.6D83D860F79@f35.poczta.interia.pl>
	<s5hr69fiudn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 5DCB82463A
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 18:40:02 +0200 (CEST)
In-Reply-To: <s5hr69fiudn.wl%tiwai@suse.de>
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

On Sun, 27 Jul 2008 10:49:56 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At 23 Jul 2008 15:03:20 +0200,
> krzysztof.h1@poczta.fm wrote:
> > 

> > > > --- linux-2.6.26/sound/isa/cs423x/cs4236.c~	2008-07-23
> > > 07:40:16.129637645 +0200
> > > > +++ linux-2.6.26/sound/isa/cs423x/cs4236.c	2008-07-23 07:40:32.905641806
> > > +0200
> > > > @@ -325,6 +325,7 @@ static int __devinit snd_cs423x_pnp_init
> > > >  static int __devinit snd_card_cs4232_pnp(int dev, struct
> > > snd_card_cs4236 *acard,
> > > >  					 struct pnp_dev *pdev)
> > > >  {
> > > > +	acard->wss = pdev;
> > > >  	if (snd_cs423x_pnp_init_wss(dev, acard->wss) > 0)
> > > >  		return -EBUSY;
> > > >  	cport[dev] = -1;
> > > > 
> > > 
> > > Acked-by: Rene Herman >rene.herman@gmail.com>
> > > 
> 
> Sorry, but this has to be pushed as soon as possible while wss_lib
> patches are for 2.6.28.
> 

To be 100% clear:
1. This patch does not require the wss_lib patches.
2. This patch does not conflict with the wss_lib patches.

Regards,
Krzysztof

----------------------------------------------------------------------
Partyjka w Chinczyka?
Graj >>> http://link.interia.pl/f1e67
