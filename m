Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F049CC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 10:19:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9DB81867;
	Mon, 14 Mar 2022 11:18:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9DB81867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647253188;
	bh=Xhm3zTCf6fMF/1xTFWS49KczB8qcaMTMqtJUqaWvAOQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C91yQYLortbhKGM1CbBO5Tu3iruMdGuI0zSLRXOSA7ewGS6hZcymzWcjhZSewpm5W
	 FgXsC1vPIaxhfu1YDuJLsT+GwvOvx3471oNBkLXrAabnxcmzX9mu1ZLXycI/+GW/ea
	 g0KuuvoP1r9T/1gDy56c765CxwEPjk11RiEy7qFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5F50F80510;
	Mon, 14 Mar 2022 11:18:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90B37F804E5; Mon, 14 Mar 2022 11:18:31 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24679F804E5
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 11:18:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24679F804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="HebpY9GH"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 9BB481F43E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1647253108;
 bh=Xhm3zTCf6fMF/1xTFWS49KczB8qcaMTMqtJUqaWvAOQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HebpY9GHsh4/EF1tb4cHCYjdHjqFoVaMStCWf+GYjxlRAznKIX3amuZoiYtQxjE8M
 IIUk+s1KDRkDTFgsSTXfphKdFlww+OayPkTXu+Jf3EYt5xxqmqgguuIIvvuTOVcZVZ
 ln9nTOWYrtlF0uoLsEngQLKneKZsZQUE6nB4ez+0c6/gAsrYLdxLLcF9B2yaj47abM
 Qn150wl9SlffmS6MUiRrpGFpuTBJctTNO79R6IRtJtPfKlyg377hLtWqpE3kLermgu
 3YlGn4WBRNl4DkHPKZuUZmVqhXH219FD3YThf3h7kDgqzlJkB08my6jvOx9f7vHvdV
 Hx/+EuJRSsfLQ==
Message-ID: <5f79e76b-1333-159c-2dc7-0f7e8927e4df@collabora.com>
Date: Mon, 14 Mar 2022 11:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 03/19] ASoC: mediatek: mt8186: support audsys clock control
Content-Language: en-US
To: Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org, robh+dt@kernel.org
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-4-jiaxin.yu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-4-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com, julianbraha@gmail.com,
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

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> Add mt8186 audio cg control. Audio clock gates are registered to
> CCF for reference count and clock parent management.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8186/mt8186-audsys-clk.c | 150 ++++++++++++++++++
>   sound/soc/mediatek/mt8186/mt8186-audsys-clk.h |  15 ++
>   .../soc/mediatek/mt8186/mt8186-audsys-clkid.h |  45 ++++++
>   3 files changed, 210 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clkid.h
> 
