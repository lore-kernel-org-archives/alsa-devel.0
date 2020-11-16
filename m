Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416DEC4742C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 17:59:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE79221527
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 17:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jPOTzpv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE79221527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F0EE1701;
	Mon, 16 Nov 2020 18:58:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F0EE1701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605549547;
	bh=YQc4aaF9wNx2xHj0MdAD9g8TiSgOaQcDrLQbzlj1Ki0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jPOTzpv4uJHwnzaiBMM6mlIUwv6XdaaI1rFMj8UcyUYO+s7HZ3m2ggGOI9fe+SyTk
	 7wuyuT2uruR/vbdANSjzKHW1pJnQT5yaz01q8mSTch33mpgMKjPu4qNOWLtHyt7KYT
	 GZJnMrp95TpziHyewIDokR5HfVTGga1X690vU5nI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB688F80167;
	Mon, 16 Nov 2020 18:58:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 841F6F80168; Mon, 16 Nov 2020 18:58:15 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF80DF8010A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 18:58:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF80DF8010A
IronPort-SDR: oCHQdAygdU4XKwZ9jCy2zlKP0nVkbDNm0TjX3nTeq0awePIhXCP04LsCmq1iWoy3W+hg5u2vUt
 bFmr0Bxs1RhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="157812207"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; d="scan'208";a="157812207"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 09:58:02 -0800
IronPort-SDR: ihyv+UQ+JIiTFQxDiHy5yB6kuDIuTzvzPjqmX9tOZfRsszfqfDXW02aaAuin9RAh/AbHwOUanH
 r6cQlmv++1rg==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; d="scan'208";a="475615027"
Received: from schekuri-mobl.amr.corp.intel.com (HELO [10.209.161.230])
 ([10.209.161.230])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 09:58:01 -0800
Subject: Re: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
To: "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
 <0a0854d1ddaf4f9b81ef5569a7d501a5@intel.com>
 <20201113164946.GD4828@sirena.org.uk>
 <2cf7075b-bd51-21a5-2058-3a98e6c488a7@redhat.com>
 <d462c890495e4dda8698b5ba5eb50066@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f62abcd8-b67f-774b-61b5-e08cfc3d2cc7@linux.intel.com>
Date: Mon, 16 Nov 2020 11:47:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d462c890495e4dda8698b5ba5eb50066@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "tiwai@suse.de" <tiwai@suse.de>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
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



> +static inline bool snd_soc_acpi_sof_parent(struct device *dev)
> +{
> +	return dev->parent && dev->parent->driver && dev->parent->driver->name &&
> +		!strcmp(dev->parent->driver->name, "sof-audio-acpi");
> +}
> +
> 
> -and-
> 
> +	/* set pm ops */
> +	if (sof_parent)
> +		pdev->dev.driver->pm = &snd_soc_pm_ops;
> +

The legacy Baytrail/Cherrytrail driver uses its own power management 
flow instead of the ASoC one. This patch does not cause the problem, it 
recognizes instead that this legacy driver cannot use the same pm ops.

I wish we didn't have to do this but there's just no alternative.

Dynamically assigning the .pm ops is not illegal and has been done in 
other drivers.

> -and-
> 
> +	/* set card and driver name */
> +	if (snd_soc_acpi_sof_parent(&pdev->dev)) {
> +		bdw_rt5650_card.name = SOF_CARD_NAME;
> +		bdw_rt5650_card.driver_name = SOF_DRIVER_NAME;
> +	} else {
> +		bdw_rt5650_card.name = CARD_NAME;
> +		bdw_rt5650_card.driver_name = DRIVER_NAME;
> +	}
> +

That is also intentional. We modified the card names based on Jaroslav's 
feedback, and this code change is just the mirror of what happened 
before with build-time code changes. Should we have changed the legacy 
card names? Maybe, but that might have added issues for users so we left 
the names untouched.

> pieces that are appearing several times throughout the series.
> ASoC is a framework on its own. It is by all means an extension to an
> older, more general ALSA framework. With every passing month SOF code
> found in /sound/soc/sof gets closer to becoming yet another framework,
> one that is placed on top of ASoC. Samples taken from this series
> augment this statement. If ASoC framework is missing means for its child
> drivers to do specific things, it's better to update the framework than
> creating yet another one.

There are no ASoC devices or drivers, we use platform devices/drivers. I 
don't see any need for an ASoC extension here.

> Explicit 'ifs' asking whether we're dealing with SOF or other solution
> is at best a code smell. I believe this is unnecessary complexity added
> to the code especially once you realize user needs to play with module
> parameters to switch between solutions. If we assume user is able to
> play with module parameters then why not simply make use of blacklist
> mechanism?

Been there, done that. We don't want to use either denylist of kernel 
parameters.

denylists create confusion for users, it's an endless stream of false 
errors and time lost in bug reports.

The use of the kernel parameter is ONLY for expert users who want to 
tinker with the system or debug issues, the average user should not have 
to play with either denylists or kernel parameters.

> And last but not least: intel-dsp-config is (as already stated) a mean
> for solving the HDA-runtime-driver-selection problem. Mixing it with
> ACPI devices is another layer of confusion.

Why? Who said it was PCI only? We already take care of DMIC, SoundWire, 
Google Chromebooks, open platforms, why not ACPI? It's just one API to 
be used when more than one driver can register to the same device.

>> Exactly. As Pierre-Louis mentions the Intel team does not have most
>> of the affected hardware. Since I've been working on making BYT and CHT
>> based devices work better with Linux as a side project for the last
>> couple of years I have been buying these kinda devices 2nd hand when ever
> ...
>> As Pierre-Louis mentioned I've already been working with him on getting
>> ready to move everything BYT/CHT related over to SOF. I've already been
>> testing SOF on various devices with mostly ok results so far.
>> But this is a process not a switch which we can simply throw.
> 
> Hans, thanks for sharing your concerns.
> 
> I'm afraid it's basically impossible to be fully prepared as you and
> Pierre pointed out. Even when speaking about catpt and BDW, we too
> didn't have all the available production stuff.
> 
> And thus I don't believe there will ever be a "good moment" to switch.
> Once internal validation confirms driver is stable it's better to switch
> entirely to the new solution with CI and devs on standby - ready to
> address any upcoming reports. Don't believe /atom/ has clean slide
> anyway given the patches and issues being posted from time to time
> related to said solution.

You refer to tests made by Intel when we are talking about community 
based tests here. We precisely do not have 'CI and devs on standby', the 
transition will be made by distributions themselves.

Besides, CI cannot test jack detection and all the flavors of 
microphone/speaker placements, which are the source of 99% of the issues.

> I understand you're here for atom-based products yet the patchset also
> touches on catpt aka hsw/bdw. While to my knowledge old /atom/ has no
> active CI running - so the switch is desirable - the same cannot be said
> about catpt. Because of that, I don't see any reason for appending any
> catpt-related changes here. Leave no place for confusion. One solution
> for one architecture that's recommended and maintained.

There is no confusion, the wording is explicit

"
SOF does not fully support Broadwell and has limitations related to
+	  DMA and suspend-resume, this is not a recommended option for
+	  distributions.
"

But there are niche users who prefer it for their own experiments, so 
what's the issue in making their life simpler?
