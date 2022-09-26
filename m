Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D43AC32771
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 08:25:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B92E820;
	Mon, 26 Sep 2022 10:24:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B92E820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664180723;
	bh=mQyvu1ScEHkd61hzAOnaU61WIDBcOrPXfYxLmQ5wJ7Y=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nT6lP5NXPW/L4qAEd7sbEcLQIf1jJzCfj+dFMqkfEaHqcrlAXM1pzhPy1Ej+XKyCf
	 7k2A15kMhnSdGymY71sIkTfKMwsbUvMg63BdA+74BbS+MWXcNegDCTduycZbtjpmqe
	 idHM3SYSxHlvugNn69cW2JLnvbB+h5uEfK2Gx1Io=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 545DCF8053A;
	Mon, 26 Sep 2022 10:24:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8057CF8027D; Mon, 26 Sep 2022 10:23:58 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B88CF80134;
 Mon, 26 Sep 2022 10:23:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B88CF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="KfDYT4ic"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id AB697660222F;
 Mon, 26 Sep 2022 09:23:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1664180630;
 bh=mQyvu1ScEHkd61hzAOnaU61WIDBcOrPXfYxLmQ5wJ7Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KfDYT4icIc/2yq/2SgtoNp8u+hOtidbqB4DY8R2vieQGKH9O/XW8Wl1+dV3BX1JDK
 GqyBAcQR0o8gfDZVNKCuIOA7p3Ng8KSWljWGiVNEXloXkcWaDA1vpk6w3UHI89eDKf
 Lq9I52r3BzFvIaFytSheCH42Z5usCmK2zKcWYMuMBVnwzIM73JMJQxWhUO0xHFO7uD
 ouGE1KjFJ/gwk5csTMjM147jBqaKOdijSw/cpbSBdvz1j00EC1ugqfUq/1RjYoIEZb
 PIsyohUn6z7yDv8EM/qbDzuiNkLzVCCpjwFyeftKZVIjR45epVf97YGWHxFO9/np0g
 TUGy3xQ7Z3IWw==
Message-ID: <7e752eda-2851-b13b-9a57-920ade4bacfd@collabora.com>
Date: Mon, 26 Sep 2022 10:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] ASoC: SOF: mediatek: mt8195: Add pcm_hw_params
 callback
Content-Language: en-US
To: Chunxu Li <chunxu.li@mediatek.com>, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, peter.ujfalusi@linux.intel.com,
 lgirdwood@gmail.com, daniel.baluta@nxp.com
References: <20220924033559.26599-1-chunxu.li@mediatek.com>
 <20220924033559.26599-2-chunxu.li@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220924033559.26599-2-chunxu.li@mediatek.com>
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
> Add pcm_hw_params callback for mt8195 to support continue
> update dma host position
> 
> Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


