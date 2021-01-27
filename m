Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E2BC43381
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:39:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B5F64DA0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B5F64DA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A35D16FF;
	Wed, 27 Jan 2021 18:38:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A35D16FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611769155;
	bh=ejSVIa1337YHKZ6Qtegw2vyw8LAyhZdJiuvitgbGKMc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XNfgs3YrUihH+WrK8xxjExv7M6id1IJSz1WhD7tIEg/mVWgUzymlshL1oFuuvrDHQ
	 0Z1sZQrDCrl7gOIwnkoMTLzqGdXXPgnC/sAEVwkgd87mrpIOKjMeDddj3BPchBKkNV
	 TY14m6uYgLWGJ6RINa8nyvd3V1t+xUAU42cFe1ao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A90BF800F0;
	Wed, 27 Jan 2021 18:29:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D88DF80259; Wed, 27 Jan 2021 18:28:45 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A2A5F800E9
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 18:28:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A2A5F800E9
IronPort-SDR: SWn+iKInKtDeghr4j99k5cvAmSY4UHgohZAhId7KaI1w79vQOIsMFblCWwL2cIX+C/5sc32l8z
 IFEIldPJSgOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167777438"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; d="scan'208";a="167777438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 09:28:27 -0800
IronPort-SDR: hqDu3WS98TI7yoUuuPLr0IGqC4vI5OKQ7KDoEZ5zKepMYEJUbi+SCSgN8H+T+Y0GJ4Se7+wqZW
 RYnh0wazBLIA==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; d="scan'208";a="388402900"
Received: from susiezhx-mobl.amr.corp.intel.com (HELO [10.213.180.238])
 ([10.213.180.238])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 09:28:27 -0800
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To: =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
 <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com>
Date: Wed, 27 Jan 2021 11:28:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Len Brown <lenb@kernel.org>
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




> Weird, I can't reproduce this problem with my self-compiled kernel :/
> I don't even see soundwire modules loaded in. Manually loading them of course
> doesn't do much.
> 
> Previously I could boot into the "faulty" kernel by using "recovery mode", but
> I can't do that anymore - it crashes too.
> 
> Maybe there's some kind of race and this bug depends on some specific
> ordering of events?

missing Kconfig?
You need CONFIG_SOUNDWIRE and CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE 
selected to enter this sdw_intel_acpi_scan() routine.

