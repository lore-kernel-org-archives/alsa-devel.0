Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBCAC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:33:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3423B206BE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hhRDZU1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3423B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63C6D184E;
	Fri, 13 Mar 2020 18:32:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63C6D184E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584120812;
	bh=RyITYV+25S7evSPVd77NnfLjmCEIjFet/Qu385EdOBw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hhRDZU1C5xSBbHR3BwcriBDGhBeRPtdxy48AOhhz4XoU6UPeZQvZZAw7BMcsr25vk
	 KiUOnR3cuVSXNYjFRXhWYcFSJAPnjBBHEb8ne7dQEUs1hL+FlI3pW8c3hnyp/mJWCf
	 kp7Rnpf1MnRg9FrRV7PePsprFLMyvhBculzkMO9g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E577F802D2;
	Fri, 13 Mar 2020 18:29:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36363F802C2; Fri, 13 Mar 2020 18:29:21 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB6E1F802BE
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 18:29:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB6E1F802BE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 10:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; d="scan'208";a="237017325"
Received: from sblancoa-mobl.amr.corp.intel.com (HELO [10.251.232.239])
 ([10.251.232.239])
 by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2020 10:29:13 -0700
Subject: Re: [PATCH 04/16] soundwire: cadence: handle error cases with
 CONFIG_UPDATE
To: Vinod Koul <vkoul@kernel.org>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-5-pierre-louis.bossart@linux.intel.com>
 <20200313120855.GF4885@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <77c5b945-4738-f3fe-5e8f-9cffaf9a74c7@linux.intel.com>
Date: Fri, 13 Mar 2020 12:09:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313120855.GF4885@vkoul-mobl>
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



On 3/13/20 7:08 AM, Vinod Koul wrote:
> On 11-03-20, 13:41, Pierre-Louis Bossart wrote:
>> config_update() may time out or cannot be use in ClockStopMode
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 71cba2585151..4089c271305a 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -239,6 +239,11 @@ static int cdns_config_update(struct sdw_cdns *cdns)
>>   {
>>   	int ret;
>>   
>> +	if (sdw_cdns_is_clock_stop(cdns)) {
>> +		dev_err(cdns->dev, "Cannot program MCP_CONFIG_UPDATE in ClockStopMode\n");
> 
> This looks fine but duplicates the log, so maybe you can remove from
> here or preceding patch... Or use single line as I suggested in that
> patch and keep this as is.

It doesn't duplicate it. In Patch1 it's a dev_dbg log that's useful for 
integration, and that function is used in other places (see the 
soundwire:intel series).

In this patch this is a clear error leading to a master hang.
