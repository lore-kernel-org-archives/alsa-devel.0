Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED5CF9C7A
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:06:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14AA2DF6;
	Wed, 25 Sep 2024 17:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14AA2DF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727276784;
	bh=WIUE+NR4dmM7UiIRiFrWrzm0HxLBv/l07VyuLoQbaoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XLyAw2hluZBn1JcftwX/I3XSl+Xf3SO4chajywOy1ENx8g1CqT6QXZ/RaY0cgK2Qc
	 l8fKWuMyjkovWTC9sgr1VRINo1/vo5T1TahowAjpVeYrXQfnRwzK8FKF7xaJQjgeNq
	 dHTnZq+YPacCXPIyJiy+8tIbR61LwwspD686V/lk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9D3DF8060F; Wed, 25 Sep 2024 17:05:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16F40F805FB;
	Wed, 25 Sep 2024 17:05:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA227F805E8; Wed, 25 Sep 2024 17:05:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CBC1F805B5
	for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2024 17:05:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CBC1F805B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TfCI+2t3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727276721; x=1758812721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WIUE+NR4dmM7UiIRiFrWrzm0HxLBv/l07VyuLoQbaoI=;
  b=TfCI+2t3JlE9XB4lEHcJBM4HHrMBvr4hjZgzdYBVH47m9mno3f2cSrrE
   lYCEfZAouVJiVs4e+xGiHLR/8eetiUSMe7ppdsuAAOs8fLU6F91BfbTtt
   rtNCb61uX5KVLggK4BOJVLb8RGDOXKXRtDNH6GAud0Np0Y77pAFtE5q8y
   Ih5cS3BNoGocBUz1NczsWaHMlC6pSBHBa0RnLCyboreRGDo4aLyE7YR3o
   CH/ty45+cEIB3NYdOpHIu/qnffxJ0DiOYU2uEdG+aMLxSdShPHDRcjqIW
   TrdID+7sFWYuv6kwsVK9H+5l82jXHP7iaQUZsptq5TNv+fSRKK9wQnLp0
   w==;
X-CSE-ConnectionGUID: GtTx7g/mRhaCoRCpeaQV6w==
X-CSE-MsgGUID: alBO/1DuSrWmXZ0cWTj3TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26482931"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600";
   d="scan'208";a="26482931"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2024 08:05:19 -0700
X-CSE-ConnectionGUID: t0VHFxgySvWLh5P88yN8lA==
X-CSE-MsgGUID: D7kHPYD7S9yt1ec8gM4MTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600";
   d="scan'208";a="76317712"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.30])
 ([10.245.246.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2024 08:05:13 -0700
Message-ID: <a7e97534-0351-4673-9fbe-e02b2aef998c@linux.intel.com>
Date: Wed, 25 Sep 2024 16:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 25/32] ASoC: qcom: qdsp6: Fetch USB offload mapped
 card and PCM device
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com, corbet@lwn.net, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, krzk+dt@kernel.org,
 Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, robh@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
References: <20240925010000.2231406-1-quic_wcheng@quicinc.com>
 <20240925010000.2231406-26-quic_wcheng@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240925010000.2231406-26-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: ZMB2EX7IMMFHMOI5RBB5OXEE2S4VKJST
X-Message-ID-Hash: ZMB2EX7IMMFHMOI5RBB5OXEE2S4VKJST
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZMB2EX7IMMFHMOI5RBB5OXEE2S4VKJST/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


> +static int q6usb_update_offload_route(struct snd_soc_component *component, int card,
> +				      int pcm, int direction, long *route)
> +{
> +	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
> +	struct snd_soc_usb_device *sdev;
> +	int ret = 0;
> +	int cidx = -1;
> +	int pidx = -1;
> +
> +	mutex_lock(&data->mutex);
> +
> +	if (list_empty(&data->devices) ||
> +	    direction == SNDRV_PCM_STREAM_CAPTURE) {
> +		ret = -ENODEV;
> +		goto out;
> +	}

well the code above seems to invalidate what I understood earlier, in
that an error code is returned instead of a set of -1 values...

> +
> +	sdev = list_last_entry(&data->devices, struct snd_soc_usb_device, list);
> +
> +	/*
> +	 * Will always look for last PCM device discovered/probed as the
> +	 * active offload index.
> +	 */
> +	if (card == sdev->card_idx &&
> +	    pcm == sdev->ppcm_idx[sdev->num_playback - 1]) {
> +		cidx = component->card->snd_card->number;
> +		pidx = q6usb_get_pcm_id(component);
> +	}
> +
> +	if (cidx < 0 || pidx < 0) {
> +		cidx = -1;
> +		pidx = -1;
> +	}
> +
> +out:
> +	route[0] = cidx;
> +	route[1] = pidx;
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
