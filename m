Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CACC388F9
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 13:45:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0483A20781
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 13:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Fg8aGLB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0483A20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 108DA1667;
	Mon, 23 Nov 2020 14:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 108DA1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606139143;
	bh=qV5ywUepgGAeIcMerwTCMnFf7uMAvZRQDcMS5icGQVM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fg8aGLB3BuyMSNdHOlZqXxgLb0SoYIcJV0zOwZOHfwKJ7y+2OzjOcAvHWzl831ENl
	 32GhJHBel/HhWUyvKaInUOUlID7hZf1tPLG66s7L+w8VKN2bEqRLTypyUBDPAkGkAj
	 BslSxxgG3vxXZ+nh/uBeTFTpf7sOu8f80MuQxuyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9590EF8015F;
	Mon, 23 Nov 2020 14:44:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22F11F80255; Mon, 23 Nov 2020 14:44:50 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAB83F80128
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 14:44:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAB83F80128
IronPort-SDR: lbJwhV4CWmGbfaRmqfPSLodkDpyr2yRm5XS7jv1/K+m05krmdgMssnzyWBdpWpqHOn7u9rVcNQ
 8tXkOWmRGOQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159530854"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; d="scan'208";a="159530854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2020 05:44:42 -0800
IronPort-SDR: 0YOEdlhbHllFXV0VXqJrmN57k5zXYl59TpMwgXZEw5gicLXxp0J3EJMiONcmLPyKhBoXftBuvt
 O4ukTwBlAwQw==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; d="scan'208";a="327201580"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2020 05:44:40 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1khCA1-009AUS-TS; Mon, 23 Nov 2020 15:45:41 +0200
Date: Mon, 23 Nov 2020 15:45:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123134541.GG4077@smile.fi.intel.com>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
 <20201123124129.GA170000@kozik-lap>
 <20201123134225.GF4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201123134225.GF4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
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

On Mon, Nov 23, 2020 at 03:42:25PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 23, 2020 at 01:41:29PM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Nov 23, 2020 at 12:37:31PM +0000, Mark Brown wrote:
> > > On Mon, Nov 23, 2020 at 12:48:32PM +0200, Andy Shevchenko wrote:
> > > > On Sun, Nov 22, 2020 at 11:59:20AM +0100, Krzysztof Kozlowski wrote:
> > > > > On Fri, Nov 20, 2020 at 08:04:29PM +0000, Mark Brown wrote:
> > > 
> > > > > > Surely if that's the desired outcome the fix is to change the definition
> > > > > > of of_match_ptr() such that it leaves the reference with CONFIG_ACPI,
> > > > > > perhaps hidden behind a config option for PRP0001?  That seems better
> > > > > > than going through the entire tree like this.
> > > 
> > > > > That could be indeed an easier way to achieve this.
> > > 
> > > > ...easier and wrong in my opinion. Not all drivers need that.
> > > > What the point to touch it in the driver which is OF-only?
> > > > (For IP which will quite unlikely to be present in ACPI world)
> > > > Or if the device will get the correct ACPI ID?
> > > 
> > > That feels like something that should be done with Kconfig dependencies
> > > like a direct OF dependency (possibly a !PRP0001 dependency?) for the
> > > driver or possibly with having a variant of_match_ptr() for things that
> > > really don't want to support PRP0001.  Just removing all the use of
> > > of_match_ptr() is both noisy and confusing in that it looks like it's
> > > creating issues to fix, it makes it hard to understand when and why one
> > > should use the macro.
> > 
> > For the OF-only drivers (without other ID table), there is no point to
> > use the macro. Driver can bind only with DT, so what is the point of
> > of_match_ptr? To skip the OF table when building without OF? Driver
> > won't be usable at all in such case. So maybe for compile testing?
> > There is no need to remove OF table for simple build tests.
> 
> I'm on the same page here.

I should have elaborated that under OF only I meant rather !ACPI. So, when it
has no ID tables, I agree that macro is not needed. But, for instance, I²C
device drivers tend to have table even for ->probe_new() callback to be able to
instantiate them via user space.

-- 
With Best Regards,
Andy Shevchenko


