Return-Path: <SRS0=xcY/=3T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA19C2D0DB
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:15:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DEB20678
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mL3LMWHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DEB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB9111614;
	Thu, 30 Jan 2020 16:14:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB9111614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580397328;
	bh=KDcf6fecXXoyxSErp/NCQdYQ0ZC8IGXIIdLP7GjUPP4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mL3LMWHfcbdluK9n7wCJSEOfxCJspyS1AgaRSvYpbtNLdaomHIFOZr/xVot2vvDPO
	 NY6ya8VqbcEPhVGN1aAmc5gdg8fqhzWhNegh4FV8WFOjC1uTr6oT6OWJnrKLcMuTf2
	 sHqbZzxbO6Qo0D+ijn7D0TRze4lfJ3eh0yrYPkWs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4582FF80123;
	Thu, 30 Jan 2020 16:14:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D987F80150; Thu, 30 Jan 2020 16:14:37 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02CC9F800F1
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 16:14:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02CC9F800F1
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jan 2020 07:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; d="scan'208";a="377071659"
Received: from jsmesenc-mobl.amr.corp.intel.com (HELO [10.252.140.145])
 ([10.252.140.145])
 by orsmga004.jf.intel.com with ESMTP; 30 Jan 2020 07:14:30 -0800
To: Mark Brown <broonie@kernel.org>
References: <20200129223603.2569-1-pierre-louis.bossart@linux.intel.com>
 <20200129223603.2569-2-pierre-louis.bossart@linux.intel.com>
 <20200130145548.GE6682@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c6391973-fe6e-bd36-a2b5-c28cefc1ef75@linux.intel.com>
Date: Thu, 30 Jan 2020 09:14:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130145548.GE6682@sirena.org.uk>
Content-Language: en-US
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Intel: sof_pcm512x: add support
 for SOF platforms with pcm512x
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

Thanks for the review Mark,

>> +static int sof_pcm512x_codec_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_component *codec = rtd->codec_dai->component;
>> +
>> +	snd_soc_component_update_bits(codec, PCM512x_GPIO_EN, 0x08, 0x08);
>> +	snd_soc_component_update_bits(codec, PCM512x_GPIO_OUTPUT_4, 0x0f, 0x02);
>> +	snd_soc_component_update_bits(codec, PCM512x_GPIO_CONTROL_1,
>> +				      0x08, 0x08);
> 
> These look like they might be a DAPM widget of some kind?

it's the LED support only, turned on when you play and off when you stop.
At some point, I added a gpiochip support in the PCM152x codec driver to 
avoid doing this, and have a nicer way of toggling the gpios. Due to 
lack of time, I didn't maintain this solution, but we could add it in a 
follow-up version if that was desired. It's really not the main 
functionality of this patch.
-Pierre
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
