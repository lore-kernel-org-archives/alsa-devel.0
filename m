Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6448CC388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 09:57:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F9920729
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 09:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aYovgJu2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gYyw0+MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F9920729
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 171A7170B;
	Wed, 11 Nov 2020 10:56:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 171A7170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605088644;
	bh=1SZfdRLFiqmBquNwF9RriXehYVEnhHNSpgHnR4lQ4FA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aYovgJu20ffmBPJKyPpMoXJuaqXOFryI7yfhmvABsESDSTXrRK/iKJc0+8hoFLLVD
	 GXQLVE52b18nx5/YoUfpAQ1iPNgkBbLe4Aw+QzvXafm/WktZVLrpjK3A+GDBALQhuL
	 FJ1agJNYzAu2TMTs7TeLd2hJRt9xI44zM59AzNco=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91370F801F5;
	Wed, 11 Nov 2020 10:56:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 009EDF8020C; Wed, 11 Nov 2020 10:56:32 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 475D5F80059
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 10:56:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 475D5F80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="gYyw0+MK"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0AB9mVfV002156; Wed, 11 Nov 2020 03:56:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=rQwZKjOMdTOmjEEacDCGUbZDgJkNgTgUBSotZPFxJCw=;
 b=gYyw0+MKuJfNKA2kO+NQdOjchiJTSObTijV9LvXDLYPjzCLTxg1lgfMZ9Wwb8oWXIDgv
 q8c1cLg1gY/0+QtoJIa5TdqjDaMV6A1ijgmN/pilpQghN96p1+F2m5Ap8uQZjU9kcrZH
 VQzjRLFAV5Ecxe7PPzXVPnllHpg2Y8QOelZSDq/0IC4zFhw/W1KVVkFboITaD3I41c6g
 kul0bAzh/Ixn6Oq1ChTPvTN83FjConycC7HYuJh4HxrAVKT75bBgz7w5h//fE0cIaxnb
 5wmekzfydIuXFl0oEWqNMJaDQYD5PWh6JX4kjEYwO/8O+p/6Moe/g7w27Jw9CT4qLQXT dw== 
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
 by mx0b-001ae601.pphosted.com with ESMTP id 34qg5xtrtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 11 Nov 2020 03:56:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 11 Nov
 2020 09:56:23 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 11 Nov 2020 09:56:23 +0000
Received: from [10.0.2.15] (ausnpc0lsnw1.ad.cirrus.com [198.61.64.168])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A1CCC2A1;
 Wed, 11 Nov 2020 09:56:22 +0000 (UTC)
Subject: Re: [PATCH 2/3] ASoC: wm8997: Fix PM disable depth imbalance on error
To: Zhang Qilong <zhangqilong3@huawei.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
References: <20201111041326.1257558-1-zhangqilong3@huawei.com>
 <20201111041326.1257558-3-zhangqilong3@huawei.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <5f0e1888-417b-88fc-aaba-8eb40a73d85b@opensource.cirrus.com>
Date: Wed, 11 Nov 2020 09:56:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201111041326.1257558-3-zhangqilong3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=986
 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=2 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110053
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
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

On 11/11/2020 04:13, Zhang Qilong wrote:
> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed on the error handling path to
> keep it balanced according to context.
> 
> Fixes: 31833ead95c2c ("ASoC: arizona: Move request of speaker IRQs into bus probe")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   sound/soc/codecs/wm8997.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
> index 37e4bb3dbd8a..744104edb2eb 100644
> --- a/sound/soc/codecs/wm8997.c
> +++ b/sound/soc/codecs/wm8997.c
> @@ -1163,10 +1163,10 @@ static int wm8997_probe(struct platform_device *pdev)
>   
>   	ret = arizona_init_vol_limit(arizona);
>   	if (ret < 0)
> -		return ret;
> +		goto err_pm_disable;
>   	ret = arizona_init_spk_irqs(arizona);
>   	if (ret < 0)
> -		return ret;
> +		goto err_pm_disable;
>   
>   	ret = devm_snd_soc_register_component(&pdev->dev,
>   					      &soc_component_dev_wm8997,
> @@ -1176,9 +1176,14 @@ static int wm8997_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "Failed to register component: %d\n", ret);
>   		goto err_spk_irqs;
>   	}
> +	arizona_free_spk_irqs(arizona);

Should not be freeing speaker irqs on successful probe.
This looks like an existing bug in the driver where the return 0 was
missing so it would always exit through the error path.

> +
> +	return ret;
>   
>   err_spk_irqs:
>   	arizona_free_spk_irqs(arizona);
> +err_pm_disable:
> +	pm_runtime_disable(&pdev->dev);
>   
>   	return ret;
>   }
> 
