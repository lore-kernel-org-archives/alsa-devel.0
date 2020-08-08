Return-Path: <SRS0=nyeS=BS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053DC433E0
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Aug 2020 11:51:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6225B2075D
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Aug 2020 11:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ckopqfol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6225B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFC61850;
	Sat,  8 Aug 2020 13:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFC61850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596887508;
	bh=vjdSom4nuSF66kN8G1PTFnJ5spoAHJFKJNTxorjrugc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ckopqfolMg1HjUTg42x3rnHagjVSxmaV+OGLWze79K/YDrTp87RfwndhXV5zw2xZQ
	 0fkpZWuazBqvuuM290O+jDwM2HU8sjLTUDmHZexJD8MYLESnLjKsO/D1CHlt/wg3rT
	 2HH4G1+HYCqfIqnGAJ2yY3f6rUsheaAn8RsnXF+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 548C7F80159;
	Sat,  8 Aug 2020 13:50:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFFC3F8015A; Sat,  8 Aug 2020 13:50:56 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49C1AF80139
 for <alsa-devel@alsa-project.org>; Sat,  8 Aug 2020 13:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49C1AF80139
IronPort-SDR: kYdnhhHIvdpkiL34hddDWiwOJ85OLF6XbXWsr+TlRmgd9uogDbBoUJo8cRVHnQNcHO0IqE5Buv
 rqRyOkDbNQDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="238124241"
X-IronPort-AV: E=Sophos;i="5.75,449,1589266800"; d="scan'208";a="238124241"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2020 04:50:47 -0700
IronPort-SDR: RY6e6cIAEuw9jAEtJHzQAo+TtYcs2rMsvFB0XpOqb75p9Np2nBd92PuDIWEMvR/RM+OglNhkLw
 13oQba3sB53w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,449,1589266800"; d="scan'208";a="333797017"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga007.jf.intel.com with ESMTP; 08 Aug 2020 04:50:43 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@intel.com>)
 id 1k4NN3-007Egj-Pr; Sat, 08 Aug 2020 14:50:41 +0300
Date: Sat, 8 Aug 2020 14:50:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 01/13] ASoC: Intel: Add catpt device
Message-ID: <20200808115041.GN3703480@smile.fi.intel.com>
References: <20200807110649.17114-1-cezary.rojewski@intel.com>
 <20200807110649.17114-2-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807110649.17114-2-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 filip.kaczmarski@intel.com, harshapriya.n@intel.com, marcin.barlik@intel.com,
 zwisler@google.com, lgirdwood@gmail.com, tiwai@suse.com,
 filip.proborszcz@intel.com, broonie@kernel.org, michal.wasko@intel.com,
 cujomalainey@chromium.org, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
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

On Fri, Aug 07, 2020 at 01:06:37PM +0200, Cezary Rojewski wrote:
> Declare base structures, registers and device routines for the catpt
> solution. Catpt deprecates and is a direct replacement for
> sound/soc/intel/haswell. Supports Lynxpoint and Wildcat Point both.


...

> +struct catpt_mregion {
> +	u32 start;
> +	u32 end;
> +	bool busy;
> +	struct list_head node;
> +};

I'm wondering if struct resource can be used instead.

You know that you may introduce a new type of resource if you want to.

> +static inline size_t catpt_mregion_size(const struct catpt_mregion *reg)
> +{
> +	return reg->end - reg->start + 1;
> +}
> +
> +/* True if region r1 intersects region r2 */
> +static inline bool catpt_mregion_intersects(struct catpt_mregion *r1,
> +					    struct catpt_mregion *r2)
> +{
> +	return (r1->start >= r2->start && r1->start <= r2->end) ||
> +	       (r1->end >= r2->start && r1->end <= r2->end);
> +}
> +
> +static inline bool catpt_mregion_intersecting(struct catpt_mregion *r1,
> +					      struct catpt_mregion *r2,
> +					      struct catpt_mregion *ret)
> +{
> +	if (!catpt_mregion_intersects(r1, r2))
> +		return false;
> +	ret->start = max(r1->start, r2->start);
> +	ret->end = min(r1->end, r2->end);
> +	return true;
> +}

Yeah, it reminds the existing resource infrastructure. Why to repeat it?


-- 
With Best Regards,
Andy Shevchenko


