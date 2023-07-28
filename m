Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1742AC001E0
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jul 2023 09:39:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4C7883E;
	Fri, 28 Jul 2023 11:38:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4C7883E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690537181;
	bh=x/NC9kRms1NVzTGvKisnxeIx9pk+AWAePM5eU3NJJEE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lbUa4MsFn2ML6Ubkmcp8jdPe/6bJD2Q648bOCYwdQAnZ2qZwjH+0BFg7Pl8CmrNXF
	 L9ZPQdwoQ9s3dcqDFEkmkkA9i1utjJPkXucmGDv440yoyBRH2r3g2qHUndmVPe53yY
	 zoQX5cQXdjacTMfwf3cyGGW2ooNvAQVXTYUH9drQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91183F800C7; Fri, 28 Jul 2023 11:38:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DF94F8019B;
	Fri, 28 Jul 2023 11:38:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3A39F8019B; Fri, 28 Jul 2023 11:38:18 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B50BF800C7
	for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2023 11:38:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B50BF800C7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=cFsn/MCB
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EFE26605835;
	Fri, 28 Jul 2023 10:38:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1690537092;
	bh=x/NC9kRms1NVzTGvKisnxeIx9pk+AWAePM5eU3NJJEE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cFsn/MCB70uY4rbKGJ8wTrwILnk7lT3fOOncZ8C8E4B95hFd23zxEUYEobQOWvDRG
	 MCOI6OpNFHN5h1baDmQO2d5zHnzLbxyPAbiApr7rQrHFkZANZCNJZrcqLNsrMg7kH0
	 XuO2p5lJslgF1X6KyAfwHBeHVZIxp+dp3ljoWERIm4qEjRESjn0jbfPOmM+KCn8b2V
	 kErrCb7mhiICxvUNLPQIXq6pZwsJ7QHphPn2oCw/oRTJGxqjQfu3s8WuuEoXI0yFgh
	 od5aNQkQEA3/0N53GWxqHm4GWQLWAvLSlDnNWUkrPf6iZrRz9n4u1FoGx+JMuR5G0R
	 y8OWTa3enGTcA==
Message-ID: <4eb32bcc-9a1b-c477-71b1-823bd96c0450@collabora.com>
Date: Fri, 28 Jul 2023 11:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/6] ASoC: mediatek: mt7986: add platform driver
To: Maso Huang <maso.huang@mediatek.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Trevor Wu <trevor.wu@mediatek.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-4-maso.huang@mediatek.com>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230728090819.18038-4-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: ZE74GLSQRCXDZ6CZPLAIQHV6W5MSB6X4
X-Message-ID-Hash: ZE74GLSQRCXDZ6CZPLAIQHV6W5MSB6X4
X-MailFrom: angelogioacchino.delregno@collabora.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZE74GLSQRCXDZ6CZPLAIQHV6W5MSB6X4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 28/07/23 11:08, Maso Huang ha scritto:
> Add mt7986 platform driver.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                 |  10 +
>   sound/soc/mediatek/Makefile                |   1 +
>   sound/soc/mediatek/mt7986/Makefile         |   8 +
>   sound/soc/mediatek/mt7986/mt7986-afe-pcm.c | 622 +++++++++++++++++++++
>   4 files changed, 641 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt7986/Makefile
>   create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
> 

..snip..

> +	/* register component */
> +	ret = devm_snd_soc_register_component(&pdev->dev,
> +					      &mt7986_afe_component,
> +					      NULL, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "err_platform\n");

I know I only said about using dev_err_probe(), but "err_platform" doesn't
mean anything!

Please write a human readable error message, like "Cannot register AFE component\n"

> +
> +	ret = devm_snd_soc_register_component(afe->dev,
> +					      &mt7986_afe_pcm_dai_component,
> +					      afe->dai_drivers,
> +					      afe->num_dai_drivers);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "err_dai_component\n");

And the same here, "Cannot register PCM DAI component\n"

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
