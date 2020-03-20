Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD3C4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:53:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDA820732
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IdVGQ2wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDA820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D15817C3;
	Fri, 20 Mar 2020 12:52:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D15817C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584705188;
	bh=/P1pySoaLLW6Zi3fI18eKhWEDtzyR7Aw0pVOX8m5HfU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IdVGQ2wtjRCJBhsIM+tul4FYuAq9NS1ZFxmnd+0BOuRDVPwuh0rTc0kSdq01r+QA/
	 wV0Lk2Cyg7Cg/NRyzpiWOPFDV6udBNmPBhjD6T9KBRo5g83BDjCS1ISl00jEO769BQ
	 9yA3mnxp5CkJ0CvV3DTqrnkefeRylAwkW6AvlI8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42E3EF80171;
	Fri, 20 Mar 2020 12:52:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C80B3F8015B; Fri, 20 Mar 2020 12:52:13 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2EFBF800C0;
 Fri, 20 Mar 2020 12:52:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2EFBF800C0
IronPort-SDR: Qqn2heTNNgoHE97gfGj4XgCWluZmemrr5uwoDKwztZk/F+skhne4Ae5UHa/g1IJcYQyJPq5Jrz
 uOewovAL3zaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 04:52:05 -0700
IronPort-SDR: QZFO0jJe+m07ww/YVZwyoy3IEq02LWJFAFBPFjPtlOcXU5xSwoHwlSH6YhyqK2BohHwgfAtTXR
 r44X7PonXfNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; d="scan'208";a="234487515"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu)
 ([10.252.57.199])
 by orsmga007.jf.intel.com with ESMTP; 20 Mar 2020 04:52:04 -0700
Date: Fri, 20 Mar 2020 12:52:03 +0100
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/14] ASoC: SOF: add a power status IPC
Message-ID: <20200320115203.GA2130@ubuntu>
References: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
 <20200312144429.17959-7-guennadi.liakhovetski@linux.intel.com>
 <20200313143956.GJ5528@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313143956.GJ5528@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org
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

Hi Mark,

On Fri, Mar 13, 2020 at 02:39:56PM +0000, Mark Brown wrote:
> On Thu, Mar 12, 2020 at 03:44:21PM +0100, Guennadi Liakhovetski wrote:
> 
> >  #endif
> > +	atomic_set(&sdev->reset_count, 0);
> >  	dev_set_drvdata(dev, sdev);
> 
> Do we really need to use atomics for this?  They are hard to use
> correctly.

This variable is accessed from 2 contexts: it's incremented by the SOF 
driver, when the firmware has booted and it's read by the SOF
VirtIO backend vhost-be.c when receiving a resume request from the guest. 
Timewise the variable will only be incremented during the DSP resume / 
power up, while the VirtIO back end is waiting for the resume to complete in 
pm_runtime_get_sync(). And only after that it reads the variable. But that 
can happen on different CPUs. Whereas I think that runtime PM will sync 
caches somewhere during the process, I think it is better to access the 
variable in an SMP-safe way, e.g. using atomic operations.

> >  #include "ops.h"
> > @@ -617,6 +618,9 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
> >  	/* fw boot is complete. Update the active cores mask */
> >  	sdev->enabled_cores_mask = init_core_mask;
> >  
> > +	/* increment reset count */
> > +	atomic_add(1, &sdev->reset_count);
> > +
> 
> We at no point seem to read from this reset counter?  I can't figure out
> from this commit what it's doing.

It's used in vhost-be.c (patch 10/14).

Thanks
Guennadi
