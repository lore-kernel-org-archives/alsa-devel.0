Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C7FC3DA7A
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jan 2023 14:05:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5021D9ACE;
	Mon,  2 Jan 2023 15:04:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5021D9ACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672668348;
	bh=N63SXdlL9trrHT7Xb21JxrmzN98pQgZ+pngOJfLwRW0=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Yhjrtd/8rJ6lBqyk9UcZMWLSwTHxCZIVKj+9cnKO4pe/vwH+emaYeP99T6bcSHibm
	 s77pOg9M6p8sgLQ4U9sSriRCs69AEQRrL7Pz4k6+5T7/woUWgg0/E95E8KxzfbsLhx
	 4EHSG81yVA86blBfcgD/nPIViP8j/DK71X8LQeiQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 844FBF801EB;
	Mon,  2 Jan 2023 15:04:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCD8AF8023A; Mon,  2 Jan 2023 15:04:30 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28CCDF80238
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2023 15:04:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28CCDF80238
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=EO8Wyb5E
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 43124660036F;
 Mon,  2 Jan 2023 14:04:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1672668268;
 bh=N63SXdlL9trrHT7Xb21JxrmzN98pQgZ+pngOJfLwRW0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EO8Wyb5EuGeVId76NRTrQ9g9Nlan1KM2Ai39EmIxSU6LKNlOf7MyspUj74K/lCiKv
 lYywjFAX3bHRQci9rb6iwlrPFBZa+CdM6lIt3V5T7+p8MtZqaaHjK60rkkPDGQNeWl
 usbZ2hVsCKGGGUnuZyER/m1DJUbY7CyVrQCNbem8Jgs9mohg4vnVCNG0kfQC/JbuzZ
 FMCjIEX34EqKh8GHBUlHwUN9Xk+bLe6IAfaf90kiOEougdc8KpruVxyLFyC2VZEeMQ
 0OTpx4iqfTNHOjxczg3Oh9c2PdNvpJp4C3tuQMLi3hy1WMdvgql0L7DOb+vox5zEW+
 TAHvHrC60eoNQ==
Message-ID: <6e1a405d-b20e-1093-a236-f3713aedbb1d@collabora.com>
Date: Mon, 2 Jan 2023 15:04:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 04/13] ASoC: mediatek: mt8188: support adda in platform
 driver
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
 p.zabel@pengutronix.de
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
 <20221230055443.16024-5-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221230055443.16024-5-trevor.wu@mediatek.com>
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

Il 30/12/22 06:54, Trevor Wu ha scritto:
> Add mt8188 adda dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


