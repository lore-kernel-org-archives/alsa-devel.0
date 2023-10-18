Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2997CDB483
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Oct 2023 13:58:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB04E850;
	Wed, 18 Oct 2023 15:57:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB04E850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697637524;
	bh=5AeLSEWrRP+H5Fb6/38V6XWZBDN12WIWs+JsApoQgvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=N8IhfgdYcVZy4HBPA/hR4nPLMr6AdTmx1ISmNs1eJr1ZTRo7ndLWdfKaiOdeTSAff
	 9batU/HgRO9JgntaW/77rlyonIIubR+SXBQLWLEVItvkl1/XwV+nkUCjF95iK1ulRy
	 T5OTBK1k/FXOiSoke5jZW1eGLUtO58LwN/hflkJ0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92E4AF8027B; Wed, 18 Oct 2023 15:57:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42CDDF8027B;
	Wed, 18 Oct 2023 15:57:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4DE3F8027B; Wed, 18 Oct 2023 15:57:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E5ECF80236
	for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2023 15:57:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E5ECF80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i+R9SbYU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697637438; x=1729173438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5AeLSEWrRP+H5Fb6/38V6XWZBDN12WIWs+JsApoQgvk=;
  b=i+R9SbYU4UTstLe0lH6ER2DBajGNKI/CA9uwBHje4OdL8Bh5ufcPrUsF
   MFEZgA/zJREnsT0UHpOoGWcAT8XhhOcQFKrjZl+masOsNi/v8QB7Ouk2F
   h/UjeNrbeKkwFVM2/uLe+vy1nn9GS4K/PAKW6UD2dLxu4rOAaHFGifFj2
   ZzKUMHQdXp1tCz8+7vKEKQHq/HL23dns66PSNg+RD+n3DHJlz3NqSWsEV
   rRCF3jhX//KHJLaMxBN3WMHlRYRgiOeii0nWm/d8sQcjoNXe5IDE8wvxy
   rRJkzrpxkwOmuIcrLAAWbBnz3LiGm3zkoIrD30nlwnGYcS2OXYpX9hlsr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472242450"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200";
   d="scan'208";a="472242450"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 06:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930209923"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200";
   d="scan'208";a="930209923"
Received: from dmangels-mobl.amr.corp.intel.com (HELO [10.209.187.130])
 ([10.209.187.130])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 06:57:13 -0700
Message-ID: <2f05708e-3ee8-472e-a24f-6f3eb118133c@linux.intel.com>
Date: Wed, 18 Oct 2023 08:47:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/34] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
To: Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
 Thinh.Nguyen@synopsys.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-10-quic_wcheng@quicinc.com>
 <7aa4ea87-9d1f-400a-bcc5-b56e5b4500c6@linux.intel.com>
 <c72bcf47-af0b-8819-1c30-06b51358381e@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c72bcf47-af0b-8819-1c30-06b51358381e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5HOCD5HI5PADG2Q2FIVV7ZITEENJ7JMK
X-Message-ID-Hash: 5HOCD5HI5PADG2Q2FIVV7ZITEENJ7JMK
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5HOCD5HI5PADG2Q2FIVV7ZITEENJ7JMK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


>>> Specifically, the QC ADSP can support all potential endpoints that are
>>> exposed by the audio data interface.  This includes, feedback endpoints
>>> (both implicit and explicit) as well as the isochronous (data)
>>> endpoints.
>>
>> implicit feedback means support for capture. This is confusing...
>>
> 
> I mean, a USB device can expose a capture path, but as of now, we won't
> enable the offloading to the audio DSP for it.  However, if we're
> executing playback, and device does support implicit feedback, we will
> pass that along to the audio DSP to utilize.

Not following. Implicit feedback means a capture stream *SHALL* be
started. Are you saying this capture stream is hidden and handled at the
DSP level only? If yes, what prevents you from exposing the capture
stream to userspace as well?

I must be missing something.

>>>   +static const struct snd_soc_dai_ops q6usb_ops = {
>>> +    .probe        = msm_dai_q6_dai_probe,
>>> +    .prepare    = q6afe_dai_prepare,
>>> +    .hw_params    = q6usb_hw_params,
>>
>> this is rather confusing with two different layers used for hw_params
>> and prepare? Additional comments or explanations wouldn't hurt.
>>
> 
> I thought this was how the ASoC design was.  Each DAI defined for a
> particular path has it own set of callbacks implemented to bring up any
> required resources for that entity.  So in this case, it initializes the
> "cpu" DAI, which is the main component that handles communication with
> the audio DSP.

Usually prepare and hw_params rely on the type of DAI callbacks, but
here you are mixing "q6afe" and "q6usb" which are shown in your Patch0
diagram as "cpu" and "codec" dais respectively. I don't think it's
correct to tie the two, it's a clear layering violation IMHO. The codec
dai .prepare should not invoke something that modifies the state of the
CPU dai, which should have its own .prepare callback.
