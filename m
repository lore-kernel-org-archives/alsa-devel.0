Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F80C4BA13
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:39:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD3220656
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="To5hNA/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD3220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CF071616;
	Wed, 26 Feb 2020 17:38:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CF071616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582735141;
	bh=YQDMakzKkwIwb2i/m5HHcukmQxJFQ48650m7wR+rLnI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=To5hNA/jhOyCxuIk6aLMxnR1rRD30S/lVr3wr1s0WtVHdcYCgvIIzl82MahEUfXSt
	 XrG8e9CUH6IZZZORFMJKQ6bkohfvwIhOrAzeentGZ8BrgOg6kpORC70Fp8sKCGNFXB
	 eUwsuQqLbuMxkoPV826uR5zFexlfPX20pB7vTLT0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82DE9F8016F;
	Wed, 26 Feb 2020 17:38:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 622CFF8016F; Wed, 26 Feb 2020 17:38:09 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E4FCF80089
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 17:38:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E4FCF80089
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2020 08:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; d="scan'208";a="410671937"
Received: from nkaburla-mobl.amr.corp.intel.com (HELO [10.252.133.245])
 ([10.252.133.245])
 by orsmga005.jf.intel.com with ESMTP; 26 Feb 2020 08:38:01 -0800
Subject: Re: [PATCH] soundwire: bus: provide correct return value on error
To: Vinod Koul <vkoul@kernel.org>
References: <20200225164907.23358-1-pierre-louis.bossart@linux.intel.com>
 <20200226080326.GU2618@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <69a06304-c869-0539-0c85-9ab154807269@linux.intel.com>
Date: Wed, 26 Feb 2020 08:54:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226080326.GU2618@vkoul-mobl>
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



On 2/26/20 2:03 AM, Vinod Koul wrote:
> On 25-02-20, 10:49, Pierre-Louis Bossart wrote:
>> From: Bard Liao <yung-chuan.liao@linux.intel.com>
>>
>> It seems to be a typo. It makes more sense to return the return value
>> of sdw_update() instead of the value we want to update.
>>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index 13887713f311..b8a7a84aca1c 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -1070,7 +1070,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>>   	if (ret < 0) {
>>   		dev_err(slave->bus->dev,
>>   			"SDW_DP0_INTMASK read failed:%d\n", ret);
>> -		return val;
>> +		return ret;
> 
> good catch. But can we optimize it to:
>>   	}
>>   
>>   	return 0;
> 
> make this as below and remove the return above.

ok, will resend as v2.
