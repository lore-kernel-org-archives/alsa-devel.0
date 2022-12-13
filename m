Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7FAC4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Dec 2022 10:52:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9D951FA0;
	Tue, 13 Dec 2022 11:51:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9D951FA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670928737;
	bh=CPtGI1Gm3EBQgjAgidWD2nOZuLxuahaQPZx80t2p9Aw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XyjDWtD2bjkkcS10So09iTh926dxgE61QDp4vNCXCndWfcOSGOfMAW3+SQ6Lk5qK3
	 OIdxWBxjjdIUT7DKTDfo2AJFFgR9odWVi9hiNyKjnROD3I5pEFDyRn2viC5bFwT1Zd
	 lcZDYRdfgwIqLeBPq07Fg0gZ0FyykhgATP0VW8Kc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 609B8F8047D;
	Tue, 13 Dec 2022 11:51:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB761F804D6; Tue, 13 Dec 2022 11:51:26 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A6B9F80272
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2022 11:51:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A6B9F80272
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=FnrvvckK
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 24C536602AB2;
 Tue, 13 Dec 2022 10:51:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1670928683;
 bh=CPtGI1Gm3EBQgjAgidWD2nOZuLxuahaQPZx80t2p9Aw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FnrvvckKqFm5f5w5WSHzXga8eY2j1Zlh+4OwBbS2cgSCLJZItOxhwN6OTwKpdOuUM
 6dfWe2dg+1EtWVaY94pImHhAp3wxFnp69+M7DmeeRY3Vw/KJoC6Rq8rBOJXr/gdFY3
 njevkjoaQIVXuCnREJvnm6lYKgA/p4UsgCFp549Wj1YkyS+XQ2KLYUsqR1/jFBmyJ8
 /n1RMpwIPFB2qjrsY1ZwOeWR8l5VgJqdUXx55E9N159VDIwfpsUdmx3fx0Z3uNtsp9
 biJlY4u1kt/MNr8u6vqslcs/7U3R7mQTWBX6GgIEZLPU1dIv3cEGfWTHMfzEG/IY4L
 dA5rg/9pfxfQg==
Message-ID: <2383be6d-8ddd-f12f-5083-cf837f9f9478@collabora.com>
Date: Tue, 13 Dec 2022 11:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 07/12] ASoC: mediatek: mt8188: support audio clock
 control
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
 p.zabel@pengutronix.de
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
 <20221208033148.21866-8-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221208033148.21866-8-trevor.wu@mediatek.com>
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
> Add audio clock wrapper and audio tuner control.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


