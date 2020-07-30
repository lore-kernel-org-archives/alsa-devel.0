Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B76C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:42:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F02207F5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NrXZ37vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F02207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1211A175F;
	Thu, 30 Jul 2020 10:41:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1211A175F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596098531;
	bh=f7whHtZSWi4zOVdLFRwadFNKuZUGA8Ok5GN+Dew+CCM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NrXZ37vMpIlufE19O0F+PVMepHBjZthGk4b/mKIax/9Lcjgd0Ewb9EZx30aaPJ6pz
	 jQsmBt6mq/lzSpheypw+UPvYeJcMziMh5FI9gY9+rbSnk/q3p/EEyjBhwtUMRX3RHb
	 SD+ug/k/TF/BngEcvPiS2JuyWiqb1UzG1PseWaxI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AF6FF8021C;
	Thu, 30 Jul 2020 10:41:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D988EF8021E; Thu, 30 Jul 2020 10:41:18 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 093B7F800C9
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 10:41:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 093B7F800C9
IronPort-SDR: GAmdpzm6YtKuWjMpSa94R4pWABipm2kE4lzR8uD4PaFxt9izoen4J7FacfNEgKtVQdZxTkHnmx
 2ZIqXg2uWe9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="216040358"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="216040358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 01:41:09 -0700
IronPort-SDR: rbKpV/B1Z7+Dqz1XsWN76n1nNT7gZylJ/EOiDhfngjZpDyBE4qGmNDDrN9Da5ahR1x5Ms/WScL
 R/H1csJg6SlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="304501983"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga002.jf.intel.com with ESMTP; 30 Jul 2020 01:41:04 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1k147c-004smT-2N; Thu, 30 Jul 2020 11:41:04 +0300
Date: Thu, 30 Jul 2020 11:41:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Brent Lu <brent.lu@intel.com>
Subject: Re: [PATCH v2 0/2] Add period size constraint for Atom Chromebook
Message-ID: <20200730084104.GE3703480@smile.fi.intel.com>
References: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Sam McNally <sammc@chromium.org>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Stuart <daniel.stuart14@gmail.com>, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
 Damian van Soelen <dj.vsoelen@gmail.com>
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

On Thu, Jul 30, 2020 at 04:13:33PM +0800, Brent Lu wrote:
> Two different constraints are implemented: one is in platform's CPU
> DAI to enforce period sizes which are already used in Android BSP. The
> other is in Atom Chromebook's machine driver to use 240 as period size.
> 
> Changes since v1:
> -Add comma at the end of media_period_size array declaration.

You missed my tags, any reason why?

-- 
With Best Regards,
Andy Shevchenko


