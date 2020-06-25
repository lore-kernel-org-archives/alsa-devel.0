Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F2C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:35:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29A7207E8
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ErlcDqhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29A7207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50B181934;
	Thu, 25 Jun 2020 20:34:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50B181934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593110110;
	bh=ZCuGzMj67f5q0giLMnnB4t12bJbCO9f3sPUwQAN5mc0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ErlcDqhQaDSK1Xigr+MqbxBKZD21NqXANAw1f3LlZpy3rFbsPLSPhrUjSfGDJGoA8
	 bFzKxiPY9vrz/7pUjxZJXRUBGOT4tfezcvguqEXPW4YDxSY8j7rD6eliJpkRgLmqoB
	 hP1/F8906eFTLDxdjhf3D8yAr3h5/yy0wWauuT0k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A090CF80218;
	Thu, 25 Jun 2020 20:34:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECD3BF80234; Thu, 25 Jun 2020 20:34:17 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0225EF800B2
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 20:34:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0225EF800B2
IronPort-SDR: y89VdAI3fZ4XgbzHznruRfH6hbAbl3pOSjBqzHwQ6QubOVAMTUaNM7P7sEmLFnrlvToZM8FdJL
 f4y8LuHpNkww==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="125271526"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="125271526"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 11:34:06 -0700
IronPort-SDR: Vq+RiBCPMMRmDwiLqBeF/YDl+sKHyo0HCHKx7zK4fWNp7s1jmddQICASL3USpurYtxvXJ/k072
 qz2we6I5coMQ==
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="298227031"
Received: from kpcavias-mobl.amr.corp.intel.com (HELO [10.254.110.181])
 ([10.254.110.181])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 11:34:06 -0700
Subject: Re: [PATCH 3/4] ASoC: Intel: sof_sdw: add missing .owner field
To: Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200625180635.3563-1-pierre-louis.bossart@linux.intel.com>
 <20200625180635.3563-4-pierre-louis.bossart@linux.intel.com>
 <1298226b-183c-af59-7be8-98e98149ef0c@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f24a5ef6-95eb-6a93-f25b-189ac270500a@linux.intel.com>
Date: Thu, 25 Jun 2020 13:34:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1298226b-183c-af59-7be8-98e98149ef0c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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



On 6/25/20 1:24 PM, Cezary Rojewski wrote:
> On 2020-06-25 8:06 PM, Pierre-Louis Bossart wrote:
>> This field is required for ASoC cards. Not setting it will result in a
>> module->name pointer being NULL and generate problems such as
>>
>> cat /proc/asound/modules
>>   0 (efault)
>>
>> Reported-by: Jaroslav Kysela <perex@perex.cz>
>> Suggested-by: Takashi Iwai <tiwai@suse.de>
>> Fixes: 52db12d193d4 ('ASoC: Intel: boards: add sof_sdw machine driver')
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> ---
>>   sound/soc/intel/boards/sof_sdw.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/boards/sof_sdw.c 
>> b/sound/soc/intel/boards/sof_sdw.c
>> index e1c1a8ba78e6..d26b82526163 100644
>> --- a/sound/soc/intel/boards/sof_sdw.c
>> +++ b/sound/soc/intel/boards/sof_sdw.c
>> @@ -893,7 +893,7 @@ static const char sdw_card_long_name[] = "Intel 
>> Soundwire SOF";
>>   static struct snd_soc_card card_sof_sdw = {
>>       .name = "soundwire",
>> -    .late_probe = sof_sdw_hdmi_card_late_probe,
> 
> Deletion of .late_probe looks off in this patch. Typo?

Thanks for spotting this, will send a fix. I did fix that conflict, I 
must have screw something up at a later stage.

>> +    .owner = THIS_MODULE,
>>       .codec_conf = codec_conf,
>>       .num_configs = ARRAY_SIZE(codec_conf),
>>   };
>>
