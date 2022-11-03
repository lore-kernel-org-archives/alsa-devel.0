Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F75CC4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Nov 2022 09:00:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D41E2F7;
	Thu,  3 Nov 2022 09:59:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D41E2F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667466038;
	bh=yyA4nshyOejFruW2qTCDX0nI9Crc4tmHokItn82rW+k=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u98MD4iilrqPldohDcG8bsc21Wksd2r+mSeo7FYM0p6u7nfFDqNd/SBbqrXx+QtE8
	 O2gIk+zh2YfnXGXshoquatD13COdBuWBmubsoBpa6VJAsvlDOrjzFBcZchRokrlfuC
	 dw5TmG1aZYW5OAU6hcBNPMF6lSrfD0zrJsMN6Ors=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E8C9F8051C;
	Thu,  3 Nov 2022 09:59:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 869AFF80155; Thu,  3 Nov 2022 09:59:46 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D720F80155
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2022 09:59:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D720F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="PSxgdhGa"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id E11BC6600366;
 Thu,  3 Nov 2022 08:59:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667465979;
 bh=yyA4nshyOejFruW2qTCDX0nI9Crc4tmHokItn82rW+k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PSxgdhGag8XE9XK1B8mnVZNqTZgJqYvHfsY6M/w7vbYXSfwg5wEBe2fcxRHdEnAtw
 eH2tk7CntQM2Sq2k/5WGSqqdihck3cW3gTa+HyapP8VbDiGGhedTgj8crQAfBt3JZD
 DSlP0Vna11jsKz2p5ZWY+0RPOXRSWpkP9VEUWg4z+BUgeoQOIt/8L5n4MzRlN2AxYG
 Zx75XWGTnh7eFoTtz3mFSPwAxJjbI8RuizPdnv3uZpUePnrnp/7HS3NtC7sWD5YXnw
 Fm8gAYD2gcPWfPqq8fYgERwbcfCRvm7gKhsON8Ddz7T41ju1DUz5KLF5MDPvGyv+ld
 z9Cyi8mG96KWQ==
Message-ID: <128d8f47-1e60-bb64-e457-d61ceb17c176@collabora.com>
Date: Thu, 3 Nov 2022 09:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 2/2] ASoC: mediatek: mt8186-rt5682: Modify machine
 driver for two DMICs case
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 linux-kernel@vger.kernel.org
References: <20221102125936.2176748-1-ajye_huang@compal.corp-partner.google.com>
 <20221102125936.2176748-3-ajye_huang@compal.corp-partner.google.com>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221102125936.2176748-3-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 "chunxu . li" <chunxu.li@mediatek.com>,
 =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

Il 02/11/22 13:59, Ajye Huang ha scritto:
> Having two DMICs, a front DMIC and a Rear DMIC,
> but only host audio input AUX port0 is used for these two Dmics.
> A "dmic-gpios" property is used for a mixer control to switch
> the dmic signal source between the Front and Rear Dmic.
> 
> Refer to this one as an example,
> commit 3cfbf07c6d27
> ("ASoC: qcom: sc7180: Modify machine driver for 2mic")
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

