Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37013C43334
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jul 2022 11:59:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76333174E;
	Wed, 20 Jul 2022 13:58:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76333174E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658318374;
	bh=OCHV3LrI/vyQixP3DxOoE4b9zuV6oB1vmKK2aXiHK0Y=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/WbSw1lXVuQR7rY1gqnRzZelM3McphPBFU1C03AAJ7epiOqKP1chrDEKIUejdoY4
	 Nym0XMQzZdfOqdRRrdQNdjeKCnq/BaSg4xE+TkGgF5kwiVFlgkEvR3PIynBpk8Micl
	 k+4m+JgkdAwXkUdYZhvLuma772LpC0z+X6uPUzI4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2291FF80125;
	Wed, 20 Jul 2022 13:58:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF54CF80169; Wed, 20 Jul 2022 13:58:42 +0200 (CEST)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1C30F80125
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 13:58:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1C30F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="PusYh3vG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1658318311; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPPCh6LnPww+kbqa2Z9TXCT7MqlxqoEk5GKe4eZg+d0=;
 b=PusYh3vGIr5JCPPDBQ8btI6tloV/wi1FD8zh2hjxM8uwjCti0yfNjmhO5GKnJTh5bTfvKa
 HDX7u8KKHaMyJ/O8lI7mNxbJowK6byOGJ9D2+YACKn525LYwz/0ZbIDUWSbhCs9N0pSIiR
 +lS+gbFz6RpgFLuOjtkBMjrLqvP6Ltc=
Date: Wed, 20 Jul 2022 12:58:19 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 10/11] ASoC: jz4740-i2s: Move component functions near
 the component driver
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Message-Id: <7LIBFR.71QJ7EA1306B1@crapouillou.net>
In-Reply-To: <20220708160244.21933-11-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-11-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, tiwai@suse.com,
 broonie@kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Aidan,

Le ven., juil. 8 2022 at 17:02:43 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Move the component suspend/resume functions near the definition
> of the component driver to emphasize that they're unrelated to
> the DAI functions.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

I'm not really fond of moving code like that, so I'll leave Mark with=20
the liberty to take or not this patch.

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 72=20
> +++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 70b9d28a40ce..5db73f12efcf 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -303,42 +303,6 @@ static int jz4740_i2s_set_sysclk(struct=20
> snd_soc_dai *dai, int clk_id,
>  	return ret;
>  }
>=20
> -static int jz4740_i2s_suspend(struct snd_soc_component *component)
> -{
> -	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> -
> -	if (snd_soc_component_active(component)) {
> -		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF,=20
> JZ_AIC_CONF_ENABLE);
> -		clk_disable_unprepare(i2s->clk_i2s);
> -	}
> -
> -	clk_disable_unprepare(i2s->clk_aic);
> -
> -	return 0;
> -}
> -
> -static int jz4740_i2s_resume(struct snd_soc_component *component)
> -{
> -	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> -	int ret;
> -
> -	ret =3D clk_prepare_enable(i2s->clk_aic);
> -	if (ret)
> -		return ret;
> -
> -	if (snd_soc_component_active(component)) {
> -		ret =3D clk_prepare_enable(i2s->clk_i2s);
> -		if (ret) {
> -			clk_disable_unprepare(i2s->clk_aic);
> -			return ret;
> -		}
> -
> -		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
> -	}
> -
> -	return 0;
> -}
> -
>  static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> @@ -459,6 +423,42 @@ static const struct i2s_soc_info=20
> jz4780_i2s_soc_info =3D {
>  	.pll_clk_name		=3D "pll half",
>  };
>=20
> +static int jz4740_i2s_suspend(struct snd_soc_component *component)
> +{
> +	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> +
> +	if (snd_soc_component_active(component)) {
> +		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF,=20
> JZ_AIC_CONF_ENABLE);
> +		clk_disable_unprepare(i2s->clk_i2s);
> +	}
> +
> +	clk_disable_unprepare(i2s->clk_aic);
> +
> +	return 0;
> +}
> +
> +static int jz4740_i2s_resume(struct snd_soc_component *component)
> +{
> +	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(i2s->clk_aic);
> +	if (ret)
> +		return ret;
> +
> +	if (snd_soc_component_active(component)) {
> +		ret =3D clk_prepare_enable(i2s->clk_i2s);
> +		if (ret) {
> +			clk_disable_unprepare(i2s->clk_aic);
> +			return ret;
> +		}
> +
> +		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct snd_soc_component_driver jz4740_i2s_component =3D {
>  	.name			=3D "jz4740-i2s",
>  	.suspend		=3D jz4740_i2s_suspend,
> --
> 2.35.1
>=20


