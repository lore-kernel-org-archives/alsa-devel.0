Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824DC43464
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:37:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080E820756
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h7fWFvUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080E820756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C9891664;
	Mon, 21 Sep 2020 08:36:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C9891664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600670250;
	bh=Yy3GQXBHl52wq/QFPOXp8NYbK0Acy8y3ly46W8hh1+8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h7fWFvUg6GKrsL1H61nviU6i9/oIBS2T2Q2NEG0zErhst+QEzonmvQr/PIcNm0YRG
	 Gz1sNvHaWdduOM2RT994XwwzJmDCPqcePXprMovV9wof7QS9v81g1+WDKTscJIVs70
	 /VAuaqnkUpYFYO73TuKx74+od25ZxfgMPmRsFQ2c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1F5BF8010A;
	Mon, 21 Sep 2020 08:36:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0DEEF80162; Mon, 21 Sep 2020 08:36:36 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39E64F8010A
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 08:36:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39E64F8010A
Received: by verein.lst.de (Postfix, from userid 2407)
 id B25CE68AFE; Mon, 21 Sep 2020 08:36:28 +0200 (CEST)
Date: Mon, 21 Sep 2020 08:36:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: Re: a saner API for allocating DMA addressable pages v3
Message-ID: <20200921063628.GB18349@lst.de>
References: <20200915155122.1768241-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915155122.1768241-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, netdev@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

Any comments?

Thomas: this should be identical to the git tree I gave you for mips
testing, and you add your tested-by (and reviewd-by tags where
applicable)?

Helge: for parisc this should effectively be the same as the first
version, but I've dropped the tested-by tags due to the reshuffle,
and chance you could retest it?

On Tue, Sep 15, 2020 at 05:51:04PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series replaced the DMA_ATTR_NON_CONSISTENT flag to dma_alloc_attrs
> with a separate new dma_alloc_pages API, which is available on all
> platforms.  In addition to cleaning up the convoluted code path, this
> ensures that other drivers that have asked for better support for
> non-coherent DMA to pages with incurring bounce buffering over can finally
> be properly supported.
> 
> As a follow up I plan to move the implementation of the
> DMA_ATTR_NO_KERNEL_MAPPING flag over to this framework as well, given
> that is also is a fundamentally non coherent allocation.  The replacement
> for that flag would then return a struct page, as it is allowed to
> actually return pages without a kernel mapping as the name suggested
> (although most of the time they will actually have a kernel mapping..)
> 
> In addition to the conversions of the existing non-coherent DMA users,
> I've also added a patch to convert the firewire ohci driver to use
> the new dma_alloc_pages API.
> 
> The first patch is queued up for 5.9 in the media tree, but included here
> for completeness.
> 
> 
> A git tree is available here:
> 
>     git://git.infradead.org/users/hch/misc.git dma_alloc_pages
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_pages
> 
> 
> Changes since v2:
>  - fix up the patch reshuffle which wasn't quite correct
>  - fix up a few commit messages
> 
> Changes since v1:
>  - rebased on the latests dma-mapping tree, which merged many of the
>    cleanups
>  - fix an argument passing typo in 53c700, caught by sparse
>  - rename a few macro arguments in 53c700
>  - pass the right device to the DMA API in the lib82596 drivers
>  - fix memory ownershiptransfers in sgiseeq
>  - better document what a page in the direct kernel mapping means
>  - split into dma_alloc_pages that returns a struct page and is in the
>    direct mapping vs dma_alloc_noncoherent that can be vmapped
>  - conver the firewire ohci driver to dma_alloc_pages
> 
> Diffstat:
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
