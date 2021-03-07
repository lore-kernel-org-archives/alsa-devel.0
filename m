Return-Path: <SRS0=dfEF=IF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F3AC433E0
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 15:54:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7790650BD
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 15:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7790650BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C871618FC;
	Sun,  7 Mar 2021 16:53:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C871618FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615132456;
	bh=I8PbQX9cJJq4/WzM9p+1zUdv3dEpQzOdhZ4hkERptLs=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k2AW3C01vCOSnoNI1/31eSXm7PVoKDUm7wM1Mn/SUCfdPXdu0S6kSbVgVXFD65XAk
	 hKHlvwPoiJLcfEDMqt07WvsGboP2/Mdkgbv8fEEu6NrKBko/CuwMmZl4uwBfUM0+tb
	 IcPk6NefzxBl4+IVrPvm8gWhIKOpG+hY52UyLlpk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0875EF80139;
	Sun,  7 Mar 2021 16:53:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D0FAF80227; Sun,  7 Mar 2021 16:53:23 +0100 (CET)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0000F80139
 for <alsa-devel@alsa-project.org>; Sun,  7 Mar 2021 16:53:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0000F80139
Date: Sun, 07 Mar 2021 15:53:04 +0000
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: codecs/jz4770: Remove superfluous error message
To: Tang Bin <tangbin@cmss.chinamobile.com>
Message-Id: <G4WLPQ.USQXU1D7YOL61@crapouillou.net>
In-Reply-To: <20210307072133.10832-1-tangbin@cmss.chinamobile.com>
References: <20210307072133.10832-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>
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



Le dim. 7 mars 2021 =E0 15:21, Tang Bin <tangbin@cmss.chinamobile.com> a=20
=E9crit :
> The function devm_platform_ioremap_resource has already contained
> error message if failed, so remove superfluous dev_err here.
>=20
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Looks good.

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/codecs/jz4770.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
> index 298689a07..5a24471a5 100644
> --- a/sound/soc/codecs/jz4770.c
> +++ b/sound/soc/codecs/jz4770.c
> @@ -900,11 +900,8 @@ static int jz4770_codec_probe(struct=20
> platform_device *pdev)
>  	codec->dev =3D dev;
>=20
>  	codec->base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(codec->base)) {
> -		ret =3D PTR_ERR(codec->base);
> -		dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(codec->base))
> +		return PTR_ERR(codec->base);
>=20
>  	codec->regmap =3D devm_regmap_init(dev, NULL, codec,
>  					&jz4770_codec_regmap_config);
> --
> 2.20.1.windows.1
>=20
>=20
>=20


