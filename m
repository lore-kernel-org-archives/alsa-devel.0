Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77310C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 15:26:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C83C18D4;
	Thu, 10 Mar 2022 16:25:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C83C18D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646925966;
	bh=G44TKaXJ2702MH14xQ2xJ5CzDZDhej3DrvU8W8AmQpM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iZatIKAHa7+ygUwZmTrGROGxBP1znrr9H4dBMR/gNcDl1wP9siLk/O+uyXVq8ic4E
	 BxamMlHQUbCcaxXeEwCZjiAqDq15tsSzgS8Wchg71j3kXbp4jYmjtVVQO46HPECk1U
	 8tMsvP1tzDySgqZpZ5TTj8MZ1c4l/GygpWV/LzH4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28B89F800D2;
	Thu, 10 Mar 2022 16:25:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35B0DF80137; Thu, 10 Mar 2022 16:25:15 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B2CBF800D2
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 16:25:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B2CBF800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="SXhuKhFE"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 6B0911F45A2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1646925907;
 bh=G44TKaXJ2702MH14xQ2xJ5CzDZDhej3DrvU8W8AmQpM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SXhuKhFEp8Pn5kLpJ9uE75VypUMiWbTDJVSbQOK8PeLRuwMErkdO4jbich+dzPauC
 qCJWCscyap4JMwtArGtY5HzKtdvHxmWP7UbBPZXUPeHdFbn2BmwfQ33I7MwQG8brbd
 fYowneCd2ko50BtGZSUUzuRyJ/wegpIExSkuV6lgm16tPDRBenjMZEc9g8r/MZCpiT
 JZBtRYcs3DiM/nITjUjJB6X2evoUXrnf21ef/sN5ap4/j6gW50i8UJIkGflgdbeBHL
 docIDtmUfdlSE6vs5URQcIca6NSmP9Jcr8vaydjsb9YA3GvDJgCzFyl9ueHgXddWqI
 r4s8PlBH5D3EQ==
Message-ID: <ead686bc-06ae-c572-999a-af22c183550f@collabora.com>
Date: Thu, 10 Mar 2022 16:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/5] ASoC: mediatek: mt8195: add reset controller
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, matthias.bgg@gmail.com
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
 <20220308072435.22460-2-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220308072435.22460-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 yc.hung@mediatek.com, aaronyu@google.com, linux-arm-kernel@lists.infradead.org
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

Il 08/03/22 08:24, Trevor Wu ha scritto:
> Audio hardware is possibly used in the firmware stage, so resetting audio
> hardware before regcache records default register values is required.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
> index 550636500949..72b2c6d629b9 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
> @@ -16,6 +16,7 @@
>   #include <linux/of_platform.h>
>   #include <linux/of_reserved_mem.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>   #include "mt8195-afe-common.h"
>   #include "mt8195-afe-clk.h"
>   #include "mt8195-reg.h"
> @@ -3056,6 +3057,7 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
>   	struct mtk_base_afe *afe;
>   	struct mt8195_afe_private *afe_priv;
>   	struct device *dev = &pdev->dev;
> +	struct reset_control *rstc;
>   	int i, irq_id, ret;
>   	struct snd_soc_component *component;
>   
> @@ -3092,6 +3094,20 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	/* reset controller to reset audio regs before regmap cache */
> +	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
> +	if (IS_ERR(rstc)) {
> +		ret = PTR_ERR(rstc);
> +		dev_err(dev, "could not get audiosys reset:%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = reset_control_reset(rstc);
> +	if (ret) {
> +		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
> +		return ret;
> +	}
> +
>   	spin_lock_init(&afe_priv->afe_ctrl_lock);
>   
>   	mutex_init(&afe->irq_alloc_lock);



