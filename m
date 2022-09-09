Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37808ECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 07:37:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 670A0169E;
	Fri,  9 Sep 2022 09:36:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 670A0169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662709059;
	bh=UX+vi+FdnLov80MlTgas9MMxCaC7dGmiE21tUnnYlkw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uvBa8Mmo+4kMktokWwskJPVhDSIr+86OlI3xbM3CsSTpAQ8yxVi7K1ZYxSe5wzPMX
	 mvGDSBllYTGBl60+OlYjUIH585hB7AEiB8JilFZUcWz3r+RjZ72Leizm5G/PAQtATR
	 cUm0h20hR9fCtoGN8tnAp503mMnIY78013qb6tPo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB1D9F8056F;
	Fri,  9 Sep 2022 09:34:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93F80F80553; Fri,  9 Sep 2022 09:34:50 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C63FBF80553
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 09:34:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C63FBF80553
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="fYqple5A"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D17B6601FB8;
 Fri,  9 Sep 2022 08:34:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1662708882;
 bh=UX+vi+FdnLov80MlTgas9MMxCaC7dGmiE21tUnnYlkw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fYqple5AGtnvz9nIggKzsiVfg9ersxHSb2UJiEBqEb5qk54iOdalXoxti0AnYFaEn
 4Kep4SfSfHJBNMiTKMU4s4P5MlSJiDv8ZfpjqhkZzi7BStCyvYgn3AO+eS4MeuLMsg
 728ykeOuDsnqBUQ9aZGU7YyuK5y3REpr9D8UBdAC6iDJOUwi52DFT+P/xs8iZ+RG+R
 s5HuIKUKt+pMwImBOmy6N3qTv2vDNMeEb2G7iKphDqsr1OtVDoWp7CUSbzzCQBuinJ
 Mi/axLFu2OiOWHqi20ydk27ZSxY43d20x1RRTLZ4SZbuBeyYKtqNiYXKp3oJQtGHDv
 ISI196tY9DUBg==
Message-ID: <3b7f5a3c-c1f2-7bb3-7583-74b244d9fc13@collabora.com>
Date: Fri, 9 Sep 2022 09:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 02/10] ASoC: mediatek: mt8192-mt6359: Make i2s9 share the
 clock from i2s8
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <20220908161154.648557-3-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908161154.648557-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Tzung-Bi Shih <tzungbi@google.com>, linux-mediatek@lists.infradead.org,
 Akihiko Odaki <akihiko.odaki@gmail.com>, kernel@collabora.com,
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
> Both i2s8 and i2s9 are connected to the rt5682 codec and should share
> the same clock to work in a full-duplex manner. Set the clock sharing
> during the initialization for rt5682.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[For MT8192 Asurada]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


