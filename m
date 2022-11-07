Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5A0C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 09:08:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F419C82E;
	Mon,  7 Nov 2022 10:07:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F419C82E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667812098;
	bh=prmGmYokfxjatbKpcc4DQXf1AZmk9zVLfrXHS15NugY=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DY3xAw+j70FbmWPmNuXb+D6MEHtottggyHL+aBX+nLuR1S9IqQSl3ie2qvvDMWVaX
	 lItI6hhTtpj72nmpUYdYVrPOlsr839WvQVe/pjWhEtyKawbQc+Pxyd/dZjXeNPDxQF
	 Ds1e0n4yjOqN6EkxxPTKJvKX9V9jCo8FBo65ebjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70BC4F804C1;
	Mon,  7 Nov 2022 10:07:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D396FF804D0; Mon,  7 Nov 2022 10:07:13 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 985F1F80116
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 10:07:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 985F1F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="JY3SBDqc"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id B3378660239F;
 Mon,  7 Nov 2022 09:07:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667812026;
 bh=prmGmYokfxjatbKpcc4DQXf1AZmk9zVLfrXHS15NugY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JY3SBDqc0y+wUpmIZtCHEyo/Y2S9DGJBc4bzw8gaJOf4eOE0ng0bVT+aFGsIYg/oo
 BYDCAb9OgYO5bp2DBPTUvwxCAx9Jqn+HCvVQCFGjpkv4rGgwhMgSxBY73g2zBH2Y+0
 KB6ess79kEPv/lnwLGFL2iVICMuaIZu86Mbm1V3vF0ScgXNTc1vwx0SYBAN0LPIA5f
 WerpxNGiElXw9P5Iz5SI1s7aFkqHSRqExET7dkoqS6luj9mYbd0H0IaXo7puG0WFzM
 iy/gz+AIGkWJdT84jbR3TEB4qCh7Cxxv5L6KRt4gV6rqRUFuajw+K9zYiIeGqCy/lz
 KKuxkxUVCycxQ==
Message-ID: <b4e53cc6-ad6e-dfc1-608f-ce9243f73bbc@collabora.com>
Date: Mon, 7 Nov 2022 10:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt8183-mt6358: Register to module
 device table
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>
References: <20221104212409.603970-1-nfraprado@collabora.com>
 <20221104212409.603970-2-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221104212409.603970-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Tzung-Bi Shih <tzungbi@kernel.org>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 linux-mediatek@lists.infradead.org, Akihiko Odaki <akihiko.odaki@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
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

Il 04/11/22 22:24, Nícolas F. R. A. Prado ha scritto:
> Register the compatibles for this module on the module device table so
> it can be automatically loaded when a matching device is found on the
> system.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


