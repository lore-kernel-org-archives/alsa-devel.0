Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2928AC432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:05:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2772075C
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d+9h05Jb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ev5z29XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2772075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC01341;
	Tue, 26 Nov 2019 18:04:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC01341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574787919;
	bh=CL4xsKlW6EOoGdyPjF6G6wAfwYBd0ItuYR/7+4LdL0U=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d+9h05Jb709U+K9HUyiOuq+0B+S+Rj2x0fVZJxhHHu+dpsIvZCsyvnSDFXXIqfgx+
	 u3Mozhn8MPSSmaWjPCq20RtdZtw1KlSfoVRLX+GncyP4e2XxbtHg7fg2crspXbEOCJ
	 3fdZTmNl8A4E+63fTIRit+wR/MP+jAqLJa2iPccI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70B1BF80149;
	Tue, 26 Nov 2019 18:04:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93A7CF80159; Tue, 26 Nov 2019 18:04:26 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9C4AF80109
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2019 18:04:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9C4AF80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="ev5z29XS"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAQH480h007261; Tue, 26 Nov 2019 11:04:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Iv/PtGLcU5/lFZn00YMSkCI5yPeSpQhva72OPbmoEfw=;
 b=ev5z29XShzgOtVef/thntsmFpHUnpN/knHoMYxlYe5fTD++rn7pldDKwj/Q4IeDJyax2
 ap2Ycv9TwQ4pgZHw8cZwyHXB/VClBZrFgaz21hrUQ40yTyUJ0l/m1TzcrdrGOcWlzlQt
 /rkIVNaC0RjAfLt+Q0by63zLGoYuXoC+vT6K3UwvpsZxsKIwTchd0TxEiX/4fPHiEC2s
 QPfAqBVMV1cEEGpTqiNPeiXlWs67nsknWykeZGNwcvNdlwEN1ZQn7xTUNuOJRaqeFQE4
 iTST6WiKnfz5g5m9pBOBKl5Ajt8kZrcVWYo51/YGr/YfnYqdCbxa0m3hGyO1VmXgvIGt Kg== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
 by mx0a-001ae601.pphosted.com with ESMTP id 2wf328mjy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 26 Nov 2019 11:04:20 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 26 Nov
 2019 17:05:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Tue, 26 Nov 2019 17:05:13 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 88F6A2C6;
 Tue, 26 Nov 2019 17:04:18 +0000 (UTC)
Date: Tue, 26 Nov 2019 17:04:18 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Michael Walle <michael@walle.cc>
Message-ID: <20191126170418.GL10439@ediswmail.ad.cirrus.com>
References: <20191122232532.22258-1-michael@walle.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191122232532.22258-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911260142
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8904: fix automatic sysclk
	configuration
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

On Sat, Nov 23, 2019 at 12:25:32AM +0100, Michael Walle wrote:
> The simple-card tries to signal the codec to disable rate constraints,
> see commit 2458adb8f92a ("SoC: simple-card-utils: set 0Hz to sysclk when
> shutdown"). This wasn't handled by the codec, instead it would set the
> FLL frequency to 0Hz which isn't working. Since we don't have any rate
> constraints just ignore this request.
> 
> Fixes: 13409d27cb39 ("ASoC: wm8904: configure sysclk/FLL automatically")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
