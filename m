Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46301C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:26:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB64620801
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WTS1H8XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB64620801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E008D1697;
	Tue, 18 Feb 2020 18:25:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E008D1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582046779;
	bh=NiNdA4STW+Kp4u9Cr8EIBcNpBuDiwpa9AsaiON8Bm40=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WTS1H8XGbmm9MNAIcY7b9gRFXCeqerRZxF762EPAUNSNlCUkiMhO/0CfKpznu3Rw4
	 1VvAJYFctIZ2dVvSLNsUvgSLbdg7/VDVPV13R4qfX+ok7gL5E3gouQhhXQgnbXQBQC
	 qqt7mt0ZUBb3BYAzmAMir6Yie8XcDaDIsWpnI4lo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0BF8F80148;
	Tue, 18 Feb 2020 18:24:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59F80F80247; Tue, 18 Feb 2020 18:24:35 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6BD1F80145
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 18:24:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6BD1F80145
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 09:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; d="scan'208";a="408136597"
Received: from bmerugul-mobl1.amr.corp.intel.com (HELO [10.251.159.61])
 ([10.251.159.61])
 by orsmga005.jf.intel.com with ESMTP; 18 Feb 2020 09:24:26 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: codecs: make PCM5102A codec selectable
To: David Douard <david.douard@sdfa3.org>, alsa-devel@alsa-project.org
References: <20200214002505.13112-1-david.douard@sdfa3.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ae4df82b-4493-4086-1654-2b6d62cf7d0e@linux.intel.com>
Date: Tue, 18 Feb 2020 10:04:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214002505.13112-1-david.douard@sdfa3.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>
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

[Adding Mark Brown - CC: maintainers if you want your patch to be applied]

On 2/13/20 6:25 PM, David Douard wrote:
> The PCM5102A codec entry in the Kconfig file lacks a title/description
> to make it selectable in menuconfig (since it has no dependent i2s/spi
> sub-modules like e.g. the pcm512x one).

For my education, who uses this codec? it's not selected by any machine 
driver?

> ---
>   sound/soc/codecs/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 7e90f5d83097..676fa62e9b7f 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -934,7 +934,7 @@ config SND_SOC_PCM3168A_SPI
>   	select REGMAP_SPI
>   
>   config SND_SOC_PCM5102A
> -	tristate
> +	tristate "Texas Instruments PCM5102A CODEC"
>   
>   config SND_SOC_PCM512x
>   	tristate
> 
