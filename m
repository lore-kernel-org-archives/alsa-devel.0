Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10559C4320A
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 16:30:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC8B60FC1
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 16:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BC8B60FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F40F1725;
	Mon,  2 Aug 2021 18:29:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F40F1725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627921821;
	bh=tuN1jc+AGngQeSr1xZnNyYNX8LtLeb3q2B6XzZSLGsA=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SJhyNNbgZ9XLU7oM8lF9l+O5/yRE7i8fD8xrr0b/FCRHxS9Gkru3ZVEFpCH7Eobfj
	 Ts6E67IXKDv+SGYg5vc1PDlEhVaaHHHrq9b043XWU8fyV/n/5RpSzK5bjRxQvF/oyw
	 ojp3Ph2AIttWUVISCgZb5CkNS1+Dklcp1v7Iz8lU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48D00F801F7;
	Mon,  2 Aug 2021 18:29:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAF73F8025F; Mon,  2 Aug 2021 18:29:09 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A62CF80095
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 18:29:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A62CF80095
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="193083707"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="193083707"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 09:28:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="501877782"
Received: from skarumur-mobl.amr.corp.intel.com (HELO [10.212.72.192])
 ([10.212.72.192])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 09:28:57 -0700
Subject: Re: [PATCH 3/4] soundwire: intel: exit clock stop mode on system
 suspend
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20210727055608.30247-1-yung-chuan.liao@linux.intel.com>
 <20210727055608.30247-4-yung-chuan.liao@linux.intel.com>
 <YQd1C0QQMDNtzfAq@matsya>
 <792f70bd-b4ae-e3a1-c37e-ba2913018d0b@linux.intel.com>
Message-ID: <2b7f632d-e8b2-7a14-54c6-86d19ca4ba01@linux.intel.com>
Date: Mon, 2 Aug 2021 11:28:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <792f70bd-b4ae-e3a1-c37e-ba2913018d0b@linux.intel.com>
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




>> 1. In above you are calling resume of child devices first and then intel
>> device, which sounds reverse, should you not resume intel device first
>> and then child (codec devices) ?
>>
>> 2. What about when resume is invoked by the core for the child devices.
>> That would be called in the PM resume flow, so why do it here?
> 
> I realize it's a complicated sequence, it took us multiple phases to get
> it right. There are multiple layers between power domain, bus and driver.
> 
> The .prepare phase happens before the system suspend phase. Unlike
> suspend, which progresses from children to parents, the .prepare is
> handled parent first.
> 
> When we do a request_resume of the child device, by construction that
> also resumes the parent. In other words, if we have multiple codecs on a
> link, the first iteration of device_for_each_child() will already resume
> the parent and the first device, and the second iteration will only
> resume the second device.
> 
> What this step does is make sure than when the codec .suspend routine is
> invoked, the entire bus is already back to full power. I did check
> privately with Rafael (CC:ed) if this sequence was legit.
> 
> We did consider modifying the system suspend callback in codec drivers,
> so that we would do a pm_runtime resume(). This is functionally
> equivalent to what we are suggesting here, but we decided not to do so
> for two main reasons
> 
> a) lots of code changes across all codecs for an Intel-specific issue
> 
> b) we would need to add a flag so that codec drivers would know in which
> Intel-specific clock-stop mode the bus was configured. That's not so
> good either.
> 
> It seemed simpler to use to add this .prepare step and test on the Intel
> clock stop mode before doing a pm_runtime_resume for all codecs.

Note that we could invert the two parts and do a parent resume first,
and a loop for all children second. It's completely equivalent, but
might be less convoluted to understand without any implicit behavior
assumed.

	if ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) ||
	    !clock_stop_quirks) {

		/* resume parent first */
		ret = pm_request_resume(dev);
		if (ret < 0)
			dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);

		/*
		 * resume all children next.
		 * if there are no children on this link,
		 * this is a no-op
		 */
		ret = device_for_each_child(bus->dev, NULL, intel_resume_child_device);

		if (ret < 0)
			dev_err(dev, "%s: intel_resume_child_device failed: %d\n", __func__,
ret);
	}
	
