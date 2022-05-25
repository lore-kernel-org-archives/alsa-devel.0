Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16C7C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 25 May 2022 21:32:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D87C6163C;
	Wed, 25 May 2022 23:31:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D87C6163C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653514335;
	bh=FoPSSUs1/5dO5P26gVSwaImoqHPclA56N3pkOrZONTg=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DV3oWyWc3sF/5016iovX8EOpgffB8GA9eTt4TR8bswJGOPYVqGxTOhjh2y9CLogPC
	 IJYQpQYwD5lEYTwhTqXhNbQB0OLjztEOSbTVmwKAL3tUSlR3G8TWRkgNPPKCP0yps7
	 f0wzc/WMmEZuVisLgKScK8mhahzIrVE7CMz9njrM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F4F0F8016D;
	Wed, 25 May 2022 23:30:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68762F804B1; Wed, 25 May 2022 23:30:55 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8C39F80169
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2022 23:30:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8C39F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="EGZw/eW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653514250; x=1685050250;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FoPSSUs1/5dO5P26gVSwaImoqHPclA56N3pkOrZONTg=;
 b=EGZw/eW1fwP0J3SfRqxzmQggaHlzXN0ICbcgKUE6I/NaPyVkyRtUvlMC
 KTH6S94E5Rt+qhJa3NHxme2e5TpKzfQpj3ntPs3ZXJfjG2JJ/AwJx2a9a
 pGZzscpd1i/Mxo8WJahdrsqtzs9A3fPDHFSDGr0hWbOd9V1EgG9EUdjqe
 mIGbCNQPBjGBB22rsOwJeOyVjvy9Q559+WyXb1x6nI3DhEy/8M6cUcK0N
 Sn+LQQJY4K3roljSYuRbErBVhP81SsRpdiJ4LPnotV4PBgoDR3h0pZFd+
 uRn+3Q9wVSIGshFmoQsBbRqwEg9m4XTbd6poYn75S1mPeHOn4NTYaY/Mn A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253812017"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; d="scan'208";a="253812017"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2022 14:30:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; d="scan'208";a="745955669"
Received: from srotter-mobl1.amr.corp.intel.com (HELO [10.212.216.74])
 ([10.212.216.74])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2022 14:30:38 -0700
Message-ID: <01acfbad-7668-dfc6-b797-a9fa5f402a26@linux.intel.com>
Date: Wed, 25 May 2022 16:28:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] ASoC: amd: acp: Add support for rt5682s and rt1019
 card with hs instance
Content-Language: en-US
To: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20220525203415.2227914-1-Vsujithkumar.Reddy@amd.com>
 <20220525203415.2227914-3-Vsujithkumar.Reddy@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220525203415.2227914-3-Vsujithkumar.Reddy@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sunil-kumar.Dommati@amd.com, ajitkumar.pandey@amd.com,
 Kai Vehmanen <kai.vehmanen@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jia-Ju Bai <baijiaju1990@gmail.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
 Vijendar.Mukunda@amd.com
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



On 5/25/22 15:34, V sujith kumar Reddy wrote:
> We have new platform with rt5682s as a primary codec and rt1019 as an
> amp codec. Add machine struct to register sof audio based sound card
> on such Chrome machine.
> 
> Here we are configuring as a soc mclk master and codec slave.
> 
> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
> ---
>  sound/soc/amd/acp-config.c          |  9 ++++
>  sound/soc/amd/acp/acp-mach-common.c | 69 ++++++++++++++++++++++++-----
>  sound/soc/amd/acp/acp-sof-mach.c    | 15 +++++++
>  3 files changed, 82 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
> index ba9e0adacc4a..39ca48be7be9 100644
> --- a/sound/soc/amd/acp-config.c
> +++ b/sound/soc/amd/acp-config.c
> @@ -147,6 +147,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
>  		.fw_filename = "sof-rmb.ri",
>  		.sof_tplg_filename = "sof-acp-rmb.tplg",
>  	},
> +	{
> +		.id = "RTL5682",
> +		.drv_name = "rt5682s-hs-rt1019",
> +		.pdata = &acp_quirk_data,
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &amp_rt1019,
> +		.fw_filename = "sof-rmb.ri",
> +		.sof_tplg_filename = "sof-acp-rmb.tplg",
> +	},

that means a 3rd entry with the same pair of firmware/topology files?

>  	{},
>  };
>  EXPORT_SYMBOL(snd_soc_acpi_amd_rmb_sof_machines);
> diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
> index a03b396d96bb..4aad3fee51cf 100644
> --- a/sound/soc/amd/acp/acp-mach-common.c
> +++ b/sound/soc/amd/acp/acp-mach-common.c
> @@ -148,10 +148,15 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
>  	struct snd_soc_card *card = rtd->card;
>  	struct acp_card_drvdata *drvdata = card->drvdata;
>  	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> -	int ret;
> +	unsigned int fmt = 0;

fmt initialization is overridden below.

> +	int ret = 0;

useless init...

>  
> -	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> -				   | SND_SOC_DAIFMT_CBP_CFP);
> +	if (drvdata->soc_mclk)
> +		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
> +	else
> +		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
> +
> +	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);

... overridden here

>  	if (ret < 0) {
>  		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
>  		return ret;

