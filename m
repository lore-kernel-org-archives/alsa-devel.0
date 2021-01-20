Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E251C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 22:29:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD162220B
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 22:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD162220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C7201762;
	Wed, 20 Jan 2021 23:28:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C7201762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611181778;
	bh=YehWsBvz02Ie/mkFcxkwZtY6qgTTaA6FZKfzUfFSejU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvB8/pBzYs6P7Oqv9K//x01+6uDPqTHZZR3f2hm9Jp7ak6Q+ksYY6TD2EXUCLvwDT
	 4uoKGwTvOkIU0kZtKzMzmIQSCsbobEBxu2D9ONlaSrl3xiF47fhh6AJDvDHzs/yMR1
	 gDCYj5k0pPbqPxrwQRU0FmMMr5a+TQsr3y2nRIks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9677AF80166;
	Wed, 20 Jan 2021 23:28:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E9EFF8016E; Wed, 20 Jan 2021 23:28:37 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0CE5F8012C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 23:28:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0CE5F8012C
IronPort-SDR: n4H1gvzgntXb2jrkmQs45OWNe9hYzah/svesFwRghHlgVdAvDSgXGUX0NIO1kLnPKUWOHxV+op
 0moEdHQ3rweA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="263999021"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; d="scan'208";a="263999021"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 14:28:26 -0800
IronPort-SDR: A3l+tWrwWD2lDdIHZ9JWJZ3mi0uI5w+xME/wG0yHTwQSnfHvUyJXlZ1Iok3hN6IWeVOo8LrCfu
 aLZ3Uc8uqs2g==
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; d="scan'208";a="356220083"
Received: from bmetsx-mobl1.amr.corp.intel.com (HELO [10.209.108.15])
 ([10.209.108.15])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 14:28:25 -0800
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
Date: Wed, 20 Jan 2021 16:28:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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




>> Linux 5.10 fails to boot on my IceLake laptop, where 5.9 worked fine.
>> I'm not sure whether it's a bug in ACPI or Soundwire subsystem, so I'm
>> sending this to both
>> lists. The W taint flag is because of an unrelated nouveau failure (It
>> was busted on 5.9, and is
>> still on 5.10). Full kernel log down below.
>> It's from a distro kernel, but I can build my own kernel with patches if needed.
> 
> Please try to add a check for handle against NULL to
> snd_intel_dsp_check_soundwire() after
> 
> handle = ACPI_HANDLE(&pci->dev);
> 
> and see if this makes any difference.
> 
> This should check handle against NULL anyway, even if it didn't crash later on.

Is there a way you can share the DSDT?

The only thing we do in that sdw_intel_acpi_scan() function is check for 
an _ADR and read two _DSD properties. I think it's been 2 years since we 
wrote it and never had an issue, never say never I guess...

If you want to bypass this problem for the time being, you can add a 
kernel option in /etc/modprobe.d/alsa-base.conf

options snd-intel-dspcfg dsp_driver=1

that will force the use of the HDaudio legacy driver and bypass the 
driver autodetection.
