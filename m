Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDFDECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 07:37:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C11481679;
	Fri,  9 Sep 2022 09:36:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C11481679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662709028;
	bh=Tzg/KMC5DofvyyVkSfmNmWKXbrDA4Yg43gmkwq2jIjk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jde7d8xGUxZaPe6RmPYKLk4wLO8gOOBoGvSTU7UdXGKGvqPhZ0L3LH3/O/6uMBgGG
	 hV3MWbaEOdfeaK4dDKJwP3n1rBzshC+F/VaVDJ+wTF+3zy7CejpRc0dCw7DbX8Xge2
	 lxzlzFqnWr3mmHncpV9Ggz+Kek3I1myd+/tHoiNA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA486F8055C;
	Fri,  9 Sep 2022 09:34:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10A63F80537; Fri,  9 Sep 2022 09:34:45 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9686AF8053A
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 09:34:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9686AF8053A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="C+KJmOih"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id DE3D36601F9D;
 Fri,  9 Sep 2022 08:34:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1662708875;
 bh=Tzg/KMC5DofvyyVkSfmNmWKXbrDA4Yg43gmkwq2jIjk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=C+KJmOihyla+EBZdYxYVP37t7+7zgXeA0xqgMQHoWae6/5HCqhpe1zJ14rWT+oByp
 1rHtKCxYgY74Kd/4UHnrlNMRvVIEMpzQsaZly511bY1g+7/+/5PlTUWNJ7pjYqdmRM
 xbch77UaAjk8KfMHP60g5s62frATaZMmQFWAB3A+JVt7QcXyO7oGa7qhFOf5zrXq6w
 6/XpND3c85WCthmBWR4YPP3n7lYttBkBbYGwebnA7xP1VFJESyQFaRmQhSURKLMJXx
 /wOJhh/baixLVA2lWhzQC0nk4CXFer7+yvjsLRTs9C3ZTcpzRQVW4auSwSJgY6t6Qs
 bbBOeCQawlXRQ==
Message-ID: <7d376fb2-2f80-5973-5275-a273a2c18107@collabora.com>
Date: Fri, 9 Sep 2022 09:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 03/10] ASoC: mediatek: mt8192: Remove clock share parsing
 from DT
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <20220908161154.648557-4-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908161154.648557-4-nfraprado@collabora.com>
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
> Now that the clock sharing for i2s ports can be configured from the
> sound machine driver, remove the logic that was used to parse the
> properties from the devicetree.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[For MT8192 Asurada]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


