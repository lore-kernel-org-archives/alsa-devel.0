Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFCCC44514
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:02:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38B88601ED;
	Fri, 17 Jul 2026 13:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38B88601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784286170;
	bh=mSgS5AaQQAucWu8Oo76kWO6ywHsqTYPwz04D5lfr9Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jfT2HGAcHK8tCHcZ0iI43Fx1FIAFJ3FU9V2xBfPesjk+T/tOyCK6Zhv5kBwu57K1x
	 boQCO7RHggzmB46mWy9leG8BWq1pmgANZIIvfjnZP6onozplGS2UyJOYSRq0MpqrfV
	 nO2JcsGUUNclx7jVf4Y/ofzQ9IZduEiA53Zap7XE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48B73F805F5; Fri, 17 Jul 2026 13:02:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F9F2F80600;
	Fri, 17 Jul 2026 13:02:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBF8CF80526; Fri, 17 Jul 2026 13:02:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784286137;
	b=B9Zkn6oxkhoY2mFr07Qoo64v3rmVPw1lB0TC7vL372pr+aAOyUJPU5Pvgu7TtlkFEwbR
	 PxdKz6DdXQYcGs7LWAsM8GkPvKhl+4qUGKegAwEWJtG4FLeA95hgUUcPH/f5b09qMqHSn
	 3XD9kgZwXCZ7Ncy0XN9J0xC5DE9UKvhLcdKVEOGCbvgNYrpc7p5UaJFy4VMr2NXDKw5NX
	 HNU3yNVH88lvPAfKnfa9bEuQIayi3AlciXImFHw+iUE8YpfqqIevJLkPWi/+Uf1WEPv4m
	 e70FLFjn/bEhIdliRlU/3Ja9lQh18ZOnL3vYluQ6Ij0ObijFKtQ7eV7lfuLsffBzAYw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784286137;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=mSgS5AaQQAucWu8Oo76kWO6ywHsqTYPwz04D5lfr9Y4=;
	b=ZaT5cwho9CbQUJK8xgrHdZni2CwOAwuHaTyc5m/UzsozNvwEd+ubo2mIeUxW2A12UW1S
	 4WucCXQpoo8nzMsKssNG67h5LQlEx6/Q5vtgvfGgk1WIGwJPTt4lUWB4Lrjh8w3BovSwq
	 PSQoxRjz8xS5dORSLGR420hR65fFQmdAwcVj8Lwm8ETFCk10iv/2htuLU51craOgEC5Ub
	 AWyxnL+vi6tKb/bLDAncsLTOMzaD0DTlbbYJOSp3O4gT1uZr8QXn+ThGHMhzd4tne7ODq
	 4ojesAx3h9ZcNu/DF5p5SBk1gfrTuOXUmP4CN0A1gtd4jZt/jAnLPclMkke6vGwf0DA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AYfCeQUE;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07B88F801F7
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 13:02:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07B88F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AYfCeQUE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784286138; x=1815822138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSgS5AaQQAucWu8Oo76kWO6ywHsqTYPwz04D5lfr9Y4=;
  b=AYfCeQUEYNS0MpZzn/AmAHVay5jxTa8pckTjvJCx6dbguqLXFCkMgZyN
   V88POhTiXuJP/psReZbC6L1OBeWpI/g5csYJhK6bE9zU3M6rsU0wi2o0c
   a0RolF/2OJvWrSpZ/l99phDdbRAqLsEH26nOfHfF9yU8Ahg3rE0vdPrEo
   Tb6sys+zKPSbk+lf1npKTqC+gXFghYD69pGiBdNfdTs/V6ZHhdfYBPo1Z
   c7SeaR8n8gHGgTWwalENmfXvO5S0QO482cmpdWd7eG+Q+dOEeyUGzYQs/
   8yx71geLvbpWjOhG5+ayYuF+DIFw//eJAeLfhtQzyizOSzek9UDVIdpoH
   A==;
X-CSE-ConnectionGUID: nJH7UUS8TLSkzGgLC0Zyyw==
X-CSE-MsgGUID: irwrzSCVTJi+GH2CcbAeKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95312427"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000";
   d="scan'208";a="95312427"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 04:02:13 -0700
X-CSE-ConnectionGUID: hq+mAKuNTYCQCDrQZdIP1w==
X-CSE-MsgGUID: lDInkW8mTRCeTATcy3sDDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000";
   d="scan'208";a="261723945"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.143])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 04:02:10 -0700
Date: Fri, 17 Jul 2026 14:02:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, 13916275206@139.com, krzk@kernel.org,
	alsa-devel@alsa-project.org, baojun.xu@ti.com, riyo@ti.com
Subject: Re: [PATCH v1] ASoC: tas2781: Add calibration kcontrols for TAS2573
Message-ID: <aloLsNafNO0E2YVh@ashevche-desk.local>
References: <20260717073927.181-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717073927.181-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
Message-ID-Hash: 2B6TMCWIMVP4UM6IPOT4NLYRAKL74ASU
X-Message-ID-Hash: 2B6TMCWIMVP4UM6IPOT4NLYRAKL74ASU
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2B6TMCWIMVP4UM6IPOT4NLYRAKL74ASU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Jul 17, 2026 at 03:39:27PM +0800, Shenghao Ding wrote:
> Add calibration kcontrols for TAS2573 in TAS2781 driver to support
> device-specific calibration settings.

...

>  		memcpy(config->name, &data[offset], 64);
> +		/* If in the coef bin file are several configs with the
> +		 * keyword "calib", init_profile_id only store the last
> +		 * init profile id, and same as calibration_profile_id.
> +		 */

/*
 * Even in this patch you have inconsistent style, try to follow
 * the correct one (as in this example) everywhere in the ASoC subsystem.
 * The above style is only approved in net subsystem.
 */

-- 
With Best Regards,
Andy Shevchenko


