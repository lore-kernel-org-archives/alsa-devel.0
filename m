Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7039C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Mar 2022 09:41:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93F66163E;
	Mon, 28 Mar 2022 11:40:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93F66163E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648460484;
	bh=rO1Wll8UgpMzOFA3g9e/r79dgEKx10oscN/HIiHivo4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lpaKJU1PchsoaJVyGKVybLlpDL+Q0sFyyo7wgY6jrP2LI+0g8jtw69pURIqQUZwON
	 CsEX43RYvF4TX3h913LZWHIi9CXKfH4Um/paWIEGzcYZZevjWj+L4vwwZYeQFpCKiI
	 pQukoKWp3yvfiQdchga/kyX4Q8AYLfSxp+x6uQDE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20473F80128;
	Mon, 28 Mar 2022 11:40:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25BCFF800FA; Mon, 28 Mar 2022 11:40:32 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE112F800FA
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2022 11:40:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE112F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="N+33namd"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S8Awgg030875;
 Mon, 28 Mar 2022 04:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=aZk9iLH3PqA6QYCkkF2Lc8yVPiM4ANZGWrqFgAv/m+M=;
 b=N+33namdLkYis+ypDnkWLuw/hg2uYlP3D/SQoV98x5ycBUjruEf0roZARhGFllqwpEEq
 iPx61OfGd5zQJI8gvqIOsHwjAE0VlQBJgN1fb66nMetPx+IoStRCXTX96fW4UM/otlej
 IDbLMJKB1sDUCH3jxue8Euoy99VHiHdQyFQ+qpLPV4nzyZFN4YlzVXHzfdrwQ/gUObGL
 Tu39CDfmZhEuD6SV2wMGHCTSYsw+mSHlm3DJCWyZ0l8zaoYuyvy4em0V4jtzGCXYf/OP
 byofhbzBUCVB+DxFnbqllZjiQLsR2vuV7rIcM2+9LuuJGm/AlUY6PrBVoymy0BsSsP4Q Pg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081ag1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 28 Mar 2022 04:40:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 10:40:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Mon, 28 Mar 2022 10:40:21 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 091A7B16;
 Mon, 28 Mar 2022 09:40:21 +0000 (UTC)
Date: Mon, 28 Mar 2022 09:40:21 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/7] ASoC: wm8731: Move regulator request into
 wm8731_init()
Message-ID: <20220328094021.GW38351@ediswmail.ad.cirrus.com>
References: <20220325153121.1598494-1-broonie@kernel.org>
 <20220325153121.1598494-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220325153121.1598494-4-broonie@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: WImHUSLBiI_G7Se76nMZilTp6GQimoPi
X-Proofpoint-GUID: WImHUSLBiI_G7Se76nMZilTp6GQimoPi
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Fri, Mar 25, 2022 at 03:31:17PM +0000, Mark Brown wrote:
> The supplies used by the wm8731 do not depend on the bus and there is no
> need to do anything with the supplies prior to instantiating the regmap so
> move the request into wm8731_init().
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
