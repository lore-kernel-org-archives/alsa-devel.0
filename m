Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837CBC64ED6
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Mar 2023 10:02:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FBA11DA;
	Wed,  1 Mar 2023 11:01:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FBA11DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677664950;
	bh=HC6KSnhiLwT/rwuATmwOy2gOfI8Nwvc1BwEcPTsflsY=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m7BTzWOiUHR3CeJTAiBQXLj/AFyNG7qC1OmZ0ZVUAb0/rSE6Cs1iZN24WnP475giu
	 5XkxwNpRMBX0l/0sY4qwd+j0L2dCCHqzXMlJj5L6ilk+kbu8kZkLVoqmUd5RZLdkw4
	 /YfeC42GtrkEAHJRo0JAs+PuwwGsBoud0X6cqmus=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AC787F8049C;
	Wed,  1 Mar 2023 11:01:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF1EFF8049C; Wed,  1 Mar 2023 11:01:10 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36979F800BA
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2023 11:00:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36979F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=kA9Lh9yA
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id CAD6E660036A;
	Wed,  1 Mar 2023 10:00:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1677664856;
	bh=HC6KSnhiLwT/rwuATmwOy2gOfI8Nwvc1BwEcPTsflsY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kA9Lh9yAHXIMWB4LLmy61Nhboafh+GLDlvQ6Tnaa991cs5bMbOWMyYw5pF9TDryWm
	 NFgxQVWLzohrtBdJzYuC9E8RBD/4gjW8pjTJkFzpCE/HqBurRx0Tn/RYW274io3hOW
	 jsT0ueuezgh1W21LGC/EX/SkKANAC1w73jFF2jIiX+Of3ndtJxsc3fmpP+K3RwTYtk
	 v72/1a45iIU0IbnHxiXH0oL2foXHeZX5VJlFCchLbEtiQ+x4cwY4+QKpX524VH9QcG
	 zKY/LAgBJ8mSHTakJ3+xvRCRlclZWHfVCEBfTJ41Ek6xUSmP4BwZNP9MQMjiN37wAe
	 /1dV80eowfUoQ==
Message-ID: <3d2f385e-dc85-8033-cf77-e5f0634c5be0@collabora.com>
Date: Wed, 1 Mar 2023 11:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ASoC: mediatek: add missing initialization
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, matthias.bgg@gmail.com
References: <20230301040835.6322-1-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230301040835.6322-1-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: YWR5TKBEI6CFBN3LIXHFTPLIXYJRPM33
X-Message-ID-Hash: YWR5TKBEI6CFBN3LIXHFTPLIXYJRPM33
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YWR5TKBEI6CFBN3LIXHFTPLIXYJRPM33/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 01/03/23 05:08, Trevor Wu ha scritto:
> In etdm dai driver, dai_etdm_parse_of() function is used to parse dts
> properties to get parameters. There are two for-loops which are
> sepearately for all etdm and etdm input only cases. In etdm in only
> loop, dai_id is not initialized, so it keeps the value intiliazed in
> another loop.
> 
> In the patch, add the missing initialization to fix the unexpected
> parsing problem.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

I agree about this fix, but this commit is not fine as it is:
Please split it in two commits and add the appropriate Fixes tag to each
for backports.

Regards,
Angelo

