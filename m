Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46256C4CEC9
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 14:33:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E81218AF
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RaZ6wcUs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AaegY7/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E81218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA781166F;
	Wed, 18 Sep 2019 16:32:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA781166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568817179;
	bh=aK30DaIvfEK3YY43muQ0YZFEBIQ9/lmnawzKtc5dSnw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RaZ6wcUsCWmMmi7ZhOBSAPMtQgggW2GwV81jhNZFYOM6KEF/PohXnnsp/RVy+Nfah
	 k0dP0cYH++NaZJaAlY/spTu1qNOKCge9gZsuvwY9xIKsil8GlcGGqmElgB1uXLO7Mf
	 +i61fBAaz0rbVv08cKiDTIKjIlEdGwAdG+604zuo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F4B8F804FF;
	Wed, 18 Sep 2019 16:32:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64FD9F80506; Wed, 18 Sep 2019 16:32:07 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 505FEF80146
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 16:32:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 505FEF80146
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="AaegY7/Y"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8IEEBG9005771; Wed, 18 Sep 2019 09:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=85mW0bFWiiIVuyJiPKM02zlJFmWQIMDT9ECHIvX0eJQ=;
 b=AaegY7/Y2PorFSTmv1tusBxEPcjnGNa9+O9pQlrOHZyxaS1oObNe3xbsuJ77XJt/FytV
 ai5CyyauW39nVL7SDis0U7KeZSzTKukIKufMtwUoShvJHhUZ499pdnyNTQ9hgdcuNZNm
 du3u6jEfTBhbFrgSnvrOqZyLQsWUoplVxmY+J8DGixg89IL6RhcQuZ5T8NSyTxOMmzaF
 iS2eg/unL2hWZkWN3ugb5aVWRjRWBC+8I99UdPS8P0+6z8y4no2c5/uJ5dxBQlJZFWZy
 YhU8Efld9uy/LdmNvghxltvCz0tRAeEG95akwMHhZqqioH5bHXF0zOI50aMkGMJSNBfE RA== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 2v37m197ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 18 Sep 2019 09:31:59 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 18 Sep
 2019 15:31:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Wed, 18 Sep 2019 15:31:57 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DA4CD2C3;
 Wed, 18 Sep 2019 14:31:57 +0000 (UTC)
Date: Wed, 18 Sep 2019 14:31:57 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <20190918143157.GH10204@ediswmail.ad.cirrus.com>
References: <20190918104634.15216-1-s.nawrocki@samsung.com>
 <CGME20190918104700eucas1p1ef0775632f5c7259fb54cab8efc96c50@eucas1p1.samsung.com>
 <20190918104634.15216-5-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190918104634.15216-5-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909180144
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 sbkim73@samsung.com, patches@opensource.cirrus.com, broonie@kernel.org,
 lgirdwood@gmail.com, krzk@kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [alsa-devel] [PATCH v1 4/9] ASoC: wm8994: Add support for MCLKn
	clock gating
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

On Wed, Sep 18, 2019 at 12:46:29PM +0200, Sylwester Nawrocki wrote:
> As an intermediate step before covering the clocking subsystem
> of the CODEC entirely by the clk API add handling of external CODEC's
> master clocks in DAPM events when the AIFn clocks are sourced directly
> from MCLKn; when FLLn are used we enable/disable respective MCLKn
> before/after FLLn is enabled/disabled.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> @@ -2260,8 +2321,28 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
>  	/* Clear any pending completion from a previous failure */
>  	try_wait_for_completion(&wm8994->fll_locked[id]);
>  
> +	switch (src) {
> +	case WM8994_FLL_SRC_MCLK1:
> +		mclk = control->mclk[0].clk;
> +		break;
> +	case WM8994_FLL_SRC_MCLK2:
> +		mclk = control->mclk[1].clk;
> +		break;
> +	default:
> +		mclk = NULL;
> +	}
> +
>  	/* Enable (with fractional mode if required) */
>  	if (freq_out) {
> +		if (mclk) {
> +			ret = clk_prepare_enable(mclk);
> +			if (ret < 0) {
> +				dev_err(component->dev,
> +					"Failed to enable MCLK for FLL%d\n",
> +					id + 1);
> +				return ret;
> +			}
> +		}
>  		/* Enable VMID if we need it */
>  		if (!was_enabled) {
>  			active_reference(component);
> @@ -2315,6 +2396,8 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
>  
>  			active_dereference(component);
>  		}
> +		if (mclk)
> +			clk_disable_unprepare(mclk);

I don't think this works in the case of changing active FLLs.
The driver looks like it allows changing the FLL configuration
whilst the FLL is already active in which case it you would have
two wm8994_set_fll calls enabling the FLL but only a single one
disabling it. Resulting in the FLL being off but the MCLK being
left enabled.

Thanks,
Charles
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
