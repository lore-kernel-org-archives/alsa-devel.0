Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2445DC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:10:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E29206FA
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vk7m8DPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E29206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1483E17A0;
	Fri, 13 Mar 2020 09:09:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1483E17A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584087015;
	bh=+Eq8i+8Leu2zNPm5DI+r0AgFKxEakGZRD+D+LWgSbS4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vk7m8DPEFacwALMtrQYcyj8LWKh7nIdzcCFoOYB/Vyh9CyhtOOyiK8cO8JUmj2p8m
	 P8nTyCyHurh9iMpfj2pICuDaEopg0NITRIUJXqBF69RdscQlmXbD/SFdlzA89v4qAT
	 RWzXpxjY1fbqaHq0NK3w0/QWBjueZElscazv0aDQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B308F80086;
	Fri, 13 Mar 2020 09:09:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FF4CF801EB; Fri, 13 Mar 2020 09:09:21 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 572FAF80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 09:09:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 572FAF80086
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 01:09:12 -0700
X-IronPort-AV: E=Sophos;i="5.70,547,1574150400"; d="scan'208";a="237140100"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.153.159])
 ([10.249.153.159])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Mar 2020 01:09:06 -0700
Subject: Re: [PATCH 01/10] ASoC: soc-acpi: expand description of _ADR-based
 devices
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
 <20200312193346.3264-2-pierre-louis.bossart@linux.intel.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <6ea77c3e-2333-2876-7fa1-ea8a2a6f35e4@linux.intel.com>
Date: Fri, 13 Mar 2020 09:09:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312193346.3264-2-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Mac Chiang <mac.chiang@intel.com>, srinivas.kandagatla@linaro.org,
 jank@cadence.com, Amery Song <chao.song@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Pan Xiuli <xiuli.pan@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, Rander Wang <rander.wang@linux.intel.com>,
 Sathya Prakash M R <sathya.prakash.m.r@intel.com>, broonie@kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Naveen Manohar <naveen.m@intel.com>, gregkh@linuxfoundation.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, slawomir.blauciak@intel.com
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



On 3/12/2020 8:33 PM, Pierre-Louis Bossart wrote:
> For SoundWire, we need to know if endpoints needs to be 'aggregated'
> (MIPI parlance, meaning logically grouped), e.g. when two speaker
> amplifiers need to be handled as a single logical output.
> 
> We don't necessarily have the information at the firmware (BIOS)
> level, so add a notion of endpoints and specify if a device/endpoint
> is part of a group, with a position.
> 
> This may be expanded in future solutions, for now only provide a group
> and position information.
> 
> Since we modify the header file, change all existing upstream tables
> as well to avoid breaking compilation/bisect.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   include/sound/soc-acpi.h                      | 39 ++++++--
>   .../intel/common/soc-acpi-intel-cml-match.c   | 87 +++++++++++++----
>   .../intel/common/soc-acpi-intel-icl-match.c   | 97 +++++++++++++++----
>   .../intel/common/soc-acpi-intel-tgl-match.c   | 49 ++++++++--
>   4 files changed, 221 insertions(+), 51 deletions(-)
> 

(...)

> diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> index 752733013d54..36e2d09cf58c 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> @@ -33,55 +33,112 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[] = {
>   };
>   EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_icl_machines);
>   
> -static const u64 rt700_0_adr[] = {
> -	0x000010025D070000
> +static const struct snd_soc_acpi_endpoint single_endpoint = {
> +	.num = 0,
> +	.aggregated = 0,
> +	.group_position = 0,
> +	.group_id = 0,
> +};
> +
> +static const struct snd_soc_acpi_endpoint spk_l_endpoint = {
> +	.num = 0,
> +	.aggregated = 1,
> +	.group_position = 0,
> +	.group_id = 1,
> +};
> +
> +static const struct snd_soc_acpi_endpoint spk_r_endpoint = {
> +	.num = 0,
> +	.aggregated = 1,
> +	.group_position = 1,
> +	.group_id = 1,
> +};
> +
> +static const struct snd_soc_acpi_adr_device rt700_0_adr[] = {
> +	{
> +		.adr = 0x000010025D070000,
> +		.num_endpoints = 1,
> +		.endpoints = &single_endpoint,
> +	}
>   };
>   
>   static const struct snd_soc_acpi_link_adr icl_rvp[] = {
>   	{
>   		.mask = BIT(0),
>   		.num_adr = ARRAY_SIZE(rt700_0_adr),
> -		.adr = rt700_0_adr,
> +		.adr_d = rt700_0_adr,
>   	},
>   	{}
>   };
>   
> -static const u64 rt711_0_adr[] = {
> -	0x000010025D071100
> +static const struct snd_soc_acpi_adr_device rt711_0_adr[] = {
> +	{
> +		.adr = 0x000010025D071100,
> +		.num_endpoints = 1,
> +		.endpoints = &single_endpoint,
> +	}
> +};
> +
> +static const struct snd_soc_acpi_adr_device rt1308_1_adr[] = {
> +	{
> +		.adr = 0x000110025D130800,
> +		.num_endpoints = 1,
> +		.endpoints = &single_endpoint,
> +	}
>   };
>   
> -static const u64 rt1308_1_adr[] = {
> -	0x000110025D130800
> +static const struct snd_soc_acpi_adr_device rt1308_2_adr[] = {
> +	{
> +		.adr = 0x000210025D130800,
> +		.num_endpoints = 1,
> +		.endpoints = &single_endpoint,
> +	}
>   };
>   
> -static const u64 rt1308_2_adr[] = {
> -	0x000210025D130800
> +static const struct snd_soc_acpi_adr_device rt1308_1_group1_adr[] = {
> +	{
> +		.adr = 0x000110025D130800,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_l_endpoint,
> +	}
>   };
>   
> -static const u64 rt715_3_adr[] = {
> -	0x000310025D071500
> +static const struct snd_soc_acpi_adr_device rt1308_2_group1_adr[] = {
> +	{
> +		.adr = 0x000210025D130800,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_r_endpoint,
> +	}
> +};
> +
> +static const struct snd_soc_acpi_adr_device rt715_3_adr[] = {
> +	{
> +		.adr = 0x000310025D071500,
> +		.num_endpoints = 1,
> +		.endpoints = &single_endpoint,
> +	}
>   };
>   
>   static const struct snd_soc_acpi_link_adr icl_3_in_1_default[] = {
>   	{
>   		.mask = BIT(0),
>   		.num_adr = ARRAY_SIZE(rt711_0_adr),
> -		.adr = rt711_0_adr,
> +		.adr_d = rt711_0_adr,
>   	},
>   	{
>   		.mask = BIT(1),
> -		.num_adr = ARRAY_SIZE(rt1308_1_adr),
> -		.adr = rt1308_1_adr,
> +		.num_adr = ARRAY_SIZE(rt1308_1_group1_adr),
> +		.adr_d = rt1308_1_adr,

Is this right, you use different struct in ARRAY_SIZE and assignment?

>   	},
>   	{
>   		.mask = BIT(2),
> -		.num_adr = ARRAY_SIZE(rt1308_2_adr),
> -		.adr = rt1308_2_adr,
> +		.num_adr = ARRAY_SIZE(rt1308_2_group1_adr),
> +		.adr_d = rt1308_2_adr,

Same here.

>   	},
>   	{
>   		.mask = BIT(3),
>   		.num_adr = ARRAY_SIZE(rt715_3_adr),
> -		.adr = rt715_3_adr,
> +		.adr_d = rt715_3_adr,
>   	},
>   	{}
>   };
> @@ -90,17 +147,17 @@ static const struct snd_soc_acpi_link_adr icl_3_in_1_mono_amp[] = {
>   	{
>   		.mask = BIT(0),
>   		.num_adr = ARRAY_SIZE(rt711_0_adr),
> -		.adr = rt711_0_adr,
> +		.adr_d = rt711_0_adr,
>   	},
>   	{
>   		.mask = BIT(1),
>   		.num_adr = ARRAY_SIZE(rt1308_1_adr),
> -		.adr = rt1308_1_adr,
> +		.adr_d = rt1308_1_adr,
>   	},
>   	{
>   		.mask = BIT(3),
>   		.num_adr = ARRAY_SIZE(rt715_3_adr),
> -		.adr = rt715_3_adr,
> +		.adr_d = rt715_3_adr,
>   	},
>   	{}
>   };

(...)
