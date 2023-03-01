Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B06C7EE2D
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Mar 2023 11:12:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 813AF827;
	Wed,  1 Mar 2023 12:11:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 813AF827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677669123;
	bh=eTzm+EIAjQcoyhPrp2GjtRD4G6+LecRvF0U2zjS/gWI=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HbxNh/C2nrIaPxv3fyP/A+0ngt+tOEBV7Y/uClZaD9qfAzrYAMvDcXAF7WmsJk7M1
	 8YBUNx9L6/T1VdVLUiDANlXL567dX5HiiXIwi6UDwVgXRKgML11+S4RTVjNC8gM9YT
	 QFTIB912StSYN4xfMa7m4024jRIvYi5lMdV+ZLgo=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23811F80520;
	Wed,  1 Mar 2023 12:11:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F963F8051B; Wed,  1 Mar 2023 12:11:02 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 566F3F804B1
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2023 12:10:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 566F3F804B1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=lVebGzc7
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id C10A26602119;
	Wed,  1 Mar 2023 11:10:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1677669058;
	bh=eTzm+EIAjQcoyhPrp2GjtRD4G6+LecRvF0U2zjS/gWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lVebGzc7EXXg57QxAJY8TSgbomC8z/uuRcUJCDyjanimBugLk1aa/j0Hk6OUwe1Xf
	 9B3TNWcQJDX8Hx83MU7TDiLzMIkWRPuM8J4L2b8tAErqpa0Zgbnpdp+knn1T/cTWsx
	 07HzAGuMu3T9L1WfEIBzdSrkaRYGdC2BuKceOz6sWRWzGdvzpXliLZZzSWssspGi7g
	 fh4gqh/zAgAQO6Vnh4HQM/j1v+4zEw9OgNpz7MF25PtcZMmIb7dw6fiw1AXfwWKLSt
	 8Ssup+fNGEvcNie4yXyZJhRgWIMqnYDdjCU0rMAXlchXynaHiBkyXtxTfAoI3zKL7s
	 nxGY/P4MKoHyg==
Message-ID: <0c26685f-225a-8ef9-a4c4-0afaf9deb742@collabora.com>
Date: Wed, 1 Mar 2023 12:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt8188: add missing initialization
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, matthias.bgg@gmail.com
References: <20230301110200.26177-1-trevor.wu@mediatek.com>
 <20230301110200.26177-2-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230301110200.26177-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: L76AJW7HL43UAEPKL3O3Z5Y37K4CYTVT
X-Message-ID-Hash: L76AJW7HL43UAEPKL3O3Z5Y37K4CYTVT
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L76AJW7HL43UAEPKL3O3Z5Y37K4CYTVT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 01/03/23 12:01, Trevor Wu ha scritto:
> In etdm dai driver, dai_etdm_parse_of() function is used to parse dts
> properties to get parameters. There are two for-loops which are
> sepearately for all etdm and etdm input only cases. In etdm in only
> loop, dai_id is not initialized, so it keeps the value intiliazed in
> another loop.
> 
> In the patch, add the missing initialization to fix the unexpected
> parsing problem.
> 
> Fixes: 2babb4777489 ("ASoC: mediatek: mt8188: support etdm in platform driver")
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

