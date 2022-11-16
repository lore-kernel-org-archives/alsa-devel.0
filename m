Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D278CC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 06:12:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F17D1638;
	Wed, 16 Nov 2022 07:11:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F17D1638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668579125;
	bh=U9Gbiiaovlju09Ro5wHT8eaxb0Q8LHJLDoIIXnvFipk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HEtvOY+9xgrI9+vIngxkYQjsE88Esxpd7cZ70AaepEr+pwgzNidpoUCONVIJ+596Z
	 gBQ2MX2VJT47O3wVgpbh8PuLjrMBn85ooOZlthZR7FHS+4mudV38ZqW43Fy+Umb2Cl
	 dcvykLkB9anEI41HS28TzwfocQcpEJ4id9n96Dcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B723F800B8;
	Wed, 16 Nov 2022 07:11:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6CA6F80163; Wed, 16 Nov 2022 07:11:12 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C282F80089
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 07:11:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C282F80089
Received: by verein.lst.de (Postfix, from userid 2407)
 id CFEBC68AA6; Wed, 16 Nov 2022 07:11:06 +0100 (CET)
Date: Wed, 16 Nov 2022 07:11:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 7/7] dma-mapping: reject __GFP_COMP in dma_alloc_attrs
Message-ID: <20221116061106.GA19118@lst.de>
References: <20221113163535.884299-1-hch@lst.de>
 <20221113163535.884299-8-hch@lst.de> <Y3H4RobK/pmDd3xG@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3H4RobK/pmDd3xG@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-s390@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-media@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 iommu@lists.linux.dev, Russell King <linux@armlinux.org.uk>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

On Mon, Nov 14, 2022 at 10:11:50AM +0200, Leon Romanovsky wrote:
> In RDMA patches, you wrote that GFP_USER is not legal flag either. So it
> is better to WARN here for everything that is not allowed.

So __GFP_COMP is actually problematic and changes behavior, and I plan
to lift an optimization from the arm code to the generic one that
only rounds up allocations to the next page size instead of the next
power of two, so I need this check now.  Other flags including
GFP_USER are pretty bogus to, but I actually need to do a full audit
before rejecting them, which I've only done for GFP_COMP so far.
