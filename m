Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78327C10F27
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:55:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A5E20650
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vV0QFGf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A5E20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BE46950;
	Wed, 11 Mar 2020 15:54:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BE46950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583938532;
	bh=tpYHFC1kOPF+SlXuOXOLBZZvTzlS5XWjdvgmNSBG2cM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vV0QFGf6oWGJMb0WgSvr60gfUF521owtVIWwyD9Ot84cxIsuINcjG4wFfrSdHGYaV
	 auawUmHMjSKkv+2deAGwCgg6tC9rT5otlYGRQr1vsm6+xXXBpO5BEr6puNcHQuv5JD
	 ajaHefKFgdyt0DiEYyxZvqwTChBbMSQGL6khwO/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B611BF8028E;
	Wed, 11 Mar 2020 15:52:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 771DFF801F8; Wed, 11 Mar 2020 15:52:28 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67659F80141
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 15:52:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67659F80141
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 07:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="242703763"
Received: from psingh6-mobl.amr.corp.intel.com (HELO [10.251.23.209])
 ([10.251.23.209])
 by orsmga003.jf.intel.com with ESMTP; 11 Mar 2020 07:52:18 -0700
Subject: Re: [PATCH 0/7] ASoC: Merge CPU/Codec DAIs
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <87y2s7vgxb.wl-kuninori.morimoto.gx@renesas.com>
 <03ac5f70-9aa3-b909-c693-caaa0afd09c9@linux.intel.com>
 <87k13rvd5g.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8e92f00a-6fb4-84e6-8e48-28b9913791c0@linux.intel.com>
Date: Wed, 11 Mar 2020 09:36:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87k13rvd5g.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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



On 3/10/20 9:27 PM, Kuninori Morimoto wrote:
> 
> Hi Pierre-Louis
> 
>>> 	rtd->cpu_dais   = [][][][][][][][][]
>>> 	rtd->codec_dais = [][][][][][][][][]
> (snip)
>>> 	rtd->dais = [][][][][][][][][][][][][][][][][][]
>>> 	            ^cpu_dais         ^codec_dais
>>> 	            |--- num_cpus ---|--- num_codecs --|
> (snip)
>> Is the end-goal to remove the cpu_dais and codec_dais, and fold them
>> as non-descript 'dais'? This is what I understand by "it will be no
>> longer good much for modern device"
> 
> Yes. We want to have non-descript DAIs in the future.
> I think this was indicated by Lars-Peter before at ELCE.
> But, I think we *can't* do it right now.
> Because many drivers are considering CPU and Codec separately.
> 
>> Or is this 'merge' a simple data handling change to avoid using two
>> "for" loops instead of one, and we are going to keep the distinction
>> between dais?
> 
> Yes.
> There are some functions which is doing something only for CPU or Codec.
> This patch-set do nothing to such functions.
> Maybe it can be updated in the future, maybe not (can't).
> 
> I hope this patch-set can be 1st step for non-descript DAIs.
> But the main purpose of this patch so far is that
> keeping current CPU / Codec DAIs method,
> but, simply merge such code *if possible*.
> 
>> more specifically I am concerned about the tons of code we have,
>> e.g. a random machine driver:
>>
>> 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>> 	struct snd_soc_jack *jack;
>> 	int ret;
>>
>> 	/* Configure sysclk for codec */
>> 	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK,
>>
>> If the rtd structure only has an array of dais, how would the codecs
>> be configured then?
> 
> The image is like this.
> It still can use rtd->cpu_dais, rtd->codec_dais.
> Of course for_each_rtd_cpu/codec_dais() macro too.
> 
> 	rtd->dais = [][][][][][][][][][][][][][][][][][]
> 	            ^cpu_dais         ^codec_dais
> 	            |--- num_cpus ---|--- num_codecs --|
> 
> 	rtd->cpu_dais   = &rtd->dais[0];
> 	rtd->codec_dais = &rtd->dais[dai_link->num_cpus];
> 
> So we can use/keep existing code/method same as before.
> Is this good answer for you ?

Thanks for the precisions.

I have no objections to the addition of the rtd->dais, it can indeed 
simplify the code by just processing all dais in the same loop.

I would still like to make sure we have an broadbrush idea of what the 
2nd step might be. It seems to me it's not possible to avoid having a 
notion of source/sink inside of a dailink (the wording is probably not 
right e.g. for full duplex, maybe domain1/domain2 component1/component2 
are more accurate). The dais are exposed by different components and are 
really the hook by which the components can be configured with 
compatible settings.

Thanks
-Pierre


