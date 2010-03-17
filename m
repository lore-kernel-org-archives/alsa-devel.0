From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: remove a card from the list,
	if instantiation failed
Date: Wed, 17 Mar 2010 22:57:10 +0000
Message-ID: <F5A1F8BA-AD6E-4C5E-9FD4-37D188CD8513@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1003172202050.4354@axis700.grange>
	(sfid-20100317_210620_060867_8046C66F)
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6E29103850
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 23:56:22 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1003172202050.4354@axis700.grange>
	(sfid-20100317_210620_060867_8046C66F)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 17 Mar 2010, at 21:06, Guennadi Liakhovetski  
<g.liakhovetski@gmx.de> wrote:

> If instantiation of a card failed, we have to remove it from the card
> list. This fixes an Oops on Migo-R, triggering, when after a failed
> firmware load attempt the driver modules are removed and re-inserted
> again.

This looks like the wrong fix - if the card failed to instantiate  
because the component drivers weren't ready then it ought to hang  
around so it can be instantiated once they appear. Presumably some  
part of the instantiation attempt is failing and not being unwound  
properly?

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Should also be good for stable.
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c8b0556..307eea0 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2361,6 +2361,8 @@ static int snd_soc_register_card(struct  
> snd_soc_card *card)
>    mutex_lock(&client_mutex);
>    list_add(&card->list, &card_list);
>    snd_soc_instantiate_cards();
> +    if (!card->instantiated)
> +        list_del(&card->list);
>    mutex_unlock(&client_mutex);
>
>    dev_dbg(card->dev, "Registered card '%s'\n", card->name);
