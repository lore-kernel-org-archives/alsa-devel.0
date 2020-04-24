Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30969C54FCB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:44:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA27C2064C
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AZqQ8PDF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="a44jU117"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08410169E;
	Fri, 24 Apr 2020 12:44:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08410169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587725094;
	bh=r8h0hDBmOlyL2ogIuSS/OdHzPmHKHtedIp92TMN28rk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AZqQ8PDF7nPk9w2w9iDhKyaBtI6tjRWEYpt/h2Yp5yOdxac4gqpqp0kmN9IYoYBWT
	 bJjJTc862BwOmwgg5N9+yX3ajt2mi8+/7BUMaUkpASrp+JH0IXm/ioCSN6m6uvX3jy
	 9d86JLwpdsHSFz1HutKc/boBriGPNkNJ1/M2H4EI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83EF6F80121;
	Fri, 24 Apr 2020 12:44:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2E4CF80142; Fri, 24 Apr 2020 12:44:01 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA3DCF80116
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 12:43:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA3DCF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="a44jU117"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03OAfX1G017788; Fri, 24 Apr 2020 05:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ckzgMaacDt/xdzl2oZNvVf9ixye3+oxLbiAY1sRbYH8=;
 b=a44jU117aiB02r76QL7C0iHcQu908O6P0Sbu0eV3tEQP07RSkLyAEeendPyNj160nreW
 U70CUzy7VANecEtQk/Pk0AR7V/oSM++NGRYIPhWdiaeZs3oWIZlE2gT1MBvNtiyQO2SR
 BNuS+lIVhgtMiqKP7VG5oCimWNJNkOQ5eudFRsbkUrp9CHRAqc/ijsjikG1aSCOk6k+I
 rgD8Nn21JayRE1iqkHsO8BVXV3YvV74kWTm7itNTp5Ml5sH5XQT0QXaUz8luC+yf0JY4
 vANWVPmv4DNoI2yysUlZ8OkxJmcd0dlBLQgRoDgWWczf86yiuKEBg3Eqpx2V2oyBZcg0 Ag== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 30fwyquwy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 24 Apr 2020 05:43:48 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 24 Apr
 2020 11:43:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Fri, 24 Apr 2020 11:43:47 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2687E2C5;
 Fri, 24 Apr 2020 10:43:47 +0000 (UTC)
Date: Fri, 24 Apr 2020 10:43:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: wm8962: Force suspend/resume during system
 suspend/resume
Message-ID: <20200424104347.GJ44490@ediswmail.ad.cirrus.com>
References: <1587708727-13657-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1587708727-13657-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240083
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

On Fri, Apr 24, 2020 at 02:12:07PM +0800, Shengjiu Wang wrote:
> Use force_suspend/resume to make sure clocks are disabled/enabled
> accordingly during system suspend/resume.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8962.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 0a2cfff44441..80332c147da9 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3854,6 +3854,8 @@ static int wm8962_runtime_suspend(struct device *dev)
>  
>  static const struct dev_pm_ops wm8962_pm = {
>  	SET_RUNTIME_PM_OPS(wm8962_runtime_suspend, wm8962_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)

I would be interested in a little more explaination of why this is
the correct fix here?

My concern is this presumably precludes the CODEC being used in any
application where it is expected to process audio during system
suspend. Admittedly, the target market for this device probably
makes that unlikely, but I am slightly uncomfortable just assuming
that will always be true.

As far as I can see the expectation is that DAPM shutdowns down
all audio streams during system suspend (except those marked to
ignore suspend, as per my above concerns) and that will cause
a pm_runtime_put on each DAPM context which I would imagine is
intended to put the CODEC into runtime suspend. I am guessing the
reason you have problems is because of the driver doing its own
pm_runtime operations in set_fll, which probably takes an extra
reference preventing the power down. Is a more complex fix
correcting the interaction with DAPM the correct solution here?

Thanks,
Charles
