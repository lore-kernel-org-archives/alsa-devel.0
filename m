Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D557C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Dec 2022 11:42:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D36051707;
	Fri, 16 Dec 2022 12:41:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D36051707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671190918;
	bh=NxebT7ioCT67lF80Wgum0sD4HDklmmyr0uuxk6QCpoA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=X59f+LWh3u79DJxVWSi0MDEIf16oLTVTORzBnw/4OUkFj5XTzfcZwjCtfwhoXvCH3
	 TFk5P6Y0XAc7P8YA1euoTx+AwI4/NkCx91E2onXaNaS6g4AlcPiVAc9HG8fzxzB9Nm
	 G13CELTGnrXLyZMTZxuX6OK0NeZ1WLxwSMWMJ5q8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EF12F804E0;
	Fri, 16 Dec 2022 12:41:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 661EAF804E2; Fri, 16 Dec 2022 12:41:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 8845AF804CB
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2022 12:41:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8845AF804CB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19081042;
 Fri, 16 Dec 2022 03:41:43 -0800 (PST)
Received: from [10.57.88.234] (unknown [10.57.88.234])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF4B3F73B;
 Fri, 16 Dec 2022 03:41:02 -0800 (PST)
Message-ID: <a76cb262-a24f-e113-5680-2025aa143ee6@arm.com>
Date: Fri, 16 Dec 2022 11:40:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [6.2][regression] after commit
 ffcb754584603adf7039d7972564fbf6febdc542 all sound devices disappeared (due
 BUG at mm/page_alloc.c:3592!)
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
 <20221216064645.GA24446@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221216064645.GA24446@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 iommu@lists.linux.dev,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 m.szyprowski@samsung.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2022-12-16 06:46, Christoph Hellwig wrote:
> Ok, it seems like the sound noncontig alloc code that I already
> commented on as potentially bogus GFP_GOMP mapping trips this.  I think
> for now the right thing would be to revert the hunk in dma-iommu.c
> (see patch below).  The other thing to try would be to remove both
> uses GFP_COMP in sound/core/memalloc.c, which should have the same
> effect.

Or we explicitly strip the flag in dma_alloc_noncontiguous() (and maybe 
dma_alloc_pages() as well) for consistency with dma_alloc_attrs(). That 
seems like it might be the most robust option.

Robin.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9297b741f5e80e..f798c44e090337 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -744,9 +744,6 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   	/* IOMMU can map any pages, so himem can also be used here */
>   	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>   
> -	/* It makes no sense to muck about with huge pages */
> -	gfp &= ~__GFP_COMP;
> -
>   	while (count) {
>   		struct page *page = NULL;
>   		unsigned int order_size;
> 
