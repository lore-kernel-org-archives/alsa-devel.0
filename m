Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE5EC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Dec 2022 07:47:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E09A3167E;
	Wed, 21 Dec 2022 08:46:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E09A3167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671608831;
	bh=EC+HHWgZfwjxyKfk0hSkmNCvs+H+mSiBeJpG+FBR1nE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BKnr5XjPwOgW3RlsLH/H9Tz7ionOmIqXFEFyOU+iqVjgCSmaYSU34o+U1cwxrZnun
	 CqTYBtHUG3OIzRmm6oFnSckKOVWvAxSnG0I5RoOgMiTCJe2BcNSbraShzRJl02S7du
	 HqhLaN5LJh2MQsqzEl0R/7nYRd/8cD7j8QBtaZbQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 520ADF8024D;
	Wed, 21 Dec 2022 08:46:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56A49F8047B; Wed, 21 Dec 2022 08:46:20 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C06DF8024D
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2022 08:46:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C06DF8024D
Received: by verein.lst.de (Postfix, from userid 2407)
 id A5D1867373; Wed, 21 Dec 2022 08:46:15 +0100 (CET)
Date: Wed, 21 Dec 2022 08:46:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 2/2] dma-mapping: reject GFP_COMP for noncohernt allocaions
Message-ID: <20221221074615.GA22974@lst.de>
References: <20221220082009.569785-1-hch@lst.de>
 <20221220082009.569785-3-hch@lst.de>
 <alpine.DEB.2.22.394.2212201653520.3532114@eliteleevi.tm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212201653520.3532114@eliteleevi.tm.intel.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 iommu@lists.linux.dev, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Dec 20, 2022 at 04:57:25PM +0200, Kai Vehmanen wrote:
> Minor nit, typo "noncohernt allocaions" in subject of this second patch.

Thanks,

I've fixed this and queued up the series.
