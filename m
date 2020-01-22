Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8369DC2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:43:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBB02465B
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tB/QJ+CW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBB02465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 858F91688;
	Wed, 22 Jan 2020 11:42:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 858F91688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579689818;
	bh=9t3c+CiiLq1YIDdAZfVQ2lCS//sNYq9rr8+BAUgoHhE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tB/QJ+CWQH8QLGPfzLlae2hz0l12EKGdt5XvJa8V9vVBjf5ROqVZ3S0kUw324dxIb
	 AC+dWnIKFqj84Y9XaH6vRiTDWN0XlhoHpGI7ro5EmAvHWYRMUqGj9fqLM6sog7kkqj
	 mnIGP1+uDavPg8j4GDqgDDdQlojAipfAzmBEai/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5633F8022D;
	Wed, 22 Jan 2020 11:42:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B7DBF80245; Wed, 22 Jan 2020 11:42:18 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACFDDF8007E
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 11:42:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACFDDF8007E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jan 2020 02:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; d="scan'208";a="374882737"
Received: from hpendurt-mobl1.amr.corp.intel.com (HELO [10.255.85.187])
 ([10.255.85.187])
 by orsmga004.jf.intel.com with ESMTP; 22 Jan 2020 02:42:08 -0800
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <87a76gmiar.wl-kuninori.morimoto.gx@renesas.com>
 <CAFQqKeV3174asC4Nd9iJawnv3X78Ec4Js3G=kQNJ0m3EiXtyBg@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d709c088-50b1-fdae-fccc-2aec49743bf2@linux.intel.com>
Date: Wed, 22 Jan 2020 04:42:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFQqKeV3174asC4Nd9iJawnv3X78Ec4Js3G=kQNJ0m3EiXtyBg@mail.gmail.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 0/7] ASoC: soc-pcm: add soc_rtd_xxx()
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


>> My ALSA SoC cleanup series focus to soc-pcm as 2nd step :)
>> These create new soc_rtd_xxx() function, and cleanup soc-pcm.c
>> (It will be more cleanup later)
>>
>> Kuninori Morimoto (7):
>>    ASoC: soc-pcm: add soc_rtd_startup()
>>    ASoC: soc-pcm: add soc_rtd_shutdown()
>>    ASoC: soc-pcm: add soc_rtd_prepare()
>>    ASoC: soc-pcm: add soc_rtd_hw_params()
>>    ASoC: soc-pcm: add soc_rtd_hw_free()
>>    ASoC: soc-pcm: add soc_rtd_trigger()
>>    ASoC: soc-core: remove null_snd_soc_ops
> 
> The series looks good. Thanks, Morimoto-san.
> 
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

LGTM as well.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
