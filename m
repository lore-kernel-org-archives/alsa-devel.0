Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB53C3DA7D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jan 2023 11:09:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 440781063D;
	Thu,  5 Jan 2023 12:08:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 440781063D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672916945;
	bh=1kiw+Nt5XgcB53KKtDr+R7gkEeVhhmQpgaGQMdBRJJw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AXyWyBeTGYSdcbvaAdp33RciqE92uS8PevOWkkFWukvP+knsp7ZukWc3DzzAIRPOR
	 F4R+IO2PgL9gmzWcEANy+BTD/tenOMp+tOnIYEylb5/P0rizAaPqOLE2PkQ9Wr8AYr
	 DnBjAlhUNm5VS4UNYQHlF/b0GGZMlsUu5UjTgiic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE69FF8047B;
	Thu,  5 Jan 2023 12:08:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9C58F8047B; Thu,  5 Jan 2023 12:08:13 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25AEFF800C0
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2023 12:08:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25AEFF800C0
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=A/WUTsHe
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id D62196602D2B;
 Thu,  5 Jan 2023 11:08:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1672916890;
 bh=1kiw+Nt5XgcB53KKtDr+R7gkEeVhhmQpgaGQMdBRJJw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=A/WUTsHeShksuISQG/AgxAzAP+CQx4dsDGsshFDwf7Y+EJ0M+6JbGDxb+WgGAJchO
 Xj52jqtomYFQt+1VcX+K067bieQDQhr8hVb51KtxInDykCrZcIGCpbEDRehVeLxXcE
 XOUlL1WrU9oxXh4Ys9JrxLrIeuCea1/Y0FQoKeGxc69WTO1Dx86RXQEE9+LqghwSBX
 GL0ylej9Xm8ktH+VG+nmrclvwLCjZSvP50ToR8fJC8YOhXxVDQ8t+Th4p5NCvzKHec
 FYEXPwDGwa2FmR62+v2CDROQUOQ3rOLY0zMEt0z6OjnfqXBPiuMTcFb+7FByrrKBJD
 vVwAqsGA0TwhA==
Message-ID: <710ca95e-bb57-a487-aaf9-1861b7dcb703@collabora.com>
Date: Thu, 5 Jan 2023 12:08:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 05/13] ASoC: mediatek: mt8188: support etdm in platform
 driver
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
 p.zabel@pengutronix.de
References: <20230105081606.6582-1-trevor.wu@mediatek.com>
 <20230105081606.6582-6-trevor.wu@mediatek.com>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230105081606.6582-6-trevor.wu@mediatek.com>
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

Il 05/01/23 09:15, Trevor Wu ha scritto:
> Add mt8188 etdm dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


