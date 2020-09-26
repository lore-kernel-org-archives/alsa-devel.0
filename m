Return-Path: <SRS0=yvFc=DD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F86C2D0A8
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2020 15:34:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046A121527
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2020 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UT40WOk7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IgNtiCGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046A121527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35D671A16;
	Sat, 26 Sep 2020 17:33:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35D671A16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601134455;
	bh=PckNct9EkFnwfRm1YuKrpRmW54zmXIZZiGTNX33AXh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UT40WOk7r5BJCwNCRnPBn2zGKIfqjFszRicx0mnz/5mhtUZp1NRIWQXke8VoLt3xK
	 pSCtEQz2mO75QmTlPNin8MEzk4B3l9HhDyUzkJdU1n9LOD0HrTmT080FIZW49WZBQj
	 A7nM6pY6G+LNM+sviZGYIT32jfkf9I9cSfWVCLWI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6742F80229;
	Sat, 26 Sep 2020 17:33:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC816F80232; Sat, 26 Sep 2020 17:33:22 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39D69F80162
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2020 17:33:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39D69F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="IgNtiCGT"
Received: by mail-ed1-x542.google.com with SMTP id w1so5561327edr.3
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2020 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NyijGOIcOg0IQ8xJ7tRK9WXb8VbwFr7joS3ngRxTFtY=;
 b=IgNtiCGTIRw+9Jq9+OugAEUgOtWjA8eNb9N0lGKIZhSzq8+Nq6i8p6dAPgDSw3WCu5
 5zLCQcy1nGd484dN8MEuuVSYHqucVtHjEfU81Ws4/lYX/HOp4JbMrZzXbrOql6BtdQAy
 +hEnD/Pr6tT/viPh9YkxxEEc7eplb0NwJB92c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NyijGOIcOg0IQ8xJ7tRK9WXb8VbwFr7joS3ngRxTFtY=;
 b=eC2mQVqcnG5HyO0OfQpkgFwtcr7BJhdtzqWtNL2gePI9FaP1sMGfgoVVWyAxBrkK2t
 KLXh62Byy4XhvAm6Aft3VnZO6mYdVJNA1A1MRDmAbu4emZaXS6OzihmW8HoA7ZicY7fh
 YBLp/q3K25HZ2upTcdg4g3UovCkmQhyiU37TvDY10gBquEYWqdLNfDyGy6WjHDEcx10z
 RjyYaTr9gzo18EiIjZKBuu1zazRHTnulczfZNWS3qNr36DGvFe9iTK2kz+7M89wDz8bX
 k2i1RaZN61fnT14dvvYjhhKACkuGdUVg9beYyiHDlfuf01l62dlgUiYIqAaReZo4kU7Z
 EiTw==
X-Gm-Message-State: AOAM530RL61v8n+FSxWM9zOwYmizrMIkhhO3UNQqFIYrbrUvt4Gyonrh
 XLTumiRgeO4MvaAMY8QNm59kYfZjnC7CAIfp
X-Google-Smtp-Source: ABdhPJyVnLe1WyajTWV412Q6CVZWbY55mVjbUMK7Y4Fs6lF9uj6LE+sduEkNPR1UbfyMOhDxSkHjcw==
X-Received: by 2002:a50:d2d1:: with SMTP id q17mr7095902edg.167.1601134390717; 
 Sat, 26 Sep 2020 08:33:10 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id r16sm4695163edc.57.2020.09.26.08.33.10
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 08:33:10 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id e2so2362297wme.1
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2020 08:33:10 -0700 (PDT)
X-Received: by 2002:a7b:c925:: with SMTP id h5mr2968012wml.28.1601133943201;
 Sat, 26 Sep 2020 08:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200915155122.1768241-1-hch@lst.de>
 <20200915155122.1768241-18-hch@lst.de>
 <20200925184622.GB3607091@chromium.org> <20200926141428.GB10379@lst.de>
In-Reply-To: <20200926141428.GB10379@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Sat, 26 Sep 2020 17:25:27 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CjSKswdc3qOEZy73cyYJ9kfaXsSFyxkOHA+buh-J12UA@mail.gmail.com>
Message-ID: <CAAFQd5CjSKswdc3qOEZy73cyYJ9kfaXsSFyxkOHA+buh-J12UA@mail.gmail.com>
Subject: Re: [PATCH 17/18] dma-iommu: implement ->alloc_noncoherent
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>
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

On Sat, Sep 26, 2020 at 4:14 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Sep 25, 2020 at 06:46:22PM +0000, Tomasz Figa wrote:
> > > +static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
> > > +           dma_addr_t *handle, enum dma_data_direction dir, gfp_t gfp)
> > > +{
> > > +   if (!gfpflags_allow_blocking(gfp)) {
> > > +           struct page *page;
> > > +
> > > +           page = dma_common_alloc_pages(dev, size, handle, dir, gfp);
> > > +           if (!page)
> > > +                   return NULL;
> > > +           return page_address(page);
> > > +   }
> > > +
> > > +   return iommu_dma_alloc_remap(dev, size, handle, gfp | __GFP_ZERO,
> > > +                                PAGE_KERNEL, 0);
> >
> > iommu_dma_alloc_remap() makes use of the DMA_ATTR_ALLOC_SINGLE_PAGES attribute
> > to optimize the allocations for devices which don't care about how contiguous
> > the backing memory is. Do you think we could add an attrs argument to this
> > function and pass it there?
> >
> > As ARM is being moved to the common iommu-dma layer as well, we'll probably
> > make use of the argument to support the DMA_ATTR_NO_KERNEL_MAPPING attribute to
> > conserve the vmalloc area.
>
> We could probably at it.  However I wonder why this is something the
> drivers should care about.  Isn't this really something that should
> be a kernel-wide policy for a given system?

There are IOMMUs out there which support huge pages and those can
benefit *some* hardware depending on what kind of accesses they
perform, possibly on a per-buffer basis. At the same time, order > 0
allocations can be expensive, significantly affecting allocation
latency, so for devices which don't care about huge pages anyone would
prefer simple single-page allocations. Currently the drivers know the
best on whether the hardware they drive would care. There are some
decision factors listed in the documentation [1].

I can imagine cases where drivers could not be the best to decide
about this - for example, the workload could vary depending on the
userspace or a product decision regarding the performance vs
allocation latency, but we haven't seen such cases in practice yet.

[1] https://www.kernel.org/doc/html/latest/core-api/dma-attributes.html?highlight=dma_attr_alloc_single_pages#dma-attr-alloc-single-pages

Best regards,
Tomasz
