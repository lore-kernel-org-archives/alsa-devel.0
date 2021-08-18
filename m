Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F28C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 15:54:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F14B610CB
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 15:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F14B610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 258FB1689;
	Wed, 18 Aug 2021 17:53:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 258FB1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629302074;
	bh=/cFeLxIcORYWfMb4lFDFWgsSv47qFWEqIAvu7VX11vk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hE49+1xzUw0DHm7v1bbtOywwDjqA2L+EPPOqZjJpPjTcLeAY4QlOraMi0GPT7vu2l
	 TVucRRKGsXahHvVIuWCTXJ+dW/7y5ldulEGr7Hquh9fV1Jw6yTsv4o1x1exucFVH77
	 U+1RYeIityuIE8ASyqR3jIV1sYKlLBPmWmmiiKAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6033F800EC;
	Wed, 18 Aug 2021 17:53:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3642AF80249; Wed, 18 Aug 2021 17:53:42 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04929F80169
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 17:53:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04929F80169
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="301943190"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="301943190"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 08:53:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="449809140"
Received: from ksawchu-mobl.amr.corp.intel.com (HELO [10.212.83.236])
 ([10.212.83.236])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 08:53:09 -0700
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com> <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com> <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
 <YR0nAcC3wJd3b4Vu@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
Date: Wed, 18 Aug 2021 10:53:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR0nAcC3wJd3b4Vu@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 vkoul@kernel.org, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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




>> a) we have to use request_module()
> 
> Wait, why?
> 
> module loading is async, use auto-loading when the hardware/device is
> found and reported to userspace.  Forcing a module to load by the kernel
> is not always wise as the module is not always present in the filesystem
> at that point in time at boot (think modules on the filesystem, not in
> the initramfs).
> 
> Try fixing this issue and maybe it will resolve itself as you should be
> working async.

It's been that way for a very long time (2015?) for HDAudio support, see
sound/pci/hda/hda_bind.c. It's my understanding that it was a conscious
design decision to use vendor-specific modules, if available, and
fallback to generic modules if the first pass failed.

Takashi, you may want to chime in...




