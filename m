Return-Path: <SRS0=PVpb=XA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E0AC41514
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:12:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20B52067D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m0nIupA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20B52067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57DCF1679;
	Thu,  5 Sep 2019 15:11:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57DCF1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567689167;
	bh=3fzsZkgTsbZ1iQtdBPk/f8No+hTbUHfdFM+6ee1MtmQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m0nIupA4iNy/fUa/BB1+vtVhGpjvRLMAR3AlxkNpH2vsItEgBN4U2U4jj/dIV8hWu
	 rRYpQ2kd4N5FwHVBdPaEuBmvNHZJpZTqiHYxCpN/yksOOp+7xyDCbXmCMvrj+aWF0X
	 lH76llKiN62i+AKIQSym7VolXaq6+HDtt310S8p8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9ABAEF803D1;
	Thu,  5 Sep 2019 15:11:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D977EF80448; Thu,  5 Sep 2019 15:11:54 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 750EFF80171;
 Thu,  5 Sep 2019 15:11:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 750EFF80171
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 06:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; d="scan'208";a="267015311"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga001.jf.intel.com with ESMTP; 05 Sep 2019 06:11:45 -0700
Received: from ravisha1-mobl1.amr.corp.intel.com (unknown [10.255.36.89])
 by linux.intel.com (Postfix) with ESMTP id DDE31580105;
 Thu,  5 Sep 2019 06:11:44 -0700 (PDT)
To: Takashi Iwai <tiwai@suse.de>,
 Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
References: <20190905053302.9262-1-pawel.harlozinski@linux.intel.com>
 <20190905053302.9262-2-pawel.harlozinski@linux.intel.com>
 <s5ha7bjgup9.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9b997691-a609-e7b5-94a6-d42e26dfa080@linux.intel.com>
Date: Thu, 5 Sep 2019 08:11:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5ha7bjgup9.wl-tiwai@suse.de>
Content-Language: en-US
Cc: cezary.rojewski@intel.com, alsa-devel@alsa-project.org,
 patch@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [alsa-devel] [RFC PATCH 2/3] ALSA:core: Add rate 24kHz
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

On 9/5/19 12:48 AM, Takashi Iwai wrote:
> On Thu, 05 Sep 2019 07:33:00 +0200,
> Pawel Harlozinski wrote:
>>
>> Adds SNDRV_PCM_RATE_24000 at the bottom to keep backward compability
>> with alsa library.
>>
>> Signed-off-by: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
> 
> No.  Such a fancy rate has to be handled inside the driver locally
> instead of adding to the common rate.

It's not that crazy, this is supported in the HDaudio spec:

Sample Base Rate Divisor (DIV):
000 = Divide by 1 (48 kHz, 44.1 kHz)
001 = Divide by 2 (24 kHz, 22.05 kHz)

I am not sure why 22.05 made the cut and not 24 kHz, they are both 
derived from common clocks with the same divider... Same for 11.025 and 
12...

> 
> 
> Takashi
> 
>> ---
>>   include/sound/pcm.h     | 1 +
>>   sound/core/pcm_native.c | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
>> index bbe6eb1ff5d2..09d0a2a2dce8 100644
>> --- a/include/sound/pcm.h
>> +++ b/include/sound/pcm.h
>> @@ -119,6 +119,7 @@ struct snd_pcm_ops {
>>   #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
>>   #define SNDRV_PCM_RATE_352800		(1<<13)		/* 352800Hz */
>>   #define SNDRV_PCM_RATE_384000		(1<<14)		/* 384000Hz */
>> +#define SNDRV_PCM_RATE_24000		(1<<15)		/* 24000Hz */
>>   
>>   #define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
>>   #define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index 11e653c8aa0e..f52f28e3edb1 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>> @@ -2164,13 +2164,13 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
>>   	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
>>   }
>>   
>> -#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
>> +#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12 ||  SNDRV_PCM_RATE_24000 != 1 << 15
>>   #error "Change this table"
>>   #endif
>>   
>>   static const unsigned int rates[] = {
>>   	5512, 8000, 11025, 16000, 22050, 32000, 44100,
>> -	48000, 64000, 88200, 96000, 176400, 192000, 352800, 384000
>> +	48000, 64000, 88200, 96000, 176400, 192000, 352800, 384000, 24000
>>   };
>>   
>>   const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
>> -- 
>> 2.17.1
>>

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
