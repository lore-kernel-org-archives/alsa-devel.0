Return-Path: <SRS0=hLTZ=7B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD018C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 01:46:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C67D20657
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 01:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HMPeUHuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C67D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AF20179D;
	Tue, 19 May 2020 03:46:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AF20179D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589852814;
	bh=H0tdezm6VvSNp+WW6MdgkZayeU1c0ffBeRS+/QANZk8=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HMPeUHuvuu98cs0tOZJbE7FmkrOqYXqs++23NCHkWxY2PmvAcLM9aRNA8tHrgM342
	 2TwZIwBZ/cB1CYFNFimZaxYpkrsjo5g+Ttgcubmmjf063DPQg6Pc+uEUHWb8hpiEl6
	 yLU+q24i/EnguduBvtVI+APHsindnmTB+HVrVZyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4DC2F80161;
	Tue, 19 May 2020 03:46:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68929F801A3; Tue, 19 May 2020 03:46:02 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1287EF80132
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2020 03:45:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1287EF80132
IronPort-SDR: kflPzpMJnG945oWOzQEgNgM6R/jduKfjuAnyqC3kRmskm/oqWxKcSAeq2mWyOmBOb6/tVElbOA
 yHW5VdFD/UBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2020 18:45:52 -0700
IronPort-SDR: jnrxK593tbEPZZJ50PuF97Sga6U+1CFAG1QNlwWXv5JN+U9iKFtfiKkUxAwP7DSEdu3nQnQhPs
 eLKTa/5y9YCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; d="scan'208";a="342985998"
Received: from kciepluc-mobl.ger.corp.intel.com ([10.254.182.89])
 by orsmga001.jf.intel.com with ESMTP; 18 May 2020 18:45:51 -0700
Message-ID: <3e3c0f3247b1759fb640601bc55ff07cb8e2e92b.camel@linux.intel.com>
Subject: Re: [PATCH 4/7] ASoC: soc-link: add snd_soc_link_be_hw_params_fixup()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Mon, 18 May 2020 18:45:35 -0700
In-Reply-To: <871rng68l1.wl-kuninori.morimoto.gx@renesas.com>
References: <877dx868op.wl-kuninori.morimoto.gx@renesas.com>
 <871rng68l1.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On Tue, 2020-05-19 at 10:02 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> dai_link related function should be implemented at soc-link.c.
> This patch adds snd_soc_link_be_hw_params_fixup().
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc-link.h |  3 +++
>  sound/soc/soc-core.c     |  6 +++++-
>  sound/soc/soc-dai.c      |  8 +++-----
>  sound/soc/soc-link.c     | 11 +++++++++++
>  sound/soc/soc-pcm.c      | 14 +++++---------
>  5 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/include/sound/soc-link.h b/include/sound/soc-link.h
> index 2a81dca945cd..aae72f668de6 100644
> --- a/include/sound/soc-link.h
> +++ b/include/sound/soc-link.h
> @@ -9,6 +9,9 @@
>  #define __SOC_LINK_H
>  
>  int snd_soc_link_init(struct snd_soc_pcm_runtime *rtd);
> +int snd_soc_link_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> +				    struct snd_pcm_hw_params *params);
> +
>  int snd_soc_link_startup(struct snd_pcm_substream *substream);
>  void snd_soc_link_shutdown(struct snd_pcm_substream *substream);
>  int snd_soc_link_prepare(struct snd_pcm_substream *substream);
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index d5450e61626a..d6818f8c7f1d 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1655,7 +1655,11 @@ static void soc_check_tplg_fes(struct
> snd_soc_card *card)
>  			dai_link->dpcm_playback = 1;
>  			dai_link->dpcm_capture = 1;
>  
> -			/* override any BE fixups */
> +			/*
> +			 * override any BE fixups
> +			 * see
> +			 *	snd_soc_link_be_hw_params_fixup()
> +			 */
>  			dai_link->be_hw_params_fixup =
>  				component->driver->be_hw_params_fixup;
>  
> diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
> index ce4e1fd1ab79..39959cc99bc9 100644
> --- a/sound/soc/soc-dai.c
> +++ b/sound/soc/soc-dai.c
> @@ -313,11 +313,9 @@ int snd_soc_dai_hw_params(struct snd_soc_dai
> *dai,
>  	int ret = 0;
>  
>  	/* perform any topology hw_params fixups before DAI  */
> -	if (rtd->dai_link->be_hw_params_fixup) {
> -		ret = rtd->dai_link->be_hw_params_fixup(rtd, params);
> -		if (ret < 0)
> -			goto end;
> -	}
> +	ret = snd_soc_link_be_hw_params_fixup(rtd, params);
> +	if (ret < 0)
> +		goto end;
>  
>  	if (dai->driver->ops &&
>  	    dai->driver->ops->hw_params)
> diff --git a/sound/soc/soc-link.c b/sound/soc/soc-link.c
> index 691910e82bff..a735b3ba2385 100644
> --- a/sound/soc/soc-link.c
> +++ b/sound/soc/soc-link.c
> @@ -35,6 +35,17 @@ int snd_soc_link_init(struct snd_soc_pcm_runtime
> *rtd)
>  	return soc_link_ret(rtd, ret);
>  }
>  
> +int snd_soc_link_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> +				    struct snd_pcm_hw_params *params)
> +{
> +	int ret = 0;
> +
> +	if (rtd->dai_link->be_hw_params_fixup)
> +		ret = rtd->dai_link->be_hw_params_fixup(rtd, params);
> +
> +	return soc_link_ret(rtd, ret);
> +}
> +
>  int snd_soc_link_startup(struct snd_pcm_substream *substream)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 2b5068001efb..26246228d8c5 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2087,15 +2087,11 @@ int dpcm_be_dai_hw_params(struct
> snd_soc_pcm_runtime *fe, int stream)
>  				sizeof(struct snd_pcm_hw_params));
>  
>  		/* perform any hw_params fixups */
> -		if (be->dai_link->be_hw_params_fixup) {
> -			ret = be->dai_link->be_hw_params_fixup(be,
> -					&dpcm->hw_params);
> -			if (ret < 0) {
> -				dev_err(be->dev,
> -					"ASoC: hw_params BE fixup
> failed %d\n",
> -					ret);
> -				goto unwind;
> -			}
> +		ret = snd_soc_link_be_hw_params_fixup(be, &dpcm-
> >hw_params);
> +		if (ret < 0) {
> +			dev_err(be->dev,
> +				"ASoC: hw_params BE fixup failed %d\n",
> ret);
We can remove this error too isnt it? snd_soc_link_be_hw_params_fixup()
would already have printed an error and this would be a duplicate?

Thanks,
Ranjani

