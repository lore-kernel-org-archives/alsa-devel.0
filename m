Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41CAC54FD0
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:52:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2952076C
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LzxiB6Zm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QrNz/50v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2952076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A78D168B;
	Tue, 21 Apr 2020 14:51:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A78D168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587473545;
	bh=2xunkTjGfoKhgU94zj4Gq66HZR0JFCnLl6j5Em8ckmM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LzxiB6ZmWbyMQsburSrCf9lWxJXLJrbkcXcoNmg8hDZl8eHy5fSQOnTh3boPx5Uzi
	 C9cM4qmCOmASBT+vToVsvPTKWaMX0Yfc9m6w5RcK7eltNRYTWX3I84U8xwfBN3Aas5
	 bmxjJiXMfDtfzRJV6E2Womqi7S4njpput0n4OuEY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC5F8F80143;
	Tue, 21 Apr 2020 14:51:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9E3AF80252; Tue, 21 Apr 2020 14:51:26 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B71E6F8012F
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 14:51:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B71E6F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="QrNz/50v"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03LCmBIE030798; Tue, 21 Apr 2020 07:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=3ebij2CYYPySDRI9w+Vjts9N9Ci452bjddzCuXab8jQ=;
 b=QrNz/50vQn+s82QaIf2yOXn83neVLRDRXN3vYBoMwZ5bgyVMdjePwUyuhW0YoZFscD+U
 Q3l6yzmBODM3xVYvfVZV48Vm8GzGuNZ5BkoZD7eTqxaK10oJFfFw+U56nSM+EmKijPbU
 9n/yEfo/1Dl98BWcVHUCPJQKtcQx6vu8bvOQa45Cp3VCWAajjvvH2wbYGr8PFX8TjNgO
 3HPgr2IbvN0vJ68AybtHYpCOz6GGavgPKmbnZG8YFprqQy9rWpvflJQ41hetH0/mLrgR
 SyyJd317lDTzsbz1KboCP1IHVlnMV2zMpe++9xn9B1Od0O7C1mpdk5r1t8tcKbCZAHRa dA== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 30fxy4cvry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 21 Apr 2020 07:51:13 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 21 Apr
 2020 13:51:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Tue, 21 Apr 2020 13:51:11 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A3A0C448;
 Tue, 21 Apr 2020 12:51:11 +0000 (UTC)
Date: Tue, 21 Apr 2020 12:51:11 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 2/8] ASoC: codec: wm_adsp: use snd_compress_ops
Message-ID: <20200421125111.GE44490@ediswmail.ad.cirrus.com>
References: <87wo6avdq1.wl-kuninori.morimoto.gx@renesas.com>
 <87tv1evdlu.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87tv1evdlu.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=949
 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210101
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On Mon, Apr 20, 2020 at 04:08:13PM +0900, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We can use snd_compress_ops.
> Let's switch to use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Minor nits in future no need to put "codec:" in the title and it
would be really appreciated if you could CC
patches@opensource.cirrus.com for changes to wm_adsp.c it is in
the maintainers file.

Thanks,
Charles
