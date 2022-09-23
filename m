Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B5CECAAD8
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Sep 2022 08:59:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2D36820;
	Fri, 23 Sep 2022 10:58:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2D36820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663923570;
	bh=wQmu1prepFsDvoMxrwrAtiqg7HEwyKsBpugOrawZEkQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XOo0eCv8jUKog0EwUk6T72Ve5JG8ij0sKYUh98BaH3BG64LT0BEmiqhoDVStQ5FWB
	 DY8IpRKXR8rdgF3uJC4UN/8klbnQGj2xYEKVoWwWFu07/Kt9I0xpIuZKo1rI0KAo2R
	 VoshZbappgZNHZf21bcpgxfXtpuYd3OFi4lA8Dtk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 163A7F804E4;
	Fri, 23 Sep 2022 10:58:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E69F4F804AC; Fri, 23 Sep 2022 10:58:12 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD737F801EC
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2022 10:58:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD737F801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="K6wTIJ1b"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 13063660223C;
 Fri, 23 Sep 2022 09:58:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1663923485;
 bh=wQmu1prepFsDvoMxrwrAtiqg7HEwyKsBpugOrawZEkQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=K6wTIJ1bY5gfv5Kpet4pzsWBrE1rM/8GzteW+6esTf+m1sm8opaXfNjL+9lFAv0L3
 RQdOXSqvhx3+Wt+7Vc59beI20KyZGhUwK08vhqspehoRm5V+WGqd/sdPn1/kdmTur4
 jSwY0pTEA+UKqc0BqPGhqd7hersgBQNaKzNDfRG5HF9G/WVVo+yl2kgFyyFfXmCz2k
 0OCkBIfYw3Zg4WD9MRiij1LMGJfbHXuRZw5p5nu3k4ovSQ4GIDLsQwRwEl0dxjLZ3f
 xQod9S8J43hFfiV3CIn72IWRypxJxwRuya9DeQphAfc988UliaNSqMqos05ZNx7Boh
 +cN7aPf9UoOeg==
Message-ID: <00ac0110-5369-87ec-36dd-d5f07f0b6d7c@collabora.com>
Date: Fri, 23 Sep 2022 10:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 5/6] ASoC: mediatek: mt8186-rt5682: Add headset widgets
 with switches
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>
References: <20220922235951.252532-1-nfraprado@collabora.com>
 <20220922235951.252532-6-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220922235951.252532-6-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, "chunxu.li" <chunxu.li@mediatek.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
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

Il 23/09/22 01:59, Nícolas F. R. A. Prado ha scritto:
> Add DAPM widgets for headphones and headset microphone, with matching
> switches, to allow toggling these paths based on the jack connection
> status.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


