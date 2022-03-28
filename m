Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D748C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Mar 2022 09:47:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60E241775;
	Mon, 28 Mar 2022 11:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60E241775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648460843;
	bh=cJiXhpQvjcag5QOrCKoMtko8cylbo/PMVIfwc4fBUz0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fR0HjdCzBaXXEV8ZktbiqgKQUWHdr7uydgsNPOq1yT2LvUqJBJIJr7Oq/dBxMmmsY
	 XO4VLKKOZr2vfhVgLn3vwp4Ofqk9qNz83gIXO7VXDG2wlBBH0iYCTuJ3P2e229m8PY
	 MZOE7IZJgHjTsF65BShTen1tiHINpOmc1lAVS/HA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00A45F80271;
	Mon, 28 Mar 2022 11:46:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A02A8F804CF; Mon, 28 Mar 2022 11:46:31 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B9AEF8026D
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2022 11:46:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B9AEF8026D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="jEwkhI/q"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S89AWv025933;
 Mon, 28 Mar 2022 04:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ycAqSODlyIBXBYeXGaVL2PLkjXwClbha5XEkRlCAIWY=;
 b=jEwkhI/qxfclrXR0NKU9JIp9J2w4hi54hUS+heNPf+nLUeEUmMO1r20/hm5I8Qll6UMx
 6SfJyLDL9PJMzMMYOA5yceYS5nb7CQUEWSbmuItF+hATxd4TSMzEm231Q/YCZpqZdcW9
 q/epUAOG5BA4zrbUGw+T2sxVcUgfwBg6f4ptJtrUdVkWVOFfxco1XbfswZE00V2CMeUd
 WzHRsjhbfX8c9t19y75e1/AkpqIfEqq3kikqFxIXPCVPc7b7ZJo3LLPd8dy0S8W5RxXh
 9jYnSIU2F6ZRdisJz1C+RCNyAwbS2FlpO1r24q3W1EJlK8noJRkFpg84SgY9JR17NMzs 7Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3f1y8pa88n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 28 Mar 2022 04:46:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 10:46:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Mon, 28 Mar 2022 10:46:22 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E869546A;
 Mon, 28 Mar 2022 09:46:21 +0000 (UTC)
Date: Mon, 28 Mar 2022 09:46:21 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 7/7] ARM: configs: Update multi_v5_defconfig for
 WM8731 bus refactoring
Message-ID: <20220328094621.GA38351@ediswmail.ad.cirrus.com>
References: <20220325153121.1598494-1-broonie@kernel.org>
 <20220325153121.1598494-8-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220325153121.1598494-8-broonie@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: t1XWJyBuqDFaC_T8WjVC8zT3hlZUzAel
X-Proofpoint-ORIG-GUID: t1XWJyBuqDFaC_T8WjVC8zT3hlZUzAel
X-Proofpoint-Spam-Reason: safe
Cc: soc@kernel.org, patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
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

On Fri, Mar 25, 2022 at 03:31:21PM +0000, Mark Brown wrote:
> The WM8731 driver has been refactored so the I2C and SPI bus code is
> separate modules. Refresh multi_v5_defconfig to reflect this.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: soc@kernel.org
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
