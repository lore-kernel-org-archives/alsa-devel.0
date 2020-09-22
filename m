Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E55C2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:57:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D5C208A9
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ceHpt17z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D5C208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A5DE16EB;
	Tue, 22 Sep 2020 12:56:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A5DE16EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600772238;
	bh=cHKW2bc0fotxQTnBQ7o6D31JTnl/iy74sh354wVcCpM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ceHpt17zwBLObOTUvepxQte8Xk4wrzPp9uxv5MkgbWNJLMar4dkD7p//zfH7ftj10
	 +Ref2sbjml07s2uwY5hMDjv6kl90KxLwCrDSeyj/MWmJ+3+XOy9XtRoRBWoKVLRxZt
	 gxUhtI4t0NOmA1+k+O5MMJoTazGl2cHUr71B4SjI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A3D9F802A2;
	Tue, 22 Sep 2020 12:56:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02E14F802C3; Tue, 22 Sep 2020 12:56:26 +0200 (CEST)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by alsa1.perex.cz (Postfix) with ESMTP id C68A3F8015F
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 12:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C68A3F8015F
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1kKfxr-000822-04; Tue, 22 Sep 2020 12:56:03 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 1F9C4C0FFF; Tue, 22 Sep 2020 10:50:49 +0200 (CEST)
Date: Tue, 22 Sep 2020 10:50:49 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/18] lib82596: convert to dma_alloc_noncoherent
Message-ID: <20200922085049.GE8477@alpha.franken.de>
References: <20200915155122.1768241-1-hch@lst.de>
 <20200915155122.1768241-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915155122.1768241-12-hch@lst.de>
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

On Tue, Sep 15, 2020 at 05:51:15PM +0200, Christoph Hellwig wrote:
> Use the new non-coherent DMA API including proper ownership transfers.
> This includes moving the DMA helpers to lib82596 based of an ifdef to
> avoid include order problems.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/net/ethernet/i825xx/lasi_82596.c |  25 ++---
>  drivers/net/ethernet/i825xx/lib82596.c   | 114 ++++++++++++++---------
>  drivers/net/ethernet/i825xx/sni_82596.c  |   4 -
>  3 files changed, 80 insertions(+), 63 deletions(-)

Tested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de> (SNI part)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
