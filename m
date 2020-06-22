Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B862C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:18:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270B52068F
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sz4IKLZj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XU2mRLGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270B52068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A7B51682;
	Mon, 22 Jun 2020 10:17:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A7B51682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592813906;
	bh=iUa9GzrontFtIzrZkhNe2zW0jql3ynn1xW7qb8DWF68=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sz4IKLZjZI59ipsN7LSs4PwKgliut6KTlWjMshOZKvto2xqZTAdOyC45wDZ8y/Faf
	 ILjfAS0sjpav0X9QFycHbS/qR8fP3llX9TxWAYRaXP4b8971pdyqQkkeHcUsG6W656
	 tIdM39ClS3OYDFUCqgD4RduwbF1pq/y1MaoF7IiY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F09E4F8015A;
	Mon, 22 Jun 2020 10:17:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF333F8015B; Mon, 22 Jun 2020 10:17:33 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1E12F80157
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 10:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1E12F80157
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="XU2mRLGb"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05M8BTIT015552; Mon, 22 Jun 2020 03:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=U4UkVX32v0YeAnaTc2BOiIL0sdnwYbCxDLo++vbEd1s=;
 b=XU2mRLGbrmqbSe5btY23z0GT2GrW3woeZ7HnvMmn15zor8cvJtEszbNh/uulOHJXn5Hs
 wVT9uGiMkqdURrwoKXvBkb9Sx4/6r7n0FrrGo8lqM844N0Z8Lx+vhidnyVyb0PLluCsz
 GjA4DUuWQGSN18o0Rl/WSg43tF5SBs18NBtypPh4v2UB4pkZZeV5gwe53R2mAFPVQxbX
 lHeLrJ2oSnRuYFdOCnp3ZaQfvJSnx3izaa1coKLBuQieFVzktupuTOw/s1RoSeDmg7bT
 xo/9klolphLsj5pXPgAGxxZniCL/EHrRoH9nl8foX1asUpSDklX5a4g9tK+fkR1yz9p5 Hw== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 31sf6ea2r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 22 Jun 2020 03:17:24 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 22 Jun
 2020 09:17:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 22 Jun 2020 09:17:22 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BE446448;
 Mon, 22 Jun 2020 08:17:22 +0000 (UTC)
Date: Mon, 22 Jun 2020 08:17:22 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: David Rhodes <david.rhodes@cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Add controls for calibration and
 diagnostic FW
Message-ID: <20200622081722.GV71940@ediswmail.ad.cirrus.com>
References: <20200619212651.2739-1-david.rhodes@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200619212651.2739-1-david.rhodes@cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 clxscore=1015
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 cotscore=-2147483648 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220062
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 Vlad Karpovich <Vlad.Karpovich@cirrus.com>, lgirdwood@gmail.com
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

On Fri, Jun 19, 2020 at 04:26:51PM -0500, David Rhodes wrote:
> From: Vlad Karpovich <Vlad.Karpovich@cirrus.com>
> 
> Exposed additional mixer controls to select calibration or diagnostic
> firmware.
> 
> 'Calibration' --> chip-dsp<id>-spk-cali.wmfw (.bin)
> 'Diagnostic'  --> chip-dsp<id>-spk-diag.wmfw (.bin)
> 
> Signed-off-by: Vlad Karpovich <Vlad.Karpovich@cirrus.com>
> Signed-off-by: David Rhodes <david.rhodes@cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
