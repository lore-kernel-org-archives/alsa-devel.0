Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43204C64ED8
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Feb 2023 08:57:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DA5420F;
	Mon, 27 Feb 2023 09:56:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DA5420F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677488237;
	bh=taQhUxaOsGhHCfOQ95dCcLkENRbmjmYKLoYAD5LNXW8=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OWSHRCUIQxig0Oi7OejZFPdq/f7rr19BMJZ9ikBd40HsAfphQqUFxQltnzcU5qFaH
	 yVN5c2E2rT4a+xFBFcNnxvO9qYqpKCIO+Ifrq+qijuZ0F/lD9L3zDW5W7iHqYRDZRw
	 iXUDKeqD0xCohVzUdEQmhqxtWXKrViYhltKZLP3Q=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AE53F804B1;
	Mon, 27 Feb 2023 09:55:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3653F80533; Mon, 27 Feb 2023 09:55:19 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D0B45F80520
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2023 09:55:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0B45F80520
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=gGaOdL5d
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F3C56602E18;
	Mon, 27 Feb 2023 08:55:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1677488116;
	bh=taQhUxaOsGhHCfOQ95dCcLkENRbmjmYKLoYAD5LNXW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gGaOdL5dKQXEAcGurCbekn69w0lAAUeW+kaXbM3b5k/JB6dftwOLovhfChJiIIc9/
	 wxTYv8hMF3ThFE84763OZI1+HB/yzrqfKyZqXcDWYCjJNtnQIj4Ed3WchjouLekcpu
	 SMMJwWn2eq8BD3h4OVvy6LGNnhNpu2rITZaFC5VlOFT1xRnvj0MxbG6e/9sSuTMjpj
	 7NgmWlS54202XIaKHwjNS49yp+DpTnv4w8dm7ffnAjn3RtGvkE1p+s9bKzeAi9vMqr
	 IsyeDtfbEsTk9KuQRbB1U93EGUcNc6Wfgu3iAQyfVdJcNSmnjLUkTSQgHKR/E/B78X
	 5IiAhx7uMNLrQ==
Message-ID: <867761ec-6209-b2fb-6cfd-0052698a357d@collabora.com>
Date: Mon, 27 Feb 2023 09:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] ASoC: mt6358: Validate Wake on Voice 2 writes
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20230224-asoc-mt6358-quick-fixes-v1-0-747d9186be4b@kernel.org>
 <20230224-asoc-mt6358-quick-fixes-v1-2-747d9186be4b@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230224-asoc-mt6358-quick-fixes-v1-2-747d9186be4b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 4JWJ3I2MFCFF2VSIZQTYMEI4DAIJEYDX
X-Message-ID-Hash: 4JWJ3I2MFCFF2VSIZQTYMEI4DAIJEYDX
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4JWJ3I2MFCFF2VSIZQTYMEI4DAIJEYDX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 26/02/23 13:47, Mark Brown ha scritto:
> Currently the Wake on Voice 2 control accepts and stores any value written
> but it reports that only 0 and 1 are valid values. Reject any out of range
> values written by userspace.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


