Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342A8C7EE2D
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Feb 2023 08:56:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37EC3832;
	Mon, 27 Feb 2023 09:55:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37EC3832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677488182;
	bh=TMi4EMDMJ6BN+G43IUeSNqmzFjjGoOITcOTDgs0VSYM=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m1NwP+SjEXAKSbYrARbIQ6ZE/j3KSy6BXAhBGt1eQ9IybmiSlGAahKgYs2HWVOJuZ
	 d7d7M9V2GufLPK0JnhjxCuIcMweFLqzNpYrm8c/ZPyg3py1mCzB7MRCRMZHowlvFW8
	 mXwCvDfatHPc9bkNP7C0UhU12Bv5fyqe7qxbz5B4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6059DF8049C;
	Mon, 27 Feb 2023 09:55:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFA67F8049C; Mon, 27 Feb 2023 09:55:10 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0E393F80236
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2023 09:55:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E393F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=ljlsB1ra
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 3AF786602216;
	Mon, 27 Feb 2023 08:55:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1677488108;
	bh=TMi4EMDMJ6BN+G43IUeSNqmzFjjGoOITcOTDgs0VSYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ljlsB1ra7Ty9HhGq2NFp6Bc47GzvflrpVfEmvUEbWZS95vIELcjJNeKM42l8azOrX
	 D8rL642+hjIqgCXm0ypYkIYUzTTmHm3kzLuLM7hfP78KOc6m8aVjOUEpGENff1GHSG
	 pihyoJueMobh7WmKB+hgibecmYvgdMvi4vdtvoPDT/GuXCE8V/F6Vgh4HTtGfaWHLK
	 LzQwwFpFeMDrkaRshDG9xQwklts5+uhHFbLaqUrXZGnpE1+YkJ1yBWiKA5QyNe+m/2
	 PTq+0AXDfJPKRqpn8ieN3TqLurwxa0kLehCa2cJbM2hIRSLQGWq2kHKFG7/u5BSz4B
	 pJR211/AOMxpw==
Message-ID: <ece739cc-7d75-8f99-2a43-06ff8490c5b8@collabora.com>
Date: Mon, 27 Feb 2023 09:55:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ASoC: mt8183: Fix event generation for I2S DAI
 operations
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20230224-asoc-mt8183-quick-fixes-v1-0-041f29419ed5@kernel.org>
 <20230224-asoc-mt8183-quick-fixes-v1-2-041f29419ed5@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230224-asoc-mt8183-quick-fixes-v1-2-041f29419ed5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: VJKCACIG4454SSRJEE5KI42K2ACJ6ONI
X-Message-ID-Hash: VJKCACIG4454SSRJEE5KI42K2ACJ6ONI
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VJKCACIG4454SSRJEE5KI42K2ACJ6ONI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 26/02/23 13:49, Mark Brown ha scritto:
> ALSA control put() operations should return 0 if the value changed so that
> events can be generated appropriately for userspace but the custom control
> in the MT8183 I2S DAI driver doesn't do that, fix it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


