Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D587C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 10:26:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD3EA184D;
	Mon, 14 Mar 2022 11:26:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD3EA184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647253613;
	bh=aEs1SFqoEgSqlYmwJeL2S9EUjavPhZ0L4qzqDRpfny4=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qDDj7txHuTxWFx0dArT4WQDceRa9W6qTyLAPy99L5s0VblU3OG5LioXRWyfCvW5Wi
	 ++eOXii8ACirAc6hgtIPsbEmCx4WdawI4ii4y4YYu6gJH8RCXNoculq8MA49vBq+Ud
	 g/X9EVTklhLb0rDSu4vsyipHJ9eHPIQNUeRPAxyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9F7CF80139;
	Mon, 14 Mar 2022 11:25:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B775BF80510; Mon, 14 Mar 2022 11:25:28 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1674BF80100
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 11:25:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1674BF80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="LzuHfhhh"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id B01451F43505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1647253522;
 bh=aEs1SFqoEgSqlYmwJeL2S9EUjavPhZ0L4qzqDRpfny4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LzuHfhhhy05sxCVVCJOoPAdJqjRDABOOt5S9sp7Ks3z/oFTmuJB3u1v7UGWtK9Cme
 JXZq+4vin3gzjUZgoB4H5PxuMgzPttAL0rlyXOZ4zYbkqLbJGJdIRnDa6offNrQvJN
 6Axy74Efz4VMD9AUYgIR8k0+fI/42onBtJ1oPN0ilBvrpR+SmckwhT0MZlQba6JG3C
 +bY4g/FdhV3GsnAhQkVxRhaiO59nyOCtKbXJSgznRuZvCOCwc+jAuv6SP1qEk3xfg3
 T/q4AZyawkdTNhMsdPWpNYXgk7tnQQxVGvDaY022TXM6wEwFrJ3v/wZ+CEiWuFK2u+
 qXxMC3JYW4wKg==
Message-ID: <3d980cef-cfa2-6161-9c5b-cd0705d8e8b1@collabora.com>
Date: Mon, 14 Mar 2022 11:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 05/19] ASoC: mediatek: mt8186: support hostless in platform
 driver
Content-Language: en-US
To: Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org, robh+dt@kernel.org
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-6-jiaxin.yu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-6-jiaxin.yu@mediatek.com>
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
> Add mt8186 hostless dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../soc/mediatek/mt8186/mt8186-dai-hostless.c | 298 ++++++++++++++++++
>   1 file changed, 298 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-hostless.c
> 
