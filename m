Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9867AC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 18:16:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621A264DE1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 18:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621A264DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5CB5170B;
	Mon,  1 Feb 2021 19:15:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5CB5170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612203369;
	bh=GaxfMq1OoxWW4mx++VdIfovDeWlvU/1bUZStLD9k5PA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oB+3ppZgEDpu3CDJzW1KJz1rqAXHYF5PG8YkFmAFdXjDzvLuoPHCMb2/kYRoYjKrw
	 fFNyAYRtllkC7wWhnPdFYJWEN0PnwmOC38qXpd1OnH8e9SFVrP3EzUjNF/rrllxFZ9
	 jGSTQb4tCfYauaypZsd9NDboXS2XXn+mFY8MQElQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14142F80264;
	Mon,  1 Feb 2021 19:13:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8092F801DB; Mon,  1 Feb 2021 19:13:38 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9A47F80151
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 19:13:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9A47F80151
IronPort-SDR: wW+xhjzVukXy+P5luBJVwj93E+OuLlaO8Rw4TRc8cM70h3jaxb1nUaC9Ic3AJ1YYP2UsgoUucQ
 DiHrmOHhNSqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167833501"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="167833501"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:13:23 -0800
IronPort-SDR: YaexhowrX58cGW5Z/SvbLYYQls9i/sLfs+0sE7by42KAMEA666T5cZYT/LIzdos1aFkFmF+LQE
 txYpvk/Quzmg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="412516907"
Received: from dkhaldi-mobl1.amr.corp.intel.com (HELO [10.212.126.61])
 ([10.212.126.61])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:13:22 -0800
Subject: Re: [PATCH 2/3] soundwire: intel: add
 SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH quirk
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-3-yung-chuan.liao@linux.intel.com>
 <20210201104229.GY2771@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0ed1c91b-09ca-dc6f-39d1-850d12f4f9c4@linux.intel.com>
Date: Mon, 1 Feb 2021 10:20:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201104229.GY2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org, jank@cadence.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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



On 2/1/21 4:42 AM, Vinod Koul wrote:
> On 26-01-21, 16:37, Bard Liao wrote:
>> There is nothing we can do to handle the bus clash interrupt before
>> interrupt mask is enabled.
>>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index a2d5cdaa9998..f7ba1a77a1df 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1286,6 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>>   	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
>>   		prop->hw_disabled = true;
>>   
>> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
> 
> Should this not be last 'enabling' the quirk patch in series :)

Sorry, I don't understand the comment. Do you mind clarifying Vinod?
