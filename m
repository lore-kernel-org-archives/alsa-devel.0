Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7A1C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:27:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C672072D
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TNT2KFB0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mntKRLbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C672072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9559816EF;
	Mon, 17 Aug 2020 11:26:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9559816EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597656464;
	bh=tvchmmlmMWIYMwE8lGy6IWF3GqgBIN1CAsccQ9ySHhI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TNT2KFB0RO5+clR/mQWkrp67Ig+8SLFd0L+yJQgYdm9BCRueFt2GjMToPDfdo70LN
	 Ory09irDZXzLDDSnoSdtu/2OB4WfBfh8NNKA4jALBKrcUbcPzIvuJ80SRZfnZcYuoI
	 djcYb3/gsTjeOuQe6+dDGFkR7pAqYfPYIMepTUn8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CC84F802C2;
	Mon, 17 Aug 2020 11:25:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7B9FF802D2; Mon, 17 Aug 2020 11:25:19 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7812DF802C2
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 11:25:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7812DF802C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="mntKRLbI"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07H9ESQh010070; Mon, 17 Aug 2020 04:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=TOMG9uggUh7oDX4aK+NWCK0xxwHG0y+9ef6Fql8ClsU=;
 b=mntKRLbIat4GaFeijS/y5Klnuk8lqyCtlPff+2LLi77AocgXIYB2b5xIg27JCHlHVZfb
 yuEy2eSLpXOtP72l0i6I/7BB3clegneo4nbeQLDPHgifTQNncRLqwdIlgyrMGfYDdpK9
 W06t3Mt/4M37JPbtAqQN3pcmXwExn7HZ2tKYM+2Y2NX5f5pyxQYMYv1c/Zztt8a6aabR
 yWBy26gd7i2NHLplpaIKBIWk1dVOJ96xuceMy/72s9P7fibynnP6qobI2aGNTS/pNw3j
 GcMBKHGCUFw+ca4iHc2eTUSxEBQqMC2jLgigOMZrXD/qzAouVN+g6Gk3n8WiYz9c1F3I uA== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 32xd42t8ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 17 Aug 2020 04:25:07 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 17 Aug
 2020 10:25:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 17 Aug 2020 10:25:05 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 35F5F2C3;
 Mon, 17 Aug 2020 09:25:05 +0000 (UTC)
Date: Mon, 17 Aug 2020 09:25:05 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH RFC] ASoC: wm8994: Avoid attempts to read unreadable
 registers
Message-ID: <20200817092505.GF10899@ediswmail.ad.cirrus.com>
References: <CGME20200731173856eucas1p292d2bc7319aa6a9af9b0e48b89ae803b@eucas1p2.samsung.com>
 <20200731173834.23832-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200731173834.23832-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=631
 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170070
Cc: simon@lineageos.org, alsa-devel@alsa-project.org, b.zolnierkie@samsung.com,
 patches@opensource.cirrus.com, lgirdwood@gmail.com, broonie@kernel.org,
 m.szyprowski@samsung.com
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

On Fri, Jul 31, 2020 at 07:38:34PM +0200, Sylwester Nawrocki wrote:
> The driver supports WM1811, WM8994, WM8958 devices but according to
> documentation and the regmap definitions the WM8958_DSP2_* registers
> are only available on WM8958. In current code these registers are
> being accessed as if they were available on all the three chips.
> 
> When starting playback on WM1811 CODEC multiple errors like:
> "wm8994-codec wm8994-codec: ASoC: error at soc_component_read_no_lock on wm8994-codec: -5"
> can be seen, which is caused by attempts to read an unavailable
> WM8958_DSP2_PROGRAM register. The issue has been uncovered by recent
> commit "e2329ee ASoC: soc-component: add soc_component_err()".
> 
> This patch adds a check in wm8958_aif_ev() callback so the DSP2 handling
> is only done for WM8958.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---

Sorry for the delay.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
