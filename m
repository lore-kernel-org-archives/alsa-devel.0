Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCFDC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jul 2022 11:57:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 192BA1718;
	Wed, 20 Jul 2022 13:56:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 192BA1718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658318250;
	bh=q1Lkek+keCqDzErUiHffgUa3nFsBd4DZkq4lgE+N314=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VAJlw5SCsvt1EPu5saBVyePqvpQuRgzAgMsvpeFCMi/KZHXMJtVwSTram1PIXc+iG
	 RsRGlUFw7lAJX11DzsfO+8KB0DjaB7Ccb06jqIUHdbzwpiov31yM/4Vl5jijTA+NOe
	 5Nzgu4n23U/cs8gMwntcYYO7uAX2lgCAbtIT7gSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75043F80125;
	Wed, 20 Jul 2022 13:56:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D497F800BA; Wed, 20 Jul 2022 13:56:38 +0200 (CEST)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A70AF80125
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 13:56:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A70AF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="ouJniZi1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1658318190; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Otu7SpCpuiaT1NLh/DRIgkeeMxIACISVLGxUE2EKWbk=;
 b=ouJniZi1hlAwdQ6wpoWIC/pc0AEoqH+m7LymtYUHg7UFEvQH/nAEtdwWtj9myQp2I7BNOL
 PE8hIAbItCNKIzmwhmr2C8oser6RREY46gSWp1MVyxGbwHRqvwFnQrBjR2EBPwTjAHxSGe
 PSX9FxsEHtT8nU9gpMFOCBrUesPA0FE=
Date: Wed, 20 Jul 2022 12:56:19 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 08/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE
 sample formats
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Message-Id: <VHIBFR.8XGKG1NT4PHX1@crapouillou.net>
In-Reply-To: <20220708160244.21933-9-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-9-aidanmacdonald.0x0@gmail.com>
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

Le ven., juil. 8 2022 at 17:02:41 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The audio controller on JZ47xx SoCs can transfer 20- and 24-bit
> samples in the FIFO, so allow those formats to be used with the
> I2S driver. Although the FIFO doesn't care about the in-memory
> sample format, we only support 4-byte format variants because the
> DMA controller on these SoCs cannot transfer in 3-byte multiples.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index a41398c24d0e..9be2f3f1b376 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -238,9 +238,15 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  	case SNDRV_PCM_FORMAT_S8:
>  		sample_size =3D 0;
>  		break;
> -	case SNDRV_PCM_FORMAT_S16:
> +	case SNDRV_PCM_FORMAT_S16_LE:


I had to lookup the macro to verify, but this is correct.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

>  		sample_size =3D 1;
>  		break;
> +	case SNDRV_PCM_FORMAT_S20_LE:
> +		sample_size =3D 3;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		sample_size =3D 4;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -375,7 +381,9 @@ static const struct snd_soc_dai_ops=20
> jz4740_i2s_dai_ops =3D {
>  };
>=20
>  #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
> -		SNDRV_PCM_FMTBIT_S16_LE)
> +			 SNDRV_PCM_FMTBIT_S16_LE | \
> +			 SNDRV_PCM_FMTBIT_S20_LE | \
> +			 SNDRV_PCM_FMTBIT_S24_LE)
>=20
>  static struct snd_soc_dai_driver jz4740_i2s_dai =3D {
>  	.probe =3D jz4740_i2s_dai_probe,
> --
> 2.35.1
>=20


