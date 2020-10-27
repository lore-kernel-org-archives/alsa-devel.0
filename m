Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F8DC4363A
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:00:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E6820878
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lA7zXZaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E6820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0716616DC;
	Tue, 27 Oct 2020 19:59:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0716616DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603825233;
	bh=YyI8JuV/dpr8wfA07agcfS4G/BMjh0FGYqhVbpeAdfY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lA7zXZaMwyS2juGtY9Zo+en0IPUQ0ygM3GsDbRVqAsX9g3IQfyp6htuQUJ1WU9aMH
	 k2TUJwHBMKsmRZXCZkooH5Q0ep8NWVByWxIJCFUNB1PNZgMziZ8clAgWyS7UTedJ6G
	 TmJIHjvnzV3OHGDswWcR81q4wqbW0zOGloVJk02o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FB67F80086;
	Tue, 27 Oct 2020 19:59:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E64DF8020D; Tue, 27 Oct 2020 19:59:41 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81EFDF80086
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 19:59:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81EFDF80086
IronPort-SDR: lX3DqSu8fIl6Gp+RkeW6rhG8Jss3Uhf90RRLmzm+UA/yjtNimJjes9FLtE+SGoOS9+OH7In56c
 jRz7f2waIBtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="147428970"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; d="scan'208";a="147428970"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 11:59:24 -0700
IronPort-SDR: SFyqsuloCpBFPe0fRFFSk+S/ZWCe/xFa/AgewmFcVG01vyQXYbZBjj8wJdmMZ1FKJRtIfSVo2Z
 xg1dmHdYpzSA==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; d="scan'208";a="524844162"
Received: from nakabir-mobl.amr.corp.intel.com (HELO [10.212.164.122])
 ([10.212.164.122])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 11:59:22 -0700
Subject: Re: [PATCH v9 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
 <20201027183149.145165-2-peron.clem@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <01e34ad3-c695-c6eb-95dd-76c2cda77c6f@linux.intel.com>
Date: Tue, 27 Oct 2020 13:58:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027183149.145165-2-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Samuel Holland <samuel@sholland.org>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Marcus Cooper <codekipper@gmail.com>, linux-sunxi@googlegroups.com,
 linux-arm-kernel@lists.infradead.org
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


> @@ -452,11 +454,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>   	case SND_SOC_DAIFMT_DSP_B:
>   	case SND_SOC_DAIFMT_LEFT_J:
>   	case SND_SOC_DAIFMT_RIGHT_J:
> -		lrck_period = params_physical_width(params) * slots;
> +		lrck_period = slot_width * slots;
>   		break;
>   
>   	case SND_SOC_DAIFMT_I2S:
> -		lrck_period = params_physical_width(params);
> +		lrck_period = slot_width;
>   		break;

Aren't I2S, LEFT_J and RIGHT_J pretty much the same in terms of lrclk 
rate/period? the only thing that can change is the polarity, no?

Not sure why it's handled differently here?
