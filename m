Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE13C54E94
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jan 2023 17:17:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4163F6C0;
	Wed, 25 Jan 2023 18:17:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4163F6C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674667071;
	bh=+FsfjVh96kHMiXflnl9uGUaz68h9YTawTmC/lL5rqUo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vUa33FChzF6xPl2prXEkz7oSByRt0NpHP3P7fXQHuwnL8Wf7p16OHrjrsdTms/wzN
	 TsOGGQBNUBv292mZbwdA8dzQT8ErHnq0ipM2jT22x4nbAvjeSHa2g5U6owClbonSnL
	 8CkaGOU/O8p+kViScuZs7z23YWH/AvnX6wwYnlEo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCF97F80163;
	Wed, 25 Jan 2023 18:17:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 730AFF802E8; Wed, 25 Jan 2023 18:16:59 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9908F800FB
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 18:16:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9908F800FB
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aCoMSfEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674667017; x=1706203017;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+FsfjVh96kHMiXflnl9uGUaz68h9YTawTmC/lL5rqUo=;
 b=aCoMSfEPEpgLbKfs5jAjChSgE83LyF/LlHgPdBAqPntHCNND1uwKR3X2
 8Jb0zr0jrs0trvwP8eUtB1lGShv3slWvz/3pCimUqPCZg+JRuzA2KZVgm
 93ndIIMou+Uw2ERjm2dMRaC7OBLgyO832DtBH/MWDh+wTuIcwucSpyZdq
 vaPWSFIRowb3OHu0F3oXoH4SaW4lX/GpTkCJaz5Dnji1fsO2HCUoa7Wy3
 Jf2egjjbwNXHuuGIAKTA8gifg/CsLnEik2Vqk7GC3dFIbc04azXn+gicu
 WFCFzSAM8GMaG3hme5p5qp/YBtzO7wClelI4qZD6lcz4M12/EGQ1Wr2bC Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="327868193"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; d="scan'208";a="327868193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 09:15:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="805068835"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; d="scan'208";a="805068835"
Received: from bshunt-mobl.amr.corp.intel.com (HELO [10.212.37.80])
 ([10.212.37.80])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 09:15:31 -0800
Message-ID: <92052eef-3c61-7f3e-75c1-09b76cd38e24@linux.intel.com>
Date: Wed, 25 Jan 2023 11:15:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/5] ASoC: amd: acp: Refactor i2s clocks programming
 sequence
Content-Language: en-US
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 broonie@kernel.org, alsa-devel@alsa-project.org
References: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
 <20230109132104.1259479-4-venkataprasad.potturu@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230109132104.1259479-4-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>,
 Jia-Ju Bai <baijiaju1990@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, Vijendar.Mukunda@amd.com,
 V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch adds new Sparse warnings [1]:

sound/soc/amd/acp/acp-mach-common.c:189:35: error: restricted
snd_pcm_format_t degrades to integer
sound/soc/amd/acp/acp-mach-common.c:333:35: error: restricted
snd_pcm_format_t degrades to integer
sound/soc/amd/acp/acp-mach-common.c:478:35: error: restricted
snd_pcm_format_t degrades to integer
sound/soc/amd/acp/acp-mach-common.c:619:35: error: restricted
snd_pcm_format_t degrades to integer

> @@ -193,7 +163,11 @@ static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
>  	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>  	int ret;
> -	unsigned int fmt;
> +	unsigned int fmt, srate, ch, format;
> +
> +	srate = params_rate(params);
> +	ch = params_channels(params);
> +	format = 8 * params_format(params);

This last line looks suspicious, no? format-to-physical-size conversions
should be using existing macros.

Should it be

format = params_physical_width(params);

?


> +	/* Set tdm/i2s1 master bclk ratio */
> +	ret = snd_soc_dai_set_bclk_ratio(codec_dai, ch * format);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "Failed to set rt5682 tdm bclk ratio: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!drvdata->soc_mclk) {
> +		ret = acp_clk_enable(drvdata, srate, ch * format);
> +		if (ret < 0) {
> +			dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
> +			return ret;
> +		}

[1]
https://github.com/thesofproject/linux/actions/runs/4005001249/jobs/6874834205
