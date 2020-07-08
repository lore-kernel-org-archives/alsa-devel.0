Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A194C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 12:56:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CFA20656
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 12:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sb7x4sEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CFA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 309791669;
	Wed,  8 Jul 2020 14:55:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 309791669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594212997;
	bh=Fv6C7raJkVB+wDDi4T0E8sIE8WKRg3KJqMq6LGP4hlI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sb7x4sEgW3dhKKJkasZ8zb11LuROFVWXDWPB0LLV+H3OgCnhHC6voiAYCAE8tUmV9
	 UIuuZXVcUGWpM60E3oA5XM9C37ZX+thTc8FaV9lyHZTstYZcNQ4BG+7jOTSSRvgUhl
	 Pr9YQrt4ZAw7jfMBoh/RqfL87+fw2ufsXSq+hUiE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A346BF80150;
	Wed,  8 Jul 2020 14:55:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7524F8015A; Wed,  8 Jul 2020 14:55:44 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDAB4F80115
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 14:55:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDAB4F80115
IronPort-SDR: fbJAEYBcX/JQqHHLuZnIEBHYXY3or0+ntpWL5mVdTnLSTDky+dlzcLBsMEwDQ+Th153x7c3GSw
 d4pk3EvZw+nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="209317328"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; d="scan'208";a="209317328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 05:55:30 -0700
IronPort-SDR: Suofd+7AXM9bgYprsc3aXwnwRy34R3yv6fE2zBFww32epVdK9ww47VGE/BD3lLFPYFZ/t9GI1I
 5VBOwLBt5z7A==
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; d="scan'208";a="323870355"
Received: from sare-mobl.amr.corp.intel.com (HELO [10.251.7.246])
 ([10.251.7.246])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 05:55:30 -0700
Subject: Re: [PATCH v3 06/10] ASoC: sti: uniperif: fix 'defined by not used'
 warning
To: Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
 <20200707191615.98296-7-pierre-louis.bossart@linux.intel.com>
 <a376393a-6a17-2836-204b-0d4ff60729c0@st.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <31969204-1ada-3775-64da-092ded0bff8f@linux.intel.com>
Date: Wed, 8 Jul 2020 07:55:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a376393a-6a17-2836-204b-0d4ff60729c0@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "tiwai@suse.de" <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
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



On 7/8/20 4:11 AM, Arnaud POULIQUEN wrote:
> Hi Pierre-Louis,
> 
> On 7/7/20 9:16 PM, Pierre-Louis Bossart wrote:
>> Fix W=1 warning. The table uni_tdm_hw is declared in a header included
>> by multiple C file. This isn't really a good practice but for now
>> using __maybe_unused makes the following warning go away.
>>
>> sound/soc/sti/sti_uniperif.c:12:
>> sound/soc/sti/uniperif.h:1351:38: warning: ‘uni_tdm_hw’ defined but
>> not used [-Wunused-const-variable=]
>>   1351 | static const struct snd_pcm_hardware uni_tdm_hw = {
>>        |                                      ^~~~~~~~~~
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Thanks for the patch,
> Seems that the same patch has already been proposed by Lee:
> https://www.spinics.net/lists/arm-kernel/msg820327.html

that's right, we both fixed the same things, and this is the merged series.
Do you mind providing a tag if you're ok with the change?

> Regards,
> Arnaud
> 
>> ---
>>   sound/soc/sti/uniperif.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
>> index 2dc2da5d458b..a16adeb7c1e9 100644
>> --- a/sound/soc/sti/uniperif.h
>> +++ b/sound/soc/sti/uniperif.h
>> @@ -1348,7 +1348,7 @@ struct sti_uniperiph_data {
>>   	struct sti_uniperiph_dai dai_data;
>>   };
>>   
>> -static const struct snd_pcm_hardware uni_tdm_hw = {
>> +static __maybe_unused const struct snd_pcm_hardware uni_tdm_hw = {
>>   	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>   		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
>>   		SNDRV_PCM_INFO_MMAP_VALID,
>>
