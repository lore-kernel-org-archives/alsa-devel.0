Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EBDC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 18:11:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD6E610A6
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 18:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FD6E610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E22616A4;
	Wed, 18 Aug 2021 20:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E22616A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629310261;
	bh=psjiUaGaNpIDizmkRsxQbNKzS+NFkl8hpEIbjKZB5+I=;
	h=From:Subject:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iqA5B1VMgR+pRPI7BaULIKKryqYAenexrW7aN4gYWVhYDd2DXsEzaAiUzx4RxSwc1
	 jrRLNYIkuMOecT+hTOuU/gppPBJmvYR/OJre3PpUYxDswax3ZeffumVU95CeHRlRUU
	 /7JX/SzziUxVkrf+XNb7riz7ApnOc5R1GMw9qwYQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA50EF80246;
	Wed, 18 Aug 2021 20:10:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E29AF80249; Wed, 18 Aug 2021 20:10:07 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D70BF800EC
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 20:09:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D70BF800EC
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="213268923"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; d="scan'208";a="213268923"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 11:09:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; d="scan'208";a="449858802"
Received: from smendon-mobl.amr.corp.intel.com (HELO [10.212.121.30])
 ([10.212.121.30])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 11:09:46 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com> <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com> <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
 <YR0nAcC3wJd3b4Vu@kroah.com>
 <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
 <YR06L+gTzyiYY/rG@kroah.com>
Message-ID: <244b3030-0d24-300f-354d-46878b708056@linux.intel.com>
Date: Wed, 18 Aug 2021 13:09:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR06L+gTzyiYY/rG@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 vkoul@kernel.org, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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


>>>> a) we have to use request_module()
>>>
>>> Wait, why?
>>>
>>> module loading is async, use auto-loading when the hardware/device is
>>> found and reported to userspace.  Forcing a module to load by the kernel
>>> is not always wise as the module is not always present in the filesystem
>>> at that point in time at boot (think modules on the filesystem, not in
>>> the initramfs).
>>>
>>> Try fixing this issue and maybe it will resolve itself as you should be
>>> working async.
>>
>> It's been that way for a very long time (2015?) for HDAudio support, see
>> sound/pci/hda/hda_bind.c. It's my understanding that it was a conscious
>> design decision to use vendor-specific modules, if available, and
>> fallback to generic modules if the first pass failed.
> 
> If it has been this way for so long, what has caused the sudden change
> to need to export this and call this function?

Fair question, I did not provide all the context with a cover letter
that was already quite long. Here are more details:

In the existing Intel audio drivers, we have a PCI device that first get
probed. The PCI driver initializes the DSP and exposes what the audio
DSP can do, but the platform-specific configuration for a given board is
handled by a child device [1]. We have all kinds of hard-coded lookup
tables to figure out what the board is and what machine driver should be
used based on the presence of other ACPI devices and/or DMI quirks
[2][3]. We must have used this solution since 2010, mainly because 'the
other OS' does not rely on platform firmware for a description of the
audio capabilities.

In the 'soon' future, that machine driver will probed with its own ACPI
ID and become generic, with all the information related to the board
described in platform firmware and parsed by the driver. This is how the
'simple card' works today in Device Tree environments, platform firmware
describes how host-provided components are connected to 3rd-party
components. I cannot provide more details at this time since this is a
not yet a publicly-available specification (this specification work does
take place in a standardization body).

That change in how the machine driver gets probed creates a new problem
we didn't have before: this generic machine driver will probe in the
early stages of the boot, long before the DSP and audio codecs are
initialized/available.

I initially looked at the component framework to try to express
dependencies. It's really not clear to me if this is the 'right'
direction, for ASoC-based solutions we already have components that
register with a core.

I also started looking at other proposals that were made over the years,
this problem of expressing dependencies is not new. No real luck.

In the end, since the DeviceTree-based solutions based on deferred
probes work fine for the same type of usages, I tried to reuse the same
deferred probe mechanism. The only reason why I needed to export this
function is to work-around the request_module() use.

I am not claiming any award for architecture, this is clearly a
domain-specific corner case. I did try the async probe, I consulted with
Marc Brown, had an internal review with Dan Williams and Andy
Shevchenko. While nobody cheered, it seemed like this export was
'reasonable' compared to a re-architecture of the HDaudio/HDMI support -
which is a really scary proposition.

There is no immediate rush to make this change in this kernel cycle or
the next, I am open to alternatives, but I wanted to make sure we don't
have any Linux plumbing issues by the time the specification becomes
public and is used by 'the other OS'.

Does this help get more context?

[1] https://elixir.bootlin.com/linux/latest/source/sound/soc/sof/core.c#L234

[2]
https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/common/soc-acpi-intel-tgl-match.c#L323

[3]
https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/sof_sdw.c#L50




