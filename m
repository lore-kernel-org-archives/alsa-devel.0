Return-Path: <SRS0=k5Qg=4P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67086C35677
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3FA246AE
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B6S5NNmr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="M/B+wVKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3FA246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 259111671;
	Thu, 27 Feb 2020 14:52:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 259111671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582811622;
	bh=8z3ywkXBoxjABqzZPop6fexjis8wd7nePJ1lagL4bpQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B6S5NNmrUSITrxJssgUS0YcjN9dCv4+HJjtTpHJha3YTZrrdKPFpenqSRTX6K38tk
	 NtzO1Zos5/+k/BxcryLKpFb4Ffhx3yHb6tM40VNxb+12BVrEnneYK756+EjObO4xDw
	 Wx9zKqqK2YO/K/9FvzhFZD6ZzLfznjQH6TB2WbPo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2AC6F80089;
	Thu, 27 Feb 2020 14:52:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EDDDF80142; Thu, 27 Feb 2020 14:52:50 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12B56F80089
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2020 14:52:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12B56F80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="M/B+wVKT"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01RDqCX8026476; Thu, 27 Feb 2020 07:52:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=cslc29hczETAlQa0X23hPQTj91TBsgGjB1S2qq30ylY=;
 b=M/B+wVKT5KIY+EntGHNNSZmwep7JogzZUSHR9y5Lu1mtdz+qaXHl6WUBeazJOMmcPMZn
 V2ADsuQHEMe0IwJtbsDkeyvi7RfXBX4LGQBtDllcAp47SjURfr3/ygBwfxwgRELGeHM7
 BHbxihSv89oKLzzc8RkbfKVrcJiA4YSY8Iidxia9rgTvnPDIIp2n5j9i1SlrmE4LrI/0
 agCe7zQUga4ocNJiHd6oCmdcuyq8mEQrzcZDsrcAHnSBjBb4kGknLwUUPU8OHZ8Rdqwd
 mAm6TRMjIeKcI6ipuEC5/bD+iUrsfA3hI6B3ZXELjrxl9d+1g/SX/M8uZY8QSyfUStnP RQ== 
Authentication-Results: ppops.net;
 spf=pass smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
 by mx0b-001ae601.pphosted.com with ESMTP id 2ydcmbbkgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 27 Feb 2020 07:52:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 27 Feb
 2020 13:52:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Thu, 27 Feb 2020 13:52:43 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0E48645D;
 Thu, 27 Feb 2020 13:52:43 +0000 (UTC)
Date: Thu, 27 Feb 2020 13:52:43 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 1/2] mfd: wm8994: Fix driver operation if loaded as
 modules
Message-ID: <20200227135243.GI108283@ediswmail.ad.cirrus.com>
References: <CGME20200226100814eucas1p1ef5e4d5eb763f37bcd4eceffc798792d@eucas1p1.samsung.com>
 <20200226100802.16384-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200226100802.16384-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270110
Cc: alsa-devel@alsa-project.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
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

On Wed, Feb 26, 2020 at 11:08:01AM +0100, Marek Szyprowski wrote:
> WM8994 chip has built-in regulators, which might be used for chip
> operation. They are controlled by a separate wm8994-regulator driver,
> which should be loaded before this driver calls regulator_get(), because
> that driver also provides consumer-supply mapping for the them. If that
> driver is not yet loaded, regulator core substitute them with dummy
> regulator, what breaks chip operation, because the built-in regulators are
> never enabled. Fix this by annotating this driver with MODULE_SOFTDEP()
> "pre" dependency to "wm8994_regulator" module.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Be good to ensure patches@opensource.cirrus.com is CCed on
patches for the old Wolfson CODECs.

Thanks,
Charles
