Return-Path: <SRS0=ZcFB=XS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38457C3A5A6
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:26:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D7820578
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OmDm9uol";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="I9VIqGAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D7820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4525166F;
	Mon, 23 Sep 2019 11:25:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4525166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569230777;
	bh=1iFUJBEW/8khWTmOfQSy5Z+FEgVaaAi9y9tYWEpxZig=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OmDm9uol4RnPuaMR4zy6EAIPy8pg7e5UzxgXNBFRSCsz5M7vMPAKDHIHovkP98KBJ
	 10loLs3tKjFEJ0GcNPQaj7ifQjIdvjkE4tSYMNlRlu3EEgJLGu0XthuHO+Rd7T9n7l
	 LfCemJmAr9tkPHz7igu6qvL9hkXjXybLyRfM/v9c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BA10F8031A;
	Mon, 23 Sep 2019 11:25:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27DFEF8044C; Mon, 23 Sep 2019 11:25:26 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21F43F80307
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2019 11:25:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21F43F80307
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="I9VIqGAa"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8N9OhOp004541; Mon, 23 Sep 2019 04:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=OenETI2BlyjKLCH8My5ZcKXoQz9o782ZPMAD8kB1A9Y=;
 b=I9VIqGAavSGxcFxwBs8KSWLUHZ/NGrnt9Enxz4YMZe57fIC9yRlsXcpDYcQ9PeQz6vuJ
 AQhDwBRlmZ8N0DDZ9R8zJuwmzo1gLhalJN1DsDJs4aPzBzc+UPobGnu9fLwXycJriV8N
 wObM9s9Ln1DMN0J3VNgcoPgB4epsjdqLFB8vUQVMaZiCm8/DhtIwaKoeBa4W7q4I/E05
 LnQOvjk+HoxJbsQzxKu52f1swLW8rvNdfqZLKDSc86J/AK7kjdRVAd9eXmVZwrCw5Lu4
 0DEXCk58FQjeywMSNNdNddmbO49xyFYumqlP2DfCS9aKR2M4qfD2DC8L4N0oqhZUrM5g CA== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 2v5h9238qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 23 Sep 2019 04:25:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 23 Sep
 2019 10:25:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Mon, 23 Sep 2019 10:25:17 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 612982C1;
 Mon, 23 Sep 2019 09:25:17 +0000 (UTC)
Date: Mon, 23 Sep 2019 09:25:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <20190923092517.GO10204@ediswmail.ad.cirrus.com>
References: <20190920130218.32690-1-s.nawrocki@samsung.com>
 <CGME20190920130316eucas1p2de713006a13c62c0b895c2e33e0d14c7@eucas1p2.samsung.com>
 <20190920130218.32690-4-s.nawrocki@samsung.com>
 <7334ce45-f192-4421-aa3d-d142582153ef@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7334ce45-f192-4421-aa3d-d142582153ef@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 priorityscore=1501
 adultscore=0 mlxlogscore=742 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909230094
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 sbkim73@samsung.com, patches@opensource.cirrus.com, broonie@kernel.org,
 lgirdwood@gmail.com, krzk@kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [alsa-devel] [PATCH v2 03/10] ASoC: wm8994: Add support for
 setting MCLK clock rate
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Sep 23, 2019 at 11:10:48AM +0200, Sylwester Nawrocki wrote:
> On 9/20/19 15:02, Sylwester Nawrocki wrote:
> > Extend the set_sysclk() handler so we also set frequency of the MCLK1,
> > MCLK2 clocks through clk API when those clocks are specified in DT.
> > 
> > Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Sorry, I squashed other patch to this one but forgot to remove above tags, 
> not sure if those still stand as there was rather significant change in 
> the patch. 
> 

I am happy with my tag being there.

Thanks,
Charles
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
