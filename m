Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18B6ECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 07:36:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B9AA16A3;
	Fri,  9 Sep 2022 09:35:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B9AA16A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662708979;
	bh=ah+w7LaAqF28DnY7d+1O80L02oQa2kje4Gx6qQdSYsk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HHwiPam1ZT1wBGV8/nTW1v25tY1OM9ECZ/UMMg5xL+wv63R2N5fOT7hh6vRTRQa79
	 rWiwHXbgdhTUMyA5rLBHmUZRdDfqO7vGkXl0jTvD1jyTJYT2RUEp4EP0/JSguqpZLx
	 wL5R3DogMXV5lohjZCZo6+eJFcjJp4UrSIdxruB0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DD5DF8011C;
	Fri,  9 Sep 2022 09:34:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14CA0F80538; Fri,  9 Sep 2022 09:34:36 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD599F8011C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 09:34:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD599F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="ey+7xPgF"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 650A96601FB5;
 Fri,  9 Sep 2022 08:34:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1662708869;
 bh=ah+w7LaAqF28DnY7d+1O80L02oQa2kje4Gx6qQdSYsk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ey+7xPgFMzl9qr9JrKqDdeQcrF8IZRaHem5Dc5V3sD2Wxc4YSqGhbLJonnI4RXXDE
 UvapLlMIsbrGYzPnW6+L5p3pyeZHFHJhDRd0IFIG4QC9NyiTjn9B2QlawGCnIofBMT
 Vc6Xu70QJ1oqnu/nbJnQ94ub5PfnibWZekFrTFmr0fzZq/kXohO0GN+xeU0Cfcot33
 S5OECCIXd/GhQPRzQFmImZ1rn2Kce92O11iGE5O0ZXKSt+y2itKyvx5qN5+lLpRHO6
 mi5fS8R2ei4jsmZWQX1Ex1QHcQRsV+sjy3Bv+4ubWY6a7YjLSkytGWOyZb6IPs+UrF
 rvfKlJ4RsFlVw==
Message-ID: <29b332ee-cef9-28af-8f87-00a2e7e37f80@collabora.com>
Date: Fri, 9 Sep 2022 09:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 08/10] ASoC: mediatek: mt8186: Allow setting shared clocks
 from machine driver
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <20220908161154.648557-9-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908161154.648557-9-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Chunxu Li <chunxu.li@mediatek.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, Dan Carpenter <dan.carpenter@oracle.com>
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

