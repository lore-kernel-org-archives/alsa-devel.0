Return-Path: <SRS0=ycDz=3H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F3CC33CB1
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jan 2020 07:14:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E426224687
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jan 2020 07:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JmqgclTe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxcKFA5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E426224687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AFB517B9;
	Sat, 18 Jan 2020 08:13:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AFB517B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579331641;
	bh=3oxYCQF89R+PEtcvYdMCe/xUOKr2cAdFuc1hIcxs78o=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JmqgclTe0pDD9cBwJTMgnuKUAkEKeKdAvFgjQi2ljRhTak9mM995oydhhV0qTCCMk
	 5UeDsnp7cOa7L1zE+HGRnEoXb0OrPnifuQOluLGy1N2g3wLYS27LmSpzDXlGSiExlJ
	 STU6Ljoub5DNeus/zmYiyVCCxGfroAoKlmiKjVXs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A55A9F8014D;
	Sat, 18 Jan 2020 08:13:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 993C4F8014E; Sat, 18 Jan 2020 08:13:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01F2AF80126
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2020 08:13:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01F2AF80126
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bxcKFA5d"
Received: from localhost (unknown [171.61.88.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC61F24687;
 Sat, 18 Jan 2020 07:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579331581;
 bh=8kYNVmCF+TfrVkxC52xPjvOoyGTuOnOi1x6LfPS1HMs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bxcKFA5dIk8hiFgSgSIkxdEqrhb4Xp8HVp2zECd7nhlwSBhIVih4XBzbCSzbcMCfS
 SSPwDKZ+7rMv+n3/QGbrQo0/sm7WB7a/8cMVgKRioeleQyh+FZ+K0Zt+MKE3/ymRPX
 pF726Ici8UpopGXeOuXhnMej6lXe4RPzYIz68X6U=
Date: Sat, 18 Jan 2020 12:42:57 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20200118071257.GY2818@vkoul-mobl>
References: <20200114060959.GA2818@vkoul-mobl>
 <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 14-01-20, 10:01, Pierre-Louis Bossart wrote:
> 
> > I am quoting the code in patch, which i pointed in my first reply!
> > 
> > On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> > 
> > > diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> > > index 4b769409f6f8..42f7ae034bea 100644
> > > --- a/drivers/soundwire/intel_init.c
> > 
> > This is intel specific file...
> > 
> > > +++ b/drivers/soundwire/intel_init.c
> > 
> > snip ...
> > 
> > > +static struct sdw_intel_ctx
> > > +*sdw_intel_probe_controller(struct sdw_intel_res *res)
> > 
> > this is intel driver, intel function!
> > 
> > > -
> > > -		link->pdev = pdev;
> > > -		link++;
> > > +		/* let the SoundWire master driver to its probe */
> > > +		md->driver->probe(md, link);
> >                              ^^^^^^
> > which does this... calls a probe()!
> > 
> > And my first reply was:
> > 
> > > > +             /* let the SoundWire master driver to its probe */
> > > > +             md->driver->probe(md, link);
> > > 
> > > So you are invoking driver probe here.. That is typically role of driver
> > > core to do that.. If we need that, make driver core do that for you!
> > 
> > I rest my case!
> 
> I think you are too focused on the probe case and not realizing the
> extensions suggested by this patchset. A "driver" is not limited to 'probe'
> and 'remove' cases.
> 
> As mentioned since mid-September, there is a need for an initialization of
> software/kernel structures (which I called probe but should have been called
> init really), and a second step where the hardware is actually configured -

I find it amusing that a person whom i admired for strict use of terms
can get this differently!

A rename away from probe will certainly be very helpful as
you would also agree that terms 'probe' and 'remove' have a very
special meaning in kernel, so let us avoid these

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
