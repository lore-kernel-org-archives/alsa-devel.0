Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D9BC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 14:17:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A4161494
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 14:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A4161494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EC9E171E;
	Tue,  2 Mar 2021 15:16:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EC9E171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614694665;
	bh=LleYcrOEL8Gdk2tU1UTiVFkiqctEHVkX/P47FtNk+54=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=giYf/gUJOKeSLNhanMJnfHdkbgb1ndlB2OOVDFuaP8jYBnKxmN8ZHFyctTIfnD4vk
	 +G3vFNPe6/UR3i0wRARIkOF3/5ERnzCVWoLn2dmFezeg3DXcwjnObEqLIR4PGsNZkh
	 vgxybmhnUF95iIAYflj1v1X120jV0rB9WB9SEhr8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D5C1F8012D;
	Tue,  2 Mar 2021 15:16:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8EA84F80269; Tue,  2 Mar 2021 15:16:53 +0100 (CET)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6B7BF8012D
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 15:16:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6B7BF8012D
Date: Tue, 02 Mar 2021 14:16:26 +0000
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] ASoC: codec: Omit superfluous error message in 
 jz4760_codec_probe()
To: Tang Bin <tangbin@cmss.chinamobile.com>
Message-Id: <EBICPQ.45RCN3X3PJUR1@crapouillou.net>
In-Reply-To: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
References: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
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



Le mar. 2 mars 2021 =E0 21:56, Tang Bin <tangbin@cmss.chinamobile.com> a=20
=E9crit :
> The function devm_platform_ioremap_resource has already contained
> error message, so remove the redundant dev_err here.
>=20
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks!

Cheers,
-Paul

> ---
> Changes from v1
>  - to streamline the code.
> ---
>  sound/soc/codecs/jz4760.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
> index e8f28ccc145a..5ae0e312bcfc 100644
> --- a/sound/soc/codecs/jz4760.c
> +++ b/sound/soc/codecs/jz4760.c
> @@ -841,11 +841,8 @@ static int jz4760_codec_probe(struct=20
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
>  					&jz4760_codec_regmap_config);
> --
> 2.18.2
>=20
>=20
>=20


