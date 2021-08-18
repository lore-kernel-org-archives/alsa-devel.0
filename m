Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C77C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 15:29:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A42161076
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 15:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A42161076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8D3C1696;
	Wed, 18 Aug 2021 17:28:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8D3C1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629300558;
	bh=6qIatRlyPwGZZZJdwRlRttF/BEGVNA0QhKepy/wJI3o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S6yqAg2fOEuYkHYe4KCTtiwYONQUDaMTcUjUsoxQlp5jXdIumeGYm7X43elQhanR2
	 ooTPkulMlmUy/UIjY5UcwDng3YY3ehLKke5VgPi4OWp/h4LwFigSQaL5/jmp0qHLZ2
	 R3nWdVP0Q54inW85+s2bGN/Yxz1ARw2yyed+QH2w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63BFDF8028D;
	Wed, 18 Aug 2021 17:28:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 096FFF80425; Wed, 18 Aug 2021 17:28:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECAEBF8028D
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 17:28:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECAEBF8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="KjqNcnim"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4C6F61056;
 Wed, 18 Aug 2021 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1629300484;
 bh=6qIatRlyPwGZZZJdwRlRttF/BEGVNA0QhKepy/wJI3o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KjqNcnimhe4hoip2pxAOu60xIen1V94R7Z2FRA9FWPIk902tv9fET+pTABVivnF8a
 Sb3JStdG0/DJFqPd30DrjlUxeDfV8df/0Y5Ui1iqH5Hrb8+OJPjlUyijP1yPJBlEkR
 HYt3oWDC6ysehNDmBU96COWGwk20SFg2JGSv9JhI=
Date: Wed, 18 Aug 2021 17:28:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <YR0nAcC3wJd3b4Vu@kroah.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com> <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com> <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
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

On Wed, Aug 18, 2021 at 09:51:51AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> >>> The issue is that the driver core is using drivers completing probe as a
> >>> proxy for resources becoming available.  That works most of the time
> >>> because most probes are fully synchronous but it breaks down if a
> >>> resource provider registers resources outside of probe, we might still
> >>> be fine if system boot is still happening and something else probes but
> >>> only through luck.
> > 
> >> The driver core is not using that as a proxy, that is up to the driver
> >> itself or not.  All probe means is "yes, this driver binds to this
> >> device, thank you!" for that specific bus/class type.  That's all, if
> >> the driver needs to go off and do real work before it can properly
> >> control the device, wonderful, have it go and do that async.
> > 
> > Right, which is what is happening here - but the deferred probe
> > machinery in the core is reading more into the probe succeeding than it
> > should.
> 
> I think Greg was referring to the use of the PROBE_PREFER_ASYNCHRONOUS
> probe type. We tried just that and got a nice WARN_ON because we are
> using request_module() to deal with HDaudio codecs. The details are in
> [1] but the kernel code is unambiguous...
> 
>         /*
> 	 * We don't allow synchronous module loading from async.  Module
> 	 * init may invoke async_synchronize_full() which will end up
> 	 * waiting for this task which already is waiting for the module
> 	 * loading to complete, leading to a deadlock.
> 	 */
> 	WARN_ON_ONCE(wait && current_is_async());
> 
> 
> The reason why we use a workqueue is because we are otherwise painted in
> a corner by conflicting requirements.
> 
> a) we have to use request_module()

Wait, why?

module loading is async, use auto-loading when the hardware/device is
found and reported to userspace.  Forcing a module to load by the kernel
is not always wise as the module is not always present in the filesystem
at that point in time at boot (think modules on the filesystem, not in
the initramfs).

Try fixing this issue and maybe it will resolve itself as you should be
working async.

thanks,

greg k-h
