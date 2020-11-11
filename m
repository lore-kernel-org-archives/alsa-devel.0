Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C880C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 13:25:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BAF206CA
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 13:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E+ehbCfg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="i2ZLhvRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BAF206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B592F175F;
	Wed, 11 Nov 2020 14:24:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B592F175F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605101126;
	bh=ombn7OEEnkNv99AU9iYLIm0hwuoqp4XPsDg2d2JQyGg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E+ehbCfgf1bzjP/EjVSgr3Pb2B2pkKR+2C3U35CvDrq68q7Nlv1VsjzAyCkwaEu18
	 yrS/MMsc+8k7k9rLjek3sXFTt/4px0xKEWQqGZNmBZhXP1y4l9rn1PFoCJ2azgOcvh
	 +BavyPJy3tv8KzljXVEJVYIii5vkQNQUHE6TvzM0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53D23F801F5;
	Wed, 11 Nov 2020 14:24:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B47ECF8020C; Wed, 11 Nov 2020 14:24:35 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46235F8007E
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 14:24:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46235F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="i2ZLhvRz"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0ABDM3Ue020442; Wed, 11 Nov 2020 07:24:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=bWDb1UJDgXaIFdjQNw05y1bFE/r33+XEYfXaHSUxmOk=;
 b=i2ZLhvRz4cRCCP34i5rL7ZPJ7nvl8io2FKg8kdRtBQ7w+J/b+KZkqm3/1NBQ2zvIrA4H
 lvI3wxTNgMRuJxWuNtJaIAQLPUSLJPJXNY3U2NBvlhV1J0tvwlCt/TjjTvr8q13W7TzM
 5krAM/bNUSjYzEKJETj68NA7q0vVLZtHcm+6oM+qiVe9o0y5rsz1rTaqCVwpbZTWgHai
 a1xo0J454eJDI2lzubLZXDzNBKptBdArB58dpvVbNKP68vy/7x73iTNu63WYZIRX3cPG
 Gsavo/iz/EjAbviCnad1gXzLzFIkrKz3KAq6gE+1R+09xWEShRZroYxZRnbXMLjVSrC6 Vw== 
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
 by mx0b-001ae601.pphosted.com with ESMTP id 34rf1104e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 11 Nov 2020 07:24:28 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 11 Nov
 2020 13:24:26 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 11 Nov 2020 13:24:26 +0000
Received: from [10.0.2.15] (ausnpc0lsnw1.ad.cirrus.com [198.61.64.168])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4FB812A1;
 Wed, 11 Nov 2020 13:24:26 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] ASoC: arizona: Fix a wrong free in wm8997_probe
To: Zhang Qilong <zhangqilong3@huawei.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
References: <20201111130923.220186-1-zhangqilong3@huawei.com>
 <20201111130923.220186-2-zhangqilong3@huawei.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <8b1c75a7-b71a-e402-36bb-07b20c677d9a@opensource.cirrus.com>
Date: Wed, 11 Nov 2020 13:24:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201111130923.220186-2-zhangqilong3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=2 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110078
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

On 11/11/2020 13:09, Zhang Qilong wrote:
> In the normal path, we should not free the arizona,
> we should return immediately. It will be free when
> call remove operation.
> 
> Fixes: 31833ead95c2c ("ASoC: arizona: Move request of speaker IRQs into bus probe")
> Reported-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   sound/soc/codecs/wm8997.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
> index 37e4bb3dbd8a..229f2986cd96 100644
> --- a/sound/soc/codecs/wm8997.c
> +++ b/sound/soc/codecs/wm8997.c
> @@ -1177,6 +1177,8 @@ static int wm8997_probe(struct platform_device *pdev)
>   		goto err_spk_irqs;
>   	}
>   
> +	return ret;
> +
>   err_spk_irqs:
>   	arizona_free_spk_irqs(arizona);
>   
> 

Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>
