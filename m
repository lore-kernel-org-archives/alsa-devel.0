Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1292C3DA64
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Aug 2024 09:30:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF99C399C;
	Thu,  1 Aug 2024 11:30:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF99C399C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722504634;
	bh=5toF+PsLMmG3nsBrKM94Rd7v4kxGJrsS2p+u19WypBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sVWY+HwQmcTR91gDJsoBc/qISXROW0VLoK70VLWAZ9bHgkFlO/0g3Nr67FYyTUxG9
	 2Zvaf6k3Id+nYhlmaAEEzAp9vf5OPRVxZwFh8wTSDOqbVkkB3ur51MbkWP3PmFkH0b
	 qYrS0TwTlPKZhT5IpDypmo6HpoNZR794BUTMvgBo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54A22F805B5; Thu,  1 Aug 2024 11:30:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E28AF80580;
	Thu,  1 Aug 2024 11:30:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65351F8026A; Thu,  1 Aug 2024 11:16:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5DFF9F80579
	for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2024 11:12:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DFF9F80579
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KeyyRNZK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722503524; x=1754039524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5toF+PsLMmG3nsBrKM94Rd7v4kxGJrsS2p+u19WypBE=;
  b=KeyyRNZKJudSc3FVnlS3AI0ktSawfiYUlN1CgBBZbAXO0w7T1ePctNRd
   snZb7Mmf7ZFb3433H7fbAjiYS3GwhCxxFZrZqJvSdNhnxprDW1xNCqduu
   pxVO5KwiK4cpA7IM3VuVe54JNpIbMqsil2YSmBG0antAqell+eMuqo0Lz
   q4WDvkoGH4Mi2ierW2lbEEC6NQK8FempoDDiBoA0Qt5Z5o51r32i4Bz6C
   dJa9f61G9YfcCb43Msu2HOeEpfTRQTQK36z+/xdb0J54cSVxcfLvbu154
   84O3xekQAb+Jp49NXzBAu1vnkiXalr1Yid0jro9+2azjZ488AXyeHRjvJ
   Q==;
X-CSE-ConnectionGUID: dfTQGb1+Rje/EaWi+Zt/lw==
X-CSE-MsgGUID: ysxbUTV1QpylftMcw1HBkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20383539"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800";
   d="scan'208";a="20383539"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 02:11:36 -0700
X-CSE-ConnectionGUID: wcqSdmgMTj+f0XjaXEriKA==
X-CSE-MsgGUID: qPY3CEHgSiuP5J8I3USl0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800";
   d="scan'208";a="59089896"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.220])
 ([10.245.246.220])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 02:11:29 -0700
Message-ID: <33f0e72e-aff8-4733-bf71-dd592a99de97@linux.intel.com>
Date: Thu, 1 Aug 2024 10:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 15/34] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, broonie@kernel.org, lgirdwood@gmail.com, krzk+dt@kernel.org,
 Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
 gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240801011730.4797-1-quic_wcheng@quicinc.com>
 <20240801011730.4797-16-quic_wcheng@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240801011730.4797-16-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: Z22E5SIATZF6PNLAXOYDG5V3UOKEU62H
X-Message-ID-Hash: Z22E5SIATZF6PNLAXOYDG5V3UOKEU62H
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z22E5SIATZF6PNLAXOYDG5V3UOKEU62H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 8/1/24 03:17, Wesley Cheng wrote:
> The QC ADSP is able to support USB playback endpoints, so that the main
> application processor can be placed into lower CPU power modes.  This adds
> the required AFE port configurations and port start command to start an
> audio session.
> 
> Specifically, the QC ADSP can support all potential endpoints that are
> exposed by the audio data interface.  This includes, feedback endpoints
> (both implicit and explicit) as well as the isochronous (data) endpoints.
> The size of audio samples sent per USB frame (microframe) will be adjusted
> based on information received on the feedback endpoint.
> 
> Some pre-requisites are needed before issuing the AFE port start command,
> such as setting the USB AFE dev_token.  This carries information about the
> available USB SND cards and PCM devices that have been discovered on the
> USB bus.  The dev_token field is used by the audio DSP to notify the USB
> offload driver of which card and PCM index to enable playback on.

It's just fine if the AFE stuff relies on the 'port' definition/concept,
but I don't think it needs to pop-up at the ASoC/USB level.


