Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DF8C77B73
	for <alsa-devel@archiver.kernel.org>; Mon,  8 May 2023 14:04:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C061B1237;
	Mon,  8 May 2023 16:03:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C061B1237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683554649;
	bh=oZ3i7hfghLI6aro0Y/k8Mn55x2L6O1ripjY3vQcbkhU=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rYsPwUkLf1IzteHtTKqV8WMvQKssUVaofIh0Wy4cIDg9K4TM3taqM+5uFCMgRLSV7
	 5wvtc+9SscN1cGuqk4Jtk7z+srECtrOkaykL94cMp/vJtqf1mXawMLTYCSJQClNg6v
	 XGYY//J4k0QFFSEdKzZrDToCbaCkcTU2S+yR/D3w=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6235F8032D;
	Mon,  8 May 2023 16:02:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15CBFF8032D; Mon,  8 May 2023 16:02:50 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C2D65F8014C
	for <alsa-devel@alsa-project.org>; Mon,  8 May 2023 16:02:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2D65F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cqqo4lqO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683554565; x=1715090565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZ3i7hfghLI6aro0Y/k8Mn55x2L6O1ripjY3vQcbkhU=;
  b=cqqo4lqOYhBTot3XEvqSWfGhQladkdvaHEsfYSQN6xKSHIWIUN41sr3K
   QQahSzkIvXvs6/5+Z83obXnAIWX9uok+EGcTb0JxP6RNL7ktNjtaShXgT
   wVzoaRK0y+1N+yqpgL46h6CeLnh2ydV0v0TyiqcS+qYN8zVAay7LQpWIf
   JBwtuaxpU4X1LguxoFNx/tp4JrqL1pgkE9Bue9wFMUMi7IWVj+BWtmqt1
   yQbX/GsSC3xls+h5Tlzk8ti+b16JjloZhC1BCmJN5a/bmWqrtNsoB5gJK
   6mu4CTNqsX6U3u3GFpPTjl/K5LUQ9nSiBSm0SYPm/lvm92unZltQB1asx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="330013707"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200";
   d="scan'208";a="330013707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 07:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="788104121"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200";
   d="scan'208";a="788104121"
Received: from jarava-mobl1.amr.corp.intel.com (HELO [10.255.228.217])
 ([10.255.228.217])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 07:01:14 -0700
Message-ID: <cfb75ee6-f290-4f59-df3b-9acea986357f@linux.intel.com>
Date: Mon, 8 May 2023 08:59:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] soundwire: intel: Make DEV_NUM_IDA_MIN a module param
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
References: <20230508103901.7840-1-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230508103901.7840-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: VJQFAMD335EY3YE2WWWGLOU4OD6IPGA5
X-Message-ID-Hash: VJQFAMD335EY3YE2WWWGLOU4OD6IPGA5
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VJQFAMD335EY3YE2WWWGLOU4OD6IPGA5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/8/23 05:39, Richard Fitzgerald wrote:
> Add a module param so that globally-unique peripheral ID
> allocation is only enabled if wanted.
> 
> The globally-unique IDs were introduced by
> commit c60561014257
> ("soundwire: bus: allow device number to be unique at system level")
> 
> and
> commit 1f2dcf3a154a ("soundwire: intel: set dev_num_ida_min")
> 
> Assigning globally-unique IDs limits the total number of
> peripherals in a system, and the above two commits limit to a
> maximum of 8 peripherals. We now have hardware with more than
> 8 peripherals in total, so this limit is a problem. As the
> original commit says that it is only for debug it can be made
> optional.
I think it's a misunderstanding, the introduction of these IDs was
related to hardware programming sequences, not just debug.

I'll talk to Richard on this, please do not apply this patch for now.

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/intel_auxdevice.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
> index b21e86084f7b..9ebbf652e47a 100644
> --- a/drivers/soundwire/intel_auxdevice.c
> +++ b/drivers/soundwire/intel_auxdevice.c
> @@ -23,8 +23,13 @@
>  #include "intel.h"
>  #include "intel_auxdevice.h"
>  
> -/* IDA min selected to avoid conflicts with HDaudio/iDISP SDI values */
> -#define INTEL_DEV_NUM_IDA_MIN           4
> +/*
> + * sdw_dev_num_min: Set to non-zero to enable globally-unique peripheral IDs.
> + * The value is the minimum ID that will be allocated.
> + */
> +static int intel_dev_num_ida_min;
> +module_param_named(sdw_dev_num_min, intel_dev_num_ida_min, int, 0444);
> +MODULE_PARM_DESC(sdw_dev_num_min, "SoundWire Intel Master min globally-unique ID (0 to disable)");
>  
>  #define INTEL_MASTER_SUSPEND_DELAY_MS	3000
>  
> @@ -148,7 +153,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
>  	cdns->msg_count = 0;
>  
>  	bus->link_id = auxdev->id;
> -	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
> +	bus->dev_num_ida_min = intel_dev_num_ida_min;
>  	bus->clk_stop_timeout = 1;
>  
>  	sdw_cdns_probe(cdns);
