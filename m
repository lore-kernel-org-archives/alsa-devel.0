Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CEFC54FD0
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:43:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CC52098B
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VdbuBcA5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="G2DPsQ4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CC52098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F4F416A5;
	Tue, 21 Apr 2020 15:42:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F4F416A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587476617;
	bh=OqqrYlXEQz3skgeEVzCQc0OU5kUBI3lMNeT9nWDMKa4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VdbuBcA5fUkqgWFaK9VRoNmLMEhyNPFAa3yg/2MvWvxBADHD1xlX0+0RXWX7hWSHZ
	 WcSgot/jfSvCcOfW65wfKuVTBZJmh3w1IJzP/VcDYCaoxPuygJXIKbBfCcTBhL4t4v
	 VKeGsAfo7ORRBkFXVARm5Z2oZ61bugldsF7i3KJk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB45EF80143;
	Tue, 21 Apr 2020 15:42:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 100ADF801EC; Tue, 21 Apr 2020 15:42:45 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBFD4F800FF
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 15:42:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBFD4F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="G2DPsQ4u"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03LDcBsM008116; Tue, 21 Apr 2020 08:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=TZjpA3nIt/1mHsv2pXhLRfQVIe+XpCMnDYtF9bvx6i8=;
 b=G2DPsQ4uSC0gpo2S3l8tE5pIwLiLJT7Zurbsbbxmg6gDxcIq+1wRcPGN1jiMUMcBIlZb
 IwQazrZlgODidktJwlu2SIBZkl6L77QkDpRCm1WrCJ7lG0pCGEa/Wz0eztwg+xsF2bJd
 UtiCbI6IVDSjtG+3ZafE3hk2b77K6ZMLRubvAjIYiXcR1Rdemfpcp9pw74TkkYbXP/je
 qZdDU4YQ9KyGg9bpWY0ylWtLTflYYTueJHgvmQTprxxykOq97JfBEM0Ctst2a7No3Sm/
 GaXTb1bnGJSPNIE77AxG7eg3o1ahoziw1H22jvslKg9bWM8w8MdtP/3TintUxIaH6l1n 7g== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 30fxy4cyhg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 21 Apr 2020 08:42:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 21 Apr
 2020 14:42:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Tue, 21 Apr 2020 14:42:36 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6EE152C5;
 Tue, 21 Apr 2020 13:42:36 +0000 (UTC)
Date: Tue, 21 Apr 2020 13:42:36 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: wm8962: restore the CLOCKING2 register in resume
Message-ID: <20200421134236.GH44490@ediswmail.ad.cirrus.com>
References: <1587470535-20469-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1587470535-20469-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210109
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, tglx@linutronix.de, info@metux.net, allison@lohutok.net
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

On Tue, Apr 21, 2020 at 08:02:15PM +0800, Shengjiu Wang wrote:
> The CLOCKING2 is a volatile register, but some bits should
> be restored when resume, for example SYSCLK_SRC. otherwise
> the output clock is wrong
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8962.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index d9d59f45833f..6e96c0c5ad2a 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -82,6 +82,7 @@ struct wm8962_priv {
>  #endif
>  
>  	int irq;
> +	u32 regcache_clocking2;
>  };
>  
>  /* We can't use the same notifier block for more than one supply and
> @@ -3813,6 +3814,10 @@ static int wm8962_runtime_resume(struct device *dev)
>  
>  	regcache_sync(wm8962->regmap);
>  
> +	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
> +			   WM8962_SYSCLK_SRC_MASK,
> +			   wm8962->regcache_clocking2);
> +

I wonder if it might just be better to make the register
non-volatile? From looking through the datasheet I am guessing
this is volatile for the CLASSD_CLK_DIV bits, which are
controlled by the chip itself. But the datasheet claims these are
read only and protected by the security key, and they are not
read by the driver at all.

Thanks,
Charles

>  	regmap_update_bits(wm8962->regmap, WM8962_ANTI_POP,
>  			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA,
>  			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA);
> @@ -3842,6 +3847,9 @@ static int wm8962_runtime_suspend(struct device *dev)
>  			   WM8962_STARTUP_BIAS_ENA |
>  			   WM8962_VMID_BUF_ENA, 0);
>  
> +	regmap_read(wm8962->regmap, WM8962_CLOCKING2,
> +		    &wm8962->regcache_clocking2);
> +
>  	regcache_cache_only(wm8962->regmap, true);
>  
>  	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies),
> -- 
> 2.21.0
> 
