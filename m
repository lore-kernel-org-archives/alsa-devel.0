Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA9C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 19:54:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B668D60F91
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 19:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B668D60F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7388116B9;
	Mon, 27 Sep 2021 21:53:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7388116B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632772487;
	bh=FSfWXlVkpsQM4JLiueJcLlPgILY9+4oUD99aT0ZLOwo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UpYlpDcnDRp06+h+o4wF+tjlxqsXkI+3GQSIoUUOQcRj9yAgOdy0z/KcYBolwdaOb
	 rNkqjK2hENdxBPq3NZeExQ23CJfFyjiLZIpCmfT0Xni7i8Ofy2ifjKiKc7bvGNoBvv
	 cd9TeF2iEGF9h9TL9AJkIT9s5wi0huLTx7qTAZbk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B896AF804E2;
	Mon, 27 Sep 2021 21:53:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92EA5F80301; Mon, 27 Sep 2021 21:53:07 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A232F80147
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 21:52:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A232F80147
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="211802378"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; d="scan'208";a="211802378"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 12:52:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; d="scan'208";a="486268016"
Received: from asen4-mobl2.amr.corp.intel.com (HELO [10.212.27.2])
 ([10.212.27.2])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 12:52:51 -0700
Subject: Re: [PATCH v8 18/22] ASoC: qdsp6: audioreach: add topology support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
 <20210927135559.738-19-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f2009225-22b5-97ed-9cb5-87a43b2c3039@linux.intel.com>
Date: Mon, 27 Sep 2021 11:21:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927135559.738-19-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
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


> +static int audioreach_control_load_mix(struct snd_soc_component *scomp,
> +				       struct snd_ar_control *scontrol,
> +				       struct snd_kcontrol_new *kc,
> +				       struct snd_soc_tplg_ctl_hdr *hdr)
> +{
> +	struct snd_soc_tplg_vendor_value_elem *c_elem;
> +	struct snd_soc_tplg_vendor_array *c_array;
> +	struct snd_soc_tplg_mixer_control *mc;
> +	int tkn_count = 0;
> +
> +	mc = container_of(hdr, struct snd_soc_tplg_mixer_control, hdr);
> +	c_array = (struct snd_soc_tplg_vendor_array *)mc->priv.data;
> +
> +	c_elem = c_array->value;
> +
> +	while (tkn_count <= (le32_to_cpu(c_array->num_elems) - 1)) {
> +		switch (le32_to_cpu(c_elem->token)) {
> +		case AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:
> +			scontrol->sgid = le32_to_cpu(c_elem->value);
> +			break;
> +		default:
> +			/* Ignore other tokens */
> +		break;

indentation still off

> +
> +		}
> +		c_elem++;
> +		tkn_count++;
> +	}
> +
> +	return 0;
> +}
