Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723B7C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 23:50:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2BD20657
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 23:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PO1xyiC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2BD20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FDFD1675;
	Wed, 22 Jul 2020 01:49:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FDFD1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595375425;
	bh=OCLUmFTbktm41/iwpiLfQc486+YyahXc4D+HIKUPR+4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PO1xyiC29ifpvHPQfEoPi1a3y1dO/LUJ9CltJ5TCd9VMP26DqS38OKtk96ZVaRPUT
	 7n9KLSyhlwY9r2U9vm9hQIkCClGDW1S7Uu+Z9pQvY9yDuHVfmleBb7ddCR4ejhMqeR
	 CxRo07NQtt50WleVlYQ7fFgRUbvV661SsuEmv5zE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3F93F802E8;
	Wed, 22 Jul 2020 01:46:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A6E3F802DB; Wed, 22 Jul 2020 01:46:20 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC46DF80268
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 01:46:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC46DF80268
IronPort-SDR: I2r5H4+FTeVNCYNJ2VJ1S/aJ0xOZyyvEtX5zlN75Z4aQG9CB256B8Car0vMUxlnrED770VqYI2
 zMIwY3pO8M9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="151576932"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; d="scan'208";a="151576932"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 16:46:11 -0700
IronPort-SDR: O+Zbmqj3QdWHOWpt1LnUKLcLzu7x9zcOB2XDaVewCuA3B352SntT5b+n2dzMbRz84RDYXShJYy
 g9EQedM6yeEw==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; d="scan'208";a="362539392"
Received: from krlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.6])
 ([10.255.231.6])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 16:46:10 -0700
Subject: Re: [RFC PATCH v2 6/6] ASoC: q6asm-dai: add support to
 set_codec_params
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-7-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <970e7065-4731-e553-f07f-896aaa57c5dc@linux.intel.com>
Date: Tue, 21 Jul 2020 15:09:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721170007.4554-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 vkoul@kernel.org
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



On 7/21/20 12:00 PM, Srinivas Kandagatla wrote:
> Make use of new set_codec_params callback to allow decoder switching
> during gapless playback.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 33 ++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index b5c719682919..a8cfb1996614 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -876,6 +876,37 @@ static int __q6asm_dai_compr_set_codec_params(struct snd_soc_component *componen
>   	return 0;
>   }
>   
> +static int q6asm_dai_compr_set_codec_params(struct snd_soc_component *component,
> +					    struct snd_compr_stream *stream,
> +					    struct snd_codec *codec)
> +{
> +	struct snd_compr_runtime *runtime = stream->runtime;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +	int ret;
> +
> +	ret = q6asm_open_write(prtd->audio_client, prtd->next_track_stream_id,
> +			       codec->id, codec->profile, prtd->bits_per_sample,
> +			       true);
> +	if (ret < 0) {
> +		pr_err("q6asm_open_write failed\n");
> +		return ret;
> +	}
> +
> +	ret = __q6asm_dai_compr_set_codec_params(component, stream, codec,
> +						 prtd->next_track_stream_id);
> +	if (ret < 0) {
> +		pr_err("q6asm_open_write failed\n");
> +		return ret;
> +	}
> +
> +	ret = q6asm_stream_remove_initial_silence(prtd->audio_client,
> +						   prtd->next_track_stream_id,
> +						   prtd->initial_samples_drop);
> +	prtd->next_track_stream_id = 0;

same comment as in the other patchset, the stream_id toggles between 1 
and 2, it's not clear to me what 0 means.

off-by-one bug or feature?
