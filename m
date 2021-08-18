Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E419DC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 05:45:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3462F61029
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 05:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3462F61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F30741662;
	Wed, 18 Aug 2021 07:44:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F30741662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629265543;
	bh=7446DzpnOmXY4YsWJJYk17WCKdb6uzLqiGzSw2ucE7Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=le3Fy+YIYUXTnaIca1Z2hcG6jRuewNV/bBchbwi12pS9DrZ+wxzCBTwgaswHrl6MH
	 k27VpcJKuje7JIq0WWiG7RYkKPFiNVc7TeDfD6j57ZIQ7GFG14GWKtCr+yFSqXvxBV
	 AQP1bLYcQVL++SBHX0L1kHkwLqjVs9aspXrgfPY0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 760A3F800EC;
	Wed, 18 Aug 2021 07:44:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67BB4F80249; Wed, 18 Aug 2021 07:44:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2B13F800EC
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 07:44:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2B13F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="DIt3/ctK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E282C61029;
 Wed, 18 Aug 2021 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1629265483;
 bh=7446DzpnOmXY4YsWJJYk17WCKdb6uzLqiGzSw2ucE7Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DIt3/ctKDnKk1yHUF5CEjOyKodI6tV6uqCyZgbnHxUXsQV9sSGF69aNnJSta7tdP0
 KEcg/j6ezycsgOnXBQhFi9+L33P0xEBC7odObRiNyUNsrjYNgizGq9/AqUo0BqYqeZ
 mO/IaPxHCz0Kdm5Vlphzj8C2/BwLu0Pq26qpTw1c=
Date: Wed, 18 Aug 2021 07:44:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <YRyeR6imvSwOOasQ@kroah.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 vkoul@kernel.org, broonie@kernel.org,
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

On Tue, Aug 17, 2021 at 02:00:56PM -0500, Pierre-Louis Bossart wrote:
> The premise of the deferred probe implementation is that a successful
> driver binding is a proxy for the resources provided by this driver
> becoming available. While this is a correct assumption in most of the
> cases, there are exceptions to the rule such as
> 
> a) the use of request_firmware_nowait(). In this case, the resources
> may become available when the 'cont' callback completes, for example
> when if the firmware needs to be downloaded and executed on a SoC
> core or DSP.
> 
> b) a split implementation of the probe with a workqueue when one or
> ore request_module() calls are required: a synchronous probe prevents
> other drivers from probing, impacting boot time, and an async probe is
> not allowed to avoid a deadlock. This is the case on all Intel audio
> platforms, with request_module() being required for the i915 display
> audio and HDaudio external codecs.
> 
> In these cases, there is no way to notify the deferred probe
> infrastructure of the enablement of resources after the driver
> binding.

Then just wait for it to happen naturally?

> The driver_deferred_probe_trigger() function is currently used
> 'anytime a driver is successfully bound to a device', this patch
> suggest exporing by exporting it so that drivers can kick-off
> re-probing of deferred devices at the end of a deferred processing.

I really do not want to export this as it will get really messy very
quickly with different drivers/busses attempting to call this.

Either handle it in your driver (why do you have to defer probe at all,
just succeed and move on to register the needed stuff after you are
initialized) or rely on the driver core here.

thanks,

greg k-h
