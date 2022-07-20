Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB855C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jul 2022 11:46:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 234CF1743;
	Wed, 20 Jul 2022 13:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 234CF1743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658317572;
	bh=24J1y7sKWoRrsre1KSP2ntWW4M0Lj3QVd4SxolL1y4I=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nZWSX7PApDKMIERzlAAT4KMx0bVgXIOt7+290w0QMfDNlnYzxWX88uyJw3BCy/pn4
	 nsbdIcT+u7RAYwzNiJqVxD31xtaoXwqrt6WP+Z/JRHW3a+dypOp1/kORa19Rp0HfWY
	 hXu/PU29VLesqkv5OlrjVTW/yxLsI9SvTb/eJ2k4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0D4EF80139;
	Wed, 20 Jul 2022 13:45:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DFC5F80139; Wed, 20 Jul 2022 13:45:20 +0200 (CEST)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EC02F80139
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 13:45:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EC02F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="iPOLvHJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1658317506; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bKwE+toAiomkN28VXesGLY//goBv768kEOswtqRRQc=;
 b=iPOLvHJP61X03hKCV3JDE9Avz79NmZ86qy+0oo4GA87LC/bMQ97tlxIfISaH7PVeiLHkdM
 NAhXKKpypxISh8bpoREB2L4MulLLvN4jy7zFOyD1wbImWpeHwTPtrDCj5pMaeYjgAmFX8O
 dGeON8yfLT6I3AthNIreGYPV4kq7nf8=
Date: Wed, 20 Jul 2022 12:44:51 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 02/11] ASoC: jz4740-i2s: Remove unused 'mem' resource
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Message-Id: <RYHBFR.1MXJ3WUJSHEG3@crapouillou.net>
In-Reply-To: <20220708160244.21933-3-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-3-aidanmacdonald.0x0@gmail.com>
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

Hi,

Le ven., juil. 8 2022 at 17:02:35 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> This isn't used and doesn't need to be in the private data struct.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 576f31f9d734..adf896333584 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -98,7 +98,6 @@ struct i2s_soc_info {
>  };
>=20
>  struct jz4740_i2s {
> -	struct resource *mem;
>  	void __iomem *base;
>=20
>  	struct clk *clk_aic;
> --
> 2.35.1
>=20


