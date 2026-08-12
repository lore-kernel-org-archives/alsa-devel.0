Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF265C5B56A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:13:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E649B60202;
	Wed, 12 Aug 2026 09:13:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E649B60202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786518803;
	bh=ObzH5kp5CDfoiPaG75R9jdzEA4F1KXNwXB9PAHaeg7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ttYXOUauHtkhpdXGWZkSnuF8mWsz0OlbJI6SXue3RdMpS32QKCoBTL5RNtql8aaso
	 3E375LiGP3puUQlDoO/PzP2D5HewUtE4BCqVYFPqyQENK/Hph0DXzCRkYIAZ9iTLQy
	 kiFEGQ/TW13+tSiIwiHNRgRL1+8/eniVsCnr2rLM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 089DCF805FC; Wed, 12 Aug 2026 09:12:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C18DF80600;
	Wed, 12 Aug 2026 09:12:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF844F804CF; Wed, 12 Aug 2026 09:12:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786518755;
	b=fmc8w7GcVCLEUuNJm9NYjAMd9ih0QdrVP/j6WV6/bryfY8X6juK8aN3RsVtvJfb9a90i
	 R/nCGZvvu2WDhUlYfUUQqM44OLFAR38UIKIUKvN0OybM2/BoGrXED0b9mDSu9uiXedmXW
	 zy0HYenfcvc18qa1IFwkBg/rehqd5iSDifY5tBA73em3h24dpSaoSxhcf3se45KXW75FJ
	 Cf5y6+XIG1LnGrzqpN/weQVD4QtvIWj5BLLfFxtEl59TScX9xuAPdFDv8qsnop9sGkBHu
	 5pcsGc7UabJV3JXoTp/d6p+eA0vdIPaDxh4DL70/ZfUBPd/zanbsCeFAfa5BCADDiRg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786518755;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=ObzH5kp5CDfoiPaG75R9jdzEA4F1KXNwXB9PAHaeg7Y=;
	b=Z2UCtcKGyqtdUhwHLmzEz8xoajtyuln48QbTHzv6K+GrG6RkSB8qtKCLzlyRC+M8GIko
	 CDm+Q+vRVSvF85KKRQMP62ha4dZ0o4+zcrRkkbFIPSYnqKmvqd6alayNZVN+10ko763o+
	 WkAVdzvDrQiVnvvbyv1p6blwhTTcNeOe6OWXaQYx89S9FEtsIlbVrhQAHun046Z+lTjC4
	 mnPoEkZGqCqHLlUkRcf1P5Qm/Dhyzt1WmjyUOPojV8ytCtohYrFbj2sFwWNAlkBp20LUW
	 O4HB8nfUE8iodEF4LYEYIopow3cjCH+St2UNEss3usp6+WT/it0mpo1NZC8YWH8jvog==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GNkMrBVz;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B1AFF80149
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 09:12:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B1AFF80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GNkMrBVz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786518756; x=1818054756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObzH5kp5CDfoiPaG75R9jdzEA4F1KXNwXB9PAHaeg7Y=;
  b=GNkMrBVzclhAG+2UZ1n4iPagK1e7a2QT5WpS33cw4CxKuO3dmRDL/0iK
   MVYt05BWvY+Jerd9AsuY7PSq4bH+VQG1/WvdUJpBhqpSYGLscd6CbAc1F
   M5Mpo/lRB/shTzvlrt8uD59pfCmmREIKtrWp8/JYVvK9Mfppp8QZkM6Hl
   IuWCgBzFgUXjqMcn0UGt0mQbh2uxALEoi0qXIP8wrYEH4RLPw+YUtu/GQ
   XDoRime7qyPxIq65Lv7Usa/L+ipJZiOnuAnh88Xfk+04cYRaPfsJ7a+tA
   CEzBFIjlGLCmk/AkQY37wq2ZOvTbgR4GGt04rh8jLaLesGo06Cu+WH/Zw
   g==;
X-CSE-ConnectionGUID: Tz9aw7t9QKiQ9IM0Xi0n5Q==
X-CSE-MsgGUID: Gok3W1j9SHmWfKI4vmH/Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98575671"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000";
   d="scan'208";a="98575671"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 00:12:30 -0700
X-CSE-ConnectionGUID: ZiPY7thgQhCNG8lO387vZA==
X-CSE-MsgGUID: GyFRDGk7SYeV1dCcYj1SBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000";
   d="scan'208";a="260936225"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.245.92])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 00:12:27 -0700
Date: Wed, 12 Aug 2026 10:12:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com,
	pin-hao.huang@hp.com, Syed.SabaKareem@amd.com
Subject: Re: [PATCH v1] ASoC: tas2783-sdw: add firmware download status check
Message-ID: <anwc1w5oCiU8qKMN@ashevche-desk.local>
References: <20260812052124.1843-1-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812052124.1843-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
Message-ID-Hash: DNCTCERDNTMINI4LAKJUMEQDOQGTUAVW
X-Message-ID-Hash: DNCTCERDNTMINI4LAKJUMEQDOQGTUAVW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DNCTCERDNTMINI4LAKJUMEQDOQGTUAVW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Aug 12, 2026 at 01:21:24PM +0800, Baojun Xu wrote:
> Currently, the firmware download is unnecessarily triggered on every
> system resume from suspend, causing significant wake-up latency. However,
> this step is redundant if the AMP remains powered on. Furthermore, certain
> memory pages (addresses > 0xc60000) are skipped even after an AMP reset.

...

>  	} else {
>  		tas2783_update_calibdata(tas_dev);
> +		/* Mark the AMP firmware download as complete. */

> +		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 0x07),
> +			     0x22);

Make it a single line.

> +		tas_dev->first_hw_init = true;
>  	}

...

> @@ -1102,7 +1108,6 @@ static s32 tas2783_sdca_dev_resume(struct device *dev)
>  		regcache_mark_dirty(tas_dev->regmap);
>  		return ret;
>  	}
> -
>  	return 0;
>  }

Stray change.

...

>  static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
>  {
>  	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
> -	s32 ret;
> +	s32 ret, val;

Why is 'val' signed? It should be unsigned int (which is what API requires).

...

> -	usleep_range(2000, 2200);

> +		usleep_range(2000, 2200);

While at it, replace with fsleep().

-- 
With Best Regards,
Andy Shevchenko


