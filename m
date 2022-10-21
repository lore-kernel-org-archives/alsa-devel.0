Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FFDC4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Oct 2022 08:42:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BF09C064;
	Fri, 21 Oct 2022 10:41:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BF09C064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666341763;
	bh=WANU7m9hgqToTw/RP9cHBA0LoJL6y7ZdfH4haHnLtdQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h0P31rbmGp86TDsHzzUNZGI0XN3W6tQ6117p+oQNbsKh4z/FiRLQoFyjp89IIQGHx
	 3545nZc3DKGJOQCTy8uyVbehDo7EOqHoABERqVuX/9gnZHXcaXnL2x9aOfvg0A7Z0M
	 WjkNSeRl3PVv0NIL7818KvKiWSHgvvw1ideC2p6E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6DFBF800B5;
	Fri, 21 Oct 2022 10:41:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2090AF80510; Fri, 21 Oct 2022 10:41:30 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A695F800B5
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2022 10:41:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A695F800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="BkFQu0ng"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 714336600362;
 Fri, 21 Oct 2022 09:41:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1666341683;
 bh=WANU7m9hgqToTw/RP9cHBA0LoJL6y7ZdfH4haHnLtdQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BkFQu0ngUOp5evXfQqcRE2qZIAuLB3yU7igIYTzhEqQ2bVP8Ykj6FEQkq06dmt6B1
 iKzlznsYz3XOhWYnoyyC0+isM+UwVAZAC3SROnR8rr8MpSYbZlG9SQmmjcqMd7t2Te
 /FjMpQbhC2vqO3ea7+HUEMJ8KRAKC0Eics5KXzr5OAL24mTUb1Jqh0Y6uENB1AACwW
 6CNkdBRm/dGzQQzuIDYy44m71NFiMXqm5jfNOGwV3GBQOxdDZmnaw855IksiHE4xzh
 d0FLvcI1CZDKsvw8mb2CxgROoarw+N2VinCFV+3WzQp7QtdqwpmzPxta68E8KAAihK
 Bz2m9pP6AgB7A==
Message-ID: <1de8f6f4-a023-8214-c584-3f7436c98f42@collabora.com>
Date: Fri, 21 Oct 2022 10:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 05/12] ASoC: mediatek: mt8188: support etdm in platform
 driver
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
 <20221021082719.18325-6-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221021082719.18325-6-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

Il 21/10/22 10:27, Trevor Wu ha scritto:
> Add mt8188 etdm dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


