Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32901ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Oct 2022 12:55:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2DED167A;
	Mon, 31 Oct 2022 13:54:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2DED167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667220917;
	bh=lOHooi5pohixyKqlZ0SlL3CFISOCTxYrSbEfnF1+q9U=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QydCmwp+LbjqovpZFtkQ1rct7pK8LyTEXCO/PFKMfCrN93BZykTYWVNhMATp8GI50
	 RdYPmjTcZyRwsxIRZUxuwTT8yjGXXYMUNZ1DCT0Xvmus/q/jmV7NOr1PMU9morusfZ
	 qU12NGrmPo+hpHpREbuqT0nTB2Nz7ZD89jq8I0W0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04E90F8015B;
	Mon, 31 Oct 2022 13:53:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 297C8F800F3; Mon, 31 Oct 2022 13:53:39 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79637F800F3
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 13:53:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79637F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="f499WdNq"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 575B7660283A;
 Mon, 31 Oct 2022 12:53:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667220807;
 bh=lOHooi5pohixyKqlZ0SlL3CFISOCTxYrSbEfnF1+q9U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=f499WdNqAR/opycj9EDQkypoD8+F+pU32v5QNpIaXvAGJWJSyJMpHx9SuQvmlec/w
 6XlDwrw2LD3zKJ3Qfm6B7Ka7oZAIKoHtABO3y+e6JfeA8cVk5rfW5NwlhKxRO34FtC
 jDF7xkGTDUyovw1xTniRRPHWgUAwefU7JHHkWVcV37eOV74fIP05+MLBPE08HF8N22
 veTwvG8V0DGweibUPBZyUI857UK/2git4BYwzp/Jv4v7dW8+V0p+pv6Zr/noMiLRaT
 L6CZUE0gOydLD+Qis2oYD3gopsP7JKJLjtSpGmCsEf1Kp2JFnbTDzC7MA7FUBVMjz+
 pgh1oVi5LuFnw==
Message-ID: <a454c363-8683-d59a-c571-1b5b29f68bd9@collabora.com>
Date: Mon, 31 Oct 2022 13:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/8] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and
 MICVDD supplies
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, Bjorn Andersson <andersson@kernel.org>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-2-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221028205540.3197304-2-nfraprado@collabora.com>
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

Il 28/10/22 22:55, Nícolas F. R. A. Prado ha scritto:
> The rt5682s codec has two supplies - AVDD and MICVDD - which are already
> used by sc7180-trogdor-kingoftown.dtsi. Document them in the binding.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

