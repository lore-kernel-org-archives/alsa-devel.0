Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9962FC11D20
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:59:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E4D20679
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WVnbqXDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E4D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68ADC16B6;
	Thu, 20 Feb 2020 21:58:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68ADC16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582232349;
	bh=lLDRlSYg64hpZzBG0pQ58NtvOe7iqG3DVVKHXpKFVX8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WVnbqXDtsCemIra3KPsY9rZBGQqFTLVld3fckSBpTj6zulY8Mw++0GjQTwyJWfg++
	 ZlPwDegZQ7u5jwE5L7DgBtKFu4rGwipesEQkni7Kc47wfi8g7uUQzeLFCDlsdOXoZB
	 skltNV7AYTDoq/XEQ6yZxu8/QUVGUkmyy8wjEl/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8659F8028A;
	Thu, 20 Feb 2020 21:58:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F80BF8028B; Thu, 20 Feb 2020 21:57:59 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E42F8F80229
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 21:57:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E42F8F80229
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Feb 2020 12:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; d="scan'208";a="259406128"
Received: from rpduffy-mobl.amr.corp.intel.com (HELO [10.254.49.41])
 ([10.254.49.41])
 by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2020 12:57:52 -0800
Subject: Re: [PATCH] ASoC: pcm512x: Fix unbalanced regulator enable call in
 probe error path
To: Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>
References: <20200220202956.29233-1-hias@horus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <81a4e657-038a-d664-1b0a-d04e25a7ddfb@linux.intel.com>
Date: Thu, 20 Feb 2020 14:54:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220202956.29233-1-hias@horus.com>
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



On 2/20/20 2:29 PM, Matthias Reichl wrote:
> When we get a clock error during probe we have to call
> regulator_bulk_disable before bailing out, otherwise we trigger
> a warning in regulator_put.
> 
> Fix this by using "goto err" like in the error cases above.
> 
> Fixes: 5a3af1293194d ("ASoC: pcm512x: Add PCM512x driver")
> Signed-off-by: Matthias Reichl <hias@horus.com>

LGTM:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/codecs/pcm512x.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
> index 861210f6bf4fd..4cbef9affffda 100644
> --- a/sound/soc/codecs/pcm512x.c
> +++ b/sound/soc/codecs/pcm512x.c
> @@ -1564,13 +1564,15 @@ int pcm512x_probe(struct device *dev, struct regmap *regmap)
>   	}
>   
>   	pcm512x->sclk = devm_clk_get(dev, NULL);
> -	if (PTR_ERR(pcm512x->sclk) == -EPROBE_DEFER)
> -		return -EPROBE_DEFER;
> +	if (PTR_ERR(pcm512x->sclk) == -EPROBE_DEFER) {
> +		ret = -EPROBE_DEFER;
> +		goto err;
> +	}
>   	if (!IS_ERR(pcm512x->sclk)) {
>   		ret = clk_prepare_enable(pcm512x->sclk);
>   		if (ret != 0) {
>   			dev_err(dev, "Failed to enable SCLK: %d\n", ret);
> -			return ret;
> +			goto err;
>   		}
>   	}
>   
> 
