Return-Path: <SRS0=mTWV=6K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C16CC54FCB
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:59:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C944206DD
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fMEg7PQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C944206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitmer.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1541827;
	Sun, 26 Apr 2020 18:58:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1541827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587920353;
	bh=r/a9ps6OO2xqur2E0ceIyULKGI5sit5lN+svIDj9O9Y=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fMEg7PQKR3EyXg9R/Zlo14lf6VxT89D5cjB8lIv39puDor5lmHwrSEW5KwSqllyjK
	 /Np9CiNusSvg+JLrvZNUBawisZy6LzVT+n1/I+YfSB2vz0HCa7hh8n9VhS10LepemQ
	 Xbed+mZr41Lev1xnRKAGaWs83mOeyqSzbYtTvaW0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50F90F80105;
	Sun, 26 Apr 2020 18:58:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B78E2F801DB; Sun, 26 Apr 2020 18:58:20 +0200 (CEST)
Received: from bitmer.com (50-87-157-213.static.tentacle.fi [213.157.87.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FD66F8010A
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 18:58:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FD66F8010A
Received: from 88-114-185-20.elisa-laajakaista.fi ([88.114.185.20]
 helo=[192.168.1.42])
 by bitmer.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <jarkko.nikula@bitmer.com>)
 id 1jSkbS-0003UA-FT; Sun, 26 Apr 2020 19:58:02 +0300
Subject: Re: [PATCH] ASoC: ti: remove comparison to bool in
 omap_mcbsp_dai_set_dai_fmt()
To: Jason Yan <yanaijie@huawei.com>, peter.ujfalusi@ti.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 rafael.j.wysocki@intel.com, tglx@linutronix.de, alsa-devel@alsa-project.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200426094238.23914-1-yanaijie@huawei.com>
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Message-ID: <718c9a90-b5ff-f538-1152-c9b585095f3c@bitmer.com>
Date: Sun, 26 Apr 2020 19:57:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426094238.23914-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 4/26/20 12:42 PM, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> sound/soc/ti/omap-mcbsp.c:1188:5-11: WARNING: Comparison to bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  sound/soc/ti/omap-mcbsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> index 3d41ca2238d4..0348963f4df7 100644
> --- a/sound/soc/ti/omap-mcbsp.c
> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -1185,7 +1185,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  	default:
>  		return -EINVAL;
>  	}
> -	if (inv_fs == true)
> +	if (inv_fs)
>  		regs->pcr0 ^= FSXP | FSRP;
>  
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
