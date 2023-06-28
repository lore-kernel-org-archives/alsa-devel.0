Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101B9EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jun 2023 14:52:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB6C5822;
	Wed, 28 Jun 2023 16:51:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB6C5822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687963966;
	bh=cg7dkx2gsnXgVGaUug0ARzW7wx7R0VAqNKiR1u2VeAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UJ1cJAbQDCKlipwfZ7iM605R23wbQ4iHlB26jifso7NzzStGIh9xXBwQnl7l2JZY/
	 QiI4bx2h/Z1dM0Tz6QGiTyQiYQtXP2LrfC/1BCrH2HHv8wznUveOgYDgBZWWhmGRck
	 LBcIeBJZLxDtA3mzrAnFFupl8U/du2krrzBMn8YI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1E76F8053B; Wed, 28 Jun 2023 16:51:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37AECF80535;
	Wed, 28 Jun 2023 16:51:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA043F80246; Wed, 28 Jun 2023 16:51:27 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 43390F80169
	for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2023 16:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43390F80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FmjDCaGT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963886; x=1719499886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cg7dkx2gsnXgVGaUug0ARzW7wx7R0VAqNKiR1u2VeAg=;
  b=FmjDCaGTn+wD/x4IzpR4NOn96YQIOZbq0lb7gCe9XQKxeDCne2HX4y1x
   6d3H54PwwHZTgxE4Nmxl5gewdIr5YQa77xdWeGQb1IngtxFyHJd0cENrr
   jNho9Rp1EFRzQUe15az8QNuuKPV9IuAeBb9hq0fEoX5PWK8yuMSEDE0Y7
   IHS9icZHNIBw4+tMPcpIa0zXqxOmKvHKgSLHX/paii6oMf1Rlw2wRcnNh
   jcs95PUDT/Ixeu+R97iUnNhO/9oPnDgZSKLOyifBvsheHWSFKEziZyqld
   WXP9/1VMuSQSeK6ffnU2CzHbK7OR0MkUqmfY5+m502vmqsh/WQAyDiuCA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="392586728"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200";
   d="scan'208";a="392586728"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 07:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="752279641"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200";
   d="scan'208";a="752279641"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2023 07:51:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qEWVp-000cvg-1B;
	Wed, 28 Jun 2023 17:51:17 +0300
Date: Wed, 28 Jun 2023 17:51:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [RFC PATCH 6/8] ASoC: Intel: avs: Update PCI ID list
Message-ID: <ZJxI5cX6hLaBRC6w@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-7-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-7-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: BCEM5FHLZR5BU4HZR7YEYNQYUSE4MB34
X-Message-ID-Hash: BCEM5FHLZR5BU4HZR7YEYNQYUSE4MB34
X-MailFrom: andriy.shevchenko@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BCEM5FHLZR5BU4HZR7YEYNQYUSE4MB34/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jun 28, 2023 at 10:51:33PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header. Adjust AVS_MACH_ENTRY macro,

AVS_MACH_ENTRY()

> so device id can be provided in short form.

ID

...

>  #define AVS_MACH_ENTRY(_id, _mach) \
> -	{ .id = (_id), .machs = (_mach), }
> +	{ .id = PCI_DEVICE_ID_INTEL_HDA_##_id, .machs = (_mach), }

I would duplicate HDA in all entries below in order to be compatible with
PCI_DEVICE_DATA() (logically, so if I grep for one, I grep exactly for
everything after PCI_DEVICE_ID_INTEL_ prefix and these won't show up.

-- 
With Best Regards,
Andy Shevchenko


