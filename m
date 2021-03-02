Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B9C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 12:24:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADDA61477
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 12:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADDA61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 794FA16D1;
	Tue,  2 Mar 2021 13:23:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 794FA16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614687860;
	bh=pZCz2WK/Rzo3NCT1TnYMEXZ1l6WtF3aHk052ywK9yNM=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=itN1d8jXId5ZZinrXQlao6c2x1gA7hDbWvDyc0kfVgzLGAS6xbZ6ZFO9lOLnNAbKM
	 a1XzJxi/kvsEB0EJZ/IfG8+Owk/Lzy2QnipTrDP6bNrLy/lK7xldpn7RYi9Y8iwJUA
	 2TGW5IMWYbVl5tE9VK6pvTn9fm0bT3MH5rxYjpbI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10C77F80088;
	Tue,  2 Mar 2021 13:23:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4862F80269; Tue,  2 Mar 2021 13:23:28 +0100 (CET)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8ED84F80088
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 13:23:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ED84F80088
Date: Tue, 02 Mar 2021 12:23:08 +0000
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: codec: Omit superfluous error message in
 jz4760_codec_probe()
To: Tang Bin <tangbin@cmss.chinamobile.com>
Message-Id: <K2DCPQ.25EEALUNZ4K3@crapouillou.net>
In-Reply-To: <20210302121148.28328-1-tangbin@cmss.chinamobile.com>
References: <20210302121148.28328-1-tangbin@cmss.chinamobile.com>
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

Hi Tang,

Le mar. 2 mars 2021 =E0 20:11, Tang Bin <tangbin@cmss.chinamobile.com> a=20
=E9crit :
> The function devm_platform_ioremap_resource has already contained=20
> error
> message, so remove the redundant dev_err here.
>=20
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/codecs/jz4760.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
> index e8f28ccc145a..c2d8a107f159 100644
> --- a/sound/soc/codecs/jz4760.c
> +++ b/sound/soc/codecs/jz4760.c
> @@ -843,7 +843,6 @@ static int jz4760_codec_probe(struct=20
> platform_device *pdev)
>  	codec->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(codec->base)) {
>  		ret =3D PTR_ERR(codec->base);
> -		dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
>  		return ret;
>  	}

Indeed, you are right.

I guess you do this instead:

if (IS_ERR(codec->base))
    return PTR_ERR(codec->base);

Cheers,
-Paul



