Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06DBC433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 18:44:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19495610A5
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 18:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19495610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C80316A2;
	Thu,  1 Apr 2021 20:44:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C80316A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617302696;
	bh=87PhwuI2U2Hgp0sxc3dSOuuCl0s6Hza5UVFguDYCOPg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJpDs0rbHFfFa/ilMrKbswF0f5fSBHXbAGjecnqCzkD4ohAD8+MdVtzyLOFRBsyrt
	 YL4drNFJFzCD19SQp7AotWyUitesE+nbjVwjYy2rYPvRXsh5aB/7dS0hv7bhmQ7m+e
	 7wSnC+K0fEL0aEjVGS4Ww8fvj3pcWBJh1d5YEkUE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AA7CF8013C;
	Thu,  1 Apr 2021 20:44:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBFDFF8026B; Thu,  1 Apr 2021 20:44:03 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C55F7F8013C
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 20:43:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C55F7F8013C
IronPort-SDR: WYLhruU+oCByvCam/LdUoXh7i5pzDFFO6P3edyKww6l5Yv/SMe6o9XWop2BL7bXfcGv1k7TBsW
 Bx/z99vS6GcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179441592"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="179441592"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 11:43:56 -0700
IronPort-SDR: XJBnaXm9h/BWh45aFK0GTo2R4IxM5/A3Xo6knAgunzHIBxvkdZt8F2zLF4Z/kJc3P5M0pneP18
 dCqZmHCspH7g==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="439323382"
Received: from vhsalasl-mobl.amr.corp.intel.com (HELO [10.255.229.235])
 ([10.255.229.235])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 11:43:54 -0700
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
 <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
 <0834b9fc-9b3a-1184-fed2-6f9c7e66c6fb@linux.intel.com>
 <YGX5AUQi41z52xk8@kroah.com>
 <81c6b53b-e3fb-32d0-1e99-365d87ab6524@linux.intel.com>
 <YGYQIJh8X2C8sW44@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <28515962-6fb1-511d-fc6b-f1422b11e6ab@linux.intel.com>
Date: Thu, 1 Apr 2021 13:43:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGYQIJh8X2C8sW44@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 hui.wang@canonical.com, Vinod Koul <vkoul@kernel.org>, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
 bard.liao@intel.com
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


>>> My bigger issue with this is that this macro is crazy.  Why do you need
>>> debugging here at all for this type of thing?  That's what ftrace is
>>> for, do not sprinkle code with "we got this return value from here!" all
>>> over the place like what this does.
>>
>> We are not sprinkling the code all over the place with any new logs, they
>> exist already in the SoundWire code and this patch helps filter them out.
>> See e.g. patch 2/2
>>
>> -			dev_err(&slave->dev,
>> -				"Clk Stop type =%d failed: %d\n", type, ret);
>> +			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
>> +					   "Clk Stop mode %d type =%d failed: %d\n",
>> +					   mode, type, ret);
> 
> You just added a debug log for no reason.

The number of logs is lower when dynamic debug is not enabled, and equal 
when it is. there's no addition.

The previous behavior was unconditional dev_err that everyone sees.

Now it's dev_err ONLY when the code is NOT -ENODATA, and dev_dgb 
otherwise, meaning it will seen ONLY be seen IF dynamic debug is enabled 
for drivers/soundwire/bus.c

Allow me to use another example from patch2:

-		if (ret == -ENODATA)
-			dev_dbg(bus->dev,
-				"ClockStopNow Broadcast msg ignored %d", ret);
-		else
-			dev_err(bus->dev,
-				"ClockStopNow Broadcast msg failed %d", ret);
+		sdw_dev_dbg_or_err(bus->dev, ret != -ENODATA,
+				   "ClockStopNow Broadcast msg failed %d\n", ret);

There's no new log, is there?

If that still gives you a heartburn, I would still like a macro that 
filters out dev_err so that we don't report an error when it's 
recoverable or harmless, and don't have spaghetti code as above.

