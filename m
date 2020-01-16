Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B6EC32771
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:54:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C8E2084D
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n0x3cl+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C8E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7CB517A9;
	Thu, 16 Jan 2020 02:53:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7CB517A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579139649;
	bh=b27ghW/1NyxwoAiPXAvemX/Z7WBHyUGU4yMD3I2Q2QE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n0x3cl+fdfnglvE/1k0watzJY5mdGTdXmlMZi1oh/5FwYT4gfswi6A8oprc+8VUrQ
	 rlHzMQIRxtxhQZ/PO/di94b9tUSivXsObM6KGLhZ/wH7BOCFjE3t/76kxNmIqtTnx7
	 11dci485TWQV3UKskLz8j1QryE3VrzQo57PtYuNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66428F801EB;
	Thu, 16 Jan 2020 02:53:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8AED7F801EB; Thu, 16 Jan 2020 02:53:16 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1BA9F800E9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 02:53:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1BA9F800E9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 17:53:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,324,1574150400"; d="scan'208";a="423839875"
Received: from cecox1-mobl.amr.corp.intel.com (HELO [10.251.131.55])
 ([10.251.131.55])
 by fmsmga005.fm.intel.com with ESMTP; 15 Jan 2020 17:52:56 -0800
To: Bard liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org,
 tiwai@suse.de
References: <20200114175152.3291-1-yung-chuan.liao@linux.intel.com>
 <20200114175152.3291-5-yung-chuan.liao@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <35fbbfcf-8741-ac4c-56b1-2fd7e19e1a7d@linux.intel.com>
Date: Wed, 15 Jan 2020 19:49:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114175152.3291-5-yung-chuan.liao@linux.intel.com>
Content-Language: en-US
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, bard.liao@intel.com
Subject: Re: [alsa-devel] [PATCH RFC v2 4/4] ASoC: add warning if the
 function is not support multi cpu yet.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/14/20 11:51 AM, Bard liao wrote:
> Multi cpu is not supported by all functions yet. Add a warning message
> to warn it.

Shouldn't we be consistent and return an error when we have an 
unexpected number of cpu dais? see below

> 
> Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
> ---
>   sound/soc/soc-compress.c              |  7 ++++---
>   sound/soc/soc-generic-dmaengine-pcm.c | 12 ++++++++++++
>   sound/soc/soc-pcm.c                   | 12 ++++++++++++
>   3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 223cd045719e..bf9d6a21bcd9 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -810,10 +810,11 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>   	int playback = 0, capture = 0;
>   	int i;
>   
> -	if (rtd->num_codecs > 1) {
> +	if (rtd->num_cpus > 1 ||
> +	    rtd->num_codecs) {
>   		dev_err(rtd->card->dev,
> -			"Compress ASoC: Multicodec not supported\n");
> -		return -EINVAL;
> +			"Compress ASoC: Multi CPU/Codec not supported\n");
> +		return -ENOTSUPP;

so this is an error...

>   	}
>   
>   	/* check client and interface hw capabilities */
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index df57ec47ad60..a6c8623d03be 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -62,6 +62,10 @@ int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
>   	struct snd_dmaengine_dai_dma_data *dma_data;
>   	int ret;
>   
> +	if (rtd->num_cpus > 1)
> +		dev_warn(rtd->dev,
> +			 "%s doesn't support Multi CPU yet\n", __func__);
> +

but here a warning...

>   	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
>   
>   	ret = snd_hwparams_to_dma_slave_config(substream, params, slave_config);
> @@ -119,6 +123,10 @@ dmaengine_pcm_set_runtime_hwparams(struct snd_soc_component *component,
>   	struct snd_pcm_hardware hw;
>   	int ret;
>   
> +	if (rtd->num_cpus > 1)
> +		dev_warn(rtd->dev,
> +			 "%s doesn't support Multi CPU yet\n", __func__);
> +

and a warning here as well

>   	if (pcm->config && pcm->config->pcm_hardware)
>   		return snd_soc_set_runtime_hwparams(substream,
>   				pcm->config->pcm_hardware);
> @@ -183,6 +191,10 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
>   	struct snd_dmaengine_dai_dma_data *dma_data;
>   	dma_filter_fn fn = NULL;
>   
> +	if (rtd->num_cpus > 1)
> +		dev_warn(rtd->dev,
> +			 "%s doesn't support Multi CPU yet\n", __func__);
> +

warning again...

>   	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
>   
>   	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 52c6f3c3ab63..e16af8effffa 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1469,6 +1469,10 @@ int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
>   	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
>   	int paths;
>   
> +	if (fe->num_cpus > 1)
> +		dev_warn(fe->dev,
> +			 "%s doesn't support Multi CPU yet\n", __func__);
> +

and warning again...

>   	/* get number of valid DAI paths and their widgets */
>   	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, list,
>   			dpcm_end_walk_at_be);
> @@ -2812,6 +2816,10 @@ static int soc_dpcm_fe_runtime_update(struct snd_soc_pcm_runtime *fe, int new)
>   	struct snd_soc_dapm_widget_list *list;
>   	int count, paths;
>   
> +	if (fe->num_cpus > 1)
> +		dev_warn(fe->dev,
> +			 "%s doesn't support Multi CPU yet\n", __func__ > +

warning

>   	if (!fe->dai_link->dynamic)
>   		return 0;
>   
> @@ -3368,6 +3376,10 @@ static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
>   	ssize_t out_count = PAGE_SIZE, offset = 0, ret = 0;
>   	char *buf;
>   
> +	if (fe->num_cpus > 1)
> +		dev_warn(fe->dev,
> +			 "%s doesn't support Multi CPU yet\n", __func__);
> +

warning

>   	buf = kmalloc(out_count, GFP_KERNEL);
>   	if (!buf)
>   		return -ENOMEM;
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
