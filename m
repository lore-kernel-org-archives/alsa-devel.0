Return-Path: <SRS0=yvFc=DD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1476C2D0A8
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:15:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF302075A
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tYopDxeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF302075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 723A71944;
	Sat, 26 Sep 2020 16:14:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 723A71944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601129730;
	bh=m/pWUM2bMReEv8jncKYWTiA7rHF48rneBW1KwjAdpvo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tYopDxeOyvhEx0BxoawCx87O+OWSpx4XhwzKpE9TtLkdEXvkpOs2sRJOvtMBv7SJb
	 nfRhfPFFkXI4tglBHrPzhyhjVjjOyv8Lk9QRY+Gtd+D/D8lxLidgESgtN80K/HD9+F
	 IjOYjMXshM00pjQkibgwXFM/slkINQ04qucoBzAs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 055DDF80229;
	Sat, 26 Sep 2020 16:14:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C9E2F80232; Sat, 26 Sep 2020 16:14:38 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD76BF800FD
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2020 16:14:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD76BF800FD
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6B5EE68B05; Sat, 26 Sep 2020 16:14:29 +0200 (CEST)
Date: Sat, 26 Sep 2020 16:14:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 17/18] dma-iommu: implement ->alloc_noncoherent
Message-ID: <20200926141428.GB10379@lst.de>
References: <20200915155122.1768241-1-hch@lst.de>
 <20200915155122.1768241-18-hch@lst.de>
 <20200925184622.GB3607091@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925184622.GB3607091@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-mips@vger.kernel.org,
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
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>
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

On Fri, Sep 25, 2020 at 06:46:22PM +0000, Tomasz Figa wrote:
> > +static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
> > +		dma_addr_t *handle, enum dma_data_direction dir, gfp_t gfp)
> > +{
> > +	if (!gfpflags_allow_blocking(gfp)) {
> > +		struct page *page;
> > +
> > +		page = dma_common_alloc_pages(dev, size, handle, dir, gfp);
> > +		if (!page)
> > +			return NULL;
> > +		return page_address(page);
> > +	}
> > +
> > +	return iommu_dma_alloc_remap(dev, size, handle, gfp | __GFP_ZERO,
> > +				     PAGE_KERNEL, 0);
> 
> iommu_dma_alloc_remap() makes use of the DMA_ATTR_ALLOC_SINGLE_PAGES attribute
> to optimize the allocations for devices which don't care about how contiguous
> the backing memory is. Do you think we could add an attrs argument to this
> function and pass it there?
> 
> As ARM is being moved to the common iommu-dma layer as well, we'll probably
> make use of the argument to support the DMA_ATTR_NO_KERNEL_MAPPING attribute to
> conserve the vmalloc area.

We could probably at it.  However I wonder why this is something the
drivers should care about.  Isn't this really something that should
be a kernel-wide policy for a given system?
