Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02486C3DA7A
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jan 2023 11:10:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 408D41064F;
	Thu,  5 Jan 2023 12:09:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 408D41064F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672917020;
	bh=LAsrZfSnQres51ppPQcdXpGQ3gS3K+MVgY/44ivN1Y4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bEBEprKTHk+Ny8LWxRBPhYGOeljshMQ1F6ntaONMmZbF54VidHzPspU076f5H2bir
	 9gb097We975KN2fRsD1HoT+1bwEhEMOI67tJnaJlDSlIz7Th3nle9QzElOwjOKlhqB
	 HZAEHmhKRZLH1lMiPQAVgwNzfESmpLu39NCjJL4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3788F8047B;
	Thu,  5 Jan 2023 12:09:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B3BDF804AD; Thu,  5 Jan 2023 12:09:29 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC8F3F8022B
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2023 12:09:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC8F3F8022B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=iAV0ZfBH
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A6786602D2B;
 Thu,  5 Jan 2023 11:09:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1672916965;
 bh=LAsrZfSnQres51ppPQcdXpGQ3gS3K+MVgY/44ivN1Y4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iAV0ZfBHi/SK8ThsE63VKckB2W2TMiARXN3hqNYC9GBS8vXSmHwFk8BwBeesxguF6
 zP/Ks+vamEcKO+tHiXLJVubRerU8+1LbLcnfN/HqDygHAouz4KePH66XvtHGBuyf6i
 IY/3y8k+ju4FBAU8qnWsg3RVY6QzQxVhI7tGbpJbP7yu92Ww2H5MudA8QLjk2C4weG
 nGYh12cV+HI9m/5+NtKCiXqU4RuHEqf5JqaxDOQT44PWAVz67QPpd2y+LZkWEAAqbv
 +9vsS2c8QEHPto8fJzPBjfbA+GxTSq6iRRxO4VnzBYp3Yy4GuFiDRv7k238VBSpJi2
 j5IjErh5uIDkQ==
Message-ID: <77e958fd-5ced-bd5a-70cb-af4fe94717d5@collabora.com>
Date: Thu, 5 Jan 2023 12:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 09/13] ASoC: mediatek: mt8188: add control for timing
 select
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
 p.zabel@pengutronix.de
References: <20230105081606.6582-1-trevor.wu@mediatek.com>
 <20230105081606.6582-10-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230105081606.6582-10-trevor.wu@mediatek.com>
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

Il 05/01/23 09:16, Trevor Wu ha scritto:
> Add mixer control for irq and memif timing selection.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


