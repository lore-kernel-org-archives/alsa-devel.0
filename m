Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D192AC2BA83
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:06:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5584D206D7
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G+DxwBDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5584D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD71F1689;
	Wed, 12 Feb 2020 17:05:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD71F1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581523582;
	bh=MLGimpuAD3idXwiTg1AHUkdNTAwHrjUxkoo5LdWGoio=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G+DxwBDNDNHA1gD9Cwdszquw3ptd2lBKGqINKwyEygu2ZcO7R2m3eNAcBO5ynUekh
	 Wlj/NnLozRsXyReqUbX1ZJkmATMfZ2/7PKqOCfr+nHnkOp+ufYvW7XWvxr09qKNX/d
	 eQ5oYW1dv5av8txogpdmh4cERINMR73f/kg1mJH8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 383A0F80228;
	Wed, 12 Feb 2020 17:03:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01521F8014F; Wed, 12 Feb 2020 17:03:54 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6BFEEF80158
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 17:03:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BFEEF80158
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 08:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; d="scan'208";a="313442343"
Received: from gmoralez-mobl.amr.corp.intel.com (HELO [10.252.135.232])
 ([10.252.135.232])
 by orsmga001.jf.intel.com with ESMTP; 12 Feb 2020 08:03:38 -0800
To: Vinod Koul <vkoul@kernel.org>
References: <20200114234257.14336-1-pierre-louis.bossart@linux.intel.com>
 <20200114234257.14336-6-pierre-louis.bossart@linux.intel.com>
 <20200212101554.GB2618@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8219635-30be-9695-a3f5-cd649aa6fab7@linux.intel.com>
Date: Wed, 12 Feb 2020 09:37:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212101554.GB2618@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 5/5] soundwire: intel: free all
 resources on hw_free()
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

Hi Vinod,

>> +static int intel_free_stream(struct sdw_intel *sdw,
>> +			     struct snd_pcm_substream *substream,
>> +			     struct snd_soc_dai *dai,
>> +			     int link_id)
>> +{
>> +	struct sdw_intel_link_res *res = sdw->link_res;
>> +	struct sdw_intel_stream_free_data free_data;
> 
> where is this struct sdw_intel_stream_free_data defined. I dont see it
> in this patch or this series..

the definition is already upstream :-)

It was added in December with

4b206d34b92224 ('soundwire: intel: update stream callbacks for 
hwparams/free stream operations')

>> -	return ret;
>> +	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
>> +	if (ret < 0) {
>> +		dev_err(dai->dev, "intel_free_stream: failed %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	sdw_release_stream(dma->stream);
> 
> I think, free the 'name' here would be apt

Right, this is something we discussed with Rander shortly before Chinese 
New Year and we wanted to handle this with a follow-up patch, would that 
work for you? if not I can send a v3, your choice.

Thanks
-Pierre
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
