Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C70FC3A5A8
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:44:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6855421670
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l2vJWFoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6855421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02156167B;
	Wed,  4 Sep 2019 19:44:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02156167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567619091;
	bh=tgRocQbmObsadFzpSjXD29p7rawQ6BuJcecAGv3tbvk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2vJWFoYlE0BATOjDXxD/rHMIO/3goAh/6RFv4tcIrRalG20GAzTjIte71+SwknFO
	 4Fy+X3VBbSOFK6eSWRwjDag3P1VyB6hadzohGqp3J63V2KuVTEDAfFfLNNZWl95GXg
	 YyOr+stB75nID2ystsN2nQgH+V5uAyBoulnvkTl8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41A93F80394;
	Wed,  4 Sep 2019 19:44:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28282F803A6; Wed,  4 Sep 2019 19:43:58 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B791F8011E
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 19:43:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B791F8011E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 10:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; d="scan'208";a="194813269"
Received: from enagase-mobl1.amr.corp.intel.com (HELO [10.251.133.230])
 ([10.251.133.230])
 by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 10:43:49 -0700
To: Vinod Koul <vkoul@kernel.org>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-3-pierre-louis.bossart@linux.intel.com>
 <20190904071317.GJ2672@vkoul-mobl>
 <71411347-93cf-2617-4edd-f6b401fe7a9b@linux.intel.com>
 <20190904164926.GA2672@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <63fc57dd-3df4-191c-2676-732f3748c55b@linux.intel.com>
Date: Wed, 4 Sep 2019 12:43:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904164926.GA2672@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: cadence_master: add
 hw_reset capability in debugfs
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 9/4/19 11:49 AM, Vinod Koul wrote:
> On 04-09-19, 08:18, Pierre-Louis Bossart wrote:
>> On 9/4/19 2:13 AM, Vinod Koul wrote:
>>> On 13-08-19, 16:32, Pierre-Louis Bossart wrote:
>>>> Provide debugfs capability to kick link and devices into hard-reset
>>>> (as defined by MIPI). This capability is really useful when some
>>>> devices are no longer responsive and/or to check the software handling
>>>> of resynchronization.
>>>>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>>    drivers/soundwire/cadence_master.c | 20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>>>> index 046622e4b264..bd58d80ff636 100644
>>>> --- a/drivers/soundwire/cadence_master.c
>>>> +++ b/drivers/soundwire/cadence_master.c
>>>> @@ -340,6 +340,23 @@ static int cdns_reg_show(struct seq_file *s, void *data)
>>>>    }
>>>>    DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>>>> +static int cdns_hw_reset(void *data, u64 value)
>>>> +{
>>>> +	struct sdw_cdns *cdns = data;
>>>> +	int ret;
>>>> +
>>>> +	if (value != 1)
>>>> +		return 0;
>>>
>>> Should this not be EINVAL to indicate invalid value passed?
>>
>> Maybe. I must admit I don't know what -EINVAL would do, this is used for
>> debugfs so it's not clear to me if the user will see a difference?
> 
> Well user should see "write error: Invalid argument" when he writes
> anything other than valid values :)

ok then, will do.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
