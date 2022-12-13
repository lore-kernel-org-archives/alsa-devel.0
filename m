Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC44C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Dec 2022 10:46:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88E5B1906;
	Tue, 13 Dec 2022 11:45:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88E5B1906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670928381;
	bh=uplpfhEN6RmyAtuxsuSug50gkJOXSHec1yz8xB64QX4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ARn8MrSbeC3TgRnO+E+MX5sAYIop4HYuVU6MByPUiGoRI4smTSW6tzkjkB0+hgKWP
	 CA5yBDLmhq0KA78UkvndP/2oxrWchajI4GBHoD25lFXqvegBl0daXqi0hwJe3xxYwR
	 2iY55J2lXEUQyf4+Fq1XLP6DTagpAjGhpa0UsJGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30E3BF8047D;
	Tue, 13 Dec 2022 11:45:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D3F8F804D6; Tue, 13 Dec 2022 11:45:29 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B362F80272
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2022 11:45:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B362F80272
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=OSPTw/wy
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id BA77E6602AB2;
 Tue, 13 Dec 2022 10:45:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1670928326;
 bh=uplpfhEN6RmyAtuxsuSug50gkJOXSHec1yz8xB64QX4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OSPTw/wyqkLD69Ap07pXFqSSC0XEq7gF01g+KFB9E+NXHRWa4YAlsJWuD/xTNM8Z0
 JwOL6FFumMHMmBEL/867Z0F0S4ggG3H3euRxkOc52f3ngcYSHS4uxH+f8XcsiyFMgv
 n86GuWECw39I2xKqSq8qTyalhtMk2VW9lTBe62DR21xnPF2MDg6RAVeoda/wB5Ae/W
 jz/adww5OPm5DKI3//39M+MSbQBXnst5kk59N3Zn8N1/GplaTYF0U9VLdJqZ9G9Nrq
 /BUSMSRMc1hiNKQaO2BglRWZZNL88eZ4PeNejBsZDKUvsfE6lMbXn6JErDRnd/J7ic
 imHFADLcqxEYw==
Message-ID: <ff9ba731-8d17-b98c-5b24-4ff831f6aba0@collabora.com>
Date: Tue, 13 Dec 2022 11:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 04/12] ASoC: mediatek: mt8188: support adda in platform
 driver
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
 p.zabel@pengutronix.de
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
 <20221208033148.21866-5-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221208033148.21866-5-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Il 08/12/22 04:31, Trevor Wu ha scritto:
> Add mt8188 adda dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> I don't add Reviewed-by tag because one new header file is included
> in the patch to resolve compiling issue found by kernel test robot.
> ---
>   sound/soc/mediatek/mt8188/mt8188-dai-adda.c | 632 ++++++++++++++++++++
>   1 file changed, 632 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-adda.c

