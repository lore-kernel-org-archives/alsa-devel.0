Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08307C432BE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 16:51:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE556023F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 16:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BE556023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 137CC1697;
	Wed, 18 Aug 2021 18:50:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 137CC1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629305457;
	bh=H+C5HRL1W26JYW1ePOo251FXVM78KF8792qIuWVToy4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UNpZjutt25HTo/MTR52CoyKmczuqsuArzSPlLVY8SBu/REkpbV14dJqDDWABfzZoQ
	 vLK8T84Kngo0KcUO9+YPugypVfvwWmRCA/WtYb5jf5YOojyDQv+3TpXAXkVTvhdDIQ
	 O6uVfCR+jlzBQQm+wXtL+z/1fkkvcTFjpVA7Vmyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E1EFF80246;
	Wed, 18 Aug 2021 18:50:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 666FDF80249; Wed, 18 Aug 2021 18:50:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC26CF80169
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 18:49:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC26CF80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="1W66Yyss"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BF90610CB;
 Wed, 18 Aug 2021 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1629305394;
 bh=H+C5HRL1W26JYW1ePOo251FXVM78KF8792qIuWVToy4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1W66YysskpVj4mdgZhCaD6Mpek43TxCCguqy7OGT+p4z5oGVaNbvG9dF0nxIHpaVc
 QMPKOl+gPm50Yf6LNwkdkRyk8If8SeoiQw6f9fd/bk3SNg3pLfA8WaL40lsp0f3BPx
 YlmnQlkXuvysNUuCPbBNqA5QiGYwJjoGLdAZ1AaY=
Date: Wed, 18 Aug 2021 18:49:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <YR06L+gTzyiYY/rG@kroah.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com> <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com> <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
 <YR0nAcC3wJd3b4Vu@kroah.com>
 <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
Cc: alsa-devel@alsa-project.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 vkoul@kernel.org, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Aug 18, 2021 at 10:53:07AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> 
> >> a) we have to use request_module()
> > 
> > Wait, why?
> > 
> > module loading is async, use auto-loading when the hardware/device is
> > found and reported to userspace.  Forcing a module to load by the kernel
> > is not always wise as the module is not always present in the filesystem
> > at that point in time at boot (think modules on the filesystem, not in
> > the initramfs).
> > 
> > Try fixing this issue and maybe it will resolve itself as you should be
> > working async.
> 
> It's been that way for a very long time (2015?) for HDAudio support, see
> sound/pci/hda/hda_bind.c. It's my understanding that it was a conscious
> design decision to use vendor-specific modules, if available, and
> fallback to generic modules if the first pass failed.

If it has been this way for so long, what has caused the sudden change
to need to export this and call this function?

