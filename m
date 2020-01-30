Return-Path: <SRS0=xcY/=3T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2324C33C9E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:26:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A215206D5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SkXBeW7J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+qhIqJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A215206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75A031665;
	Thu, 30 Jan 2020 09:25:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75A031665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580372765;
	bh=f9xdYnVLbph46pTwPdeeDEqdN4z94x4C7zgd1kDiqJY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SkXBeW7JvwUbBI3RS3RVAM/0/gSPPV4xZUhPMPEB+WEfwXbmEDiCmn/K0+8dfSi/X
	 FWUIeheN/pC7q34yzx/d/T7hB+NAIXrVCd1KDjcIFD8GoNrYVlX/pVVslHJRsTpoM6
	 gc8PcN68mWf+7G+68uItvpje9cdoNReVrzkS4w3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA37EF800F1;
	Thu, 30 Jan 2020 09:25:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C07B2F80082; Thu, 30 Jan 2020 09:25:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15B9EF80082
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 09:25:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15B9EF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="P+qhIqJa"
Received: from localhost (unknown [117.99.87.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2739206D5;
 Thu, 30 Jan 2020 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580372707;
 bh=oLADHjwsZK/zmHyFtHVsSOYErltf5rGudZWVt9X53gQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P+qhIqJa76JfwK7WzQlywJzMe3cyG8N4B/5+L+1h7UrZwiDF+xemU8OYiAEEpbMSO
 gWoo1Jn5IkfyJFb3w1k/JihqxhbvXbYnSXzCrOrE8NqUn2y9MkbB3wVUI9ZpO5MLGU
 wcxyTiwbpXEqr49mtNa7oEi3kckbyOL8jL/H+f5g=
Date: Thu, 30 Jan 2020 13:55:03 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20200130082503.GD2841@vkoul-mobl>
References: <CGME20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae@eucas1p1.samsung.com>
 <20200130070834.17537-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130070834.17537-1-m.szyprowski@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>,
 dmaengine@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2] dmaengine: Fix return value for
 dma_requrest_chan() in case of failure
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 30-01-20, 08:08, Marek Szyprowski wrote:
> Commit 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and
> slaves") changed the dma_request_chan() function flow in such a way that
> it always returns EPROBE_DEFER in case of channels that cannot be found.
> This break the operation of the devices which have optional DMA channels
> as it puts their drivers in endless deferred probe loop. Fix this by
> propagating the proper error value.

Fixed the title and Applied, thanks

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
