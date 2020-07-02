Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5915C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:32:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD3720771
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M3Em/0DM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="k/b1g1ZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD3720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEB5C16D0;
	Thu,  2 Jul 2020 11:31:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEB5C16D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593682326;
	bh=evabW955lFKLFGt5556YtgnPIJum/BwN/qOOWl9Lfbs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3Em/0DMPL6U6tonzGINuAWz1Ec1gzfbqHamXvI3e8ZrMgOYYUnAyvHjJXlQDolaC
	 /g/vOYHddGNWIvJuP3v4Nk0SgJuoEndKqfTJwCRSSBlRgYSmaInGACCeQY+MckfM4o
	 C2L+X0D/0MxIAtcW0rTUUtcggfCReuI3r/u1/sqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 516C8F8022D;
	Thu,  2 Jul 2020 11:31:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17E77F8022D; Thu,  2 Jul 2020 11:31:14 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76B3EF80252
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 11:31:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76B3EF80252
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="k/b1g1ZZ"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0629K0K6024016; Thu, 2 Jul 2020 04:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=DsXOQ2uVdkom3qXki/EB4CUI40dE3Sgxr+unh8FtXcg=;
 b=k/b1g1ZZoweeXO5bynM0d3wAAgepxc3YyukUq38mKQY0niHptP7A2g69PL9YL185YFbQ
 8cnI81hFK7mHUXfNdeBcUnFmSmfudSzNZEDoVuPMP/sEw3sp9GdT0ymGM5rw3Gpr37qv
 74CfnUVz6eDmmCk5TxUtFcFtcW7tXAnoYwEu5/g2C3qqKFVFq4l89WK4TPFoAKzGeXJp
 Ppy9sM9vSxymQrQ1SUUu6KQsexODrb9+evXOOsynwus0jlf3TslmuE9rVy/9W5wS4ieN
 PzXvgR8qN/inqu83LZKyRnX7kPYSxPwcDlc4DMiWYTZ3Tn3mgolclVFWw96pWXCoMxp/ IQ== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 31x3h4qmjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 02 Jul 2020 04:31:05 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 2 Jul 2020
 10:31:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 2 Jul 2020 10:31:03 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A6CAA2D4;
 Thu,  2 Jul 2020 09:31:03 +0000 (UTC)
Date: Thu, 2 Jul 2020 09:31:03 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <puyou.lu@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: wm8974: remove unsupported clock mode
Message-ID: <20200702093103.GN71940@ediswmail.ad.cirrus.com>
References: <1593657056-4989-1-git-send-email-puyou.lu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1593657056-4989-1-git-send-email-puyou.lu@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0
 cotscore=-2147483648 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=738 suspectscore=1 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007020069
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 broonie@kernel.org, lgirdwood@gmail.com
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

On Thu, Jul 02, 2020 at 10:30:56AM +0800, puyou.lu@gmail.com wrote:
> From: Puyou Lu <puyou.lu@gmail.com>
> 
> In DSP_A mode, BIT7 of IFACE should bit 0 according to datasheet (ie.
> inverted frame clock is not support in this mode).
> 
> Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
