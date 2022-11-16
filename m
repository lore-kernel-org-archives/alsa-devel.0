Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D30C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 15:46:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07826168A;
	Wed, 16 Nov 2022 16:45:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07826168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668613567;
	bh=SaligsGcdAN6jookavR1593WWEo02u/nVNxCXU8ZGW0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qrOPlpEbRNXpzIX7OAqW4IdXSAWwQMYZ2s/0k7Yxyc871iaK2wfsR3ynvnX8Rq/CK
	 Xc8ShiUdRMz+lsErA0XOoXjbo85/yWYDe4+JSkAAh18LQQkHWa/Co7Qoh8VwkUboKw
	 vw3BCR8h/byAQI2MXPmxtNR7SYANBfD49ushtIwA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD8A7F80163;
	Wed, 16 Nov 2022 16:45:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06804F80169; Wed, 16 Nov 2022 16:45:15 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB8BBF800B8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 16:45:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB8BBF800B8
Received: by verein.lst.de (Postfix, from userid 2407)
 id B04AC68AA6; Wed, 16 Nov 2022 16:45:07 +0100 (CET)
Date: Wed, 16 Nov 2022 16:45:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/7] RDMA/hfi1: don't pass bogus GFP_ flags to
 dma_alloc_coherent
Message-ID: <20221116154507.GB18491@lst.de>
References: <20221113163535.884299-1-hch@lst.de>
 <20221113163535.884299-3-hch@lst.de>
 <c7c6eb30-4b54-01f7-9651-07deac3662bf@cornelisnetworks.com>
 <be8ca3f9-b7f7-5402-0cfc-47b9985e007b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8ca3f9-b7f7-5402-0cfc-47b9985e007b@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-s390@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-media@vger.kernel.org,
 Alexandra Winter <wintera@linux.ibm.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 iommu@lists.linux.dev, Russell King <linux@armlinux.org.uk>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

On Wed, Nov 16, 2022 at 03:15:10PM +0000, Robin Murphy wrote:
> Coherent DMA buffers are allocated by a kernel driver or subsystem for the 
> use of a device managed by that driver or subsystem, and thus they 
> fundamentally belong to the kernel as proxy for the device. Any coherent 
> DMA buffer may be mapped to userspace with the dma_mmap_*() interfaces, but 
> they're never a "userspace allocation" in that sense.

Exactly.  I could not find a place to map the buffers to userspace,
so if it does that without using the proper interfaces we need to fix
that as well.  Dean, can you point me to the mmap code?
