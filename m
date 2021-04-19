Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC7C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 06:33:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9603E6113C
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 06:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9603E6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02DB516A0;
	Mon, 19 Apr 2021 08:32:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02DB516A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618814013;
	bh=7tTMkGtI9ST6Ivdm8b1itEfXLVl5+9KcdYb/wkUeuQM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/qgPxVnZGZh3mw/ob7rYDM3tHW3lgQ4dq6wSg/C/pgc01Bc9LqIceOf81UB805v9
	 VF/mSaGkAKHgELpb5L2KKHFcjJbeaMltd6+m1qyq1Pb2DXWHgEKy43N8dM+rFeJ37E
	 /miRYd4L465srRAhl7c4my05dP2YROSyTFWXF+oc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA281F8019B;
	Mon, 19 Apr 2021 08:32:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2544FF80227; Mon, 19 Apr 2021 08:32:38 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49ACBF80164
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 08:32:25 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 48BCAA0040;
 Mon, 19 Apr 2021 08:32:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 48BCAA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1618813945; bh=OzGfGdPOQOdPf5/lCDbnw+JYCfD8Rf8QlRo10ubkPHA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=v1TO+GrM9BUl8/cEycppjM4DvndUBZsYew+tTo7dVPKVTrCyKdegVzinQZCXxozbU
 1qdy7GPbKb2shRlYN8eZC2n+C0j2iZJDJbhWfGVbJWZ8ULRfbiJvNXSzsec6J0mdBy
 /zkOHVfYlk+ljgr0d8sI6jvhCu65GOBbBi5WT594=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 19 Apr 2021 08:32:14 +0200 (CEST)
Subject: Re: [PATCH] ASoC: rt711-sdca: remove capture switch controls
To: "Yang, Libin" <libin.yang@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "shumingf@realtek.com" <shumingf@realtek.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>
References: <20210415091609.13695-1-shumingf@realtek.com>
 <6c5b52e2-c875-9b30-60dd-d4bec77a9215@linux.intel.com>
 <BN6PR11MB1652220DB80760FD18B8308290499@BN6PR11MB1652.namprd11.prod.outlook.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <9146794c-d4a1-8dd8-4ab1-7c9c44a7703b@perex.cz>
Date: Mon, 19 Apr 2021 08:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BN6PR11MB1652220DB80760FD18B8308290499@BN6PR11MB1652.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
 "jack.yu@realtek.com" <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "derek.fang@realtek.com" <derek.fang@realtek.com>,
 "flove@realtek.com" <flove@realtek.com>
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

Dne 19. 04. 21 v 7:14 Yang, Libin napsal(a):
> Hi Pierre,
> 
> 
>> -----Original Message-----
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Sent: 2021年4月15日 19:26
>> To: shumingf@realtek.com; broonie@kernel.org; lgirdwood@gmail.com
>> Cc: oder_chiou@realtek.com; jack.yu@realtek.com; alsa-devel@alsa-
>> project.org; lars@metafoo.de; Yang, Libin <libin.yang@intel.com>;
>> derek.fang@realtek.com; flove@realtek.com
>> Subject: Re: [PATCH] ASoC: rt711-sdca: remove capture switch controls
>>
>>
>>
>> On 4/15/21 4:16 AM, shumingf@realtek.com wrote:
>>> From: Shuming Fan <shumingf@realtek.com>
>>>
>>> The settings of the switch control already set by DAPM event.
>>> These switch controls might the user confused why it can't disable the
>> capture.
>>
>> Sorry, not following. This control is used in the alsa-ucm-conf that was just
>> merged
>>
>> https://github.com/alsa-project/alsa-ucm-
>> conf/commit/197025656ec456331d1a34357b113913ec3b187f#diff-
>> 0e1c627ea89ee148fdb41aa6b3ba7851ba9c20eb43c1b87b9e0ce92164273dc3R
>> 7
>>
>> Is this saying this commit needs to be fixed with a follow-up PR? Libin, are
>> you working on this?
> 
> Yes, I will submit a patch for UCM after this patch is merged.
> 
> The background is Jaroslav requires using codec HW kcontrol for capture
> volume/switch. Shuming and I worked on it. At first we wanted to use
> FU0F to replace PGA kcontrol. But Shuming found FU0F is used in DAPM.
> So it is not proper for the capture volume/switch. And Shuming will remove
> the FU0F kcontrol.

Is switch control name aligned with the volume control name after this change?
I mean "A Capture Switch" + "A Capture Volume" not "A Capture Switch" + "B
Capture Volume".

						Jaroslav

> 
> Regards,
> Libin
> 
>>
>>
>>>
>>> Signed-off-by: Shuming Fan <shumingf@realtek.com>
>>> ---
>>>   sound/soc/codecs/rt711-sdca.c | 8 --------
>>>   1 file changed, 8 deletions(-)
>>>
>>> diff --git a/sound/soc/codecs/rt711-sdca.c b/sound/soc/codecs/rt711-
>> sdca.c
>>> index bfb7f1c8ec8f..2a09c305f4e4 100644
>>> --- a/sound/soc/codecs/rt711-sdca.c
>>> +++ b/sound/soc/codecs/rt711-sdca.c
>>> @@ -652,14 +652,6 @@ static const struct snd_kcontrol_new
>> rt711_sdca_snd_controls[] = {
>>>   		SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC,
>> RT711_SDCA_ENT_USER_FU05, RT711_SDCA_CTL_FU_VOLUME, CH_R),
>>>   		0x57, 0x57, 0,
>>>   		rt711_sdca_set_gain_get, rt711_sdca_set_gain_put,
>> out_vol_tlv),
>>> -	SOC_DOUBLE_R("FU1E Capture Switch",
>>> -		SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY,
>> RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_MUTE, CH_L),
>>> -		SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY,
>> RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_MUTE, CH_R),
>>> -		0, 1, 1),
>>> -	SOC_DOUBLE_R("FU0F Capture Switch",
>>> -		SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC,
>> RT711_SDCA_ENT_USER_FU0F, RT711_SDCA_CTL_FU_MUTE, CH_L),
>>> -		SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC,
>> RT711_SDCA_ENT_USER_FU0F, RT711_SDCA_CTL_FU_MUTE, CH_R),
>>> -		0, 1, 1),
>>>   	SOC_DOUBLE_R_EXT_TLV("FU1E Capture Volume",
>>>   		SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY,
>> RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_VOLUME, CH_L),
>>>   		SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY,
>> RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_VOLUME, CH_R),
>>>


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
