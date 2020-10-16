Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F6CC433E7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:20:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397D520848
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eIr1FELP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397D520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF76D17CD;
	Fri, 16 Oct 2020 18:19:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF76D17CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602865241;
	bh=KRh7qUNKj/686/P24+ONc4uywMplI8MMfYkIp9UGs7E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eIr1FELPdN609uxoTHV7AwLydZ39LCXFuq1b98FXjxZEDS2CVoCqligZjSn99Wm6Y
	 MQsitRr69Q+dAsFVO4/5U2rYClT9Xqn6hKi1ezWRvhGSZRWTjnwfp1PioBejuLhBJF
	 fxIe32zlBwBJyd34JbJt0s9Hk7y7MRXmbj7MMJh8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CA32F8020D;
	Fri, 16 Oct 2020 18:19:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB585F80217; Fri, 16 Oct 2020 18:19:49 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADD64F800B8
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 18:19:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADD64F800B8
IronPort-SDR: FwaQCF8Gg7HKqEOYDd1HjMdig6f5SAMTUEoAdvryPKuOurX5d6CnJCRASlPjnehRnAv9D2k3u7
 6ObdPqLMfatQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="163163716"
X-IronPort-AV: E=Sophos;i="5.77,383,1596524400"; d="scan'208";a="163163716"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2020 09:19:44 -0700
IronPort-SDR: 9ex3d/jKDvJWYK0TPP6mI96f8DwoufoBrf+3paoH02FuDcWGfgFgALpMyJYJBnyEiWYPl15cuE
 3Gvh3rX6RzfQ==
X-IronPort-AV: E=Sophos;i="5.77,383,1596524400"; d="scan'208";a="464727013"
Received: from mkorade-mobl.amr.corp.intel.com (HELO [10.254.99.143])
 ([10.254.99.143])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2020 09:19:42 -0700
Subject: Re: [PATCH] ASoC: Intel: boards: Add CML_RT1015 m/c driver
To: Mark Brown <broonie@kernel.org>, matsufan@gmail.com
References: <1602864145-32249-1-git-send-email-keith.tzeng@quantatw.com>
 <20201016160418.GF5274@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d286cbda-9dd7-fc8d-22fe-b0d8f6ef41ff@linux.intel.com>
Date: Fri, 16 Oct 2020 11:19:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016160418.GF5274@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>, mac.chiang@intel.com,
 Keith Tzeng <keith.tzeng@quantatw.com>
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



On 10/16/20 11:04 AM, Mark Brown wrote:
> On Sat, Oct 17, 2020 at 12:02:24AM +0800, matsufan@gmail.com wrote:
> 
>> +<<<<<<< HEAD
>>   obj-$(CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH) += snd-soc-cml_rt1011_rt5682.o
>> +=======
>> +obj-$(CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH) += cml_rt1011_rt5682.o
>> +obj-$(CONFIG_SND_SOC_INTEL_SOF_CML_RT1015_RT5682_MACH) += cml_rt1015_rt5682.o
>> +>>>>>>> 955c356... CHROMIUM: ASoC: Intel: boards: Add CML_RT1015 m/c driver
> 
> There's an unresolved conflict here :/

Was this patch shared on the mailing list? I don't see it in my inbox 
and in the archives?

At any rate, I am not hot on adding yet another machine driver just to 
change an amplifier version. It's really horrible to maintain all of 
these permutations by code duplication.

Adding a variant in a existing machine driver is a much better idea, and 
pretty much all new machine drivers follow this model. You could either 
rename the existing driver as cml_rt101x_rt5682 or use sof_rt5682.

Thanks
-Pierre

