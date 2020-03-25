Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A41C54FD0
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:20:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6592078E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="V5DVkR0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6592078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 861731683;
	Wed, 25 Mar 2020 14:19:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 861731683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585142410;
	bh=TlQMVw6SpOzg7I9BgEulIfuoV+aI1WbdHRx1ueZR+MM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V5DVkR0njN1K9SZxfgwAp87cb0TRWWs9EOxlFh/2jRvM8+v6/W5yHWjMETHdHp1RE
	 hx19mW1E6Z2+4vQ9OIZYZWOnxEmGAUgyW+98RDfIqg9VUvdD+Ms1xLMWaIyeg52lPD
	 M5sfZVU9TneBtzw00eX+qaQQJ/Daw8u8IleTjQYM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 161C5F80158;
	Wed, 25 Mar 2020 14:18:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 865E4F8015A; Wed, 25 Mar 2020 14:18:51 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E46EF80147
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 14:18:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E46EF80147
IronPort-SDR: 4KKIXg6/4oPlvmOXT4C8t/mPrHJnFn8kOUTReg44OTR/uwYmntm4XzhRn4xPTFX8TWzIdJ1p/A
 6EjSVO2X6jDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 06:18:45 -0700
IronPort-SDR: B4T/vk7Aw8J7ABDQrAvZ6Lly/MsWcQTRVpi/RTtimXjStBoID73ocRSuNuENjJzHD4Yw3QppIU
 YkW2yvkuIKow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="293337183"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.3.125])
 ([10.213.3.125])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2020 06:18:43 -0700
Subject: Re: [PATCH] ASoC: Intel: broadwell: Revert SSP0 link to use dummy
 components
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200319211204.21580-1-cezary.rojewski@intel.com>
 <43d75d9e-5dfe-7dee-aa7d-a8a1c0b7876f@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <17171eaa-89a7-f7ca-deae-044eae567b13@intel.com>
Date: Wed, 25 Mar 2020 14:18:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <43d75d9e-5dfe-7dee-aa7d-a8a1c0b7876f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux@dominikbrodowski.net,
 tiwai@suse.com
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

On 2020-03-19 23:20, Pierre-Louis Bossart wrote:
> 
> 
> On 3/19/20 4:12 PM, Cezary Rojewski wrote:
>> Commit:
>> "ASoC: Intel: broadwell: change cpu_dai and platform components for SOF
> 
> checkpatch.pl probably reports the format doesn't follow conventions?
> 

It does not. Reworded anyway so it's not bothering anyone.

>>
>> while enabling bdw on SOF, changed behavior for non-SOF solutions. In
>> essence replacing platform 'dummy' with actual 'platform' causes
>> redundant stream initialization to occur during audio start. hw_params
>> for haswell-pcm destroys initial stream right after its creation - only
>> to recreate it again from proceed from there.
>>
>> While harmless so far, this flow ain't right and should be corrected.
> 
> isn't
> 

Reworded.

>> The actual need for dummy components for SSP0 link is questionable but
>> that issue is subject for another series.
> 
> If we want to be consistent, the same use of a dummy platform component 
> needs to be applied to bdw-rt5677.c and bdw-rt5650.c
> 

Agreed. Combined all three into one series.

Czarek
