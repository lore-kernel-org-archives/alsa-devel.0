Return-Path: <SRS0=21/e=FE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05909C64E8A
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 11:09:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E0C2076E
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 11:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dVunoVlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E0C2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50D381670;
	Mon, 30 Nov 2020 12:08:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50D381670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606734565;
	bh=8PBymzP8akjmhKX30QLKJL7jqO4jqolPHFeRig/yzWI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dVunoVlYxtGUOLTb8LCNMyVv0F6Ii3unjCYsHv/Y6XZ74gNIpQs28rSInaJiYtZUi
	 /+5iGyCxklh66vlc7THniZ0eLMOs7hdrHLfirFfznk2CCAlSL0p5VSIO1XUEUOJRYb
	 wQr/8eOlVGCsPHC0diSzIImgMCjd2tlB68zeQqao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6461F80254;
	Mon, 30 Nov 2020 12:08:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E7D9F8025F; Mon, 30 Nov 2020 12:08:33 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9668BF80146
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 12:08:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9668BF80146
IronPort-SDR: hYUXU9hDR5vxPnQ4koIZbo86dcSuOEC9nG0snsoFfUk5rSKharaEA8wphOGsGjjuwyCwLKraov
 vru/qxM4yVmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="190797474"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; d="scan'208";a="190797474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 03:08:16 -0800
IronPort-SDR: g4di3Nc0Y/u2x2HzL6SsyXzBKY+N3ohzo8bYejvnswaYciJZrEgcn9qbRil7m+IBHKaPUBxUO4
 gJ+m7/7Rqwqg==
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; d="scan'208";a="549054576"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 03:08:14 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@intel.com>)
 id 1kjh3T-00B1qM-U7; Mon, 30 Nov 2020 13:09:15 +0200
Date: Mon, 30 Nov 2020 13:09:15 +0200
From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 2/4] ASoC: soc-generic-dmaengine-pcm: Add custom
 prepare and submit function
Message-ID: <20201130110915.GI4077@smile.fi.intel.com>
References: <20201117080354.4309-1-michael.wei.hong.sit@intel.com>
 <20201117080354.4309-4-michael.wei.hong.sit@intel.com>
 <20201117155038.GO4077@smile.fi.intel.com>
 <CO1PR11MB50269CF832CD14BA2D2A883CDAE10@CO1PR11MB5026.namprd11.prod.outlook.com>
 <20201118145055.GW4077@smile.fi.intel.com>
 <CO1PR11MB5026A81C4294BEF4EE5EF923DAFB0@CO1PR11MB5026.namprd11.prod.outlook.com>
 <BYAPR11MB30465A81744EA686D2502DB69DF50@BYAPR11MB3046.namprd11.prod.outlook.com>
 <e9bae9eb-6b8b-5a8c-eba0-d7f5da955987@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9bae9eb-6b8b-5a8c-eba0-d7f5da955987@metafoo.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "Sia, Jee Heng" <jee.heng.sia@intel.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "Sit,
 Michael Wei Hong" <michael.wei.hong.sit@intel.com>
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

On Mon, Nov 30, 2020 at 11:45:17AM +0100, Lars-Peter Clausen wrote:
> On 11/30/20 10:57 AM, Sit, Michael Wei Hong wrote:

> > Is there anymore comment on this RFC?
> > We will be using the ASoC framework to split the linked-list, since resplitting the linked-list in DMA is a no go.
> > If there isn't any more comments, we will push these patches for review and merging.

> Why is splitting the list in the DMAengine framework a no go?
> 
> The whole idea of the DMAengine framework is to hide hardware specifics. It
> offers an API with certain semantics and it is up to the driver to provide
> an implementation that implements these semantics. There does not
> necessarily have to be a 1-to-1 mapping to hardware primitives in such an
> implementation.

I would say it's not desirable.

Why should we split than resplit if we may do it in one go?
Why then we have DMA capabilities returned to the consumers.

So, I have that we need to optimize DMA SG list preparation in a way that
consumer gets SG list cooked in accordance with DMA limitations / requirements.

-- 
With Best Regards,
Andy Shevchenko


