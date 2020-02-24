Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A23C11D2F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:07:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E10520838
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RqlAyxUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E10520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE647168F;
	Mon, 24 Feb 2020 18:06:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE647168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582564063;
	bh=AmS2UEsveX5UyPuL696v7vyNe/t/HxO7u7yqnmc8O+k=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RqlAyxUVJ4Hi6CsQyJojvaySbuwNMrcGoQ2AxryQ+poRecA+UkBmw8IMyTzR2N2v3
	 2SUTGV8aXTB8/isF3QWBmWpqdOMQzi3vIqgSUmjJYTgcC/FxZ3pL5ARQHTz8WIqfAP
	 B93CnambZ65iFeyTxV8FjPxiX6cvCpRLOJNOjwmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F748F80171;
	Mon, 24 Feb 2020 18:06:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B2FAF80216; Mon, 24 Feb 2020 18:06:00 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17636F80090
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 18:05:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17636F80090
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 09:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; d="scan'208";a="230713354"
Received: from rjgardn2-mobl1.amr.corp.intel.com (HELO [10.254.182.151])
 ([10.254.182.151])
 by orsmga008.jf.intel.com with ESMTP; 24 Feb 2020 09:05:48 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: codecs: make PCM5102A codec selectable
To: David Douard <david.douard@sdfa3.org>, alsa-devel@alsa-project.org
References: <20200214002505.13112-1-david.douard@sdfa3.org>
 <ae4df82b-4493-4086-1654-2b6d62cf7d0e@linux.intel.com>
 <01adc4dc-e83e-c9a7-d4ab-71fa1aa30ee0@sdfa3.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7ef7d0a0-edd1-42b6-c4cc-1399e82fcdc0@linux.intel.com>
Date: Mon, 24 Feb 2020 10:13:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <01adc4dc-e83e-c9a7-d4ab-71fa1aa30ee0@sdfa3.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>
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


>>> The PCM5102A codec entry in the Kconfig file lacks a title/description
>>> to make it selectable in menuconfig (since it has no dependent i2s/spi
>>> sub-modules like e.g. the pcm512x one).
>>
>> For my education, who uses this codec? it's not selected by any machine
>> driver?
> 
> This codec is needed to drive PCM5102A based i2s DAC. It can be found in
> several low cost I2S DAC break boards (I have a Polyvection one for
> example) and is generally used on SBC like the RPi, Odroid or Orange Pi.
> 
> On such devices, the driver will be selected via a proper declaration of
> the device in the device tree (e.g. in a custom dts file). See for
> example this issue I submitted to the Armbian project (together with a
> PR that patches this very same issue I described in this thread):
> 
>    https://github.com/armbian/build/issues/1798

Right, but what I was referring to is what is also suggested in that 
link, codecs are typically selected from a machine driver Kconfig, i.e.

  config SND_SUN4I_I2S
  	tristate "Allwinner A10 I2S Support"
+	depends on OF
  	select SND_SOC_GENERIC_DMAENGINE_PCM
  	select REGMAP_MMIO
+	select SND_SOC_PCM5102A

Your patch provides a means for a user to force the codec driver to be 
compiled in, but it doesn't help select the minimal config needed on a 
given platform. Anyways no real objections so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
