Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1CBC4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Dec 2022 12:16:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 953C0170D;
	Fri, 16 Dec 2022 13:15:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 953C0170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671192976;
	bh=ALLkY+RbJeKMkHkTDu7vlc/QGBHCiEqSI86YCB2i/68=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UveJjIYh1jMCKOwK82nsKnVF+m19I5sRHHUXtwKJrY8ZHUErF1i6+6woYUYSpIDnM
	 18ly58uf6JGuA4CZOns59SefpycezG3mgCE4n7LwSWLvxkRMEqFne751i86ph1wTRm
	 EtKsMG2txgsiun6P8uNwAUWwbqmblfnpDlpN6g+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D89FF804E0;
	Fri, 16 Dec 2022 13:15:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32AC4F804E2; Fri, 16 Dec 2022 13:15:25 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB873F804D7
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2022 13:15:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB873F804D7
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8637667373; Fri, 16 Dec 2022 13:15:20 +0100 (CET)
Date: Fri, 16 Dec 2022 13:15:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [6.2][regression] after commit
 ffcb754584603adf7039d7972564fbf6febdc542 all sound devices
 disappeared (due BUG at mm/page_alloc.c:3592!)
Message-ID: <20221216121519.GA5710@lst.de>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
 <20221216064645.GA24446@lst.de>
 <a76cb262-a24f-e113-5680-2025aa143ee6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76cb262-a24f-e113-5680-2025aa143ee6@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu@lists.linux.dev, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Dec 16, 2022 at 11:40:57AM +0000, Robin Murphy wrote:
> On 2022-12-16 06:46, Christoph Hellwig wrote:
>> Ok, it seems like the sound noncontig alloc code that I already
>> commented on as potentially bogus GFP_GOMP mapping trips this.  I think
>> for now the right thing would be to revert the hunk in dma-iommu.c
>> (see patch below).  The other thing to try would be to remove both
>> uses GFP_COMP in sound/core/memalloc.c, which should have the same
>> effect.
>
> Or we explicitly strip the flag in dma_alloc_noncontiguous() (and maybe 
> dma_alloc_pages() as well) for consistency with dma_alloc_attrs(). That 
> seems like it might be the most robust option.

In the long run warning there and returning an error seems like the
right thing to do, yes. I'm just a little worried doing this right now
after the merge window.
