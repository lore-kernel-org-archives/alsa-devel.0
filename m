Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CB5C2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:59:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE94F20BED
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="txw7K0hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE94F20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F2B5170F;
	Tue, 22 Sep 2020 12:59:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F2B5170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600772391;
	bh=H/RbrVWPrdmzmgT6yL5IOJ5BamOJre2Z4ITFZPr0Zng=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txw7K0hg5auNjNx63bLXJr0HbmHspAiHNsU7fM/TCjHIF5sMaZJOQ52NRhkv3/eCz
	 Rk0CT2GmPCzt8811kfu0uD/VaVPwWfhsT08zxrt5OUPmSnP8rPwxmSzBQnoQ57Q5jW
	 3gAgTbWyTCU76JIeQgagIAJVcCiM4aiC8/dxEnIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D184F802E0;
	Tue, 22 Sep 2020 12:56:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFF23F802DD; Tue, 22 Sep 2020 12:56:33 +0200 (CEST)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by alsa1.perex.cz (Postfix) with ESMTP id 72964F80256
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 12:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72964F80256
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1kKfxr-000822-01; Tue, 22 Sep 2020 12:56:03 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id B061AC0FFF; Tue, 22 Sep 2020 10:49:34 +0200 (CEST)
Date: Tue, 22 Sep 2020 10:49:34 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/18] 53c700: improve non-coherent DMA handling
Message-ID: <20200922084934.GB8477@alpha.franken.de>
References: <20200915155122.1768241-1-hch@lst.de>
 <20200915155122.1768241-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915155122.1768241-8-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
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

On Tue, Sep 15, 2020 at 05:51:11PM +0200, Christoph Hellwig wrote:
> Switch the 53c700 driver to only use non-coherent descriptor memory if it
> really has to because dma_alloc_coherent fails.  This doesn't matter for
> any of the platforms it runs on currently, but that will change soon.
> 
> To help with this two new helpers to transfer ownership to and from the
> device are added that abstract the syncing of the non-coherent memory.
> The two current bidirectional cases are mapped to transfers to the
> device, as that appears to what they are used for.  Note that for parisc,
> which is the only architecture this driver needs to use non-coherent
> memory on, the direction argument of dma_cache_sync is ignored, so this
> will not change behavior in any way.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/53c700.c | 113 +++++++++++++++++++++++-------------------
>  drivers/scsi/53c700.h |  17 ++++---
>  2 files changed, 72 insertions(+), 58 deletions(-)

Tested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
