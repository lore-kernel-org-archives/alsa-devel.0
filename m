Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B8BC4320A
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 14:45:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B8B60FF2
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 14:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22B8B60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22DB4172E;
	Mon,  2 Aug 2021 16:44:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22DB4172E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627915541;
	bh=ECJa5IMo++YDHoFuwruH/HxHgRkOQN/TrOhQF0zfi+A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=miaqmXxOgRS2hNtLF4WODV5U4wkKdP3uug6Iis6mu7qM0EZoX9TqyqKZk+/1kfOMc
	 L9hB0rNoMvqsk9HRLtuPmCIhocaOui8KzaVXMQDHvPyhOZRCpftFCpu1n7dqnBrWzA
	 SamnAA7DD50mG9rqkGTELebjwLduwhk1lFVjYSjA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B49D3F80271;
	Mon,  2 Aug 2021 16:44:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B404EF8026A; Mon,  2 Aug 2021 16:44:00 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85A28F800BF
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 16:43:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85A28F800BF
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="200640130"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="200640130"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 07:43:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="436685447"
Received: from skshirsa-mobl1.amr.corp.intel.com (HELO [10.209.189.56])
 ([10.209.189.56])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 07:43:51 -0700
Subject: Re: [PATCH 3/4] soundwire: intel: exit clock stop mode on system
 suspend
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20210727055608.30247-1-yung-chuan.liao@linux.intel.com>
 <20210727055608.30247-4-yung-chuan.liao@linux.intel.com>
 <YQd1C0QQMDNtzfAq@matsya>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <792f70bd-b4ae-e3a1-c37e-ba2913018d0b@linux.intel.com>
Date: Mon, 2 Aug 2021 09:24:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQd1C0QQMDNtzfAq@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 bard.liao@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>
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


>> +static int __maybe_unused intel_pm_prepare(struct device *dev)
>> +{
>> +	struct sdw_cdns *cdns = dev_get_drvdata(dev);
>> +	struct sdw_intel *sdw = cdns_to_intel(cdns);
>> +	struct sdw_bus *bus = &cdns->bus;
>> +	u32 clock_stop_quirks;
>> +	int ret = 0;
>> +
>> +	if (bus->prop.hw_disabled || !sdw->startup_done) {
>> +		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>> +			bus->link_id);
>> +		return 0;
>> +	}
>> +
>> +	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
>> +
>> +	if ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) ||
>> +	    !clock_stop_quirks) {
>> +		/*
>> +		 * Try to resume the entire bus (parent + child devices) to exit
>> +		 * the clock stop mode. If this fails, we keep going since we don't want
>> +		 * to prevent system suspend from happening and errors should be recoverable
>> +		 * on resume.
>> +		 */
>> +		ret = device_for_each_child(bus->dev, NULL, intel_resume_child_device);
>> +
>> +		if (ret < 0)
>> +			dev_err(dev, "%s: intel_resume_child_device failed: %d\n", __func__, ret);
>> +
>> +		/*
>> +		 * in the case where a link was started but does not have anything connected,
>> +		 * we still need to resume to keep link power up/down sequences balanced.
>> +		 * This is a no-op if a child device was present, since resuming the child
>> +		 * device would also resume the parent
>> +		 */
>> +		ret = pm_request_resume(dev);
> 
> I am not sure of this patch yet, maybe I am comprehending it..
> 
> 1. In above you are calling resume of child devices first and then intel
> device, which sounds reverse, should you not resume intel device first
> and then child (codec devices) ?
> 
> 2. What about when resume is invoked by the core for the child devices.
> That would be called in the PM resume flow, so why do it here?

I realize it's a complicated sequence, it took us multiple phases to get
it right. There are multiple layers between power domain, bus and driver.

The .prepare phase happens before the system suspend phase. Unlike
suspend, which progresses from children to parents, the .prepare is
handled parent first.

When we do a request_resume of the child device, by construction that
also resumes the parent. In other words, if we have multiple codecs on a
link, the first iteration of device_for_each_child() will already resume
the parent and the first device, and the second iteration will only
resume the second device.

What this step does is make sure than when the codec .suspend routine is
invoked, the entire bus is already back to full power. I did check
privately with Rafael (CC:ed) if this sequence was legit.

We did consider modifying the system suspend callback in codec drivers,
so that we would do a pm_runtime resume(). This is functionally
equivalent to what we are suggesting here, but we decided not to do so
for two main reasons

a) lots of code changes across all codecs for an Intel-specific issue

b) we would need to add a flag so that codec drivers would know in which
Intel-specific clock-stop mode the bus was configured. That's not so
good either.

It seemed simpler to use to add this .prepare step and test on the Intel
clock stop mode before doing a pm_runtime_resume for all codecs.

> 
>> +		if (ret < 0)
>> +			dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int __maybe_unused intel_suspend(struct device *dev)
>>  {
>>  	struct sdw_cdns *cdns = dev_get_drvdata(dev);
>> @@ -1923,6 +1987,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
>>  }
>>  
>>  static const struct dev_pm_ops intel_pm = {
>> +	.prepare = intel_pm_prepare,
>>  	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
>>  	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
>>  };
>> -- 
>> 2.17.1
> 
