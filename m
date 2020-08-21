Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E1DC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:25:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236F7207C3
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="md17MHNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236F7207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AACF4167D;
	Fri, 21 Aug 2020 17:24:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AACF4167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598023502;
	bh=7eCZHt/xU6Zu+QHon5bzvhjbr4BrLH7JOuvrkVkL/Oc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=md17MHNBXEyN5E70GLKL97B3QUUp+NiRu373YnuJW9gVxCk6CF0jEoywfh650Vb6G
	 1RMLExTULgduHW7PNZZzr5O3FEIhk0WcACSrmGSdAvu5B+L6jtF5Qj4SfvozbIf1nV
	 5W/ofRHiNA96xtIzUfPja1shrS4YqwSU8eucrIo4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C718F800D3;
	Fri, 21 Aug 2020 17:24:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7086F80218; Fri, 21 Aug 2020 17:24:10 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94610F800D3
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 17:23:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94610F800D3
IronPort-SDR: fk4hwS58k2Z7FwOk6VcD0JnOP2jXvrL11eWgy1upO5IISIwFXJ3SyvjwI6aupRO4pl9RfRZTEA
 pzBlpouhjLnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="135094336"
X-IronPort-AV: E=Sophos;i="5.76,337,1592895600"; d="scan'208";a="135094336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 08:23:56 -0700
IronPort-SDR: zr1zjNdR2ZfsTBqk29XtWieg4LINsD0s6fmv+QUtyUtLdXM233ywWMMaCMB17PU9sMFN2bIyZ2
 BH/PZ1xhLQ+Q==
X-IronPort-AV: E=Sophos;i="5.76,337,1592895600"; d="scan'208";a="442379328"
Received: from pcmiller-mobl1.amr.corp.intel.com (HELO [10.209.120.121])
 ([10.209.120.121])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 08:23:54 -0700
Subject: Re: [PATCH] soundwire: intel: fix CONFIG_PM and CONFIG_PM_SLEEP
 confusion
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20200820140441.9478-1-yung-chuan.liao@linux.intel.com>
 <20200821050159.GH2639@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cab31891-15bf-4ae2-44dd-ae33de4eb4ed@linux.intel.com>
Date: Fri, 21 Aug 2020 10:23:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821050159.GH2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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



>> When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:
>>
>> drivers/soundwire/intel.c:1816:12: warning: ‘intel_resume’ defined but
>> not used [-Wunused-function]
>>   1816 | static int intel_resume(struct device *dev)
>>        |            ^~~~~~~~~~~~
>>
>> drivers/soundwire/intel.c:1697:12: warning: ‘intel_suspend’ defined
>> but not used [-Wunused-function]
>>   1697 | static int intel_suspend(struct device *dev)
>>
>> Fix by adding the missing CONFIG_PM_SLEEP.
> 
> Can you rather use __maybe for for these rather than wrapping in another
> ifdef, that is the recommended way to do this

No objections, that would work as well.
