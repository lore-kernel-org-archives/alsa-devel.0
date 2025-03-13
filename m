Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAFCC282DE
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:16:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2DB960398;
	Thu, 13 Mar 2025 17:15:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2DB960398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741882568;
	bh=CBl/skjHYGHsZPO/tdVmsPaWnigX6uOebmpzZaNJe3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ih6wkR6u8CVQFu1EhBw538ASE/Syzp7W3eFEj9a3n2Eo52+DdqKWMvykul7tuNbp/
	 ZmYUrC5KSFMPB/q37o9c2i6e+r8AdThwIS+8oomvfgcwRJw+J1n3Ek4qgKlj7Yq4OG
	 5ZdbOCwUQSvw8oA+BvuvC7nvruJImG8H/K8fbS8M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A7ACF805C1; Thu, 13 Mar 2025 17:15:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CC42F805B2;
	Thu, 13 Mar 2025 17:15:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BD3DF8026D; Thu, 13 Mar 2025 17:15:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4AEDCF800D0
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2025 17:15:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AEDCF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nC0bgDgO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882526; x=1773418526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CBl/skjHYGHsZPO/tdVmsPaWnigX6uOebmpzZaNJe3M=;
  b=nC0bgDgOf56quFYyaDGwV332w8w8aqaGI8OgPAlgDzneM6Owc8AjuUX+
   nygWCAutny8UfwoNLRkmnK9QM5Y8J0Rb8lg6/5StIyIO6O7AgIogS2JIM
   seh44m9//n/Z/cLvmy0/6KG6BwGOdrEyAMYs8e8F0j6AQcYWZdQzW+yTu
   PF4TdWdWlqeO2YQmVWSzLKsPesj/bGhpEtJfPVa2SboIUun4pVEkUUR4R
   JmImzXjL13ooBQ352eiAal4M30zvvA8xnGe+GqL9CI3V5+oR+sZ6NeQ0B
   cdR6fR/nAGNwOVYH0527w7XPQwSMwYeUNAwFTNeBhdMGGirHEGhiIUh33
   Q==;
X-CSE-ConnectionGUID: YsGGZbVqQGGTI1nrR1t+4A==
X-CSE-MsgGUID: YYFz6YxyRtGLbrmnvhutaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="68371753"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600";
   d="scan'208";a="68371753"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 09:15:21 -0700
X-CSE-ConnectionGUID: Ukz10lHGQKun6crcwpE5ig==
X-CSE-MsgGUID: dctvMqtYT2O0LfTnQCxH+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600";
   d="scan'208";a="121055291"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 09:15:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tslDJ-00000002E9P-0NV2;
	Thu, 13 Mar 2025 18:15:17 +0200
Date: Thu, 13 Mar 2025 18:15:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, 13916275206@139.com,
	13564923607@139.com, alsa-devel@alsa-project.org, baojun.xu@ti.com
Subject: Re: [RESEND PATCH v5] ASoC: tas2781: Support dsp firmware Alpha and
 Beta seaies
Message-ID: <Z9MElIE2VcQiefam@smile.fi.intel.com>
References: <20250313093238.1184-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313093238.1184-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: JFO4TKJ3JETGXGS52ODL7UYXVJC2S6VA
X-Message-ID-Hash: JFO4TKJ3JETGXGS52ODL7UYXVJC2S6VA
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JFO4TKJ3JETGXGS52ODL7UYXVJC2S6VA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Mar 13, 2025 at 05:32:38PM +0800, Shenghao Ding wrote:
> For calibration, basic version does not contain any calibration addresses,
> it depends on calibration tool to convey the addresses to the driver.
> Since Alpha and Beta firmware, all the calibration addresses are saved
> into the firmware.

I believe there is a lot of room to improve in this patch and in the entire
driver, but this probably is needed to unblock the users. So, from my point
of view if it's working, it's good enough to go.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


