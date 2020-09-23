Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5150C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:59:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4A7214D8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="V5cCyq62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4A7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE772171D;
	Wed, 23 Sep 2020 11:58:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE772171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600855146;
	bh=VyUB5E/ZZnoRM3u/3GpkQe8GNAecvhcejB+B75SUDlo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V5cCyq62BuUQ8NC5Oev4+8ImNC9c52gQZU7OUN9qR5u/EzS7J+MWR4fAeOq/O4Djk
	 O/0oXA7A38JMTQU3mhLWp3N6XjwrAS2vvhKkU1s6nlJSFIPFv+omf3V/2i4ojOAbUm
	 oxZf157+o0W7uxBII+i/NSMyu83jRIOXykWolRSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D7CBF80162;
	Wed, 23 Sep 2020 11:58:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1261AF80171; Wed, 23 Sep 2020 11:58:14 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63654F8015F
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 11:58:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63654F8015F
IronPort-SDR: bBHkXzpaQ4S9Rm8IocKd6fgV5MHmJiQdj79n4V0PJ0FUpasqfrFFTeU/nfyOOrFfUjcuYJ4nIe
 wGx8EYzpqTww==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="161783145"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="161783145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 02:58:02 -0700
IronPort-SDR: 40V8PrWw9BxMCfSQWzpGXH97VJlxJEqJ2Wb2ex//aKEsvjyFnAoKoz8SASUmSm+67xvyr53v8k
 WYp3HqrtDchA==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="511592114"
Received: from yungchua-mobl.ccr.corp.intel.com (HELO [10.252.185.213])
 ([10.252.185.213])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 02:58:00 -0700
Subject: Re: [PATCH 5/6] ASoC: Intel: sof_sdw_rt700: add codec prefix
To: Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org,
 broonie@kernel.org
References: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
 <20200923080514.3242858-6-kai.vehmanen@linux.intel.com>
 <b9481c23-5a09-0518-b05b-c01b2d04e102@perex.cz>
From: Bard liao <yung-chuan.liao@linux.intel.com>
Message-ID: <9521d264-a79a-44a4-f78d-f4491d143670@linux.intel.com>
Date: Wed, 23 Sep 2020 17:57:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <b9481c23-5a09-0518-b05b-c01b2d04e102@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com, bard.liao@intel.com
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


On 9/23/2020 4:34 PM, Jaroslav Kysela wrote:
> Dne 23. 09. 20 v 10:05 Kai Vehmanen napsal(a):
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> Somehow for this codec we never used any prefix for the controls,
>> likely because the test platform has a single SoundWire device.
>>
>> Follow the convention and use the codec prefix across the board to
>> avoid possible conflicts.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
>> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> ---
>>   sound/soc/intel/boards/sof_sdw_rt700.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/intel/boards/sof_sdw_rt700.c b/sound/soc/intel/boards/sof_sdw_rt700.c
>> index bff69cfe27f4..21e7e4a81779 100644
>> --- a/sound/soc/intel/boards/sof_sdw_rt700.c
>> +++ b/sound/soc/intel/boards/sof_sdw_rt700.c
>> @@ -23,9 +23,9 @@ static const struct snd_soc_dapm_widget rt700_widgets[] = {
>>   
>>   static const struct snd_soc_dapm_route rt700_map[] = {
>>   	/* Headphones */
>> -	{ "Headphones", NULL, "HP" },
>> -	{ "Speaker", NULL, "SPK" },
>> -	{ "MIC2", NULL, "AMIC" },
>> +	{ "Headphones", NULL, "rt700 HP" },
>> +	{ "Speaker", NULL, "rt700 SPK" },
>> +	{ "rt700 MIC2", NULL, "AMIC" },
> This line looks suspicious. Perhaps, the prefix should be added before AMIC ?

The "rt700" is a prefix for rt700 codec and the "MIC2" is one of rt700's

widget and "AMIC" is machine driver's widget. So "rt700 MIC2" looks correct

to me.



>
> 						Jaroslav
>
