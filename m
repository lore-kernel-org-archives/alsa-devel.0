Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BBDC83F12
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Aug 2023 08:48:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BFC87F1;
	Tue, 29 Aug 2023 10:47:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BFC87F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693298910;
	bh=ggXOxb46MDm+F56Dy8lRUR1PGn3qsEBhGN9jOS1J+tk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QnNZBFXaKnHkc4n9TDOKS4ew5hBIsdnVl0jHsZ2OPHk5A6m7wVFjldJAg/4eREO2c
	 ca9TFcqNkhpiyOYJIO0uCydlS7g2+1SoKq/i4kD1w81/PEDpKE7gmzHEBBttMz4s8F
	 d4yfMH7bk9a62oSOH1vrsKvIix7qXthXnADFMrLU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4308F800D1; Tue, 29 Aug 2023 10:47:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 653A8F80094;
	Tue, 29 Aug 2023 10:47:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35044F80158; Tue, 29 Aug 2023 10:47:07 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B5ADF800D1
	for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2023 10:47:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B5ADF800D1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=CvIf87Yr
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37T7duvW028909;
	Tue, 29 Aug 2023 03:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=tCsuP7AKJMpbFbr
	bid78TMjDeHr7H/IBH+iAMJKh65k=; b=CvIf87YrdV58Fbqzkb47X/AYBuKZfOH
	tB/s9zRImfwOiv5yx2Mv68PPJpvkj2YBog0ZyTgYAokzO3lPA+mV8KzR+xYjTWDX
	V0do/wUHMvz8puSDpboNinjCRO9FfTzpJgBriFf0RqPVaGq2BDE3cdkwiKqeIO9r
	JirJIczjlZNmDElEfeMLJmeJPaUnmDVYX+og8Ondw0s8cdMaPdHkf18B2SpVi73a
	gGNVpkkBAPyqnHNRFgQwvRMbj8143shKjhJ9m9w5/YeN2h6R8iJpd853kjTY5zyL
	+qdjlIc4ISlSGMe+wjUbWRBzFvmSexfNdMX4w7PKDEE2y68XU5SVE1A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj2qgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 03:46:59 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 29 Aug
 2023 09:46:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 29 Aug 2023 09:46:58 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF72F357C;
	Tue, 29 Aug 2023 08:46:57 +0000 (UTC)
Date: Tue, 29 Aug 2023 08:46:57 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@linaro.org>,
        <kernel-janitors@vger.kernel.org>, <error27@gmail.com>
Subject: Re: [PATCH next] ASoC: cs42l43: Fix missing error code in
 cs42l43_codec_probe()
Message-ID: <20230829084657.GO103419@ediswmail.ad.cirrus.com>
References: <20230829073635.1877367-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829073635.1877367-1-harshit.m.mogalapalli@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: lt2KSslfaEEodS0lMHqEliLgRvuY-hKQ
X-Proofpoint-GUID: lt2KSslfaEEodS0lMHqEliLgRvuY-hKQ
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: 2MUOPRLUYKBXSDR6ZZ4NYJHSRWJUOATH
X-Message-ID-Hash: 2MUOPRLUYKBXSDR6ZZ4NYJHSRWJUOATH
X-MailFrom: prvs=4605abc1a5=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2MUOPRLUYKBXSDR6ZZ4NYJHSRWJUOATH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Aug 29, 2023 at 12:36:35AM -0700, Harshit Mogalapalli wrote:
> When clk_get_optional() fails, the error handling code does a 'goto
> err_pm' with ret = 0, which is resturning success on a failure path.
> 
> Fix this by assigning the PTR_ERR(priv->mclk) to ret variable.
> 
> Fixes: fc918cbe874e ("ASoC: cs42l43: Add support for the cs42l43")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
