Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6804C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:40:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662932064A
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QUzbPU77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662932064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2442169B;
	Fri, 24 Apr 2020 01:39:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2442169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587685213;
	bh=Vrj3BYjYF/kyih9rBHaVvbeZbNdvfzNx2kVtQzMfMTk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUzbPU77/ENOu9+MS3dmVkJEDK3+PFun9p4jtDjLKOasH/wn6sztMLTz4waik9C4h
	 ncNd3mgVYobVqFJmPqpSPJdS7hBwj5sEUIav9bBXPcqeDC65Pxk2xpNFcRwNYY4WgW
	 +xDDSh6FlsaalLtvU47Hi4V+gH+Mc3qKdoi0bxLk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8F94F801F5;
	Fri, 24 Apr 2020 01:38:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A5B9F801ED; Fri, 24 Apr 2020 01:38:30 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8630DF80121
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 01:38:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8630DF80121
IronPort-SDR: DkoR7+B1mHM5apvILSF3HWN4x506v+iGhhAzJd7zAl+YAauCpTn5n3UZ3QVJcgo1AyL6wf+CKK
 ofpAi06sKixw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 16:38:24 -0700
IronPort-SDR: JczsA5XDcOXDmLpSbuv/mm0fP/FHxKPKzFct8HL/BBI1Nfp0n7q8K4RMs/nTu6IzuwQ7UgcD1f
 Y+NJFQ6eR1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,309,1583222400"; d="scan'208";a="280613634"
Received: from rguevarr-mobl1.amr.corp.intel.com (HELO [10.251.131.195])
 ([10.251.131.195])
 by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2020 16:38:23 -0700
Subject: Re: [PATCH 01/17] ASoC: soc-dai: add soc_dai_err()
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <871rofunaq.wl-kuninori.morimoto.gx@renesas.com>
 <87zhb3t8p5.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bf6b80e9-79ef-eddd-29ec-fc54bcac37db@linux.intel.com>
Date: Thu, 23 Apr 2020 13:33:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87zhb3t8p5.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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



On 4/22/20 6:13 PM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> At soc-dai.c, it is good idea to indicate error function and
> its component name if there was error.
> This patch adds soc_dai_err() for it.

the code below adds soc_dai_ret(), is this a typo?

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/soc-dai.c | 155 +++++++++++++++++++++++++++-----------------
>   1 file changed, 96 insertions(+), 59 deletions(-)
> 
> diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
> index 31c41559034b..d591b3bd8b99 100644
> --- a/sound/soc/soc-dai.c
> +++ b/sound/soc/soc-dai.c
> @@ -9,6 +9,24 @@
>   #include <sound/soc.h>
>   #include <sound/soc-dai.h>
>   
> +#define soc_dai_ret(dai, ret) _soc_dai_ret(dai, __func__, ret)
> +static inline int _soc_dai_ret(struct snd_soc_dai *dai,
> +			       const char *func, int ret)
> +{
> +	switch (ret) {
> +	case -EPROBE_DEFER:
> +	case -ENOTSUPP:
> +	case 0:
> +		break;
> +	default:
> +		dev_err(dai->dev,
> +			"ASoC: error at %s on %s: %d\n",
> +			func, dai->name, ret);
> +	}
> +
> +	return ret;
> +}
> +

