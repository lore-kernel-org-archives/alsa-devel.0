Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9AC4361B
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 15:12:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F50D2370D
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 15:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F50D2370D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 079361717;
	Mon,  7 Dec 2020 16:11:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 079361717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607353936;
	bh=a3QrmKHg66u0Y4TcKrbQFSLSHS8GobuT6iNcySxSKMg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xa+FRDqTz9nZ6VYR0kcOsfyG30bcVe+Ht+Nlg3+UifOJBsxZajSljRZBUDnDbLfKB
	 CQHsIIpW3whPqDRih1jhGYsF5j/HiGgm5bqTKIumN0cPfV9xY7Haeil3tTD2hH9LDe
	 D48i9vY2kamw4l09vf3SLP3UGHSbv1MTL4tnQw3w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6638CF801D8;
	Mon,  7 Dec 2020 16:11:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38028F8020D; Mon,  7 Dec 2020 16:11:24 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABADAF8015B
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2020 16:11:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABADAF8015B
IronPort-SDR: 2UlUyob3aGfdG+ksz8wAuvwT0jICuF0HWX4YOcGgW84npKICMMVwmM8EksIpOzGrK+hqmpWaD+
 2zXg7iNJC6Nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="235315568"
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; d="scan'208";a="235315568"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2020 07:11:12 -0800
IronPort-SDR: laahLEscd3REWPVDOIcqs9FqnRD9Ol5y2SGv2URInaj6GfR21B4yGRpJiUv5Z0OaO+LeSu9T9a
 JUKTv0GHSXjQ==
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; d="scan'208";a="541526581"
Received: from singhyax-mobl2.amr.corp.intel.com (HELO [10.255.229.103])
 ([10.255.229.103])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2020 07:11:12 -0800
Subject: Re: [RFC SOF 1/2] topology: Add sof-byt-codec-tdm4.m4 file
To: Hans de Goede <hdegoede@redhat.com>
References: <20201206124626.13932-1-hdegoede@redhat.com>
 <20201206124626.13932-2-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1272e367-6600-198d-e93f-ba2bfa2c6c0f@linux.intel.com>
Date: Mon, 7 Dec 2020 09:11:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201206124626.13932-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Hi Hans,

> Some BYT/CHT boards (mostly Cherry Trail) use TDM 4 slots 24 bit as
> wire format to the codec, rather then standard I2S 2 channel 24 bit.
> 
> Add a new m4 file for this. This is a copy of sof-byt-codec.m4 with
> the following changes:
> 
> @@ -1,4 +1,4 @@
> -`# Topology for generic' PLATFORM `board with' CODEC `on SSP' SSP_NUM
> +`# Topology for generic' PLATFORM `board with' CODEC `on SSP' SSP_NUM `using TDM 4 slots 24 bit'
> 
>   # Include topology builder
>   include(`utils.m4')
> @@ -97,8 +97,8 @@
>   # BE configurations - overrides config in ACPI if present
>   #
>   DAI_CONFIG(SSP, SSP_NUM, 0, SSP2-Codec,
> -	   SSP_CONFIG(I2S, SSP_CLOCK(mclk, 19200000, codec_mclk_in),
> -		      SSP_CLOCK(bclk, 2400000, codec_slave),
> +	   SSP_CONFIG(DSP_B, SSP_CLOCK(mclk, 19200000, codec_mclk_in),
> +		      SSP_CLOCK(bclk, 4800000, codec_slave),
>   		      SSP_CLOCK(fsync, 48000, codec_slave),
> -		      SSP_TDM(2, 25, 3, 3),
> +		      SSP_TDM(4, 25, 3, 3),
>   		      SSP_CONFIG_DATA(SSP, SSP_NUM, 24)))

I don't think this change is necessary, the problem is probably that we 
still rely on the hard-coded 4 slots in the machine driver which was the 
default for the Atom/SST driver.

If I look at the cht_bsw_nau8824.c driver, the only place where there is 
a reference to 4 slots is in the cht_codec_init() function.

https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/cht_bsw_nau8824.c#L104

In other drivers, this was moved to the codec_fixup routine which is 
overridden/ignored when SOF is used.

see e.g.

https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/cht_bsw_max98090_ti.c

https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/cht_bsw_rt5645.c

If you follow the same pattern that should make this problem go away. 
When SOF is used we typically don't have any hard-coded format and 
whatever is defined in the topology is propagated to the codec driver.

Hope this helps
-Pierre
