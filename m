Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC4C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:40:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFBF61075
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFBF61075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6B8716A2;
	Mon, 10 May 2021 14:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6B8716A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620650409;
	bh=5SofxNKeEKJyLUmGPf5J50yS3HL9/uRmaU+Pl43dXBY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qLU6lwlqqpwDAVJ15Jur1O4OMT1ZDdBYgoe+/gjgAGQa2h6rxxC1iSNGNnoCYDVxQ
	 70Kb6Ulc35zIcwLs5I4jL4RXFchWzlBOewbpwcbR8OXzmbMiNqgxKWiUWpLn4V2PNh
	 I2/AvKcdfKXHTwlVBu0DmJj39lnEJOQSDsMe72/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7058CF800B4;
	Mon, 10 May 2021 14:39:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91EE1F80240; Mon, 10 May 2021 14:39:18 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84597F800B4
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 14:39:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84597F800B4
IronPort-SDR: cQD21UsXK+KX+s2raSRVxTSouHIvLXxPiQn8WUJt5nUzueCqE9t3HoJ0abljpB8XZCBtqVUwE2
 rA+EdYw+nhWA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="220129980"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="220129980"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 05:39:12 -0700
IronPort-SDR: qr+vKfhFFOxuAriRn/h1VWiMb0tXm1Qu5IZa5twkTj1uqIaFfwLl8EDw5CS3NBEwX2Poquub4Y
 Pgla+J4ZgJjA==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="470782756"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 05:39:00 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1lg5BY-00BAPk-PH; Mon, 10 May 2021 15:38:56 +0300
Date: Mon, 10 May 2021 15:38:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/14] spi: pxa2xx: Introduce int_stop_and_reset()
 helper
Message-ID: <YJkpYDfoUg04UEMy@smile.fi.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <20210423182441.50272-8-andriy.shevchenko@linux.intel.com>
 <20210510120953.GA15173@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510120953.GA15173@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>,
 linux-spi@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, May 10, 2021 at 01:09:53PM +0100, Mark Brown wrote:
> On Fri, Apr 23, 2021 at 09:24:34PM +0300, Andy Shevchenko wrote:
> > Currently we have three times the same few lines repeated in the code.
> > Deduplicate them by newly introduced int_stop_and_reset() helper.
> 
> This doesn't apply against current code, please check and resend.

Hmm...

Can you, please, point out, what branch should I use?
It seems good against v5.13-rc1 and spi/for-5.14.

Okay, I will resend against spi/for-5.14, but I don't see the issue here.


-- 
With Best Regards,
Andy Shevchenko


