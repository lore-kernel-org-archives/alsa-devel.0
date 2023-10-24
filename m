Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE72C00A8F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Oct 2023 09:28:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42B9BA4B;
	Tue, 24 Oct 2023 11:27:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42B9BA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698139694;
	bh=x0hoEPrZVpDP8h39Ok3fCECmUX60IQWzTwTBbMbxSLw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=g4QEekSy/+R48u6yqcOM+7mErH0REWquh/zjaQBNW62w6TBuG1VvRAFKT/DoF3g1f
	 40UDerzu6GjJDtIBJfr1Q5lh2UqUg9Y2Y7AhrqnZKG5XKg1UfkOLZ17WQhG7TNir9P
	 Jx58LeE34OcbTHHXi33ZmsfA05NdjJsBp8YkHa9k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 075F8F80567; Tue, 24 Oct 2023 11:26:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70B3EF80558;
	Tue, 24 Oct 2023 11:26:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6835AF80165; Tue, 24 Oct 2023 11:26:29 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E6BCBF8014B
	for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2023 11:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6BCBF8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=Ce9179+q
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C5976603102;
	Tue, 24 Oct 2023 10:26:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698139583;
	bh=x0hoEPrZVpDP8h39Ok3fCECmUX60IQWzTwTBbMbxSLw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ce9179+qx9pPm44JUfD0tJRXYpicaelpwO+Odd61yCpYnmAZ5s9P02yZn5ttY+A6r
	 pCYS1artduAaa/0dE9tSDqjMf7pSaHXpmWNeMg3D2ZfQZXHujsHO5ISRxs7rGR/i+E
	 OfUHa22kpx1q/A1QwIIapWiQEFUBp/YWGMkAfUhaKxfdXuzdzAOgETnEhEr5fGqufk
	 QW2gIWyZMfQwE5Gjez6vguZJKU7iGitWb7of0eP32mONUEaHcIy1mu6ekaJ7s80mM9
	 fp4Cnk1nV6Tjx2Pv2gQtubXGK+thr1yqtk/s91r1LUoWjktfEmRBIMDgZanXhpEWIH
	 R1OyQbH721FXA==
Message-ID: <1b92e452-c325-4f6f-8ac3-22086c4a7b2e@collabora.com>
Date: Tue, 24 Oct 2023 11:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ASoC: mediatek: mt7986: drop the remove callback
 of mt7986_wm8960
Content-Language: en-US
To: Maso Huang <maso.huang@mediatek.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231024035019.11732-1-maso.huang@mediatek.com>
 <20231024035019.11732-2-maso.huang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231024035019.11732-2-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: XCZFRRBCPYREXCDOAAUCSZBJLOBFWMYB
X-Message-ID-Hash: XCZFRRBCPYREXCDOAAUCSZBJLOBFWMYB
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XCZFRRBCPYREXCDOAAUCSZBJLOBFWMYB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 24/10/23 05:50, Maso Huang ha scritto:
> Drop the remove callback of mt7986_wm8960.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


