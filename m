Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B304BECAAD3
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 07:36:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6203169A;
	Fri,  9 Sep 2022 09:35:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6203169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662708969;
	bh=M/ImFX4OghN1Sdqc5u8HRD4U/spLXlNjoEztoXxxE1Y=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXkV5oZAwo+Ov8bZv7+h6Lkx0pbeGU1/E5QvomXVW7rTPayHzqfezvkgFf/sQpJc/
	 eF6jqRjiZC8uNH9mWVKivDYa7cBWwcn9X3oe+epn9Ni6/Dl0X2+xZCZITfOLnZbxkB
	 Ez1Ar9MVqkhhpYC5Er3aef/5ie7MQODaosRzMjBM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C83ECF80528;
	Fri,  9 Sep 2022 09:34:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B303EF8032B; Fri,  9 Sep 2022 09:34:28 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BF43F8023A
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 09:34:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BF43F8023A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="VV7I4Gac"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id ECB6B6601FAE;
 Fri,  9 Sep 2022 08:34:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1662708864;
 bh=M/ImFX4OghN1Sdqc5u8HRD4U/spLXlNjoEztoXxxE1Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VV7I4GacRYbbGnJOBZylhdmQ1mJ6FLW8Y6tKEVxsS55KjFuXLa7WJtZmjBtAr+3Rm
 ynGCagswN0JNdNnlv0NXuw6bHi/zQNMyw99Fc8DCwcOEGopnKhHKt9Ocms+Hnocb2Q
 9g9HncPI5Ix4eMLFq0NpB3XkEaFO1EmW2k0eDTcWkjnWqrHpKqph5bEAtBuUbkAs5J
 YvSiorEW0+3GmQV3xD+Rz/4KvrOsYEF8+RyYIT0HKzAP6mG+kWuMVBSKsORkO9vXEM
 fpRTGYStE11oPnoAQ6D5zrTHCP/qg9A8zQClAiwwWSNP4ghCWP0ELwhu4ZcTRVPi5a
 1xUgOsMa+COsw==
Message-ID: <be60c122-2c01-5963-0b49-9f55806f787d@collabora.com>
Date: Fri, 9 Sep 2022 09:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 01/10] ASoC: mediatek: mt8192: Allow setting shared clocks
 from machine driver
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <20220908161154.648557-2-nfraprado@collabora.com>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908161154.648557-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
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

Il 08/09/22 18:11, Nícolas F. R. A. Prado ha scritto:
> Add a new function to configure the shared clock between two i2s ports,
> and export it. This will allow the clock sharing to be set from the
> machine driver instead of the devicetree.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[For MT8192 Asurada]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

