Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB4C4727F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:48:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A9E20878
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b0LZjPUY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dRgYAI+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A9E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99F4F18F0;
	Fri, 25 Sep 2020 20:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99F4F18F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601059706;
	bh=ZIq55S70Fuj9dVtEWfh1nN6C3/t+NsGXQsafXPqV9mY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b0LZjPUYXM9/32O3iSRSJWNQmrvJVT5Op1+yMZoCKcnDo5dFnT/Jjw44DkbQqO9vo
	 4mQvGM76pCvrkx6KgmwERFN7cHGNLNS+vMuEQUpCvqE9Xa7RLll2ybW29KElKbbM1C
	 d4NIr/DQJMp9xHTRk6k6+Oi0Fe/18H9/sFgM91XA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AB06F80162;
	Fri, 25 Sep 2020 20:47:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5315CF80254; Fri, 25 Sep 2020 20:47:24 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6548F80162
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 20:47:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6548F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="dRgYAI+I"
Received: by mail-wm1-x342.google.com with SMTP id e2so4508241wme.1
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g/BH1U9GUunsIrnO/GbdPQWxTeH46s0MtJm8Rv2PmQg=;
 b=dRgYAI+Il/XnGvkuGcGG/lsBUKoJIpFGsPVq7bdfwYbSWBuKZWhEyZ/C6V2T06d7l+
 MlGVte7aAMEe5kn/Xzgvbo6wkmehHB6utltBuTWLjuy10bgK9jfUtimOpRmqNVZ/PDb7
 pPEsfddSQturiPpnwk/9j/tF8/GG+ViphzAqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g/BH1U9GUunsIrnO/GbdPQWxTeH46s0MtJm8Rv2PmQg=;
 b=UXNVi5qP9nJaUVXAVQTyVc87RCaVdcMDIN8u9O0efZMGsdt0e1mrvJcAHCuExUx1LE
 j1EVmZ9XsC/rmN8A0Lz/FU2M7gPMoLDbs/O0EvT8xr/+j/ZhXZPBmAOL9uvnpGJKDayG
 flX5/2sLzhl3dqnIMjEadheIIMQ64ualecLLfTEz9VWQWEO1RVE/9JVrePCjEcygw3Dm
 3/vW8ewmYRIxsGmKj1r26Y4LGqNYYrUkrD/i9vqS8SC2I5rxZsKE4PGaplPTMfkGiY0l
 2wEFeNNuJAOw3Z8eLRNtVQq0FtbSU4NLCRyWonzDXHmYQlBFc4DTXZsPpGN+f38pbEYm
 wDVw==
X-Gm-Message-State: AOAM532knu3H+hk3A7GUPJlUT/e7U5rNF+hPmLv290Xc6/uC763F3a7T
 fXl+O7NRuyeqiXXeVqs3z3lDig==
X-Google-Smtp-Source: ABdhPJwizv9lDNCgaSezSHmDHMwhCyQSsePLifiuaYRBnBvcSMHXRWloRU3D/0rZv64JO/qSChFcJg==
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr4754086wmt.189.1601059634661; 
 Fri, 25 Sep 2020 11:47:14 -0700 (PDT)
Received: from chromium.org (216.131.76.34.bc.googleusercontent.com.
 [34.76.131.216])
 by smtp.gmail.com with ESMTPSA id w15sm3841044wro.46.2020.09.25.11.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 11:47:13 -0700 (PDT)
Date: Fri, 25 Sep 2020 18:47:12 +0000
From: Tomasz Figa <tfiga@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/18] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
 flag
Message-ID: <20200925184712.GC3607091@chromium.org>
References: <20200915155122.1768241-1-hch@lst.de>
 <20200915155122.1768241-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915155122.1768241-2-hch@lst.de>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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

Hi Christoph,

On Tue, Sep 15, 2020 at 05:51:05PM +0200, Christoph Hellwig wrote:
> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> The patch partially reverts some of the UAPI bits of the buffer
> cache management hints. Namely, the queue consistency (memory
> coherency) user-space hint because, as it turned out, the kernel
> implementation of this feature was misusing DMA_ATTR_NON_CONSISTENT.
> 
> The patch revers both kernel and user space parts: removes the
> DMA consistency attr functions, rollbacks changes to v4l2_requestbuffers,
> v4l2_create_buffers structures and corresponding UAPI functions
> (plus compat32 layer) and cleanups the documentation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../userspace-api/media/v4l/buffer.rst        | 17 -------
>  .../media/v4l/vidioc-create-bufs.rst          |  6 +--
>  .../media/v4l/vidioc-reqbufs.rst              | 12 +----
>  .../media/common/videobuf2/videobuf2-core.c   | 46 +++----------------
>  .../common/videobuf2/videobuf2-dma-contig.c   | 19 --------
>  .../media/common/videobuf2/videobuf2-dma-sg.c |  3 +-
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 18 +-------
>  drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 10 +---
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  5 +-
>  include/media/videobuf2-core.h                |  7 +--
>  include/uapi/linux/videodev2.h                | 13 +-----
>  11 files changed, 22 insertions(+), 134 deletions(-)

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
