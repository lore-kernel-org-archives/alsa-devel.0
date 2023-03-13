Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0A8C61DA4
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Mar 2023 17:50:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05C8A1452;
	Mon, 13 Mar 2023 18:49:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05C8A1452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678729835;
	bh=k1jfQWwUrLRiIUyKxmnw1YYQ/KfXv2xO0bIFnvUL4Dk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QksWDpE/IpIrJQUaIra5EHOwdaCMoI1J6g1VHUxiLfbdcQ2xYGVcoH/AytZkQBSUg
	 d8Si3BlJEvwvWRLR+bfIQlTfuaIXkuBYZmrf9EeT7fjzT6gOPb993dwshH3wPUyxM5
	 WnpGtrtgAoU59BLT0S4DsVr165xltB9hCwy75sHQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86961F80425;
	Mon, 13 Mar 2023 18:49:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 889CBF80425; Mon, 13 Mar 2023 18:49:19 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 55025F8016C
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2023 18:49:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55025F8016C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HaoPxOv8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678729756; x=1710265756;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=k1jfQWwUrLRiIUyKxmnw1YYQ/KfXv2xO0bIFnvUL4Dk=;
  b=HaoPxOv8LY2tJHDcUhQFcGMtr4eBWM4MvwKQrdLetgEEOLIMBUa09coT
   cY3+gYBl+q8wkngVHwPYWty+BOcTyR/sg4c8Id8jOV85W+1TrubxovcAR
   x8u6nCDl/zJAh8kzzdBGWYOLYEgTkfLEmOlxE7m/6ig1afePxDgaZp3cz
   vkPxMvtMW8w0Tc10oMG2EmsQ5guyaMW4VrDZPu70aqBe8jDUsq73pduzU
   FnH7UbIgO5GhhmUUjCXf0ReOgACAVLbe5pglt/KMOay57sE8u00LSLPv4
   ucL8zTkpTB3bVVLrRXz319RzWLjGhrl/1bE6eTDqnE0k5xFx/EvNBOQJ7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321069346"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400";
   d="scan'208";a="321069346"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 10:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="852860027"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400";
   d="scan'208";a="852860027"
Received: from jlewis8x-mobl.amr.corp.intel.com (HELO [10.255.34.75])
 ([10.255.34.75])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 10:49:10 -0700
Message-ID: <6fbd4471-9f72-c87c-3803-90f7224abce0@linux.intel.com>
Date: Mon, 13 Mar 2023 09:46:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/2] ASoC: max98363: add soundwire amplifier driver
Content-Language: en-US
To: =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
 ckeepax@opensource.cirrus.com, herve.codina@bootlin.com,
 wangweidong.a@awinic.com, james.schulman@cirrus.com,
 ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
 povik+lin@cutebit.org, flatmax@flatmax.com, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
 ryans.lee@analog.com
References: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 6QDAJXCYIW6EKKMGUNK5AUQTR5GEJ722
X-Message-ID-Hash: 6QDAJXCYIW6EKKMGUNK5AUQTR5GEJ722
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6QDAJXCYIW6EKKMGUNK5AUQTR5GEJ722/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


> +	ret = sdw_stream_add_slave(max98363->slave, &stream_config,
> +				   &port_config, 1, stream);
> +	if (ret) {
> +		dev_err(dai->dev, "Unable to configure port\n");
> +		return ret;
> +	}
> +
> +	if (params_channels(params) > 16) {
> +		dev_err(component->dev, "Unsupported channels %d\n",
> +			params_channels(params));
> +		return -EINVAL;
> +	}

Do you actually support more than 8 channels?

The data port DPnPrepareCtl and DPn_ChannelEn registers expose 8
channels max. It's always possible to 'cheat' by packing two channels in
the same sample, but that would require custom signaling between manager
and peripheral that isn't present.

Could it be a left-over from a TDM implementation?

The rest of the patch looks fine.
