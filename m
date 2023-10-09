Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFCAE95A91
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Oct 2023 08:53:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D6579F6;
	Mon,  9 Oct 2023 10:52:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D6579F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696841598;
	bh=AeV4F+YxzIjrv5/reJdTrfUYSuarpl9kOSA1kuEAPvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nbIOkNuTpzrgyyO3rJrd0fxZ//Ktl6ahMA3FbqAy+pcLNHZ7QverwlLBSbA0AnBZX
	 KL9laPEbWZAUn16ujIGTkmzqIkMVhmaxV7QUl/qsBZuTc6lQDuDILcrvcbcQaj8gen
	 rVKn8KsnXYisAra3oZIrfMT8bhGYwfygNv8DzW7c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9859F8055C; Mon,  9 Oct 2023 10:51:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CF47FF80563;
	Mon,  9 Oct 2023 10:51:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DA89F80536; Mon,  9 Oct 2023 10:51:31 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1D0C4F8027B
	for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2023 10:51:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D0C4F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=C0fx5MLH
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AF27660716C;
	Mon,  9 Oct 2023 09:51:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1696841482;
	bh=AeV4F+YxzIjrv5/reJdTrfUYSuarpl9kOSA1kuEAPvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C0fx5MLHjUZ5LPSlk6G1axwyJy0cOqyKNZ52QU6lB43BTBR0w0Mf7fjyUyON7X6H+
	 TKUnseRy62LLKr9BPLlejzLwT53I/XgvNNxfkkc5A9mewZd1tLHHFwF9PEXM48chFe
	 Z5w6QWRFgGPai6iV2dnoN/ojzmI+WT3ugpjIdLLlTmXzaiuob7RhvaIhbDSZXby/Pe
	 6KZousTG9vwzBtpwb2Pu75Veo4pc2hAWE8z3A/9zb56bB+t4pRtmVuC60UKU5RN5a8
	 7cDpfFVf6M3EUqOONlJjhPiq2hIwvBrB7wPQNZ7l9hNhod8O/O9UW2Wdke2vXdbXfg
	 YFbyQYJAGyibA==
Message-ID: <dfcd36ac-712b-5169-5320-0e1591107252@collabora.com>
Date: Mon, 9 Oct 2023 10:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/8] gpiolib: of: Add quirk for mt2701-cs42448 ASoC sound
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 alsa-devel@alsa-project.org
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
 <20231006-descriptors-asoc-mediatek-v1-1-07fe79f337f5@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-1-07fe79f337f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: VVSOMCC4FGW4PC5N5DJGBGHR2FKVG5QR
X-Message-ID-Hash: VVSOMCC4FGW4PC5N5DJGBGHR2FKVG5QR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VVSOMCC4FGW4PC5N5DJGBGHR2FKVG5QR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 06/10/23 15:46, Linus Walleij ha scritto:
> These gpio names are due to old DT bindings not following the
> "-gpio"/"-gpios" conventions. Handle it using a quirk so the
> driver can just look up the GPIOs.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

