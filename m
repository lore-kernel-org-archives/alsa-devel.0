Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF4C4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:16:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89372221E5
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ljfgtYZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89372221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B20F01887;
	Fri, 25 Sep 2020 13:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B20F01887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601032605;
	bh=YXWHDsfmUvoWrU0M4vq8HSpHvlyhj+/dC4gLhqA4hb0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ljfgtYZmcksY/HsY+GgJfYwYnM0b16OB91oLzGtD64WYa/R5Ni6w7WXJo4bd6eC9s
	 /LyYDwCpTFNHLCnsDVd1xXkwfaV1r9pwOHfYr6DrGUnCr2TQVbn76Po6Sm0uDIg/32
	 fpoyw6+7OcofYzC0CQxE+/OcbGRazdKfZjdYsgyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F17CF80171;
	Fri, 25 Sep 2020 13:15:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A79BF801EB; Fri, 25 Sep 2020 13:15:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4590CF800F6
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 13:15:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4590CF800F6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B1D101E;
 Fri, 25 Sep 2020 04:15:42 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986323F70D;
 Fri, 25 Sep 2020 04:15:38 -0700 (PDT)
Subject: Re: [PATCH 08/18] dma-mapping: add a new dma_alloc_noncoherent API
To: Christoph Hellwig <hch@lst.de>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
 <tfiga@chromium.org>, Matt Porter <mporter@kernel.crashing.org>,
 iommu@lists.linux-foundation.org
References: <20200915155122.1768241-1-hch@lst.de>
 <20200915155122.1768241-9-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c8ea4023-3e19-d63b-d936-46a04f502a61@arm.com>
Date: Fri, 25 Sep 2020 12:15:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200915155122.1768241-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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

On 2020-09-15 16:51, Christoph Hellwig wrote:
[...]
> +These APIs allow to allocate pages in the kernel direct mapping that are
> +guaranteed to be DMA addressable.  This means that unlike dma_alloc_coherent,
> +virt_to_page can be called on the resulting address, and the resulting

Nit: if we explicitly describe this as if it's a guarantee that can be 
relied upon...

> +struct page can be used for everything a struct page is suitable for.

[...]
> +This routine allocates a region of <size> bytes of consistent memory.  It
> +returns a pointer to the allocated region (in the processor's virtual address
> +space) or NULL if the allocation failed.  The returned memory may or may not
> +be in the kernels direct mapping.  Drivers must not call virt_to_page on
> +the returned memory region.

...then forbid this document's target audience from relying on it, 
something seems off. At the very least it's unhelpfully unclear :/

Given patch #17, I suspect that the first paragraph is the one that's no 
longer true.

Robin.
