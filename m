Return-Path: <SRS0=SwAr=ON=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,CTE_8BIT_MISMATCH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C7DC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Sep 2021 12:55:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FED161152
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Sep 2021 12:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FED161152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 284BE822;
	Thu, 23 Sep 2021 14:54:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 284BE822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632401718;
	bh=++l0yRSrk63MxGwMuAL7CUewRBHDHMEKo6Foolu2stY=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fUHGRW/a7edquAr5FtYKF9mV2XBaX4LLzGLdixh2Qg0pdZCYx1WvLVGrul1WeLbe8
	 e6LjhKcdMM1oa9Sd2/CwOnKbzCXt8tDx71Zjdsv7fNbbfWiiA+UIEhOeFGel1oL5Al
	 uO7wBnme5U5UwQdbOXbh1qUqsfZ1FPMpa+qFEYx0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C125F8025F;
	Thu, 23 Sep 2021 14:54:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52576F80268; Thu, 23 Sep 2021 14:54:25 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 917E4F8013F
 for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2021 14:54:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 917E4F8013F
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="211075329"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="211075329"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 05:54:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="474840079"
Received: from mmocanu-mobl1.ger.corp.intel.com (HELO [10.249.36.33])
 ([10.249.36.33])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 05:54:09 -0700
Message-ID: <203bf6cd-6407-f01d-52c3-e399d06cb3f6@linux.intel.com>
Date: Thu, 23 Sep 2021 15:54:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 10/12] ASoC: SOF: Intel: hda: make sure DAI widget is
 set up before IPC
Content-Language: en-US
To: Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org
References: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
 <20210917143659.401102-11-daniel.baluta@oss.nxp.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20210917143659.401102-11-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 daniel.baluta@nxp.com
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



On 17/09/2021 17:36, Daniel Baluta wrote:
> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> With the implementation of the dynamic pipeline feature, widgets
> will only be setup when a PCM is opened during the
> hw_params ioctl. The BE hw_params callback is responsible for
> sending the DAI_CONFIG for the DAI widgets in the DSP.
> With dynamic pipelines, the DAI widgets will need to set up
> first before sending the DAI_CONFIG IPC in the BE hw_params.
> 
> Update the BE hw_params/hw_free callbacks for all ALH, HDA and SSP
> DAIs to set up/free the DAI widget before/after DAI_CONFIG IPC.
> 
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/sof/intel/hda-dai.c | 176 ++++++++++++++++++++-------------
>  sound/soc/sof/intel/hda.c     | 177 +++++++++++++++++++++++++---------
>  sound/soc/sof/intel/hda.h     |   5 +
>  sound/soc/sof/sof-audio.c     |   1 +
>  sound/soc/sof/sof-audio.h     |   2 +-
>  sound/soc/sof/topology.c      |   3 -
>  6 files changed, 245 insertions(+), 119 deletions(-)
> 
> diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
> index 2f54a659b78a..d1ec8bfb6002 100644
> --- a/sound/soc/sof/intel/hda-dai.c
> +++ b/sound/soc/sof/intel/hda-dai.c
> @@ -155,49 +155,70 @@ static int hda_link_dma_params(struct hdac_ext_stream *stream,
>  	return 0;
>  }
>  
> -/* Send DAI_CONFIG IPC to the DAI that matches the dai_name and direction */
> -static int hda_link_config_ipc(struct sof_intel_hda_stream *hda_stream,
> -			       const char *dai_name, int channel, int dir)
> +/* Update config for the DAI widget */
> +static struct sof_ipc_dai_config *hda_dai_update_config(struct snd_soc_dapm_widget *w,
> +							int channel)
>  {
> +	struct snd_sof_widget *swidget = w->dobj.private;
>  	struct sof_ipc_dai_config *config;
>  	struct snd_sof_dai *sof_dai;
> -	struct sof_ipc_reply reply;
> -	int ret = 0;
>  
> -	list_for_each_entry(sof_dai, &hda_stream->sdev->dai_list, list) {
> -		if (!sof_dai->cpu_dai_name)
> -			continue;
> +	if (!swidget) {
> +		dev_err(swidget->scomp->dev, "error: No private data for widget %s\n", w->name);

NULL pointer dereference, just return NULL without the print. The caller
is printing anyways.

> +		return NULL;
> +	}
>  

-- 
Péter
