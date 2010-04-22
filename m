From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC - Support for multiple components
Date: Thu, 22 Apr 2010 12:03:46 +0100
Message-ID: <1271934226.3228.286.camel@odin>
References: <1271686144.3208.305.camel@odin>
	<k2ved82fe3e1004211407qae60e223of729dff1b6e34d83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DD4DC103866
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 13:03:51 +0200 (CEST)
Received: by wwi14 with SMTP id 14so1143538wwi.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 04:03:51 -0700 (PDT)
In-Reply-To: <k2ved82fe3e1004211407qae60e223of729dff1b6e34d83@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-04-21 at 16:07 -0500, Timur Tabi wrote:
> On Mon, Apr 19, 2010 at 9:09 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> > I've CC'ed folks on this mail who have either contributed or maintain
> > ASoC architecture code. Please have a look at your architecture and test
> > if you can. I only have access to OMAP and pxa3xx hardware and as such
> > have only tested the changes on these two architectures only. I'd
> > appreciated anyone else testing on the other architectures too.
> 
> A few things:
> 
> First, you probably need to add this:
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 38d94d7..c2df201 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1364,8 +1364,10 @@ static void snd_soc_instantiate_card(struct
> snd_soc_card *card)
>                 soc_bind_dai_link(card, i);
> 
>         /* bind completed ? */
> -       if (card->num_rtd != card->num_links)
> +       if (card->num_rtd != card->num_links) {
> +               mutex_unlock(&card->mutex);
>                 return;
> +       }
> 
>         /* card bind complete so register a sound card */
>         ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
> @@ -1373,6 +1375,7 @@ static void snd_soc_instantiate_card(struct
> snd_soc_card *card)
>         if (ret < 0) {
>                 printk(KERN_ERR "asoc: can't create sound card for card %s\n",
>                         card->name);
> +               mutex_unlock(&card->mutex);
>                 return;
>         }
>         card->snd_card->dev = card->dev;
> 

Thanks, applied. I guess this got lost in a rebase.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
