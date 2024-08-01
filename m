Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53999C3DA4A
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Aug 2024 09:28:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63A243951;
	Thu,  1 Aug 2024 11:28:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63A243951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722504491;
	bh=OziTlghW/wlMQZK0K9+wYZg1uMjzZ8EsjYPZDOViGlo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mIQLVn7Ea2dKRUftlwnmDvzt7RmY/F0W+ojZJZxxj1JmHZGQbtMH8Rg6zOobfd5IZ
	 QR6EpNpQXwCh3Kp8C6Xplv1o8K7OKyZR124T1nXRfmfry1xGRIvAOc/HpavkKhuqp1
	 gE9/SYKPpf9WIy2u3V0CVQ84OVO6K0s9OPV7MpzM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 143D8F805B5; Thu,  1 Aug 2024 11:27:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE14EF805BA;
	Thu,  1 Aug 2024 11:27:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C189F80269; Thu,  1 Aug 2024 11:16:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 95058F80448
	for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2024 11:12:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95058F80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Zgz2dlHr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722503525; x=1754039525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OziTlghW/wlMQZK0K9+wYZg1uMjzZ8EsjYPZDOViGlo=;
  b=Zgz2dlHrdoWS3aE0aJhPmuHk7fkclfHoFk4GyMnJK/VW4ceQ69A5jYKq
   QJnN5RYw4j2Wz8zpqvfxFREyAhRvoMo7HxzHhe1XqTXe+RhuXodna4Wzp
   jKJFhBVHlbac/ahGL/dj4dfINr+RS9MMxhP/WtoG8h/79RMnErDNh8qQG
   37wO/ftf3ptWFokCb56vQqY7jdsfeVHOdV5acdvT4jR+y0B4+WK4X/Z/X
   TfINh3HrMRvd9yej+TXs9s2gJNm+L180IE1YEisJLCqU9GGfqnTo2Iu8O
   0NF5Kqbb+H/5EF+s51E2Lu8JlnLcI2Dp6TBwqPS10X+oVqNLPr+p0EKzw
   w==;
X-CSE-ConnectionGUID: ZEXjeA3JQQGYMsfojR2F8A==
X-CSE-MsgGUID: H3cifvmsQ9m+l8GgN1XmOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20383571"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800";
   d="scan'208";a="20383571"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 02:11:50 -0700
X-CSE-ConnectionGUID: BHajjV1SQTOmkqgtPprL1g==
X-CSE-MsgGUID: wBaSr/dKTH29cbTi2Z2zog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800";
   d="scan'208";a="59089939"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.220])
 ([10.245.246.220])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 02:11:43 -0700
Message-ID: <5f37c04d-f564-40b9-a9f3-d071ea0a6f19@linux.intel.com>
Date: Thu, 1 Aug 2024 10:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 17/34] ASoC: qcom: qdsp6: Add USB backend ASoC driver
 for Q6
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
 <20240801011730.4797-18-quic_wcheng@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240801011730.4797-18-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: MSLEHZT7TQJFO3CXHOZ3P2JDAIFU2HPC
X-Message-ID-Hash: MSLEHZT7TQJFO3CXHOZ3P2JDAIFU2HPC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MSLEHZT7TQJFO3CXHOZ3P2JDAIFU2HPC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>




> +static int q6usb_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params,
> +			   struct snd_soc_dai *dai)
> +{
> +	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +	struct q6afe_port *q6usb_afe;
> +	struct snd_soc_usb_device *sdev;
> +	int ret;
> +
> +	/* No active chip index */
> +	if (list_empty(&data->devices))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	sdev = list_last_entry(&data->devices, struct snd_soc_usb_device, list);
> +
> +	q6usb_afe = q6afe_port_get_from_id(cpu_dai->dev, USB_RX);
> +	if (IS_ERR(q6usb_afe))
> +		goto out;
> +
> +	/* Notify audio DSP about the devices being offloaded */
> +	ret = afe_port_send_usb_dev_param(q6usb_afe, sdev->card_idx,
> +						sdev->pcm_idx);
> +
> +out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}

Humm, multiple questions here

a) is this intentional that the params are not used in a hw_params routine?

b) if yes, could this be replaced by a .prepare callback

c) along the same lines as b), is suspend-resume during playback
supported? Usually this is handled with a .prepare callback to restore
connections.
> +
> +static const struct snd_soc_dai_ops q6usb_ops = {
> +	.hw_params = q6usb_hw_params,
> +};


