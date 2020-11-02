Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32546C00A89
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:20:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AD6206B7
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YaB8I/9+";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FSwCTChV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AD6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC1A916DD;
	Mon,  2 Nov 2020 09:20:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC1A916DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604305254;
	bh=0piY80B4GWSScxJcAUqI/amYrXsKGWrVDNPobuE1CSQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YaB8I/9++iECrRCudABGof2tfRy3PtOw/L5nTiixwpAxrsHe6kesKhGnA1wtguYle
	 SXKvZxhpYvtV2x/HIEge6wTLiF1jvzxgRrXJiRa/4B8qU/MCYuw+/Hiwqtl90Ud7Vo
	 XTFyFIJJe9i2BwqBWdVc5RKWvKZ1rL1yeBkMsMvw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F749F80229;
	Mon,  2 Nov 2020 09:20:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61D19F80083; Mon,  2 Nov 2020 09:20:02 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DEF5EF80083
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 09:19:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEF5EF80083
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FSwCTChV"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A28Jsjl087168;
 Mon, 2 Nov 2020 02:19:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1604305194;
 bh=8QkUcp7suRi8RShJ/lyYhamgLqKphm7ps0gHEJVZIcM=;
 h=Subject:To:References:From:Date:In-Reply-To;
 b=FSwCTChVAJ/jKeZCXZPLSDuoOK4PpIECMvE/EbdET2trUUxtVZeF6iRce6cRhZOPf
 ozsBpflEC8AnpQOYCix7M61DuJOjNj1hv98NHr+f6Jq5yPsnhBLBob97XkP7vm8Qxo
 aMmehq014oP3j4MIH5QEmKoGAYF9aJG/hdYUapJE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A28Jsdh127918
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Nov 2020 02:19:54 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 02:19:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 02:19:54 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A28Jq7r049544;
 Mon, 2 Nov 2020 02:19:53 -0600
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: fix possible reference leak in
 __davinci_mcasp_set_clkdiv
To: Zhang Qilong <zhangqilong3@huawei.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <alsa-devel@alsa-project.org>
References: <20201030153626.94150-1-zhangqilong3@huawei.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <745d0b29-9b97-32fd-0d50-24b3df266ca6@ti.com>
Date: Mon, 2 Nov 2020 10:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201030153626.94150-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 30/10/2020 17.36, Zhang Qilong wrote:
> pm_runtime_get_sync() will increment pm usage counter whatever it
> does. Forgetting to call pm_runtime_put will result in reference
> leak in __davinci_mcasp_set_clkdiv, so we should fix it.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index a6b72ad53b43..4b46dd827f3f 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -607,6 +607,8 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  static int __davinci_mcasp_set_clkdiv(struct davinci_mcasp *mcasp, int div_id,
>  				      int div, bool explicit)
>  {
> +	int ret = 0;
> +
>  	pm_runtime_get_sync(mcasp->dev);
>  	switch (div_id) {
>  	case MCASP_CLKDIV_AUXCLK:			/* MCLK divider */
> @@ -644,11 +646,11 @@ static int __davinci_mcasp_set_clkdiv(struct davinci_mcasp *mcasp, int div_id,
>  		break;
>  
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
>  
>  	pm_runtime_put(mcasp->dev);
> -	return 0;
> +	return ret;
>  }
>  
>  static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
