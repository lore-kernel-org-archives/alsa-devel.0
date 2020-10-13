Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0EBC433E7
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:02:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A9722B2D
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jxUBBk7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A9722B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7BB4167E;
	Tue, 13 Oct 2020 15:01:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7BB4167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602594156;
	bh=TjyOf8Y31mdDt8pGjw3+e2TYZrWAE9oo4pPEMKbIYy8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jxUBBk7A94xU8CYo3lF+LdcmYWUOtWo+YBGpdKlPnIpvqWDSvVuzzvMD0S9q2KGk1
	 hiPxogKlA7lAtdc5duAGqCk16F6yFAna6oplVqAHlVAbVSh6v7MRP1AbYjR/Xwv33n
	 kDmfttaDSDFqoLhIDjrOL7b495KW7+a7/jsPjpcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C2FAF8016F;
	Tue, 13 Oct 2020 15:01:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E756F801A3; Tue, 13 Oct 2020 15:01:44 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 971B5F8012C
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 15:01:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 971B5F8012C
IronPort-SDR: z6C47iy/HRw9DDtZz5CFkElVfJfMpTRWuO9haqVIINKaW9Fxlvds+Op1p7yjVEci+n6J62AuHB
 dRrQ1xoQ7l7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="166015067"
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; d="scan'208";a="166015067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 06:01:20 -0700
IronPort-SDR: 4bTd7iIIlYKzyDN8gAbflNVnBgh+UJEwC/YONZqSk9ffh/qb/den14FqT7OmP8BQiPuvJSi8yY
 zt9TUElRw0Eg==
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; d="scan'208";a="318279779"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 06:01:18 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@intel.com>)
 id 1kSJwa-005pjr-Gj; Tue, 13 Oct 2020 16:02:20 +0300
Date: Tue, 13 Oct 2020 16:02:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine: Document support for TX only or RX only
 streams
Message-ID: <20201013130220.GQ4077@smile.fi.intel.com>
References: <20201008161105.21804-1-broonie@kernel.org>
 <20201009102751.GS4077@smile.fi.intel.com>
 <20201009103124.GT4077@smile.fi.intel.com>
 <20201012133745.GD4332@sirena.org.uk>
 <20201012135527.GW4077@smile.fi.intel.com>
 <20201012154803.GG4332@sirena.org.uk>
 <20201012163147.GD4077@smile.fi.intel.com>
 <20201012182604.GH4332@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012182604.GH4332@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Michael Wei Hong Sit <michael.wei.hong.sit@intel.com>
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

On Mon, Oct 12, 2020 at 07:26:04PM +0100, Mark Brown wrote:
> On Mon, Oct 12, 2020 at 07:31:47PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 12, 2020 at 04:48:03PM +0100, Mark Brown wrote:
> > > On Mon, Oct 12, 2020 at 04:55:27PM +0300, Andy Shevchenko wrote:
> 
> > > > 	if (ret != DMA mode ok)
> > > > 		ret = try PIO mode;
> 
> > > > which makes OF dependent parts gone along with relying on the properties rather
> > > > than real resource availability.
> 
> > > I don't understand the blocker to writing that code at the minute?
> 
> > Return code in both cases DMA okay, DMA is not okay is 0.
> 
> Ah, right - we don't really expose the resulting component to the
> drivers.  Although we don't appear to have any drivers doing the open
> coding you suggest?  The active use case we have is for drivers
> (currently only the STM32 SAI AFAICT) that always do DMA but only do one
> direction (not half duplex, a single direction on a given DAI).  They
> don't want to fall back to PIO, they want to know which channel is
> valid.  It's not just a DMA/no DMA question, it's also which of the DMA
> channels are valid.

Looking into them I think all of the cases are requiring DMA to work.
At least one channel. Seems no one is designed for optional DMA performance.

The problem here is they are checking for properties (meta-data) rather than
resources (data) to be available. But since they will fail sooner or later it
doesn't make big difference.


% git grep -n dma-names -- sound/soc/ | cut -f1 -d: | sort -u
sound/soc/adi/axi-i2s.c
sound/soc/atmel/atmel-i2s.c
sound/soc/stm/stm32_sai_sub.c
sound/soc/tegra/tegra210_admaif.c
sound/soc/ti/davinci-mcasp.c

axi-i2s: Checks for channels to see if capture / playback are supposed to be
	 working, but AFAICS tries without actually checking the resources
	 availability.

	snd_soc_dai_init_dma_data(dai,
		i2s->has_playback ? &i2s->playback_dma_data : NULL,
		i2s->has_capture  ? &i2s->capture_dma_data  : NULL);

atmel-i2s: Checks for half-duplex channel, but registers unconditionally.

        snd_soc_dai_init_dma_data(dai, &dev->playback, &dev->capture);

tegra210_admaif: Checks for Tx to be always present.

	Custom DAI probe that simply assigns data structure pointers.

davinchi-mcasp: Checks for names to be present

	Custom DAI probe that simply assigns data structure pointers.

-- 
With Best Regards,
Andy Shevchenko


