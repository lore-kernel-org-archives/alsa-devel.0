Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15525C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Nov 2022 08:38:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67EAA1ED;
	Mon, 21 Nov 2022 09:37:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67EAA1ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669019886;
	bh=nj5hYa2Uv7ARsPhjSCtxUDoLfjFw7tengbqAhE0k/Cw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGdrJu/1z8o6uhpCJD3k37IbxPZX5D2Yy8hycYSHjBgkTbQBR5yTINGavE15hRTXL
	 AxA9zvowr1pZ//uGckIrxoQYF8BbrXnmhloXyuj0BWj9TbeTHIQFZHHXcMkdecXLT4
	 x/iU1rK6dBh+DwyIH2iVd9Khm+qsKJw3bGiiqvKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F55AF80149;
	Mon, 21 Nov 2022 09:37:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85DB3F8028D; Mon, 21 Nov 2022 09:37:14 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF3ECF80115
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2022 09:37:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF3ECF80115
Received: by verein.lst.de (Postfix, from userid 2407)
 id CDDBA68AA6; Mon, 21 Nov 2022 09:37:07 +0100 (CET)
Date: Mon, 21 Nov 2022 09:37:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 6/7] ALSA: memalloc: don't pass bogus GFP_ flags to
 dma_alloc_*
Message-ID: <20221121083707.GA27649@lst.de>
References: <20221113163535.884299-1-hch@lst.de>
 <20221113163535.884299-7-hch@lst.de> <87leod52l6.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leod52l6.wl-tiwai@suse.de>
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

On Mon, Nov 14, 2022 at 10:04:37AM +0100, Takashi Iwai wrote:
> It mentions something about sparc32/64.  I hope this isn't relevant
> any longer (honestly I have no idea about that).

It shouldn't.  sparc is using fairly generic code now.
