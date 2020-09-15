Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4862C43461
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:37:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99D02076C
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Tb1A0X9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99D02076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C0971663;
	Tue, 15 Sep 2020 08:36:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C0971663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600151842;
	bh=J5/pXeI6U7hyoZtAFY/YjKsWVVrZ0oM4sEqSQ8AcGHM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tb1A0X9qXviLuz+t6kRlH7aZPJIietU5Y51CW32DyXZontfQ47sXPWBGPCvVd/5Vq
	 zT5iXXAwBsklrBPrcVB7+BmmyTT1nietbB/irSoY428v8qGjV+6XGwxccKBEGuC/yp
	 y5+jGPOYFmUqI3G7oEZkV5iZ3u9oEhmFA9VdE6Fk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2947F80212;
	Tue, 15 Sep 2020 08:36:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61FC8F80212; Tue, 15 Sep 2020 08:36:26 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C88BF80146
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 08:36:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C88BF80146
Received: by verein.lst.de (Postfix, from userid 2407)
 id CFEFC6736F; Tue, 15 Sep 2020 08:36:18 +0200 (CEST)
Date: Tue, 15 Sep 2020 08:36:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: a saner API for allocating DMA addressable pages v2
Message-ID: <20200915063618.GD19113@lst.de>
References: <20200914144433.1622958-1-hch@lst.de>
 <20200914152617.GR6583@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914152617.GR6583@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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

On Mon, Sep 14, 2020 at 04:26:17PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 14, 2020 at 04:44:16PM +0200, Christoph Hellwig wrote:
> > I'm still a little unsure about the API naming, as alloc_pages sort of
> > implies a struct page return value, but we return a kernel virtual
> > address.
> 
> Erm ... dma_alloc_pages() returns a struct page, so is this sentence
> stale?

Yes.

> You say that like it's a bad thing.  I think the problem is more that
> people don't understand what non-coherent means and think they're
> supporting it when they're not.
> 
> dma_alloc_manual_flushing()?

That sounds pretty awkward..

> 
> > As a follow up I plan to move the implementation of the
> > DMA_ATTR_NO_KERNEL_MAPPING flag over to this framework as well, given
> > that is also is a fundamentally non coherent allocation.  The replacement
> > for that flag would then return a struct page, as it is allowed to
> > actually return pages without a kernel mapping as the name suggested
> > (although most of the time they will actually have a kernel mapping..)
> 
> If the page doesn't have a kernel mapping, shouldn't it return a PFN
> or a phys_addr?

Most APIs we'll feed it into need a struct page.  The difference is just
that it can be a highmem page.  And if we want to get fancy we could
change the kernel mapping to PROT_NONE eventually.
