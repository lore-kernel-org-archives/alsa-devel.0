Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC0C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:29:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67AB62068E
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W6i0kvk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AB62068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F19D91655;
	Mon, 15 Jun 2020 10:28:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F19D91655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592209741;
	bh=gpdKkAnY1DIOV2OdGaEtOElQ/hAKX5CC8YXn37/GsNI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W6i0kvk/cYKmBfyGIukyCpf7R/p82oemFFoYRAWUsaO3XdE8RqoijVTJIadcohu2M
	 TislP3njF/d+cc0c4aoR0ThjRpAIdKzCJjKCA5bT+/VHAJ0/28CJlLZl7N/r5tkUcB
	 p73HCjt1MZQzH/TSSwfTvAixIiGfMkQJ3J971dTY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DC03F80162;
	Mon, 15 Jun 2020 10:28:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D521F80171; Mon, 15 Jun 2020 10:28:04 +0200 (CEST)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by alsa1.perex.cz (Postfix) with ESMTP id 96154F800CD
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 10:27:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96154F800CD
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1jkkSm-0004iN-00; Mon, 15 Jun 2020 10:27:28 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 4D970C0687; Mon, 15 Jun 2020 10:13:46 +0200 (CEST)
Date: Mon, 15 Jun 2020 10:13:46 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 13/29] dt: fix broken links due to txt->yaml renames
Message-ID: <20200615081346.GA5592@alpha.franken.de>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <0e4a7f0b7efcc8109c8a41a2e13c8adde4d9c6b9.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e4a7f0b7efcc8109c8a41a2e13c8adde4d9c6b9.1592203542.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: alsa-devel@alsa-project.org,
 Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-rockchip@lists.infradead.org, Sandy Huang <hjc@rock-chips.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-bluetooth@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Jun 15, 2020 at 08:46:52AM +0200, Mauro Carvalho Chehab wrote:
> There are some new broken doc links due to yaml renames
> at DT. Developers should really run:
> 
> 	./scripts/documentation-file-ref-check
> 
> in order to solve those issues while submitting patches.
> This tool can even fix most of the issues with:
> 
> 	./scripts/documentation-file-ref-check --fix
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt  | 2 +-
>  .../devicetree/bindings/display/rockchip/rockchip-drm.yaml    | 2 +-
>  Documentation/devicetree/bindings/net/mediatek-bluetooth.txt  | 2 +-
>  Documentation/devicetree/bindings/sound/audio-graph-card.txt  | 2 +-
>  Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt  | 2 +-
>  Documentation/mips/ingenic-tcu.rst                            | 2 +-
>  MAINTAINERS                                                   | 4 ++--
>  7 files changed, 8 insertions(+), 8 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
