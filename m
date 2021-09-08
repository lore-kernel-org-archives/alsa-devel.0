Return-Path: <SRS0=cWdV=N6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AADDC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 17:55:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7621B6113D
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 17:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7621B6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 191431688;
	Wed,  8 Sep 2021 19:54:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 191431688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631123701;
	bh=sFd76z2w6jWgvOcl81/4ZpAe02c1uLMIpuzbVYB+yzw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZgTxBMqZagXHw0Ir5BVE4gxlC+0ogR6WFASPIZbvlFJw5YtleCSO4qt1G0oKtO1k7
	 VoMiAIKNbBzzjuJ4MZsFNsPH0hjKjuL0GPePQvXdEZQwzwPFpqf/RjhzP4zcw9JQXs
	 f0kAsZnJLfpANkp7kB6COeaY9YTVYi7OR51X2EaA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FD24F8026C;
	Wed,  8 Sep 2021 19:54:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D5D6F8049C; Wed,  8 Sep 2021 19:54:08 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE888F800C7
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 19:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE888F800C7
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="207788602"
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; d="scan'208";a="207788602"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2021 10:53:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; d="scan'208";a="693503974"
Received: from sgevirtz-mobl.amr.corp.intel.com (HELO [10.209.141.208])
 ([10.209.141.208])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2021 10:53:59 -0700
Subject: Re: [PATCH] ASoC: Intel: boards: add max98390 2/4 speakers support
To: "Chiang, Mac" <mac.chiang@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20210907093329.10742-1-mac.chiang@intel.com>
 <cef537cd-5568-83e9-e0a7-f6457250696f@linux.intel.com>
 <DM5PR1101MB2091C61F02F44088D526106084D49@DM5PR1101MB2091.namprd11.prod.outlook.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <26efdc5f-9948-12d3-7eff-a0e8f8c2e4e0@linux.intel.com>
Date: Wed, 8 Sep 2021 10:30:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM5PR1101MB2091C61F02F44088D526106084D49@DM5PR1101MB2091.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "Arava, Jairaj" <jairaj.arava@intel.com>,
 "mark_hsieh@wistron.com" <mark_hsieh@wistron.com>, "Cheng,
 Keith" <keith.tzeng@quantatw.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>, "Liao,
 Bard" <bard.liao@intel.com>
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



On 9/8/21 8:39 AM, Chiang, Mac wrote:
>> Fixed Bard's address.
>>
>> Quik summary: there are multiple issues below with rather unclear handling
>> of two separate configurations.
> There are 3 hw boards support, I summarize as below:
> 1. SSP2 connects 98390, with 2 speakers.
> 2. SSP1 connects 98390, with 2 speakers or 4 speakers.
> Thanks Piere. Please review my comments if I misunderstand.

Please clearly identify these configurations in the next revision, thanks!


>>> +int max_98390_spk_codec_init(struct snd_soc_pcm_runtime *rtd) {
>>> +	struct snd_soc_card *card = rtd->card;
>>> +	int ret;
>>> +
>>> +	ret = snd_soc_dapm_new_controls(&card->dapm,
>> max_98390_tt_dapm_widgets,
>>> +
>> 	ARRAY_SIZE(max_98390_tt_dapm_widgets));
>>> +	if (ret) {
>>> +		dev_err(rtd->dev, "unable to add dapm controls, ret %d\n",
>> ret);
>>> +		/* Don't need to add routes if widget addition failed */
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = snd_soc_add_card_controls(card, max_98390_tt_kcontrols,
>>> +
>> 	ARRAY_SIZE(max_98390_tt_kcontrols));
>>> +	if (ret) {
>>> +		dev_err(rtd->dev, "unable to add card controls, ret %d\n",
>> ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = snd_soc_dapm_add_routes(&card->dapm,
>> max_98373_dapm_routes,
>>> +
>> 	ARRAY_SIZE(max_98373_dapm_routes));
>>> +	if (ret) {
>>> +		dev_err(rtd->dev, "Speaker Left, Right  map addition failed:
>> %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = snd_soc_dapm_add_routes(&card->dapm,
>> max_98390_tt_dapm_routes,
>>> +
>> 	ARRAY_SIZE(max_98390_tt_dapm_routes));
>>> +	if (ret)
>>> +		dev_err(rtd->dev, "Tweeter Speaker Left, Right map addition
>> failed:
>>> +%d\n", ret);
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_NS(max_98390_spk_codec_init,
>>> +SND_SOC_INTEL_SOF_MAXIM_COMMON);
>>
>> again what happens if you don't have tweeters in the configuration? Why
>> would you add DAPM routes to a non-existent codec?
> Without tweeter quirk, it goes to apply max_98390_codec_conf from max_98390_set_codec_conf()
> With tweeter quirk, it goes to apply max_98390_4spk_codec_conf from max_98390_set_codec_conf()

what I meant here is that you will add the max_98390_tt_dapm_routes even
in the two speaker case. That doesn't seem right?
