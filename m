Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC46EE4996
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Aug 2023 07:50:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D69B9839;
	Mon, 21 Aug 2023 09:50:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D69B9839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692604255;
	bh=iGJb96QKLQwa2nVts2t+fDAl3b6kKUYFKD5LXEbwk+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BtfdMl6AplgBzrv3IcRW5OFw79WOt78VPAsk5mV3reBUmkIt1ZIZKb/y9+Db4z+e+
	 jEcwocQf2YAwn6cpOCD6M0YuUDNLmcbiYvFh+omSsdogo9CMNc1g12T5gD6re0vTjs
	 5o869/TxT6P/STfY69Hqd8YerXqokTgTXdNAMeCQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 646D2F80536; Mon, 21 Aug 2023 09:49:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 30DD1F800BF;
	Mon, 21 Aug 2023 09:49:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F0E3F80199; Mon, 21 Aug 2023 09:49:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 815AFF8014C
	for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2023 09:49:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 815AFF8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V0y6uws0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692604182; x=1724140182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iGJb96QKLQwa2nVts2t+fDAl3b6kKUYFKD5LXEbwk+o=;
  b=V0y6uws0Cfao4MMemqls/t53ZO5iF9BjDF2ju6qB97RKJ4qu4EwT4Y10
   h3J7JAU7czX8F9EX3Z9ls8UbNSPkwxZTHtoMMuJmgjsTBBO34oEHFF2ML
   0Y8tiYN/JSfaFXaa4IWufggFkScNCeotNqXiVmNEuMmS+OsLbTsvvcdG1
   PzHpipRGW4ih9mDHFPawjdX2I0o0Br8+iBTEsf3x2t9zAxVlULys3449/
   VOdF7v41GQfhC4+A7/G5bOGGCnL3ZQRcv0k+mBxVg9uN1CtBwrQ8zsC1Q
   sZRIJ5aMIMIz+QMpi1f4IBKxiEuybcjFDJFHJZCtGhtV8j6xwdbF5zEgm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="363683988"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200";
   d="scan'208";a="363683988"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2023 00:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="850084837"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200";
   d="scan'208";a="850084837"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91])
 ([10.94.0.91])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2023 00:49:31 -0700
Message-ID: <b5ed133e-8a4c-90d5-74c5-b8b220327813@linux.intel.com>
Date: Mon, 21 Aug 2023 09:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 17/17] ASoC: Intel: avs: Kill S24_LE in HDAudio
 streaming
To: Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org,
 tiwai@suse.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 hdegoede@redhat.com
References: <20230811164853.1797547-1-cezary.rojewski@intel.com>
 <20230811164853.1797547-18-cezary.rojewski@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230811164853.1797547-18-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: B5UUAX7IFRFS2U4UBHTU3KO26S5G3JZL
X-Message-ID-Hash: B5UUAX7IFRFS2U4UBHTU3KO26S5G3JZL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B5UUAX7IFRFS2U4UBHTU3KO26S5G3JZL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 8/11/2023 6:48 PM, Cezary Rojewski wrote:
> Eliminate all occurrences of S24_LE within the HDAudio related pcm code,
> both HOST and LINK side. Replace those with MSBITS subformats to allow
> for granular selection when S32_LE is the format of choice.
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/avs/pcm.c      | 4 +++-
>   sound/soc/intel/avs/topology.c | 9 ++++++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
> index 31737133b991..83cdce8fead4 100644
> --- a/sound/soc/intel/avs/pcm.c
> +++ b/sound/soc/intel/avs/pcm.c
> @@ -1160,8 +1160,10 @@ static const struct snd_pcm_hardware avs_pcm_hardware = {
>   				  SNDRV_PCM_INFO_RESUME |
>   				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
>   	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
> -				  SNDRV_PCM_FMTBIT_S24_LE |
>   				  SNDRV_PCM_FMTBIT_S32_LE,
> +	.subformats		= SNDRV_PCM_SUBFMTBIT_MSBITS_20 |
> +				  SNDRV_PCM_SUBFMTBIT_MSBITS_24 |
> +				  SNDRV_PCM_SUBFMTBIT_MSBITS_32,
>   	.buffer_bytes_max	= AZX_MAX_BUF_SIZE,
>   	.period_bytes_min	= 128,
>   	.period_bytes_max	= AZX_MAX_BUF_SIZE / 2,
> diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
> index 118f386d8582..5130261f0b33 100644
> --- a/sound/soc/intel/avs/topology.c
> +++ b/sound/soc/intel/avs/topology.c
> @@ -1620,8 +1620,15 @@ static int avs_dai_load(struct snd_soc_component *comp, int index,
>   			struct snd_soc_dai_driver *dai_drv, struct snd_soc_tplg_pcm *pcm,
>   			struct snd_soc_dai *dai)
>   {
> -	if (pcm)
> +	u64 subformats = SNDRV_PCM_SUBFMTBIT_MSBITS_20 |
> +			 SNDRV_PCM_SUBFMTBIT_MSBITS_24;

SNDRV_PCM_SUBFMTBIT_MSBITS_32 seems to be missing in the above?

> +
> +	if (pcm) {
>   		dai_drv->ops = &avs_dai_fe_ops;
> +		dai_drv->capture.subformats |= subformats;
> +		dai_drv->playback.subformats |= subformats;
> +	}
> +
>   	return 0;
>   }
>   

