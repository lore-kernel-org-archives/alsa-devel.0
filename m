Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19E1C10DC1
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Dec 2023 15:39:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02E6983A;
	Mon,  4 Dec 2023 16:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02E6983A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701704391;
	bh=bkf6JVVfUCqBbGhiGrUHi1gysUmPoAAmxSWpmZdALtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VKUSvbMFdxJUZfQtQ9pe4R9GEiyMXC5vh7+58hwKI0Z/AY1fPIxWu1/J6f1Xcds95
	 vsN8Ho6YqEDbOGihR7gZk0Zk9kxJxBYVcwryjy4m1V7wdvxomvcSoNwdOngcIAAixb
	 2iAOjXOHLk1Jdn36W3aHEhup2ICMc7Poprsm/hD8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59FE1F805C2; Mon,  4 Dec 2023 16:39:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67A91F805C1;
	Mon,  4 Dec 2023 16:39:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30DD9F805A0; Mon,  4 Dec 2023 16:39:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25595F800E4
	for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2023 16:38:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25595F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=g1Rx0a2M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701704329; x=1733240329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bkf6JVVfUCqBbGhiGrUHi1gysUmPoAAmxSWpmZdALtQ=;
  b=g1Rx0a2MhRLy8JsrgC383p87wHROjHZiDv6k8BsInjRGk26wzmMPancq
   3X8dqAI8zODLIZywM8Ug2UQxciA2dohMD4YjeRG0bT9WlAG2n7FnaGxPk
   3Q/C+wel0DBvyj6+D0N7gwJ+sGWWn+kLDelyk+WHuGTZw3Z0/nQRckydw
   xlztNVE8I17yWlB3JnrLoPActMocYSnGyYhbHY1T5N7+pWqe+pSE8WnYL
   jTjD4UzNU8/828AHyb5GrbbpP9lmj/kTAw+KrEndIGkiA2U7uuFDU9CXv
   t/FR2Fr2toNY7onkTcW+mcnpD6Bx5WaIPGGtgmt2HVmYlj2VX70z2JeN4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="794498"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600";
   d="scan'208";a="794498"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 07:38:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914473994"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600";
   d="scan'208";a="914473994"
Received: from sdneilso-mobl1.amr.corp.intel.com (HELO [10.212.147.197])
 ([10.212.147.197])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 07:38:42 -0800
Message-ID: <8510b464-9352-480d-88cf-857597e16cbc@linux.intel.com>
Date: Mon, 4 Dec 2023 08:55:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43 and
 cs35l56 support
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com
Cc: kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
 ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
References: <20231204135614.2169624-1-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231204135614.2169624-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: NDCGTVVAQIXCCUAWSFVAJ7E3ZGGPCRRE
X-Message-ID-Hash: NDCGTVVAQIXCCUAWSFVAJ7E3ZGGPCRRE
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NDCGTVVAQIXCCUAWSFVAJ7E3ZGGPCRRE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 12/4/23 07:56, Richard Fitzgerald wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> This is a test configuration for UpExtreme with Cirrus Logic
> CS35L56-EIGHT-C board.
> 
> The codec layout is configured as:
>     - Link3: CS42L43 Jack
>     - Link0: 2x CS35L56 Speaker (amps 1 and 2)
>     - Link1: 2x CS35L56 Speaker (amps 7 and 8)
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> Changes since V1:
> - Changed ALSA prefixes for CS35L56 to 'AMPn'
> - Renumbered the CS35L56 prefixes to match the numbering of the
>   OUTn speaker sockets on the EIGHT-C board
> ---
>  .../intel/common/soc-acpi-intel-tgl-match.c   | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
> index 5804926c8b56..e5f721ba5ed4 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c

> +static const struct snd_soc_acpi_adr_device cs35l56_0_adr[] = {
> +	{
> +		.adr = 0x00003301FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_r_endpoint,
> +		.name_prefix = "AMP1"
> +	},
> +	{
> +		.adr = 0x00003201FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_3_endpoint,
> +		.name_prefix = "AMP2"
> +	}
> +};
> +
> +static const struct snd_soc_acpi_adr_device cs35l56_1_adr[] = {
> +	{
> +		.adr = 0x00013701FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_l_endpoint,
> +		.name_prefix = "AMP8"
> +	},
> +	{
> +		.adr = 0x00013601FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_2_endpoint,
> +		.name_prefix = "AMP7"
> +	}
> +};

Don't we need the same change of name_prefix for
soc-acpi-intel-mtl-match.c? I see this in the existing code:

static const struct snd_soc_acpi_adr_device cs35l56_1_adr[] = {
	{
		.adr = 0x00013701FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_r_endpoint,
		.name_prefix = "cs35l56-8"
	},
	{
		.adr = 0x00013601FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_3_endpoint,
		.name_prefix = "cs35l56-7"
	}
};

static const struct snd_soc_acpi_adr_device cs35l56_2_adr[] = {
	{
		.adr = 0x00023301FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_l_endpoint,
		.name_prefix = "cs35l56-1"
	},
	{
		.adr = 0x00023201FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_2_endpoint,
		.name_prefix = "cs35l56-2"
	}
};

