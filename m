Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965AC433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:43:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1207F206C0
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XYVOBYdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1207F206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C38B18C8;
	Thu,  3 Sep 2020 10:42:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C38B18C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599122604;
	bh=KWKQwnqvJnx/QhZ5+RbyfmbTY2Ory0CV5zRTjI4Qnc4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYVOBYdfoC7aPvtFFjNgccdCeTnbUFgXM77OwNShFxEkWeGrgRBABgNy4ScjzD1MQ
	 xhu6xtjYbR72jelcrm9lYnVFDf7Y1V9+a6aCHQV/1XHcUFQz6NT0Hsi0UKOeahrsmw
	 h3t6sShiAKO4Y0lZFNgCNcYhJMia2Cl4iHr820Y0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F4EDF801DA;
	Thu,  3 Sep 2020 10:42:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB3CEF8021D; Thu,  3 Sep 2020 10:42:31 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 664E6F800BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 10:42:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 664E6F800BA
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2B13F68BEB; Thu,  3 Sep 2020 10:42:27 +0200 (CEST)
Date: Thu, 3 Sep 2020 10:42:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 22/28] sgiseeq: convert from dma_cache_sync to
 dma_sync_single_for_device
Message-ID: <20200903084226.GA24410@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-23-hch@lst.de>
 <20200901152209.GA14288@alpha.franken.de>
 <20200901171241.GA20685@alpha.franken.de> <20200901171627.GA8255@lst.de>
 <20200901173810.GA25282@alpha.franken.de>
 <20200902213809.GA7998@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902213809.GA7998@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>, linux-media@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
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

On Wed, Sep 02, 2020 at 11:38:09PM +0200, Thomas Bogendoerfer wrote:
> the patch below fixes the problem.

But is very wrong unfortunately.

>  static inline void dma_sync_desc_cpu(struct net_device *dev, void *addr)
>  {
> -       dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> -                      DMA_FROM_DEVICE);
> +       struct sgiseeq_private *sp = netdev_priv(dev);
> +
> +       dma_sync_single_for_device(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> +                       sizeof(struct sgiseeq_rx_desc), DMA_FROM_DEVICE);
>  }
>  
>  static inline void dma_sync_desc_dev(struct net_device *dev, void *addr)
>  {
> -       dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> -                      DMA_TO_DEVICE);
> +       struct sgiseeq_private *sp = netdev_priv(dev);
> +
> +       dma_sync_single_for_device(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> +                       sizeof(struct sgiseeq_rx_desc), DMA_TO_DEVICE);

This is not how the DMA API works.  You can only call
dma_sync_single_for_{device,cpu} with the direction that the memory
was mapped.  It then transfer ownership to the device or the cpu,
and the ownership of the memory is a fundamental concept that allows
for reasoning about the caching interaction.

>  }
>  
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
---end quoted text---
