Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B0AC388F2
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:08:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0294222272
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KG5/sIN5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jG3iHFbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0294222272
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A6D816E1;
	Mon,  2 Nov 2020 10:07:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A6D816E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604308093;
	bh=E9rBf72K5GQeWtfpkXQU3Gydp+8qi/WKgSXAqQ2RC6A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KG5/sIN5T3/hpyBKLfg1MGo/UGJUZAiA2F83pV1ibpBZdiUYOozmY5i4Q6iMr3faJ
	 6E4vwQzTbAMQw+sdLn22RTs83gtPsuPGu76vJZ8FHJF2URUtW+ZEioOwBvHikH6hLb
	 YY883pfLMYLQNWgpWy9xxCCh/7m39IxuoAAEWSR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC2FBF80229;
	Mon,  2 Nov 2020 10:07:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83089F80083; Mon,  2 Nov 2020 10:07:20 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2FFEF80083
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 10:07:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2FFEF80083
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jG3iHFbY"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A297C9d116706;
 Mon, 2 Nov 2020 03:07:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1604308032;
 bh=l+94TL1vtrXoT59ZDlXQ/xfshYQqZp6zUYBNSNMeCwo=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=jG3iHFbYJ6S4ptCsssqSncK+YLE8RJJqDmp7xnmXeoBEUoY4ul23volKYBUNpYRoW
 hGOTrLkWy0hzUO5shde9vPGQMu250Ji3CRb0mhvq7jxALtkWTTjziGikukEnKviUUQ
 sEpa7nDNA8JhX2Ys+fIWctBM9qFXLnf1lX+aXxk8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A297C7b108685
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Nov 2020 03:07:12 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 03:07:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 03:07:12 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A297ApW064333;
 Mon, 2 Nov 2020 03:07:10 -0600
Subject: Re: [PATCH v2] ASoC: ti: davinci-mcasp: fix error handling in
 davinci_mcasp_probe
To: Zhang Qilong <zhangqilong3@huawei.com>, <perex@perex.cz>, <tiwai@suse.com>
References: <20201102085436.14450-1-zhangqilong3@huawei.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <182d48d4-2866-8e7c-dc28-7f84967260e2@ti.com>
Date: Mon, 2 Nov 2020 11:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102085436.14450-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
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



On 02/11/2020 10.54, Zhang Qilong wrote:
> Forgetting to call pm_runtime_disable if davinci_mcasp_get_dt_params
> failed in function davinci_mcasp_probe, and we should go to error
> handling branch.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
> Changelog:
> V2
> - changed the subject and fixed the description.
> ---
>  sound/soc/ti/davinci-mcasp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 4b46dd827f3f..ec90c23c9e20 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2362,8 +2362,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  		goto err;
>  
>  	ret = davinci_mcasp_get_dt_params(mcasp);
> -	if (ret)
> -		return -EINVAL;
> +	if (ret) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
>  
>  	ret = devm_snd_soc_register_component(&pdev->dev,
>  					&davinci_mcasp_component,
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
