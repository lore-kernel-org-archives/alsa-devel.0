Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2A3C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Feb 2022 09:29:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CD0018E7;
	Wed, 16 Feb 2022 10:28:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CD0018E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645003747;
	bh=IvY7iJXZuxVISQOzxTkzNan7PoRvkvKAMjY1GwjciqA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WZ1lO/gHoo/kNslZRF6l3/X+yAf1p+uUBuSn0lFRSsQgpYFb11NZ/IlZkFeeVJzek
	 Pbf3HDGhebzeSbmCq/poa1weG+sSDx/XmuSYlWpGXJAT5l+wAxNjayx0IXLhjmc/ri
	 OeTz8tpj4vNyFwmcqUqU0vfBlAxZh3JzJTl7dtUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5359AF80538;
	Wed, 16 Feb 2022 10:25:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE65BF800C0; Mon, 14 Feb 2022 13:43:54 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53A4EF800C0
 for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2022 13:43:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53A4EF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="QXQIDpL+"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 5197F1F4384F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1644842626;
 bh=IvY7iJXZuxVISQOzxTkzNan7PoRvkvKAMjY1GwjciqA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QXQIDpL+wlcUJSteZlDsqVfHd73wuzzjWwwDOoEFCt2econPievKZC/1oAO4p4kkI
 Rw0W4lQ4fe47IkCH0j3J7XacuvmspOj0yZSG9NV+mDcZObophnvnWKosO5kKLfQwm3
 SWAdkas796uUKoJn8PJauQoPFyK5U8w5KJ3m+CU2UpSPLH405q5Ic07RMybfGVeKGx
 Zu/Wuog64S0en+WH1eYPiERDOEAEa/CdYr+Mo1tNNKxMzpwGwSrX70H/haQC71JmtV
 s4VHzu3D1EW9XrQAYjzaDOn4GDiDAq5z6BzvHwQs/m4bKByE40tK8IXG8QvPNiSZj1
 qorX5LpeI+OsA==
Message-ID: <67b2e6e8-e4fe-06ca-3d12-9bba83743989@collabora.com>
Date: Mon, 14 Feb 2022 13:43:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 20/23] ASoC: codecs: wcd938x: Make use of the helper
 component_compare/release_of
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Yong Wu <yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-21-yong.wu@mediatek.com>
 <YgpNqLQzpx4J6d8K@sirena.org.uk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YgpNqLQzpx4J6d8K@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 16 Feb 2022 10:25:43 +0100
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Joerg Roedel <joro@8bytes.org>, Takashi Iwai <tiwai@suse.com>,
 Rob Clark <robdclark@gmail.com>, James Wang <james.qian.wang@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

Il 14/02/22 13:40, Mark Brown ha scritto:
> On Mon, Feb 14, 2022 at 02:08:16PM +0800, Yong Wu wrote:
>> Use the common compare/release helpers from component.
> 
> What's the story with dependencies here?  I've just got this one patch
> with no cover letter...

Hello Mark,
I agree, the cover letter should be sent to everyone; Yong, please add the
proper Ccs to it next time.

Anyway, context:
https://patchwork.kernel.org/project/linux-mediatek/cover/20220214060819.7334-1-yong.wu@mediatek.com/

Cheers,
Angelo
