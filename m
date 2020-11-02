Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5FBC00A89
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:10:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4604422275
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H2IaGAiX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xtr+d/Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4604422275
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CA9816E4;
	Mon,  2 Nov 2020 10:09:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CA9816E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604308244;
	bh=UAPn3GGtZh0BGqjNRdp3XTIshUtnqNXjYnPpLMLAceM=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2IaGAiXjtrz+LEmzxMcLmasX/GqLgliiZBW9qQMhiVo2tNxEWwepGtkGdA2OcdEE
	 l42s/98pE0ynBzKMPhCNaO73Zxw/dSCYMMtcuf89XpYhk7GR6vdF8o99x0qOjLFrr5
	 6sJTJZnjs+I3psmEVpqO3MgIb9rLFsb+tGW/+ZYs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B38C1F80229;
	Mon,  2 Nov 2020 10:09:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F05FFF80232; Mon,  2 Nov 2020 10:09:52 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF829F8015A
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 10:09:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF829F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xtr+d/Jf"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A299jJb118075;
 Mon, 2 Nov 2020 03:09:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1604308185;
 bh=Fs8QYm+OVRCP/vq1V0hlIgei8nS3oKLgOymLrdq/9cg=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=xtr+d/JfJQ+bTmHpJpY0MqgUNSfhGvOjM9FYzdrzwnyMdMt/C6vrZGbkyaFq6m3JW
 RtnjzAE0Re2uqWw1Ac4ZQX6yoK4GQLPVUBhp4YKb5pFRcDt8VsIBUcRsN30HShTaJR
 6TISr4lA2IcMdubKF4b/ih8NjsvqMVZgQyl2/yVU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A299jnG112808
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Nov 2020 03:09:45 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 03:09:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 03:09:45 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A299hBZ056306;
 Mon, 2 Nov 2020 03:09:43 -0600
Subject: Re: [PATCH v2] ASoC: ti: davinci-mcasp: fix error handling in
 davinci_mcasp_probe
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Zhang Qilong <zhangqilong3@huawei.com>, <perex@perex.cz>, <tiwai@suse.com>
References: <20201102085436.14450-1-zhangqilong3@huawei.com>
 <182d48d4-2866-8e7c-dc28-7f84967260e2@ti.com>
Message-ID: <e8e537db-cda7-fe9e-5d34-77da8d992a6c@ti.com>
Date: Mon, 2 Nov 2020 11:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <182d48d4-2866-8e7c-dc28-7f84967260e2@ti.com>
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

Hi,

On 02/11/2020 11.07, Peter Ujfalusi wrote:
> 
> 
> On 02/11/2020 10.54, Zhang Qilong wrote:
>> Forgetting to call pm_runtime_disable if davinci_mcasp_get_dt_params
>> failed in function davinci_mcasp_probe, and we should go to error
>> handling branch.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Actually...

> 
>> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>> ---
>> Changelog:
>> V2
>> - changed the subject and fixed the description.
>> ---
>>  sound/soc/ti/davinci-mcasp.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
>> index 4b46dd827f3f..ec90c23c9e20 100644
>> --- a/sound/soc/ti/davinci-mcasp.c
>> +++ b/sound/soc/ti/davinci-mcasp.c
>> @@ -2362,8 +2362,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>>  		goto err;
>>  
>>  	ret = davinci_mcasp_get_dt_params(mcasp);
>> -	if (ret)
>> -		return -EINVAL;
>> +	if (ret) {
>> +		ret = -EINVAL;
>> +		goto err;

do not override the error code from davinci_mcasp_get_dt_params(), jut
jump to err.

>> +	}
>>  
>>  	ret = devm_snd_soc_register_component(&pdev->dev,
>>  					&davinci_mcasp_component,
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
