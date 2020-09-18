Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C11C43463
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:55:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEB620874
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oZSAnZXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEB620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1587516B9;
	Fri, 18 Sep 2020 15:54:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1587516B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600437335;
	bh=DpoGBjkKfiPEqCfxn1WiNdE7ZYTyJPOF7Fu+z0g9keU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oZSAnZXwvFIryiqfhuPJz7EFu9eW0l0EnJ1DHBDv/lOyyQOlFcEv2LCCTYIE8gGOi
	 gJ0uv9cIpAnGecCAB3MoDH5OSdF5Y4uHgmKaI0+Nq8u2lVuKitdfXLZ6uE8WrbZWoq
	 LodZ4hI6u/JAaZZeBMlWwOlL69v8oGB61AwRKBpA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB25EF8015A;
	Fri, 18 Sep 2020 15:54:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47938F8015D; Fri, 18 Sep 2020 15:54:44 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 815EAF80150
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 15:54:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 815EAF80150
IronPort-SDR: wLmLxnISndV4c1bBqj6F+y3sa6Cqdwmpjqj5nIbBO1tjJZWyN2g8gmHz81k1CUut2Zmjk5moWh
 /S7tzv2y6yxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147616548"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="147616548"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 06:54:35 -0700
IronPort-SDR: E1WiO87TDWd5n+pqmAhttPHPx2q5ChAn3YdplQqpLa0dMeXhF6gYDr1Xnkgqzuw3t4E5Ekgy+9
 iwgaY0R7mphA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="336811721"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 18 Sep 2020 06:54:31 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1kJGqJ-0000Dz-Hw; Fri, 18 Sep 2020 16:54:27 +0300
Date: Fri, 18 Sep 2020 16:54:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rojewski, Cezary" <cezary.rojewski@intel.com>
Subject: Re: [PATCH v5 08/13] ASoC: Intel: catpt: Simple sysfs attributes
Message-ID: <20200918135427.GD3956970@smile.fi.intel.com>
References: <20200915162944.16241-1-cezary.rojewski@intel.com>
 <20200915162944.16241-9-cezary.rojewski@intel.com>
 <20200916165033.GB3956970@smile.fi.intel.com>
 <004cfc8add4346c3b745e7d755dc9b1c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004cfc8add4346c3b745e7d755dc9b1c@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kaczmarski,
 Filip" <filip.kaczmarski@intel.com>, "N,
 Harshapriya" <harshapriya.n@intel.com>, "Barlik,
 Marcin" <marcin.barlik@intel.com>, "zwisler@google.com" <zwisler@google.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "Proborszcz, Filip" <filip.proborszcz@intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "amadeuszx.slawinski@linux.intel.com" <amadeuszx.slawinski@linux.intel.com>,
 "Wasko, Michal" <michal.wasko@intel.com>,
 "cujomalainey@chromium.org" <cujomalainey@chromium.org>, "Hejmowski,
 Krzysztof" <krzysztof.hejmowski@intel.com>, "Papierkowski,
 Piotr \(Habana\)" <ppapierkowski@habana.ai>, "Gopal,
 Vamshi Krishna" <vamshi.krishna.gopal@intel.com>
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

On Thu, Sep 17, 2020 at 03:37:14PM +0000, Rojewski, Cezary wrote:
> On 2020-09-16 6:50 PM, Andy Shevchenko wrote:
> > On Tue, Sep 15, 2020 at 06:29:39PM +0200, Cezary Rojewski wrote:
> >> Add sysfs entries for displaying version of FW currently in use as well
> >> as binary dump of entire version info, including build and log providers
> >> hashes.
> > 
> > Something tells me that this might go a bit different direction. Can you
> > achieve Greg KH's review on this?
> > 
> 
> This sounds as if I had any control whether Greg KH would review my
> changes or not. Do you want me to CC + mention him in v6 version of this
> patch?

I see few options here:
- leave as is
- reply on the patch in question with Greg in Cc and ask his opinion
- Cc series (v7?) to Greg KH and ask about certain patch

(I think the second option is the best to satisfy all sides)

-- 
With Best Regards,
Andy Shevchenko


