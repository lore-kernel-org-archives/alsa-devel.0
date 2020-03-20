Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26105C4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EE020784
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nn55aGf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EE020784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D063774C;
	Fri, 20 Mar 2020 19:18:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D063774C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584728331;
	bh=XNLZyfIwOWEmreDUmVOdzJzAdgQbc/HFSUuOQvKVZS4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nn55aGf0off2qdSMt+NOnTpAQ//zOq8koZ06WYHFgrSLN8cOt+gYSw5sO3UtQ78xV
	 m2wwIDKwgzWxqriSC9+F1ICQVgrHG/jV2mApJCRVl5y5nFriUgfza+4jRMihzEd6Bf
	 hYvOAVFjl4HzqqCJxFT7PSildBxLD9u70yNawZ74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42D9EF8015B;
	Fri, 20 Mar 2020 19:18:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21D97F800DD; Fri, 20 Mar 2020 19:18:00 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6689F800DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 19:17:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6689F800DD
IronPort-SDR: +FCI49hlTONtMMUegOB8uQgGimw4oTD8uIwCUK1S2Eite4iKT3ewP/CfpS0LRcb4R0Qn4R9+ME
 oxrkg4HqpBng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 11:17:54 -0700
IronPort-SDR: DDP/GIIyJJ19iIoNiPikDTqzpCLiEvcn3EZasMzS26QsrLJYpGZzzToJt3N8BmP4qUssLmTSV/
 L5p+doQnNwBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="392230359"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12])
 ([10.255.34.12])
 by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 11:17:51 -0700
Subject: Re: [PATCH 3/7] soundwire: intel: add mutex to prevent concurrent
 access to SHIM registers
To: Vinod Koul <vkoul@kernel.org>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-4-pierre-louis.bossart@linux.intel.com>
 <20200320134112.GC4885@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a989368c-5a57-a726-0816-2e389d733ae0@linux.intel.com>
Date: Fri, 20 Mar 2020 09:07:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320134112.GC4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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


>> diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
>> index 38b7c125fb10..568c84a80d79 100644
>> --- a/drivers/soundwire/intel.h
>> +++ b/drivers/soundwire/intel.h
>> @@ -15,6 +15,7 @@
>>    * @irq: Interrupt line
>>    * @ops: Shim callback ops
>>    * @dev: device implementing hw_params and free callbacks
>> + * @shim_lock: mutex to handle access to shared SHIM registers
>>    */
>>   struct sdw_intel_link_res {
>>   	struct platform_device *pdev;
>> @@ -25,6 +26,7 @@ struct sdw_intel_link_res {
>>   	int irq;
>>   	const struct sdw_intel_ops *ops;
>>   	struct device *dev;
>> +	struct mutex *shim_lock; /* protect shared registers */
> 
> Where is this mutex initialized? Did you test this...

Dude, we've been testing the heck out of SoundWire.

If you want to see the actual initialization it's in the intel_init.c code:

https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L231

And this was clearly stated in the cover letter:

"Reviewers might object that the code is provided without some required
initializations for mutexes and shim masks, they will be added as part
of the transition to sdw_master_device - still stuck as of 3/11."

