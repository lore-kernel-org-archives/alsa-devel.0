Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEC2C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 10:26:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC39616E4;
	Mon, 14 Mar 2022 11:25:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC39616E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647253578;
	bh=CMDLyrkwOqWTgGkVJSKbrJxuQwnDyjhV3L0QailiIj8=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bIDm6vT0832AK5HBX25mfYCQGTjSOQIMnVytk+TFpoJznnIh8+ldNMWPKpPJ/Hhsl
	 ibF9OFWQ96KeZpBXb4x+9DBHp80PoaXpVbZKs2CdXN66p5MzHukGRsfEG7zGLbDu+u
	 SYxtj+j++5kT8Sp1cBlfkoYuliqz6qmzGeTfbhc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CE4BF801EC;
	Mon, 14 Mar 2022 11:25:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFDE5F80100; Mon, 14 Mar 2022 11:25:26 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1360F80100
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 11:25:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1360F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="kB3fV4sK"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id B83AA1F434FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1647253519;
 bh=CMDLyrkwOqWTgGkVJSKbrJxuQwnDyjhV3L0QailiIj8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kB3fV4sKc0tD7r3/SJxX8Rl5Debi9JeEKE/AlO+V1kyORZVET0wnKCqS5m/qCbD36
 VGOkrAxa1UGiyaw06eshc8SRqa2lujdY8Fk9fvVOKwnJECoJIc0XjpP0eKFUXUayqb
 hlGjh/UQVKcCKW95Jc/BfmgpNTOHVDQ9o2BRjGfkCzc3pyZSIKR1wz9LLbhNS2j8Oa
 0SBgCQWR05ZRqiwJOGGvkKHxpsR9SCYsVnQd0/JKVszQsW41sDMw1WHcDdZ9RZqVPm
 N/fgKs5kSa4RprKUgKD+GeqN9UGjB+Jj5XznV/gr+o0MmhrQE51U/z/aEi5EDrj9hk
 dk/avJx8Y5jJg==
Message-ID: <fe924e75-6543-2b5a-b354-6eb38fb1cbe6@collabora.com>
Date: Mon, 14 Mar 2022 11:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 04/19] ASoC: mediatek: mt8186: support adda in platform driver
Content-Language: en-US
To: Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org, robh+dt@kernel.org
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-5-jiaxin.yu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-5-jiaxin.yu@mediatek.com>
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
> Add mt8186 adda dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 878 ++++++++++++++++++++
>   1 file changed, 878 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> 
