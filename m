Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7719C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 09:48:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8129F65134
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 09:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8129F65134
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 327FA177A;
	Mon,  8 Mar 2021 10:47:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 327FA177A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615196879;
	bh=5nOSJf9AwQw6NuPIfsOd2ENleEXi04lburtvh9YYS+U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfD+FOjERR6e114kvGIUIRXY3OWna3kqF/AHJCxY8trN6YkL81PIiLsgrCpCLDioc
	 bo0i6H5kkEAtybvyG9C+9U1ytvPdWY4oRbN11KvtpgK5qXs1BWZ84Re4rCr4ed1Uia
	 uSWtGh2hqCCVqPU3RiFKxakEIRgyewZCQfxeCkdc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E5A3F8016C;
	Mon,  8 Mar 2021 10:47:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3613DF801D8; Mon,  8 Mar 2021 10:47:07 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB743F80139
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 10:46:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB743F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="NwGGS9B3"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1289VcbB010106; Mon, 8 Mar 2021 03:46:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=WRBBl42OmvF/JPWrQ4eU/UZvz8wqfDrdOuxM4KcfRPw=;
 b=NwGGS9B3bqGznpTtAJKdUdDfntO9qG+VriMwwd+BInZo47Z9ew2QhiNxwubCQpW/G4L/
 zNQOaG6ffrmd5SizxzUyvx62ImPAtRaYMjeeuFDbgara0FMf7pHO0X5fwb2VXjVK85oB
 A58N4PzO4KmXYzxrGgCbo7WxXEe5aEYQPxWKpued5AdZRGh+HeOG4vOmErTyDGV8YKtX
 cXowPixyMSm/kjvUX1wG+7+gTRuKVuW7hCb1ourUFjP6rA3YzF2XQbVSDDlYQQvJTPB+
 gCL3cFehC/gomifByGU2bEgZxGwFij8y9TRbPp66cG2NrBBDb1ntN294gCIQhd87ISxK BQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3748199qmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 08 Mar 2021 03:46:55 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 8 Mar 2021
 09:46:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 8 Mar 2021 09:46:52 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DC0DD11D6;
 Mon,  8 Mar 2021 09:46:52 +0000 (UTC)
Date: Mon, 8 Mar 2021 09:46:52 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: wm8962: Relax bit clock divider searching
Message-ID: <20210308094652.GH106851@ediswmail.ad.cirrus.com>
References: <1615170877-25918-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1615170877-25918-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080050
Cc: alsa-devel@alsa-project.org, gustavoars@kernel.org,
 kuninori.morimoto.gx@renesas.com, patches@opensource.cirrus.com,
 tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org, sebastian.krzyszkowiak@puri.sm
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

On Mon, Mar 08, 2021 at 10:34:37AM +0800, Shengjiu Wang wrote:
> With S20_3LE format case, the sysclk = rate * 384,
> the bclk = rate * 20 * 2, there is no proper bclk divider
> for 384 / 40, because current condition needs exact match.
> So driver fails to configure the clocking:
> 
> wm8962 3-001a: Unsupported BCLK ratio 9
> 
> Fix this by relaxing bitclk divider searching, so that when
> no exact value can be derived from sysclk pick the closest
> value greater than expected bitclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
