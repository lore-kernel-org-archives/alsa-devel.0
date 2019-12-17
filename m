Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E730FC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 21:50:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F321C21582
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 21:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I2zz4yS2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u9R9JDPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F321C21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAB9B84F;
	Tue, 17 Dec 2019 22:49:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAB9B84F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576619428;
	bh=j2+VlCvTk3Q+augnIrsiOCYkzmo4XIlQXXme80ATJSQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I2zz4yS2z0/KQLE6z71mc8rpfCFMyjikbH6m+oIlNL3G7wuNr1nUPQbRJ8fEf6B1r
	 19UNQcRg4WEAa6hfvaARoNhDPhaB21SCwygc+dxPTLbrKCSDvVrzESJ9VCihaOZhT2
	 2Zlzz4wH6V6YNPKuKbayf52TsX6L/bImaiHy/EHA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 462CDF80218;
	Tue, 17 Dec 2019 22:49:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43354F80234; Tue, 17 Dec 2019 22:49:36 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42510F80100
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 22:49:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42510F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="u9R9JDPE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qzkCi90K5OpPTqS2WaFNoyFcrRp6QWoKLF380EToTYs=; b=u9R9JDPEhiAQZLwyr40lhFPAt
 EOQzgDr/JFOc36rjkcdU3TEGhr7olTFNMWnJIrw/qybTHULCqTowfi+xYG4xG9D5e15eYJ3rSQG3n
 9CWVpc3v2Nqy66s1w9tZQft94pR0PfOmzoimsvPQmjhtW2ybpcg2JnDukyJQ06tLYXsKiKj52bBI8
 kV35ABnS0p4sniRRuwBuh3/v03n1oW7Y7kBa7mBK2SotwF//YQsHSFM9BjVNDzRKPV8CqtUtQC8Hn
 l0oX6RyO2WkuTTsCJCz1gy7UMoojGi3csxPtq7qRZGQwRTJrw5XQc8Je8ZUyu9m6dxbT5eJCJ+HOC
 qtMdGnz4w==;
Received: from [2601:1c0:6280:3f0::fee9]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihKid-0007HE-NX; Tue, 17 Dec 2019 21:49:27 +0000
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20191217165649.12091-1-pierre-louis.bossart@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c705f013-3f20-9a32-2ba0-8a209cd4fe7e@infradead.org>
Date: Tue, 17 Dec 2019 13:49:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217165649.12091-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, broonie@kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: cml_rt1011_rt5682: fix
 codec_conf by removing legacy style
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 12/17/19 8:56 AM, Pierre-Louis Bossart wrote:
> Now that the legacy style is removed, we have to use the new macros
> for the codec configuration. This change was missed in the initial
> series.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Fixes: ee8f537fd8b71c ("ASoC: soc-core: remove legacy style of codec_conf")
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  sound/soc/intel/boards/cml_rt1011_rt5682.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
> index a22f97234201..ab1196108d23 100644
> --- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
> +++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
> @@ -406,19 +406,19 @@ static struct snd_soc_dai_link cml_rt1011_rt5682_dailink[] = {
>  
>  static struct snd_soc_codec_conf rt1011_conf[] = {
>  	{
> -		.dev_name = "i2c-10EC1011:00",
> +		.dlc = COMP_CODEC_CONF("i2c-10EC1011:00"),
>  		.name_prefix = "WL",
>  	},
>  	{
> -		.dev_name = "i2c-10EC1011:01",
> +		.dlc = COMP_CODEC_CONF("i2c-10EC1011:01"),
>  		.name_prefix = "WR",
>  	},
>  	{
> -		.dev_name = "i2c-10EC1011:02",
> +		.dlc = COMP_CODEC_CONF("i2c-10EC1011:02"),
>  		.name_prefix = "TL",
>  	},
>  	{
> -		.dev_name = "i2c-10EC1011:03",
> +		.dlc = COMP_CODEC_CONF("i2c-10EC1011:03"),
>  		.name_prefix = "TR",
>  	},
>  };
> 


-- 
~Randy

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
