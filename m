Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4B3C38A2D
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Oct 2022 10:07:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD43255A9;
	Tue, 25 Oct 2022 12:07:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD43255A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666692476;
	bh=UtlfTotMD2ki+X2wC6TKcrkIjBB6Q4W+mMUDKD795dM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fGBSkxL7ObR/EbLI11plD0CrYmJoqI4F12TNmn88hKFAqtLFdoFKFgXnpX4JqytgZ
	 sT602uEZBTX7ZNpmJ7fzdRTHgz1B1gFuSt3xaGJbT9fMqrWZSEubi+/BljftQkU9pK
	 wuNH1wM4j5uK7O1oeXzNBxHk7oRxQywoeztGh/CI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56D96F80115;
	Tue, 25 Oct 2022 12:07:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8B95F8049E; Tue, 25 Oct 2022 12:07:05 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7859AF80100
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 12:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7859AF80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="b9KTrGEQ"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id D1C586600363;
 Tue, 25 Oct 2022 11:07:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1666692421;
 bh=UtlfTotMD2ki+X2wC6TKcrkIjBB6Q4W+mMUDKD795dM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=b9KTrGEQpLIHDjuvIOvXFZJbHa0JO9S7ZX+EkKE7rbk3JBhjAg/65WD65Oat73Zip
 3yXfm7TZRmyQVDlCK0o8iQHjAepjQV/jok+m3F89uxQK4hsKBKWuF3ANcc/pf+COMu
 /yT2xQ2cHezIyeA56dwvvb1JJHkYYedEQGMOZtHMheUd62uv5kRAosSeewDJghC/1H
 SsVxZEDJdRh1UVINt+wndS/Z4bm5XmbAn6B9EfN0v1dnMvcGo7W2DEWP3jlpupGZG8
 D7fZ5NhzBqnxT8LRdNvY+2rKIke6f0QbEzla0vYUTBPS7lNUlgu4iqn80ark+UhUj7
 zB/cYc9jq43XQ==
Message-ID: <b1863393-0b73-ca44-12ae-567982b07f68@collabora.com>
Date: Tue, 25 Oct 2022 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: realtek,rt5682s: Add
 #sound-dai-cells
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-2-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024220015.1759428-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Derek Fang <derek.fang@realtek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@collabora.com
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

Il 25/10/22 00:00, Nícolas F. R. A. Prado ha scritto:
> The rt5682s codec is a DAI provider with two interfaces - AIF1 and AIF2
> - and therefore should have a #sound-dai-cells property that is equal to
> 1. Add it.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


