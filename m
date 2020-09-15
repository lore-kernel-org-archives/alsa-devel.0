Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E763DC43461
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:34:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596BA216C4
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EXFRPQiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596BA216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EE64168D;
	Tue, 15 Sep 2020 08:33:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EE64168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600151661;
	bh=gQN80aMoH2s3GE9erToUjhl8b7acInenUAOTa+APQvE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXFRPQiK1R0F4/XwA/XSEbn1oPVQ8Vq8mK648z3UeSuPHQYt9cjNylZ2FdX6OStFJ
	 91jPmnwCOvvYg30ZToZ2sfjZWKPORfT/r/tA9okDpetF4Wz79vCg5ZzZ6p6HlTJn2z
	 AqnX6KVkxp3p4y/G6LAq1Cpy/tH0Q+NpGPmVmnIw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 527B5F800F1;
	Tue, 15 Sep 2020 08:33:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 384B9F8027C; Tue, 15 Sep 2020 08:33:21 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66C2FF800F1
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 08:33:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66C2FF800F1
Received: by verein.lst.de (Postfix, from userid 2407)
 id 553AD6736F; Tue, 15 Sep 2020 08:33:14 +0200 (CEST)
Date: Tue, 15 Sep 2020 08:33:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH 03/17] drm/exynos: stop setting DMA_ATTR_NON_CONSISTENT
Message-ID: <20200915063314.GC19113@lst.de>
References: <20200914144433.1622958-1-hch@lst.de>
 <20200914144433.1622958-4-hch@lst.de>
 <7a1d11c2-0fc5-e110-dabe-960e516bb343@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a1d11c2-0fc5-e110-dabe-960e516bb343@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-scsi@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 iommu@lists.linux-foundation.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
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

On Mon, Sep 14, 2020 at 06:34:02PM +0300, Sergei Shtylyov wrote:
> On 9/14/20 5:44 PM, Christoph Hellwig wrote:
> 
> > DMA_ATTR_NON_CONSISTENT is a no-op except on PARISC and some mips
> > configs, so don't set it in this ARM specific driver.
> 
>    Hm, PARICS and ARM capitalized but mips in lower case? :-)

I guess it should also be PA-RISC if we start nitpicking..
