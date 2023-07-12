Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BD7EB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 12:17:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF956203;
	Wed, 12 Jul 2023 14:17:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF956203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689164273;
	bh=+tlum6euBaSBSYRCVrhu1uXmmTQNXoNiIGldL0XknoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Lt0EbsFWViwgHYt9mMM1A/sTB1S6t9PuhcZbQCZyDASffV4AZRcrz6emYoNKKsJyP
	 ahwDbTQn8TwIS1lPKvFLJnw22f5PTEpqi4ROMAAnVmEsMTRggILPOEhjuBLSpR3+Ik
	 ydWrp7RLKY6/rJeX/4EzF7bFEG0FF4WUYHLkwBsg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A725F80548; Wed, 12 Jul 2023 14:16:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 153A8F80249;
	Wed, 12 Jul 2023 14:16:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DE434F80249; Wed, 12 Jul 2023 14:16:30 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8E556F80153
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 14:16:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E556F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lf1URZvq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689164186; x=1720700186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+tlum6euBaSBSYRCVrhu1uXmmTQNXoNiIGldL0XknoY=;
  b=lf1URZvqrZ4MLI/WwYGyrJj1Zsuf1BLMj04D0JFX5+T/LCt7PmdiICn4
   7bvbXx2IXpiYLisl/Gc7GGwEjjc04GvxjtrpWUaz0xxDmbJ9YTS5ktrrV
   pAW3WrdpgaNySJ4QcNGYUjBO2dLnidwgmKlNNTmN6QTEbhtQLZzxVsM05
   mn4nweIUw3bTsQyYwgenjgc/k7iSDAY7ApJsXm0I6qdCv0iI7pXOn4V/a
   QfDzorGLziNOZZkkUOTuoMnbXC2x2NLrFp6WjXHc2BiMLHj+nfFKyl2bR
   sELKwNeAtSsHnQi4H/29npVg5UqACpiYP08LisEo8MFXbkzOls0DGHHxx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428610621"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200";
   d="scan'208";a="428610621"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 05:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="811551375"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200";
   d="scan'208";a="811551375"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144])
 ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 05:16:19 -0700
Message-ID: <ec6a8f88-ae94-21a5-ec01-013c68fd8feb@linux.intel.com>
Date: Wed, 12 Jul 2023 14:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/13] ASoC: SOF: Intel: Convert to PCI device IDs defines
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-13-amadeuszx.slawinski@linux.intel.com>
 <ZK1kPXm+FieJ+vya@smile.fi.intel.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZK1kPXm+FieJ+vya@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NLLPSDVUOVNIMKIEVKDILPS4W5E2HD2H
X-Message-ID-Hash: NLLPSDVUOVNIMKIEVKDILPS4W5E2HD2H
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NLLPSDVUOVNIMKIEVKDILPS4W5E2HD2H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 7/11/2023 4:16 PM, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 02:57:25PM +0200, Amadeusz Sławiński wrote:
>> Use PCI device IDs from pci_ids.h header and while at it change to using
>> PCI_DEVICE_DATA() macro, to simplify declarations.
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Oh, additional remark below.
> 
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
>>   sound/soc/sof/intel/pci-apl.c |  9 +++----
>>   sound/soc/sof/intel/pci-cnl.c | 15 ++++--------
>>   sound/soc/sof/intel/pci-icl.c | 12 ++++------
>>   sound/soc/sof/intel/pci-mtl.c |  3 +--
>>   sound/soc/sof/intel/pci-skl.c |  6 ++---
>>   sound/soc/sof/intel/pci-tgl.c | 45 ++++++++++++-----------------------
>>   sound/soc/sof/intel/pci-tng.c |  3 +--
>>   7 files changed, 31 insertions(+), 62 deletions(-)
>>
>> diff --git a/sound/soc/sof/intel/pci-apl.c b/sound/soc/sof/intel/pci-apl.c
>> index 69cad5a6bc72..083659ddfe6b 100644
>> --- a/sound/soc/sof/intel/pci-apl.c
>> +++ b/sound/soc/sof/intel/pci-apl.c
>> @@ -85,12 +85,9 @@ static const struct sof_dev_desc glk_desc = {
>>   
>>   /* PCI IDs */
>>   static const struct pci_device_id sof_pci_ids[] = {
>> -	{ PCI_DEVICE(0x8086, 0x5a98), /* BXT-P (ApolloLake) */
>> -		.driver_data = (unsigned long)&bxt_desc},
>> -	{ PCI_DEVICE(0x8086, 0x1a98),/* BXT-T */
>> -		.driver_data = (unsigned long)&bxt_desc},
>> -	{ PCI_DEVICE(0x8086, 0x3198), /* GeminiLake */
>> -		.driver_data = (unsigned long)&glk_desc},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &bxt_desc) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL_T, &bxt_desc) },
> 
> Have we ever had APL-T? What is that? I remember that we have had two or
> three BXTs inside, and then products become for Broxton and Apollo Lake
> SoC codenames. I never have heard about -T...
> 

I've talked a bit with Cezary and it seems that 0x1a98 is BXT-M (not -T) 
and it's an RVP, BXT-M B0 to be specific. From what we know no BXT is 
available on market. Perhaps we can just remove it?


