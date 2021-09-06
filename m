Return-Path: <SRS0=AHG6=N4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A861EC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Sep 2021 16:31:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200BD60FED
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Sep 2021 16:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 200BD60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58CD71760;
	Mon,  6 Sep 2021 18:30:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58CD71760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630945902;
	bh=vONOiot1VALDXty2PkAfy7ivasK+B8u/6oczos8e2vE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSkr4qVcafqsxWDlr9bmPIM13kNPY2egMByAADRRwZGmKHR7LYvYkZh/rQWfZ3QLh
	 9S8cj6iPteOYkM4nafUxIhiX7kETRMwilCJBzggoUCK96bGs5lBbgENz/aFPeQ5wWh
	 VyDjcFsUaVPKk+s0/IOjfp6smNN4ygYhHCt5GMgs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFEFEF804EC;
	Mon,  6 Sep 2021 18:29:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40549F804A9; Mon,  6 Sep 2021 18:29:23 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DDCBF8026C
 for <alsa-devel@alsa-project.org>; Mon,  6 Sep 2021 18:29:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DDCBF8026C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="a9AWRLgg"
Received: by mail-wr1-x434.google.com with SMTP id i6so10629613wrv.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Sep 2021 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=svt/1vpTG7VrK2HiSdps0aR796SgANL3/Z27Aku9mKw=;
 b=a9AWRLgg5kG035Md5wkqLas2q0V3DDvvkf8rbo7lwx0+Fr37O9T2IXsK7LIaSdaA/M
 qpYmUAbjWJSF3/mXKrmPEOo1vamSca8Odo2r/u2lO1uj0sdnu3Z/WKsZf505S9JYK2zA
 gA75AGhbJ7eydkQd/sI48hGRmDhgQ3ZB1N4qyRzS+CUQ2wsEnyfz3Fcr8TSFfFysXZ6N
 WDrc3V0Ogc4xk79vce81+eJtw0Od2urTQylCDnO2US/eudro3w3HSAQ3Qa0weXBWaf41
 xfzXfJM4yRb1sk6UqrKKAFbIVTGuQ3iKq4mFeWtPHpnXky03AK8dOq6YElNBycsw6Q/1
 4XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=svt/1vpTG7VrK2HiSdps0aR796SgANL3/Z27Aku9mKw=;
 b=cqEzh7slDQ4O1+4F+ZXYhRBRvwF44ceuJncVXz29icWGYWt4iLV/ZCN891D6ayPJEl
 Xqv6vhyMlGgagiE2IxF+CDcyoU6GIzwY4YtYtFamoklLKqAshg0/u+Az6Y0T60QDQDDP
 xc4Kjk6Ovxzp7zMlAZYiNMrk3hQNKoemvnY4eYNYrVl188lDiLEaoSdpT4APMZPuaTGj
 1zVPS6KtpYm/u0AHAN727jRxgJAkUfsthDvkYKgVlq67OrpwX4guEyNRgruLo+/McYSx
 UjNh6daA1yZgtQFpIeS6d9L900CX7MH5SFMHzAsoxRvACBsALktDe6MZGGSHCH2+pbGA
 fptg==
X-Gm-Message-State: AOAM533KaFqXdeWsL8EHSHgQ+C5zd5fk1fKKNTq64vrDVr79kbTtmNF7
 tDhvP0r6lAWD7PIPN0tSAQMJ8Q==
X-Google-Smtp-Source: ABdhPJwvY/BXjuBuEvVM2UWTdAxh2ieL6rSFMROPIN9xVEdIe23FrGU/J7QIWoRALeNDV/Adu+YpqQ==
X-Received: by 2002:adf:fb8d:: with SMTP id a13mr14136668wrr.164.1630945758960; 
 Mon, 06 Sep 2021 09:29:18 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id o14sm7654900wrg.91.2021.09.06.09.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Sep 2021 09:29:18 -0700 (PDT)
Subject: Re: [PATCH v5 19/21] ASoC: qdsp6: audioreach: add q6apm lpass dai
 support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
 <20210903112032.25834-20-srinivas.kandagatla@linaro.org>
 <4374a141-877e-fe80-d61b-e3c7b90c447b@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c41e46aa-a854-eb65-042a-ab91c0ac1764@linaro.org>
Date: Mon, 6 Sep 2021 17:29:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4374a141-877e-fe80-d61b-e3c7b90c447b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com
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

Thanks Pierre for taking time to review this,

On 03/09/2021 16:53, Pierre-Louis Bossart wrote:
> 
>>   config SND_SOC_QDSP6_APM
>>   	select SND_SOC_QDSP6_APM_DAI
>> +	select SND_SOC_QDSP6_APM_LPASS_DAI
>>   	tristate
> 
> tristate then select?
> 
Its fixed now.

>>
>> +static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream,
>> +			       struct snd_soc_dai *dai)
>> +{
>> +	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
>> +	struct audioreach_module_config *cfg = &dai_data->module_config[dai->id];
>> +	int graph_id = dai->id;
>> +	int rc;
>> +	struct q6apm_graph *graph;
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		graph = q6apm_graph_open(dai->dev, NULL, dai->dev, graph_id);
>> +		if (IS_ERR(graph)) {
>> +			dev_err(dai->dev, "Failed to open graph (%d)\n",
>> +				graph_id);
>> +			rc = PTR_ERR(graph);
>> +			return rc;
>> +		}
>> +		dai_data->graph[graph_id] = graph;
>> +	}
> 
> so you don't open a graph on capture?
> 
> How does the rest work if dai_data->graph is not initialized?
> Or is it done somewhere else and it'd be worthy of a comment?

Yes, we are trying to sequence source graph and sink graph.
It is recommend that we load DSP with source graph first and then sink 
graph.

I will add a comment too.

--srini

> 
>> +
>> +	cfg->direction = substream->stream;
>> +	rc = q6apm_graph_media_format_pcm(dai_data->graph[dai->id], cfg);
>> +
>> +	if (rc) {
>> +		dev_err(dai->dev, "Failed to set media format %d\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	rc = q6apm_graph_prepare(dai_data->graph[dai->id]);
>> +	if (rc) {
>> +		dev_err(dai->dev, "Failed to prepare Graph %d\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	rc = q6apm_graph_start(dai_data->graph[dai->id]);
>> +	if (rc < 0) {
>> +		dev_err(dai->dev, "fail to start APM port %x\n", dai->id);
>> +		return rc;
>> +	}
>> +	dai_data->is_port_started[dai->id] = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int q6apm_lpass_dai_startup(struct snd_pcm_substream *substream,
>> +				struct snd_soc_dai *dai)
>> +{
>> +	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
>> +	int graph_id = dai->id;
>> +	struct q6apm_graph *graph;
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
>> +		graph = q6apm_graph_open(dai->dev, NULL, dai->dev, graph_id);
>> +		if (IS_ERR(graph)) {
>> +			dev_err(dai->dev, "Failed to open graph (%d)\n",
>> +				graph_id);
>> +			return PTR_ERR(graph);
>> +		}
>> +		dai_data->graph[graph_id] = graph;
>> +	}
> 
> definitively need a comment on why the behavior is different from
> capture and playback?
> 
> What prevents you from doing the same operations in .startup for capture
> and playback?
> 
>> +
>> +	return 0;
>> +}
>> +
> 
