From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: simple-card: Fix property name for
 simple-audio-card, format
Date: Mon, 10 Mar 2014 02:25:02 +0000
Message-ID: <ca5458a9aa144c20b8c5987fa29f74a8@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1394194711-32009-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 by alsa0.perex.cz (Postfix) with ESMTP id AC65A265607
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 03:25:06 +0100 (CET)
In-Reply-To: <1394194711-32009-1-git-send-email-peter.ujfalusi@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -165,7 +165,7 @@ static int asoc_simple_card_parse_of(struct device_node
> *node,
>  	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
> 
>  	/* get CPU/CODEC common format via simple-audio-card,format */
> -	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
> +	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,format")


@Peter

Sorry, the interface of snd_soc_of_parse_daifmt(struct device_node *np,
const char *prefix), it's intended not only to parse the 'XXX,format', but also
'XXX,continuous-clock', 'XXX, bitclock-inversion', 'XXX, frame-inversion',
'XXX,bitclock-master' and 'XXX,frame-master' at the same time.

Maybe just the comment here is not very correct.

Thanks,

--
Best Regards,
Xiubo


> &
>  		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
> 
>  	/* off-codec widgets */
> --
> 1.9.0
> 
> 
