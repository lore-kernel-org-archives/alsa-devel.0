Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0D8C43334
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jul 2022 11:53:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC0071740;
	Wed, 20 Jul 2022 13:52:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC0071740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658318022;
	bh=bv4lfTyxU8v0IQ1s9rAgkYmpfLKDCWkGofkym4tAI2w=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b6GGGosbfKd2F61Qx74Nt4v8mdPGG2kq317I+ggrWNFwY7VBfx8FRd0JlqNBmAViW
	 Zva5KpAOvXx/+ZNEHoB9NZjTx5gxr2/VvnIQ7Jld0R/FW9Gj1UbEaFI2tzmT4QdBqK
	 j1eHjRoYdwNAxLlSxTi2Jzs7ypAEEoVaDHa2Pm6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79C8FF80139;
	Wed, 20 Jul 2022 13:52:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAD12F80169; Wed, 20 Jul 2022 13:52:50 +0200 (CEST)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC45DF80125
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 13:52:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC45DF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="wsNEIB16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1658317963; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RquTbtLtwFfQ9inCLk4Ulpomsb9JpjXW2cXEGm/uxE4=;
 b=wsNEIB169o1MRcAZxhjwv8ptH4fid4sU4el1kqmI0/g3slTw2idUGaNG7VYj6nhO+hqvvy
 Nd6FWw3fGS4z+2+MiZBhQ+A6I/etNY2Kkc614HPoIi/zxiurGsQmnVJrYvXpkrr/9oyUWy
 uPU7gx+RvNRaThAkPx9Pj3h4asQa+jE=
Date: Wed, 20 Jul 2022 12:52:34 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 05/11] ASoC: jz4740-i2s: Use FIELD_PREP() macros in
 hw_params callback
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Message-Id: <MBIBFR.N54ZBFKURY0T2@crapouillou.net>
In-Reply-To: <20220708160244.21933-6-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-6-aidanmacdonald.0x0@gmail.com>
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

Le ven., juil. 8 2022 at 17:02:38 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Get rid of a couple of macros and improve readability by using
> FIELD_PREP() and GENMASK() for the sample size setting.
>=20
> Acked-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 043f100a9cfa..d0791dfa9c7b 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -3,6 +3,7 @@
>   *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
>   */
>=20
> +#include <linux/bitfield.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -42,8 +43,8 @@
>  #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
>  #define JZ_AIC_CONF_ENABLE BIT(0)
>=20
> -#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
> -#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
> +#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
> +#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
>  #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
>  #define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
>  #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
> @@ -61,9 +62,6 @@
>  #define JZ4760_AIC_CTRL_TFLUSH BIT(8)
>  #define JZ4760_AIC_CTRL_RFLUSH BIT(7)
>=20
> -#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
> -#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
> -
>  #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
>  #define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
>  #define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
> @@ -248,8 +246,9 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  	}
>=20
>  	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> -		ctrl &=3D ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK;
> -		ctrl |=3D sample_size << JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET;
> +		ctrl &=3D ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE;
> +		ctrl |=3D FIELD_PREP(JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE, sample_size);
> +
>  		if (params_channels(params) =3D=3D 1)
>  			ctrl |=3D JZ_AIC_CTRL_MONO_TO_STEREO;
>  		else
> @@ -257,8 +256,8 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>=20
>  		div_field =3D i2s->field_i2sdiv_playback;
>  	} else {
> -		ctrl &=3D ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
> -		ctrl |=3D sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
> +		ctrl &=3D ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE;
> +		ctrl |=3D FIELD_PREP(JZ_AIC_CTRL_INPUT_SAMPLE_SIZE, sample_size);
>=20
>  		div_field =3D i2s->field_i2sdiv_capture;
>  	}
> --
> 2.35.1
>=20


