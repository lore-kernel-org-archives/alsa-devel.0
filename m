Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D55C7EE29
	for <alsa-devel@archiver.kernel.org>; Sun, 28 May 2023 17:17:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6C3C208;
	Sun, 28 May 2023 19:16:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6C3C208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685294256;
	bh=QymTZLOdk4+8f9DlR3EZDLBNA9Q41r5+dqZ3Xj8eYv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fExtgBC8m5w9WHxEwoAF96sWipJq+sEg/XbtJL6hYOKbURWbjIOj00517tjaO2UpD
	 VA1Cq/vT7Uvz2NgtgTx0loxJR93oU2r7O5WZL7xWBELDWWOkfzILv83QwJKVexRUKr
	 OEYM84mu3w8pebdSgVm446adZ/XjuhemrChyyTZk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09283F80544; Sun, 28 May 2023 19:16:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 97151F800DF;
	Sun, 28 May 2023 19:16:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1C0FF8042F; Sun, 28 May 2023 19:16:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5ACF4F80149
	for <alsa-devel@alsa-project.org>; Sun, 28 May 2023 19:16:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5ACF4F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=r7ejmL4o
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 75BE560D41;
	Sun, 28 May 2023 17:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A5FC433EF;
	Sun, 28 May 2023 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685294163;
	bh=QymTZLOdk4+8f9DlR3EZDLBNA9Q41r5+dqZ3Xj8eYv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r7ejmL4oVaKREEyWRLRvA/TkriUb62jLjaSMjnug4T83YaJSSlWBBrhAup/+nKNHa
	 hYj2XZ798Pe3isC8RhJTpJ4GOFfNxuEjugIow0QOooYyN7RMuejMoIxfui3/grpnmb
	 UWFrgJjXNwSyPm9+4+F3elHq4DGojTv1kaWApnnyPO29c2jQQ+/8essiC7kXg4VzUZ
	 N8or61LvcsqEUM/6/dWIR/iHyhmIofY6q5nXCW2H3SntTBCRkCbwB8OU3J2wptELUI
	 xU1xl2LVO0UYCUT5xMVkfAw4mqpeiQhaKs+WX6aydu62ipuL1C9SGdM1kw9drrXoF6
	 kBF1CYO2fOXTA==
Date: Sun, 28 May 2023 18:32:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 3/9] iio: inkern: Check error explicitly in
 iio_channel_read_max()
Message-ID: <20230528183221.36407e8d@jic23-huawei>
In-Reply-To: <20230523151223.109551-4-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
	<20230523151223.109551-4-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 7ADHYY5LS4F5DZUYN7SFKEQBDK4JT4MZ
X-Message-ID-Hash: 7ADHYY5LS4F5DZUYN7SFKEQBDK4JT4MZ
X-MailFrom: jic23@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7ADHYY5LS4F5DZUYN7SFKEQBDK4JT4MZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 23 May 2023 17:12:17 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The current implementation returns the error code as part of the
> default switch case.
> This can lead to returning an incorrect positive value in case of
> iio_avail_type enum entries evolution.
> 
> In order to avoid this case, be more strict in error checking.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
It's an odd code construct, so in the interests of robustness this
looks like a good improvement to me.

Given the later patch you need for this series will see some fuzz
I think if I pick this up separately I'll currently assume this whole
series will go together.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/inkern.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 872fd5c24147..f738db9a0c04 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -858,6 +858,9 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  		val2 = &unused;
>  
>  	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
> +	if (ret < 0)
> +		return ret;
> +
>  	switch (ret) {
>  	case IIO_AVAIL_RANGE:
>  		switch (*type) {
> @@ -888,7 +891,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  		return 0;
>  
>  	default:
> -		return ret;
> +		return -EINVAL;
>  	}
>  }
>  

