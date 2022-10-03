Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0CEC433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Oct 2022 10:12:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83DC120A9;
	Mon,  3 Oct 2022 12:11:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83DC120A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664791953;
	bh=UXR58j7+XfGM08i6tAoB29i0OONnhVnnJV5zPwDCwLQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QaF2+Tc8PZJa+yc+2sQNlaeO9Un+mTB7oqphsDBk+5y6Fg5nGSrh0KLpfF/aGqXTu
	 shbBim57mTaCmrvtN+kHbGPxZeM9eDaPcQ0GgNNCV4eRXkLTVih2HNuZG5zFkdlTpX
	 1HKmQeSsGoF2wBvbIVmgeBYPRz4slmzzp4Q1cAeg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FB62F804AC;
	Mon,  3 Oct 2022 12:11:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 525A7F804D1; Mon,  3 Oct 2022 12:11:32 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5628DF800B5
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2022 12:11:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5628DF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="dvS5GR1e"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2933mfth015208;
 Mon, 3 Oct 2022 05:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=BLrL6cQ0hdXKIhChelZBHREsS2bYKLFiECIZnKsuyiA=;
 b=dvS5GR1eSzs/pIIF1CU7glrkYyeqmp12EpsL4b2Jrp0krw8YARuqW80Em9SJ1JMLkdSd
 7A5cb7TyG6nZUvzOgNCdnBF1YYcWzLYaAFIMg37XR7gysAifige1dB7IJ6bzTvT6csoL
 G7ILjmm+qPJd545h88myane9LXp3v04h23M2c4hrDp3jGJH72yEproZEvejyK+tbNges
 jdC/i2GKq9JW17weIZ4SmIW2m7ruQUAfVK6dVLiAPLRvAzDeIsGj1sthObFA91jvLvjI
 crkUwNn1BatGRcbFxBFybORH4tRMRMJBQuh4yQPjIP5gBAhIseecnKLoPHcCrTpAOC6Y Fg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jxjy321pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Oct 2022 05:11:24 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Mon, 3 Oct
 2022 05:11:22 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via
 Frontend Transport; Mon, 3 Oct 2022 05:11:22 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2AC6F475;
 Mon,  3 Oct 2022 10:11:22 +0000 (UTC)
Date: Mon, 3 Oct 2022 10:11:22 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v2 2/3] ASoC: wm8961: add support for devicetree
Message-ID: <20221003101122.GZ92394@ediswmail.ad.cirrus.com>
References: <20221003032414.248326-1-doug@schmorgal.com>
 <20221003032414.248326-3-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221003032414.248326-3-doug@schmorgal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: r7iQw3NSaPSIxmPf1TqWG5XbDpO7jJ3Y
X-Proofpoint-ORIG-GUID: r7iQw3NSaPSIxmPf1TqWG5XbDpO7jJ3Y
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

On Sun, Oct 02, 2022 at 08:24:13PM -0700, Doug Brown wrote:
> Add support for devicetree to the WM8961 driver so it can be used with
> modern DT-based kernels.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
