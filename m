Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73836C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:43:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA6D21775
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qInpVS70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA6D21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 439601764;
	Wed, 26 Aug 2020 16:42:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 439601764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598452987;
	bh=A6zRXyKRONItWgrS/9AZOekKIvRxyamYK3ii102zDvI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qInpVS70wz1n5DwzhgAWLHTuxcpqI8Evh1yXvh9Gh3AiQiBuGRGZ8zKLeMsmCrKQT
	 4PbMpOhCcdxedh/uhkGtfteK+JVEIGmvzNJ+twLBuEUEZbdrqUb7fsj0yxVljW1OKZ
	 OJAbPHQC0EYJFNDK9icW0BiGAMdtBJ9q/3YJ4trc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67F35F802BC;
	Wed, 26 Aug 2020 16:40:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEBA3F801D9; Wed, 26 Aug 2020 16:40:34 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5A11F8016F
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 16:40:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5A11F8016F
IronPort-SDR: iqsQkWEjR2BpITX3OQLrDdHzXVFRRY45bSApWQ8n9cSd1zPvJoGz6P2JguXEgOeddGgmB6CP7W
 hJA2rWnReVDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135849039"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="135849039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 07:40:24 -0700
IronPort-SDR: KHxkWteeU8emhyHgGfiOwbt/dsY21nC8/UY5bgPeCNc+exWvdcy9vNMmiijVfwhXIoSVnfVsLW
 iZeVF4gNESwA==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="299494879"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51])
 ([10.255.231.51])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 07:40:23 -0700
Subject: Re: [PATCH 09/11] soundwire: intel: add dynamic debug trace for
 clock-stop invalid configs
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
 <20200826094817.GC2639@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <21038e8d-dbd9-76c7-c758-9933fb45024a@linux.intel.com>
Date: Wed, 26 Aug 2020 09:38:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826094817.GC2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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



On 8/26/20 4:48 AM, Vinod Koul wrote:
> On 18-08-20, 10:41, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> Detect cases where the clock is assumed to be stopped but the IP is
>> not in the relevant state, and add a dynamic debug trace.
> 
> you meant a debug print..and it looks like error print below (also in title).

I don't understand the comment. Is the 'trace' confusing and are you 
asking to e.g. change the commit message to 'add dynamic debug log'?

> 
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 7c63581270fd..b82d02af3c4f 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1964,6 +1964,11 @@ static int intel_resume_runtime(struct device *dev)
>>   			}
>>   		}
>>   	} else if (!clock_stop_quirks) {
>> +
>> +		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
>> +		if (!clock_stop0)
>> +			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
>> +
>>   		ret = intel_init(sdw);
>>   		if (ret) {
>>   			dev_err(dev, "%s failed: %d", __func__, ret);
>> -- 
>> 2.17.1
> 
