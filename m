Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5527C07E9D
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 08:24:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A0921E0;
	Mon, 26 Sep 2022 10:23:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A0921E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664180689;
	bh=JkMCzYNBMwFiR1kr8tzIGWnW7VICz8110t19kZ3Se+k=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SwrHB6wZtAAtnfdJEJ2x83mB7GN62AMxXeCw8LDoosC2/1R0UJfwX6ZtUizt+f6O9
	 Pvm0AHiuzI7noAZSsLkAQ58YHuJsDpo4CAhojUG1AaI9cV664v6Ur0H9tjmPjBxygw
	 iEJETRkicLyw9eFjGKQF0IO+k1zweb11m3nWhYjI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E15A6F80254;
	Mon, 26 Sep 2022 10:23:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2945FF802BE; Mon, 26 Sep 2022 10:23:57 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1153EF80115;
 Mon, 26 Sep 2022 10:23:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1153EF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="e7+Ebbsd"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D343660205E;
 Mon, 26 Sep 2022 09:23:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1664180628;
 bh=JkMCzYNBMwFiR1kr8tzIGWnW7VICz8110t19kZ3Se+k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e7+EbbsdVJBfK95qRkg/rFlUgtL4cqB8HYCQ/OHRDRhQoz37iOjuSLFglNKU4sPDR
 wygiqD60y0wpHT0eeraZLqT4M74hvRAt0ZNg6JmwODfQMo5YS8bZYsFif5Z9HUEVM3
 JYE5+ptfrELe1Y8UOxGaByeE1Q1mycIpUlMRCFcBaorZ7Wj7u2ZydGuxegVSQFxjOF
 8qR3P+ykX6wjt+xlh52kRvhOSCUuIJ+lnKG3xMn3DBfMD/aLsMOFwnqaEYY9LAWTTL
 4SFnnDXFRhd/VemzqSeYjs7ROj8sGsg0ny7C30TlhUAJUKJDpSxRZ98H/wtkXu/COs
 5sIrvtFfqD26A==
Message-ID: <2b8c3749-0e3b-7460-82c8-b2c21ff5db8a@collabora.com>
Date: Mon, 26 Sep 2022 10:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/2] ASoC: SOF: mediatek: mt8195: Add pcm_pointer callback
Content-Language: en-US
To: Chunxu Li <chunxu.li@mediatek.com>, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, peter.ujfalusi@linux.intel.com,
 lgirdwood@gmail.com, daniel.baluta@nxp.com
References: <20220924033559.26599-1-chunxu.li@mediatek.com>
 <20220924033559.26599-3-chunxu.li@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220924033559.26599-3-chunxu.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 project_global_chrome_upstream_group@mediatek.com,
 linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
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

Il 24/09/22 05:35, Chunxu Li ha scritto:
> Add pcm_pointer callback for mt8195 to support read
> host position from DSP
> 
> Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


