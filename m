Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86BDC433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:14:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED102078B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cKqKSUC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED102078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B10C316BF;
	Tue,  1 Sep 2020 19:13:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B10C316BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598980453;
	bh=3AgNuDAjlaZT+/Ucz1j7Yd10nfiLbsKScGKLsPKiJNw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKqKSUC6JsJtGRrld16Ie22yyPtriJErvqACySim1T9R5ieRzlMfZ8sNvYSO/j4yX
	 Y6H+/58NAp5kTUefXj4SB+QF0HH6yDADOhWazvWoS0wG2L9vH6YsoQnPxc0/Y5HpO8
	 w/y5cmrg72W7c55Ls8cr7FaV1chuS/xbhtI/r+Jk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48C6EF8020D;
	Tue,  1 Sep 2020 19:13:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA6B4F80217; Tue,  1 Sep 2020 19:13:20 +0200 (CEST)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by alsa1.perex.cz (Postfix) with ESMTP id 89F77F800BA
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 19:13:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89F77F800BA
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1kD9qC-0004aY-00; Tue, 01 Sep 2020 19:13:04 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id A3E0EC0E68; Tue,  1 Sep 2020 19:12:41 +0200 (CEST)
Date: Tue, 1 Sep 2020 19:12:41 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 22/28] sgiseeq: convert from dma_cache_sync to
 dma_sync_single_for_device
Message-ID: <20200901171241.GA20685@alpha.franken.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-23-hch@lst.de>
 <20200901152209.GA14288@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901152209.GA14288@alpha.franken.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-scsi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 linux-media@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Pawel Osciak <pawel@osciak.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
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

On Tue, Sep 01, 2020 at 05:22:09PM +0200, Thomas Bogendoerfer wrote:
> On Wed, Aug 19, 2020 at 08:55:49AM +0200, Christoph Hellwig wrote:
> > Use the proper modern API to transfer cache ownership for incoherent DMA.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/net/ethernet/seeq/sgiseeq.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/seeq/sgiseeq.c b/drivers/net/ethernet/seeq/sgiseeq.c
> > index 39599bbb5d45b6..f91dae16d69a19 100644
> > --- a/drivers/net/ethernet/seeq/sgiseeq.c
> > +++ b/drivers/net/ethernet/seeq/sgiseeq.c
> > @@ -112,14 +112,18 @@ struct sgiseeq_private {
> >  
> >  static inline void dma_sync_desc_cpu(struct net_device *dev, void *addr)
> >  {
> > -	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> > -		       DMA_FROM_DEVICE);
> > +	struct sgiseeq_private *sp = netdev_priv(dev);
> > +
> > +	dma_sync_single_for_cpu(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> > +			sizeof(struct sgiseeq_rx_desc), DMA_BIDIRECTIONAL);
> >  }
> >  
> >  static inline void dma_sync_desc_dev(struct net_device *dev, void *addr)
> >  {
> > -	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> > -		       DMA_TO_DEVICE);
> > +	struct sgiseeq_private *sp = netdev_priv(dev);
> > +
> > +	dma_sync_single_for_device(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> > +			sizeof(struct sgiseeq_rx_desc), DMA_BIDIRECTIONAL);
> >  }
> 
> this breaks ethernet on IP22 completely, but I haven't figured out why, yet.

the problem is that dma_sync_single_for_cpu() doesn't flush anything
for IP22, because it only flushes for CPUs which do speculation. So
either MIPS arch_sync_dma_for_cpu() should always flush or sgiseeq
needs to use a different sync funktion, when it wants to re-read descriptors
from memory.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
