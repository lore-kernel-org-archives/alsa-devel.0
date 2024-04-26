Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C30C4345F
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:25:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56875E80;
	Fri, 26 Apr 2024 15:25:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56875E80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714137949;
	bh=ckDRuhsvVS1VZSimrLSwe76FYVFxcPXR+y8JqIk4Hrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m0dtN8AS8mEslODO6TFYm4UPbjzyYUHgoXDKdgKObGlJHZZ9mhp7MxAU7/mUfR+Wv
	 gDQmabPKNyPWwQtaCgLLYTD+rsqACFXnySB6urJDcd/bHrAzJDrBPuZVvLGAeR04M7
	 ZaM9DIr7cU4kQEAJX2GftPVrNhcZAdKRioK0AasI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 409D4F805C1; Fri, 26 Apr 2024 15:25:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58ADEF805B4;
	Fri, 26 Apr 2024 15:25:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BCA2F80571; Fri, 26 Apr 2024 15:25:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 92511F8003C
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2024 15:25:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92511F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OAxOnKaQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714137911; x=1745673911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ckDRuhsvVS1VZSimrLSwe76FYVFxcPXR+y8JqIk4Hrg=;
  b=OAxOnKaQ4iswfyhgw5gaiQ2lqHt2NLZSwgHht9c+8qBiB7eIri5MrcoI
   qMD7HKQzK7SXZ3X8vldcDN2Nq/+pOU8cD+8h92JjjVJ3LdGH0P8sXiRyD
   3O5N5hhM/T/3deX/FXj/Z8fom5l+8sXTKjYJSCaoeYNVjXmxfbAKkgXGz
   L0ybFuSO36FJDqIM6RhiCgFKggxoF94YClU+BrkYHcTT6zJ9XkCUYOLHM
   K2p3lZp5fWb6Ira9kyUJQIY3yd/qdWOamb12o03zGc7LOYo6DAsbPmzmU
   gMvavvpwthg1z6Jku/XvH29eQW2/TSg1vluc4fubmBSC4QPUbJe7vouTo
   A==;
X-CSE-ConnectionGUID: zA+1xMA5RrmUeGUnoXMYxw==
X-CSE-MsgGUID: zLM/VJA3SryNYpx0gOcJnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27388417"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000";
   d="scan'208";a="27388417"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 06:25:08 -0700
X-CSE-ConnectionGUID: e13BTyWfSnS+Wk2p9q4Yrg==
X-CSE-MsgGUID: kknPYFCBTRSMZLGJk31ntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000";
   d="scan'208";a="25302192"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53])
 ([10.94.0.53])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 06:25:02 -0700
Message-ID: <b8ff8777-6bcb-4fd7-9480-231536d23759@linux.intel.com>
Date: Fri, 26 Apr 2024 15:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 09/41] ASoC: Add SOC USB APIs for adding an USB
 backend
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
 Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
 tiwai@suse.com, robh@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-10-quic_wcheng@quicinc.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240425215125.29761-10-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: D5AS3WBM76KA2KZLSZTO4XYJGVO46LH5
X-Message-ID-Hash: D5AS3WBM76KA2KZLSZTO4XYJGVO46LH5
X-MailFrom: amadeuszx.slawinski@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D5AS3WBM76KA2KZLSZTO4XYJGVO46LH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 4/25/2024 11:50 PM, Wesley Cheng wrote:
> Some platforms may have support for offloading USB audio devices to a
> dedicated audio DSP.  Introduce a set of APIs that allow for management of
> USB sound card and PCM devices enumerated by the USB SND class driver.
> This allows for the ASoC components to be aware of what USB devices are
> available for offloading.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---

(...)

> +const char *snd_soc_usb_get_components_tag(bool playback)
> +{
> +	if (playback)
> +		return "usbplybkoffld: 1";
> +	else
> +		return "usbcapoffld: 1";
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_get_components_tag);

Is this used to expose some information to userspace?
Can those be some more readable strings if so, like:
usbplaybackoffload, usbcaptureoffload

(...)

> +
> +	node = snd_soc_find_phandle(usbdev);
> +	if (IS_ERR(node))
> +		return -ENODEV;
> +
> +	ctx = snd_soc_find_usb_ctx(node);
> +	of_node_put(node);
> +	if (!ctx)
> +		return -ENODEV;

Perhaps introduce some helper function, you do this 
snd_soc_find_phandle() followed by snd_soc_find_usb_ctx() in few places...

