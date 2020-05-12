Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32697C2D0F7
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 15:37:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6628206CC
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rMC7EoFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6628206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16BC9169F;
	Tue, 12 May 2020 17:37:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16BC9169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589297874;
	bh=cKTzQk/p/hiuQ0onL3aJI/pRnFjIiOGdoLh4CBIkccw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMC7EoFYo2IyQ9py9T5d5TjAMNQ5Pa7jYNfNs4WClGaR4pDlILh/r1Z4nohN7wGH7
	 qv4BdEMSZGy42mwkaP9DnXGM/AVDSP3J1TTCFQ10GvQ/gcZ1RFUtf/vpsaZUXpgFfp
	 I1/bdFzPQGL8xtZ04T4+7TNlhS+YUApPfnd69CXo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E790F80112;
	Tue, 12 May 2020 17:37:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A171FF8014C; Tue, 12 May 2020 17:36:33 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE7C3F800B7
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 17:36:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE7C3F800B7
IronPort-SDR: JuKEhFLxiL0wmCA5fWFzkVJUCNg5Ysp36BGOrDcI6Rar8A5gFDXMN4Ez4cnURmfT3jxJjqSpYk
 HPqSMWFZAGMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2020 08:36:04 -0700
IronPort-SDR: E9sX2zV/2B5745cbDA3jQ9cFyxG962GEG0B8MeGemJs7MZ+XP3rgZUGFlY/cLleMxYJtTf3epH
 e9LyUoQW/pbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; d="scan'208";a="340937890"
Received: from minwu-mobl.ccr.corp.intel.com (HELO [10.254.210.85])
 ([10.254.210.85])
 by orsmga001.jf.intel.com with ESMTP; 12 May 2020 08:36:04 -0700
Subject: Re: [PATCH] ASoC: topology: log all headers being parsed
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200509082248.2757-1-yang.jie@linux.intel.com>
 <75fb69cc-830f-432a-c724-7449309f2eba@linux.intel.com>
From: Keyon Jie <yang.jie@linux.intel.com>
Message-ID: <36aab97b-a45a-de39-dea1-a1aa84c5a6d9@linux.intel.com>
Date: Tue, 12 May 2020 23:36:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <75fb69cc-830f-432a-c724-7449309f2eba@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
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



On 5/12/20 2:38 AM, Pierre-Louis Bossart wrote:
> Kind reminder to always CC: maintainers....

Thanks for reminding.

> 
> On 5/9/20 3:22 AM, Keyon Jie wrote:
>> The check (tplg->pass == le32_to_cpu(hdr->type)) makes no sense as it is
>> comparing two different enums, remove the check and log all headers that
>> being parsed.
> 
> It's true that the TYPE_MIXER should probably not be compared to 
> TPLG_PASS_MANIFEST, but one would think that e.g. the TYPE_MIXER is 
> handled in the TPLG_PASS_MIXER, no? and likewise that in the 
> TPLG_PASS_MANIFEST all TPLG_TYPE_MANIFEST are handled?

Yes, all TYPE_MIXER/ENUM/BYTES are handled in the TPLG_PASS_MIXER, and 
in the TPLG_PASS_MANIFEST all TPLG_TYPE_MANIFEST are handled, but all 
these are guaranteed and more details are logged inside the 
corresponding xxx_load(), at here it is only checking the validity of 
the header, I think we can log all headers for debug purpose? Imagine 
that there might be some headers won't be parsed by any xxx_load().

> 
> Shouldn't you add a switch case to reconcile the two lists instead of 
> removing the test altogether?

I can add a function to reconcile the two list, but since we already 
have "tplg->pass != SOC_TPLG_PASS_xxx" check in each xxx_load(), do you 
suggest to moving the logging inside these xxx_load() to reduce the 
redundant check?

Thanks,
~Keyon

> 
> #define SND_SOC_TPLG_TYPE_MIXER        1
> #define SND_SOC_TPLG_TYPE_BYTES        2
> #define SND_SOC_TPLG_TYPE_ENUM        3
> #define SND_SOC_TPLG_TYPE_DAPM_GRAPH    4
> #define SND_SOC_TPLG_TYPE_DAPM_WIDGET    5
> #define SND_SOC_TPLG_TYPE_DAI_LINK    6
> #define SND_SOC_TPLG_TYPE_PCM        7
> #define SND_SOC_TPLG_TYPE_MANIFEST    8
> #define SND_SOC_TPLG_TYPE_CODEC_LINK    9
> #define SND_SOC_TPLG_TYPE_BACKEND_LINK    10
> #define SND_SOC_TPLG_TYPE_PDATA        11
> #define SND_SOC_TPLG_TYPE_DAI        12
> 
> #define SOC_TPLG_PASS_MANIFEST        0
> #define SOC_TPLG_PASS_VENDOR        1
> #define SOC_TPLG_PASS_MIXER        2
> #define SOC_TPLG_PASS_WIDGET        3
> #define SOC_TPLG_PASS_PCM_DAI        4
> #define SOC_TPLG_PASS_GRAPH        5
> #define SOC_TPLG_PASS_PINS        6
> #define SOC_TPLG_PASS_BE_DAI        7
> #define SOC_TPLG_PASS_LINK        8
> 
> 
>>
>> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
>> ---
>>   sound/soc/soc-topology.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
>> index 49875978a1ce..58cf5a12af3f 100644
>> --- a/sound/soc/soc-topology.c
>> +++ b/sound/soc/soc-topology.c
>> @@ -2685,11 +2685,10 @@ static int soc_valid_header(struct soc_tplg 
>> *tplg,
>>           return -EINVAL;
>>       }
>> -    if (tplg->pass == le32_to_cpu(hdr->type))
>> -        dev_dbg(tplg->dev,
>> -            "ASoC: Got 0x%x bytes of type %d version %d vendor %d at 
>> pass %d\n",
>> -            hdr->payload_size, hdr->type, hdr->version,
>> -            hdr->vendor_type, tplg->pass);
>> +    dev_dbg(tplg->dev,
>> +        "ASoC: Got 0x%x bytes of type %d version %d vendor %d at pass 
>> %d\n",
>> +        hdr->payload_size, hdr->type, hdr->version,
>> +        hdr->vendor_type, tplg->pass);
>>       return 1;
>>   }
>>
