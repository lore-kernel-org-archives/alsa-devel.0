Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BD8C352A1
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Nov 2022 10:20:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20D0116C9;
	Thu, 24 Nov 2022 11:19:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20D0116C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669285234;
	bh=fYzwZG+btrhJNj7qcJzSFCW1tTOHZHac4nQx+C+xmJo=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ig4Zc0BqDnSxhB9mO2A0pmVNAwUWFx1bP2o05PAZ4LOTz5q4Ox2fqlFbP2kg1WzDX
	 JepvjDDa/ixmHcYkFzyovMbdmqU9iR28ld0lnzBPrk9lfztUZbfYxhpQeC8aPFV/D1
	 HqOiauRGewC+tJqjZ8WjSHdTPj05E1YElqmw/ar8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D08CAF80245;
	Thu, 24 Nov 2022 11:19:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB17BF80431; Thu, 24 Nov 2022 11:19:42 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A93CEF8014E
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2022 11:19:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A93CEF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="ladVD4h/"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 839F96602B10;
 Thu, 24 Nov 2022 10:19:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1669285175;
 bh=fYzwZG+btrhJNj7qcJzSFCW1tTOHZHac4nQx+C+xmJo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ladVD4h/ARN4kZRmjQ270HjSLleSxaquqisDU36RMD2TrzBG1av3lgH5/NwutbCJA
 KHeCMghCW5GrjkB6eQBL5u3gtoZi9xedOyOKf2X+rOfWxlOeD9ygiVlqhXOz4BmbDB
 DrkMiMk3NyJKBZ6oLeDTFnSWMQ+2jeha9SOBdkzA896osv1To3KlBR1YF6EyLAGu39
 Wy9zbsWKJMqKEpsN2Zw6VGlrN/pGNaT4WcSBzQvTnooeqJ8DwR5duWPsJB9F+M2GZu
 D0H8FL4CeeTrWTw3IrIwveshAusTNB/Cbviv9bnABR3+nUJaj0cJDQAljsiho6ArW2
 fBYF99C9wwrLQ==
Message-ID: <dad82c29-71f7-dfb2-a682-5aeedb1a2518@collabora.com>
Date: Thu, 24 Nov 2022 11:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Correct I2S shared clocks
Content-Language: en-US
To: Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
 nfraprado@collabora.com
References: <20221123161130.543-1-jiaxin.yu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221123161130.543-1-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, chunxu.li@mediatek.com,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, ajye_huang@compal.corp-partner.google.com,
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

Il 23/11/22 17:11, Jiaxin Yu ha scritto:
> In mt8186 platform, I2S2 should be the main I2S port that will provide the
> clock, on the contrary I2S3 should be the second I2S port that will use
> this clock.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


