Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA681C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 17:25:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5841023A9C
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 17:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5841023A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CDA61EDC;
	Fri, 22 Jan 2021 18:24:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CDA61EDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611336331;
	bh=05VnOfbnvs4peje4mOZJuAVEH+S8OMDl+rEfq9gwarg=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dbqkqe+z8FX+n5cWCRY5Q7P96srmRZXiCkSzrJ0sImKoGOilAPFDEQzqLEweRt0+I
	 LUIMEmqLWU7pS37J6Dp/uyuXyI+FJen++Ca1FIVEWCHP0FboMcN9ERcHuJ6zNDVt5K
	 gn9ZnSIR51IILmIaI3Sqnrrh9gxmCoPvI9dwELEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74758F80129;
	Fri, 22 Jan 2021 18:24:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88740F8016E; Fri, 22 Jan 2021 18:24:38 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F4FFF8015B
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 18:24:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F4FFF8015B
IronPort-SDR: mH9GjfR4ajTVte+BsLkRXx62IAG+W+lWcrMTeCmURjvtgjXrSpe9KLoBR/Gax/CY7rUaMlbZjy
 KqehU/vJYsTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="241016564"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; d="scan'208";a="241016564"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2021 09:24:24 -0800
IronPort-SDR: SBngMueUiX8VlTAEO4ot/4yW5n+jDoX7KoMhG03U344707mtw/A0IFDfvw1tnUF5FN4LX4fFN5
 ZzuJzCw78OgQ==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; d="scan'208";a="367505806"
Received: from ovakana-mobl1.amr.corp.intel.com ([10.255.229.172])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2021 09:24:23 -0800
Message-ID: <1cc3c8a6326ec83e2a33310f6a80daa23fe65782.camel@linux.intel.com>
Subject: Re: Question about hdac_ext_link ref_count management
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Date: Fri, 22 Jan 2021 09:24:23 -0800
In-Reply-To: <s5hk0s47w6m.wl-tiwai@suse.de>
References: <aca60b522335f3f916f9f8f204693365bfc32231.camel@linux.intel.com>
 <s5h1red83ic.wl-tiwai@suse.de>
 <9888b27b0dc9399861ecbee23d5d4ea0d844718c.camel@linux.intel.com>
 <s5hk0s47w6m.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com
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

> > 
> > It looks like snd_hdac_ext_bus_link_power_up/down() are only called
> > during snd_hdac_ext_bus_link_get/put(). Actually, in my observation
> > disabling the CORB/RIRB buffer DMAs is what saves us power and this
> > is
> > done only if snd_hdac_ext_bus_link_put() is called on all links.
> > 
> > > The get() and put() are obviously for fully enabling and
> > > disabling
> > > the
> > > device, hence it's not suitable for the runtime PM
> > > suspend/resume.
> > > The power_up() / down() should be adjusted to fit with the
> > > runtime PM
> > > call, if any.
> > 
> > The only additional thing that snd_hdac_ext_bus_link_get/put() does
> > on
> > top of snd_hdac_ext_bus_link_power_up/down() is to stop the
> > CORB/RIRB
> > DMA when all the link ref_counts are 0. Do you think it is not
> > advisable to stop the CORB/RIRB DMA during runtime PM?
> 
> Why do you need to stop CORB/RIRB?  For stopping the CORB/RIRB DMA,
> you need to disable the IRQ and other stuff at first, in anyway.

I see. Let me go back and double check if powering down the link during
codec runtime suspend yields the same results in terms of power as well
and get back to you.

Thanks,
Ranjani

