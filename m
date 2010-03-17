From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] ASoC: remove a card from the list,
 if instantiation failed
Date: Thu, 18 Mar 2010 00:09:51 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1003180004270.4354@axis700.grange>
References: <Pine.LNX.4.64.1003172202050.4354@axis700.grange>
	(sfid-20100317_210620_060867_8046C66F)
	<F5A1F8BA-AD6E-4C5E-9FD4-37D188CD8513@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id C36BC103861
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 00:09:51 +0100 (CET)
In-Reply-To: <F5A1F8BA-AD6E-4C5E-9FD4-37D188CD8513@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 17 Mar 2010, Mark Brown wrote:

> On 17 Mar 2010, at 21:06, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > If instantiation of a card failed, we have to remove it from the card
> > list. This fixes an Oops on Migo-R, triggering, when after a failed
> > firmware load attempt the driver modules are removed and re-inserted
> > again.
> 
> This looks like the wrong fix - if the card failed to instantiate because the
> component drivers weren't ready then it ought to hang around so it can be
> instantiated once they appear. Presumably some part of the instantiation
> attempt is failing and not being unwound properly?

If snd_soc_instantiate_card() fails, when called from 
snd_soc_register_card(), the card currently stays on the list, but the 
instantiated flag is not set. If you then unload drivers and unregister 
the soc-audio platform device, snd_soc_unregister_card() is called, but 
since instantiated is not set, nothing is done and the card stays on the 
list. What's the proper unwind way in such a case then?

Thanks
Guennadi

> 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > Should also be good for stable.
> > 
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > index c8b0556..307eea0 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -2361,6 +2361,8 @@ static int snd_soc_register_card(struct snd_soc_card
> > *card)
> >   mutex_lock(&client_mutex);
> >   list_add(&card->list, &card_list);
> >   snd_soc_instantiate_cards();
> > +    if (!card->instantiated)
> > +        list_del(&card->list);
> >   mutex_unlock(&client_mutex);
> > 
> >   dev_dbg(card->dev, "Registered card '%s'\n", card->name);

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
