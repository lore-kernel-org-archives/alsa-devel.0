Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A087BC433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:49:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4952075B
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pxhLpmAo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="B5Z2w4Lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4952075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EC3C1897;
	Fri, 28 Aug 2020 17:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EC3C1897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598629790;
	bh=x2AaFAEll+rNty9PsQxBI/DldBAds0bULIUdhoNqleU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pxhLpmAoc+rwskr996lxOuxiKYdMHpeS2Xn5qlcQ+MHHOeKc9h/hgu2KClsb/q0cJ
	 L9P18heLuV7tL1ooX/jVFh0J6TvSKi+Fhy0e7y6Mx10aWINLSWGLuZvp1kBKoKgJCb
	 gKRUK56TJQ4Cd71bYA5fCrvb+9Cy89nRr4LAHG7A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4DA6F80143;
	Fri, 28 Aug 2020 17:48:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED6DCF8016F; Fri, 28 Aug 2020 17:48:57 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42D48F800EB
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 17:48:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42D48F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="B5Z2w4Lg"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07SFfUVB020212; Fri, 28 Aug 2020 10:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=OKFazoGL7MkLzQd7yCPqdh5EaX1fgkTSclCd2PlnrPI=;
 b=B5Z2w4LgvfQvjooRHstKWW1S2QGPlXC3Cr61yxerxcE64xEmx3ptJtz6eS0JvmGV4Tfv
 3RxhYFBGmUelTy7qRkvtenB1QLVIjyciVVxRVTRI4eEOfB2G0Gwcllzdw1MtVEoYJsAV
 YFXgMTQnHRRy8UYijno/64xzkbjNPYOki/oLl7tq/c7X+myDHN8me8yX3TxUZF71Wtr7
 gbTzOQkcmUkoxz5bQWhwIOvKA3WyJXNXaYLRKE05d3Oar42iq3Q0adIVoS0539YsjGSB
 cwlUrLKCEPkUBqoPDD7BhFUhb46JIm2g0ardjc+eU0eW/J56Dq9OD/hA9PHbHTaorOHL oA== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 332ysph1x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 28 Aug 2020 10:48:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 28 Aug
 2020 16:48:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 28 Aug 2020 16:48:43 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5BF622A1;
 Fri, 28 Aug 2020 15:48:43 +0000 (UTC)
Date: Fri, 28 Aug 2020 15:48:43 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/2] ASoC: wm8994: Skip setting of the WM8994_MICBIAS
 register for WM1811
Message-ID: <20200828154843.GJ10899@ediswmail.ad.cirrus.com>
References: <CGME20200827173411eucas1p1283200677c5e077c5e07af938934eb5d@eucas1p1.samsung.com>
 <20200827173357.31891-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200827173357.31891-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 mlxlogscore=602 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280119
Cc: alsa-devel@alsa-project.org, b.zolnierkie@samsung.com,
 patches@opensource.cirrus.com, lgirdwood@gmail.com,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 broonie@kernel.org, m.szyprowski@samsung.com
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

On Thu, Aug 27, 2020 at 07:33:56PM +0200, Sylwester Nawrocki wrote:
> The WM8994_MICBIAS register is not available in the WM1811 CODEC so skip
> initialization of that register for that device.
> This suppresses an error during boot:
> "wm8994-codec: ASoC: error at snd_soc_component_update_bits on wm8994-codec"
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
