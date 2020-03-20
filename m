Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206CBC4332D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:19:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71F920777
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N1ub894c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71F920777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA89584B;
	Fri, 20 Mar 2020 19:18:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA89584B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584728385;
	bh=EFpNo78qEyH+kVEhD2U177npZzS68zLpDOYo9Q73y9U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1ub894c58FdDIGiGUKSLoCsREZO91NprGB/Zx8S4idmZDupxiddPaT43dfeqXCIH
	 6lpSU3a7M/zxb6dVZm3WdaEQvekSfsW2uIGMPUl8JsIWXGnD1xZwS6YMuG7YUfLcBc
	 gwWBYmlLfB9r0dU1Gnfof9G8PN2D/oY/6YO+2g8k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49D6AF80126;
	Fri, 20 Mar 2020 19:18:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 849C4F80212; Fri, 20 Mar 2020 19:18:02 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD813F800C0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 19:17:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD813F800C0
IronPort-SDR: yCG/CbJodmFOgOojZV14hQbho7U4A2Bvqm8rcrVvvcXSTXDy/MOZ9Q1njLYBFjcChN/ZPzpfDV
 1hZmxl/xyZZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 11:17:57 -0700
IronPort-SDR: HPoo2BfGTeZXfc2JvSXi6Z+H8E5VFos3SyAL5VyFs45GdE0BcEUeHr4+yMjje42acXjshnw6Wy
 KrQAsIKwXA1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="392230366"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12])
 ([10.255.34.12])
 by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 11:17:55 -0700
Subject: Re: [PATCH 4/7] soundwire: intel: add definitions for shim_mask
To: Vinod Koul <vkoul@kernel.org>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-5-pierre-louis.bossart@linux.intel.com>
 <20200320134257.GD4885@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <deeb3af8-e950-651c-50d6-6223e75801e9@linux.intel.com>
Date: Fri, 20 Mar 2020 09:13:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320134257.GD4885@vkoul-mobl>
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
>> index 568c84a80d79..cfc83120b8f9 100644
>> --- a/drivers/soundwire/intel.h
>> +++ b/drivers/soundwire/intel.h
>> @@ -16,6 +16,7 @@
>>    * @ops: Shim callback ops
>>    * @dev: device implementing hw_params and free callbacks
>>    * @shim_lock: mutex to handle access to shared SHIM registers
>> + * @shim_mask: global pointer to check SHIM register initialization
>>    */
>>   struct sdw_intel_link_res {
>>   	struct platform_device *pdev;
>> @@ -27,6 +28,7 @@ struct sdw_intel_link_res {
>>   	const struct sdw_intel_ops *ops;
>>   	struct device *dev;
>>   	struct mutex *shim_lock; /* protect shared registers */
>> +	u32 *shim_mask;
> 
> You have a pointer, okay where is it initialized

same answer as shim_lock, it's initialized at the higher level

https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L252


>>   };
>>   
>>   #endif /* __SDW_INTEL_LOCAL_H */
>> diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
>> index 979b41b5dcb4..120ffddc03d2 100644
>> --- a/include/linux/soundwire/sdw_intel.h
>> +++ b/include/linux/soundwire/sdw_intel.h
>> @@ -115,6 +115,7 @@ struct sdw_intel_slave_id {
>>    * links
>>    * @link_list: list to handle interrupts across all links
>>    * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
>> + * @shim_mask: flags to track initialization of SHIM shared registers
>>    */
>>   struct sdw_intel_ctx {
>>   	int count;
>> @@ -126,6 +127,7 @@ struct sdw_intel_ctx {
>>   	struct sdw_intel_slave_id *ids;
>>   	struct list_head link_list;
>>   	struct mutex shim_lock; /* lock for access to shared SHIM registers */
>> +	u32 shim_mask;
> 
> And a integer, question: why do you need pointer and integer, why not
> use only one..?

You may have missed that the structures are different.

the sdw_intel_ctx is global for all links, so that the shim_mask integer 
value.
the sdw_intel_link_res is link-specific and use a pointer to the same 
shim_mask value, protected by shim_lock.





