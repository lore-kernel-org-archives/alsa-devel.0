Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D6FC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:42:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BD12064C
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VBgfkz+z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Qz0jTXmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BD12064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23F83168A;
	Tue,  7 Jul 2020 12:41:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23F83168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594118534;
	bh=l1J7rIK4JtRcZUQFZOhr5nJjMg02XniKgVx56MqpBT0=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VBgfkz+zg8hNI7dYQm9bfAmT4RCfzCBr7L6zSOXNw82VBOY3Vv2tzrOa37fXJ7fFH
	 OVac+Ppqd9Jc4bHMOAhlGl46AY/azgqSSjJmTMSEL9NA5/j5NYpHQeCsPbj8WjGmjb
	 vSjMtVlFoSr7Zz1HUFbUOIDyat8jafPp9AkpenE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F5CBF80257;
	Tue,  7 Jul 2020 12:40:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7948AF80274; Tue,  7 Jul 2020 12:40:39 +0200 (CEST)
Received: from crapouillou.net (crapouillou.net [89.234.176.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33155F800D0
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 12:40:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33155F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="Qz0jTXmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1594118427; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIqqTb/7DiiTF0NvBRzZ1q2LCcTShKFtonmzu/HJhnw=;
 b=Qz0jTXmWVy9vRXaNcwXnU6oFqCbH3OIE27MWw/sS4VBkSRqDHfkj8+2rYlCH1Ai3EHmulg
 WssaXt1UqbizS/BqeHnnkfOqUlBvwwATd5MVXcjbE4cAxWNgspDQN2tyltqGXQNrJGXiuF
 vmiR360yG4uPQP8sfRBAI9YFuDg0ALs=
Date: Tue, 07 Jul 2020 12:40:16 +0200
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 24/28] ASoC: codecs: jz4770: Remove defined but never used
 variable 'mic_boost_tlv'
To: Lee Jones <lee.jones@linaro.org>
Message-Id: <4NH3DQ.1N2VLULE2ZMG2@crapouillou.net>
In-Reply-To: <20200707101642.1747944-25-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
 <20200707101642.1747944-25-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org,
 ter Huurne <maarten@treewalker.org>, linux-arm-kernel@lists.infradead.org
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

Hi,

Le mar. 7 juil. 2020 =C3=A0 11:16, Lee Jones <lee.jones@linaro.org> a=20
=C3=A9crit :
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  In file included from include/sound/tlv.h:10,
>  from sound/soc/codecs/jz4770.c:19:
>  sound/soc/codecs/jz4770.c:306:35: warning: =E2=80=98mic_boost_tlv=E2=80=
=99=20
> defined but not used [-Wunused-const-variable=3D]
>  306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
>  | ^~~~~~~~~~~~~
>  include/uapi/sound/tlv.h:64:15: note: in definition of macro=20
> =E2=80=98SNDRV_CTL_TLVD_DECLARE_DB_SCALE=E2=80=99
>  64 | unsigned int name[] =3D { | ^~~~
>  sound/soc/codecs/jz4770.c:306:14: note: in expansion of macro=20
> =E2=80=98DECLARE_TLV_DB_SCALE=E2=80=99
>  306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
>  | ^~~~~~~~~~~~~~~~~~~~
>=20
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: ter Huurne <maarten@treewalker.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/codecs/jz4770.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
> index 34775aa624024..4dee585761c24 100644
> --- a/sound/soc/codecs/jz4770.c
> +++ b/sound/soc/codecs/jz4770.c
> @@ -303,7 +303,6 @@ static int jz4770_codec_digital_mute(struct=20
> snd_soc_dai *dai, int mute)
>  static const DECLARE_TLV_DB_MINMAX_MUTE(dac_tlv, -3100, 0);
>  static const DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
>  static const DECLARE_TLV_DB_MINMAX(out_tlv, -2500, 600);
> -static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
>  static const DECLARE_TLV_DB_SCALE(linein_tlv, -2500, 100, 0);
>=20
>  /* Unconditional controls. */
> --
> 2.25.1
>=20


