Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30DCC6FD1F
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:01:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30E9123D6;
	Tue, 26 Mar 2024 16:01:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30E9123D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711465289;
	bh=qUUvhGe91HR/wsvtB7K0cyzfk4u4vLEk2tLsleCKi1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hKnPUdp9j1O+pp0KC0Ev7e942feJyxPTCHfhMhDV7ccEN3ORM0VEU/5a5VUAOP+7n
	 GLS7FK1aBo53+SGuyxl+HSN9MhwKeulW62qPQh+pUv3W93buZS68Xs2P064/aHNVAN
	 woXNbuwEW5tpHqWHGjiSQkV5vzOvAAy8NCTwmAcc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E69E1F80579; Tue, 26 Mar 2024 16:00:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F4171F8057A;
	Tue, 26 Mar 2024 16:00:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D055F8025F; Tue, 26 Mar 2024 16:00:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5CA54F801D5
	for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2024 16:00:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CA54F801D5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JZM3qHE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711465230; x=1743001230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qUUvhGe91HR/wsvtB7K0cyzfk4u4vLEk2tLsleCKi1Q=;
  b=JZM3qHE746R0LsLxLFitKqHGFUnoHKQokRC5WohnFmfunyfiZFmSwhBi
   7kR/DbHEMvjVnCw7WudNEN2grdqmTZLVoq5UoGWBzjF/59D04W7PC2V2Z
   A1qDMD11V3Cqf0Se5XatX4EFH2w4+qsl/AlVDmb/HpSlQ+MdoLbcrB+js
   uylCnNPBR0K+SsuUzjg8HWgqvJXVpBTr+GDK7F6bTgUruthgpFl+Yrj76
   8/dRCfC4kcTxKwuqyD3LrAyu9cvCRxiyNinJkRWlaJQUOdV4BIuGfD5Fo
   bARBL+Epa5e63sR2jdVpogoIkFegPoAOzKzHmSBcxoLyo3QRv/6fpNE91
   g==;
X-CSE-ConnectionGUID: b6sLBLEbRU6hiQb9nbKtIA==
X-CSE-MsgGUID: PvHrgCcwS5akMmqBSxC6RA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6414840"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000";
   d="scan'208";a="6414840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 08:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882655"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000";
   d="scan'208";a="914882655"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 08:00:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8Hj-0000000GKif-1YRd;
	Tue, 26 Mar 2024 17:00:19 +0200
Date: Tue, 26 Mar 2024 17:00:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v1 2/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Message-ID: <ZgLjAz99JZQvrx_h@smile.fi.intel.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
 <20240326010905.2147-2-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326010905.2147-2-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: AWKAHJNI2FLS5YZQWBEOMWEXXJPLAMDT
X-Message-ID-Hash: AWKAHJNI2FLS5YZQWBEOMWEXXJPLAMDT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AWKAHJNI2FLS5YZQWBEOMWEXXJPLAMDT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Mar 26, 2024 at 09:08:59AM +0800, Baojun Xu wrote:
> Add TXNW2781 support in smi.

Same comment WRT the commit message.

I'm wondering why the patch 1&2 can't be folded...
If this should go separate, with the commit message fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


