Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82617C3DA4A
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Aug 2024 09:15:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1B3438CF;
	Thu,  1 Aug 2024 11:14:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1B3438CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722503692;
	bh=N/O38cSPMC8Lgjj4zxdXeCxlRhlPgDYWQiNhJMimuAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Tp0hOOXdjs50Qty27bldUYbguXm2w3G6Mr8UP5y2TFKxTuNKPIhtTthBYUM6tH9IG
	 qQTxNisDWDZRltFc7fi+Q7DLYpLkSBNSzJ69npMnPkDco2gBgvEkWv1ktFacmi22aS
	 F6so0TOuIJILUPtTpsB8r7d1Djxc86pX/C7VD/qQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 870D6F8068A; Thu,  1 Aug 2024 11:13:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70C84F8068A;
	Thu,  1 Aug 2024 11:13:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC924F80605; Thu,  1 Aug 2024 11:12:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B222F80588
	for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2024 11:12:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B222F80588
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ez6oncHr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722503532; x=1754039532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N/O38cSPMC8Lgjj4zxdXeCxlRhlPgDYWQiNhJMimuAc=;
  b=Ez6oncHrW3T8LaBTCzoyKOWzRutfW9ygoQbl8vVEud9mD60EOqY9h+Mk
   XnpYOp42ABRVg853pyOS3JRfR5t7b4/rfsCGg0nKwSyV+9tQ5pbmoBWGf
   tvSMh8ZsAx4SpTx1vMj5haB/7XVu3XLc5Hs+3tOyb0vXvUOqqHGZRxa4W
   XfQlLUQfanO4r/8WU4DD8E+zgz7qQti8cE989w3Fnqdq1Iw/W0F2fmb2u
   /HYruxuyJFq/Kly7Nlu/QVjf89/U1M1kgiBW+PYtTaXtBfp5ByOTbYnTi
   Elhs8YlWnQWfANjl9RZauJ7P5YB8ouVAqCCr8xPepLWRLFq7CvUDZ/pB9
   g==;
X-CSE-ConnectionGUID: K8XPlJ85T5iYiSjPt+coGg==
X-CSE-MsgGUID: 44JSaz8YSXCr5xXpNf2MDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20383652"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800";
   d="scan'208";a="20383652"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 02:12:10 -0700
X-CSE-ConnectionGUID: ppEKMHUATh6ElntSYpl8FQ==
X-CSE-MsgGUID: 3Lh38z4lTkG8C3M6/pNUTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800";
   d="scan'208";a="59090171"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.220])
 ([10.245.246.220])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 02:12:04 -0700
Message-ID: <c2ab91ed-a2e5-437e-bbdb-84988a052778@linux.intel.com>
Date: Thu, 1 Aug 2024 10:57:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 26/34] ALSA: usb-audio: qcom: Don't allow USB offload
 path if PCM device is in use
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
 <20240801011730.4797-27-quic_wcheng@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240801011730.4797-27-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: TEPL7V6QZZIZLTCC2IQRE3ECGDNN4VPD
X-Message-ID-Hash: TEPL7V6QZZIZLTCC2IQRE3ECGDNN4VPD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TEPL7V6QZZIZLTCC2IQRE3ECGDNN4VPD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 8/1/24 03:17, Wesley Cheng wrote:
> Add proper checks and updates to the USB substream once receiving a USB QMI
> stream enable request.  If the substream is already in use from the non
> offload path, reject the stream enable request.  In addition, update the
> USB substream opened parameter when enabling the offload path, so the
> non offload path can be blocked.

It's a bit weird that the mutual exclusion between the standard path and
the offloaded path is handled at the vendor level. I would think this
needs to be handled in the soc_usb framework, no?


> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/qcom/qc_audio_offload.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> index 8b0913b7256b..3b46d05f1421 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -1460,12 +1460,17 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		goto response;
>  	}
>  
> +	mutex_lock(&chip->mutex);
>  	if (req_msg->enable) {
> -		if (info_idx < 0 || chip->system_suspend) {
> +		if (info_idx < 0 || chip->system_suspend || subs->opened) {
>  			ret = -EBUSY;
> +			mutex_unlock(&chip->mutex);
> +
>  			goto response;
>  		}
> +		subs->opened = 1;
>  	}
> +	mutex_unlock(&chip->mutex);
>  
>  	if (req_msg->service_interval_valid) {
>  		ret = get_data_interval_from_si(subs,
> @@ -1487,6 +1492,11 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		if (!ret)
>  			ret = prepare_qmi_response(subs, req_msg, &resp,
>  					info_idx);
> +		if (ret < 0) {
> +			mutex_lock(&chip->mutex);
> +			subs->opened = 0;
> +			mutex_unlock(&chip->mutex);
> +		}
>  	} else {
>  		info = &uadev[pcm_card_num].info[info_idx];
>  		if (info->data_ep_pipe) {
> @@ -1510,6 +1520,9 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		}
>  
>  		disable_audio_stream(subs);
> +		mutex_lock(&chip->mutex);
> +		subs->opened = 0;
> +		mutex_unlock(&chip->mutex);
>  	}
>  
>  response:

