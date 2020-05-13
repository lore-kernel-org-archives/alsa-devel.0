Return-Path: <SRS0=BSyU=63=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2842ACA90AF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2020 08:22:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70E3205C9
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2020 08:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IpzYFpVA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SiMG6Ja9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70E3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D86EC950;
	Wed, 13 May 2020 10:21:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D86EC950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589358163;
	bh=WRJUu1hcQaz7qcOiTuTQNZYqxWl/X246c3hpUCxySik=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IpzYFpVADCghIAFAwFW3/BlDpbOQHplVF9EbvF3rnPIY4YvNIPa7BuOOIEzl/IuKY
	 E2ksk/uKkwcskhqyTUgpvDps5kfV5SHN8xiD7uxwgoQbajmE60qeUs9mt/zgUXbCX2
	 hdjGeVRlL4QYugRU1X2gq2/O9nbCzOocncHtgBa4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A02AF8022D;
	Wed, 13 May 2020 10:21:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BFB5F80247; Wed, 13 May 2020 10:21:51 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3DE9F800E3
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2020 10:21:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3DE9F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="SiMG6Ja9"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04D8G4hp007414; Wed, 13 May 2020 03:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=SN0lZANT/vbXKgnyWwzZnLfQTVL/ShY4GaSPpGpVBkA=;
 b=SiMG6Ja9eXiMz6KeoWCSkLcdZXiCb+S/pnWR9tGUM38jdOksN8I8YnnZehotk5woAzrY
 0NN4hSkhrWxXMWUF0xbxXKXVuMUiABognHDvtwk/+nh3HzLC3/C6MplbY/LiVyUxM8FF
 zHbnoS/u91w1HtYF8aHoyeEaS8BQF0n6CQhtVACjL/vkAKJgI8cWHCAMo88IzGSK82o1
 B8lQ72rx+ij/0zrht1oUXJli5kaHcofTF+rAIK6R6GdN3MJAnX2EEZH1553pLFBFBzvi
 sys7s8FxoQ5qsC6G77iSPYfA2I8F9cYUbgvTQVIYWQf6nhp5z0Ta3sPGZAQpcJXyZxNB ZA== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3100xes1ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 13 May 2020 03:21:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 09:21:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 13 May 2020 09:21:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6CA562C5;
 Wed, 13 May 2020 08:21:35 +0000 (UTC)
Date: Wed, 13 May 2020 08:21:35 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: wm8962: Use force clear for WM8962_SYSCLK_ENA
 after reset
Message-ID: <20200513082135.GF71940@ediswmail.ad.cirrus.com>
References: <1589347835-20554-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1589347835-20554-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=581
 bulkscore=0 spamscore=0 clxscore=1015 cotscore=-2147483648 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130076
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

On Wed, May 13, 2020 at 01:30:35PM +0800, Shengjiu Wang wrote:
> When CLOCKING2 is non-volatile register, we need force clear
> the WM8962_SYSCLK_ENA bit after reset, for the value in cache
> maybe 0 but in hardware it is 1. Otherwise there will issue
> as below statement in driver.
> 
> /* SYSCLK defaults to on; make sure it is off so we can safely
>  * write to registers if the device is declocked.
> 
> Fixes: c38b608504aa ("ASoC: wm8962: set CLOCKING2 as non-volatile register")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
