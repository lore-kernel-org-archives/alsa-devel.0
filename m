Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E97C282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:31:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FF020673
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CSlmm/8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FF020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 549BF1667;
	Fri, 10 Jan 2020 17:30:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 549BF1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578673891;
	bh=YsI2SqXVXbI+8uFaGs/N/7zfZyF8PbJCxjsxttorq/U=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CSlmm/8P62XHSxDncQd7JdHqGI/QY45MyWBnQgwjaa/QBuvnymbPt8K6dk99+V8nh
	 QhbcmRWHyTBhu1kG0NQOm9ansSMdR5kc1WpI2HM4zS8YHobFd5oFs0L6NAxwFJdfLc
	 WkBFC0YaDj5GKdFbJJkTp5EAVp1NTmLaXkqCJDxw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5D01F80116;
	Fri, 10 Jan 2020 17:30:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03B11F8011C; Fri, 10 Jan 2020 17:30:38 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E81EF800E4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 17:30:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E81EF800E4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 08:30:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; d="scan'208";a="224241394"
Received: from nehudak-mobl1.amr.corp.intel.com (HELO [10.251.145.164])
 ([10.251.145.164])
 by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 08:30:30 -0800
To: Vinod Koul <vkoul@kernel.org>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-3-pierre-louis.bossart@linux.intel.com>
 <20200110064838.GY2818@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a18c668f-4628-0fb9-ffa0-b24cdad1cc8b@linux.intel.com>
Date: Fri, 10 Jan 2020 10:30:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110064838.GY2818@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>,
 tiwai@suse.de, gregkh@linuxfoundation.org,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: stream: update state
 machine and add state checks
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


>> -  int sdw_prepare_stream(struct sdw_stream_runtime * stream);
>> +  int sdw_prepare_stream(struct sdw_stream_runtime * stream, bool resume);
> 
> so what does the additional argument of resume do..?
> 
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index 178ae92b8cc1..6aa0b5d370c0 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -1553,8 +1553,18 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
> 
> and it is not modified here, so is the doc correct or this..?

the doc is correct and the code is updated in

[PATCH 4/6] soundwire: stream: do not update parameters during 
DISABLED-PREPARED transition


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
