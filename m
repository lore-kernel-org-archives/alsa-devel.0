Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20258CDB465
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Oct 2023 13:04:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4876D1ED;
	Thu, 19 Oct 2023 15:03:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4876D1ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697720657;
	bh=VgSvxH67qt9LKjm5+c5G2G8wQo6a1gXmEAilB1I2dfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=F6O8UvXp3vBFpoyrAda04FThZHRRA6ufjGvTNRutL/TX6CdgR2ICPpJmhebDeQCO/
	 WBQd1snokxl932ZD3TYble+VeuMiglXiBRhEfMt+DPeXTCMLwn8N4Cy2J38EHpGhE6
	 Ez7aQvoKXgTe08BJdWpbF8Np5dVXH77U8W8VyIAY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1313F80557; Thu, 19 Oct 2023 15:03:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5953EF80166;
	Thu, 19 Oct 2023 15:03:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB76EF8025F; Thu, 19 Oct 2023 15:03:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C27BFF80166
	for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2023 15:03:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C27BFF80166
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LgAeuv4L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697720594; x=1729256594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VgSvxH67qt9LKjm5+c5G2G8wQo6a1gXmEAilB1I2dfg=;
  b=LgAeuv4LdvaOrRXTOj0vQ1rbonWNWfeCubwIquCoNQmxUkuOJ3vBX8k+
   XtTq2jHZ2C2cDE5gNPtTSxJcaSPjTSmcVAuJRuhmcjkFRNxaKwyQSt3kd
   ZdSsmWS0EJd/aETBG9/k4JSM7oxGm4hpvXj6uNycQwPLqwLQZKU6GRzja
   G+euzr/V8tvLAZTU31HJ98l6U/a/O1s2sJVJc1tE/Uk/AjQOEfz9OSavj
   V+P06bhq0e9q5Lk4PZI3PqLL2UfOxNPiwVz+bwyQre+IbwBLGVC+Nm5Dh
   voNa74L15mNi5GN/nCOtMdAQ/VvKScMvrjIQXhzmzaMOWlUhQKxSF/Fgk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385115727"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200";
   d="scan'208";a="385115727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 06:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="757014468"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200";
   d="scan'208";a="757014468"
Received: from mttran4-mobl2.amr.corp.intel.com (HELO [10.213.160.204])
 ([10.213.160.204])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 06:01:45 -0700
Message-ID: <ec25bb67-6c83-430b-bc79-234c03801250@linux.intel.com>
Date: Wed, 18 Oct 2023 20:00:00 -0500
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
 <2f05708e-3ee8-472e-a24f-6f3eb118133c@linux.intel.com>
 <fcaa93ba-3ca4-5a18-d3bd-afebe8def327@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <fcaa93ba-3ca4-5a18-d3bd-afebe8def327@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3BOFIPSPOZ6AND7PLCDCHTWIOM5QRVHQ
X-Message-ID-Hash: 3BOFIPSPOZ6AND7PLCDCHTWIOM5QRVHQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3BOFIPSPOZ6AND7PLCDCHTWIOM5QRVHQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



>>>>> Specifically, the QC ADSP can support all potential endpoints that are
>>>>> exposed by the audio data interface.  This includes, feedback
>>>>> endpoints
>>>>> (both implicit and explicit) as well as the isochronous (data)
>>>>> endpoints.
>>>>
>>>> implicit feedback means support for capture. This is confusing...
>>>>
>>>
>>> I mean, a USB device can expose a capture path, but as of now, we won't
>>> enable the offloading to the audio DSP for it.  However, if we're
>>> executing playback, and device does support implicit feedback, we will
>>> pass that along to the audio DSP to utilize.
>>
>> Not following. Implicit feedback means a capture stream *SHALL* be
>> started. Are you saying this capture stream is hidden and handled at the
>> DSP level only? If yes, what prevents you from exposing the capture
>> stream to userspace as well?
>>
>> I must be missing something.
>>
> 
> My understanding is that with implicit feedback endpoints, it allows for
> another data endpoint in the opposite direction to be utilized as a
> feedback endpoint (versus having to expose another EP, such as in the
> case of explicit feedback).  For example, if we are enabling the
> playback path (and the device does have a capture data ep) then the data
> ep used for the capture path can be used.

That's right, so all the plumbing is enabled for the capture path...
Making a decision to discard the data is very odd, all the work has
already been done at lower levels, so why not expose the captured data?

