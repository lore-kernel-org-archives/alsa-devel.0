Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E2BC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:53:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCE1207DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qWBqyv+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCE1207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0F1216BA;
	Fri, 21 Aug 2020 09:53:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0F1216BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597996430;
	bh=ZvXMB1IWTD8F9JUGvJt8JBgNfGaIsc0ZEfUfQmwDQuU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qWBqyv+KfwgdmQ31w5ICCfMl8+SmxTGiBYLbnBJQLlsHatihiJriHeraWZJJk1UiB
	 oqLhUPHwcxRxp7NiqhQwU/1lsNlmXcSPDJW4oI124b7sxQXEb8KAJQPB3qlEWoLnE+
	 I7maVFvHUGoVr4p3d7Gh6o/2yZeDHoL7iNHgbiVc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 629D6F80429;
	Fri, 21 Aug 2020 09:36:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7B2CF80228; Thu, 20 Aug 2020 06:45:40 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B40AEF801F9
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 06:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B40AEF801F9
Received: by verein.lst.de (Postfix, from userid 2407)
 id CA1C068C4E; Thu, 20 Aug 2020 06:45:33 +0200 (CEST)
Date: Thu, 20 Aug 2020 06:45:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
Message-ID: <20200820044533.GA4570@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <62e4f4fc-c8a5-3ee8-c576-fe7178cb4356@arm.com>
 <CAAFQd5AcCTDguB2C9KyDiutXWoEvBL8tL7+a==Uo8vj_8CLOJw@mail.gmail.com>
 <20200819135738.GB17098@lst.de>
 <CAAFQd5BvpzJTycFvjntmX9W_d879hHFX+rJ8W9EK6+6cqFaVMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5BvpzJTycFvjntmX9W_d879hHFX+rJ8W9EK6+6cqFaVMA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Fri, 21 Aug 2020 09:36:15 +0200
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Aug 19, 2020 at 04:11:52PM +0200, Tomasz Figa wrote:
> > > By the way, as a videobuf2 reviewer, I'd appreciate being CC'd on any
> > > series related to the subsystem-facing DMA API changes, since
> > > videobuf2 is one of the biggest users of it.
> >
> > The cc list is too long - I cc lists and key maintainers.  As a reviewer
> > should should watch your subsystems lists closely.
> 
> Well, I guess we can disagree on this, because there is no clear
> policy. I'm listed in the MAINTAINERS file for the subsystem and I
> believe the purpose of the file is to list the people to CC on
> relevant patches. We're all overloaded with work and having to look
> through the huge volume of mailing lists like linux-media doesn't help
> and thus I'd still appreciate being added on CC.

I'm happy to Cc and active participant in the discussion.  I'm not
going to add all reviewers because even with the trimmed CC list
I'm already hitting the number of receipients limit on various lists.
