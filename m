From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: simple-card: Fix property name for
	simple-audio-card, format
Date: Mon, 10 Mar 2014 11:54:38 +0200
Message-ID: <531D8BDE.9070507@ti.com>
References: <1394194711-32009-1-git-send-email-peter.ujfalusi@ti.com>
 <ca5458a9aa144c20b8c5987fa29f74a8@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C5FF62650BA
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 10:54:42 +0100 (CET)
In-Reply-To: <ca5458a9aa144c20b8c5987fa29f74a8@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 04:25 AM, Li.Xiubo@freescale.com wrote:
>> --- a/sound/soc/generic/simple-card.c
>> +++ b/sound/soc/generic/simple-card.c
>> @@ -165,7 +165,7 @@ static int asoc_simple_card_parse_of(struct device_n=
ode
>> *node,
>>  	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
>>
>>  	/* get CPU/CODEC common format via simple-audio-card,format */
>> -	priv->daifmt =3D snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
>> +	priv->daifmt =3D snd_soc_of_parse_daifmt(node, "simple-audio-card,form=
at")
> =

> =

> @Peter
> =

> Sorry, the interface of snd_soc_of_parse_daifmt(struct device_node *np,
> const char *prefix), it's intended not only to parse the 'XXX,format', bu=
t also
> 'XXX,continuous-clock', 'XXX, bitclock-inversion', 'XXX, frame-inversion',
> 'XXX,bitclock-master' and 'XXX,frame-master' at the same time.

Yes, I overlooked that. I have not checked the snd_soc_of_parse_daifmt() be=
fore.

> Maybe just the comment here is not very correct.

Probably it would be better to re-word it since the code at this point only
interested on the i2s coding and the bit/frame inversion.

> Thanks,
> =

> --
> Best Regards,
> Xiubo
> =

> =

>> &
>>  		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
>>
>>  	/* off-codec widgets */
>> --
>> 1.9.0
>>
>>
> =



-- =

P=E9ter
