Return-Path: <SRS0=20LX=PU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA86C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Nov 2021 09:26:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCDB611CA
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Nov 2021 09:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CCDB611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8847016A1;
	Mon,  1 Nov 2021 10:25:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8847016A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635758785;
	bh=iM5Z+mb6UT70s4CrS6VFOjB0fb1hk/3k5fYB7BJR1hE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DbrBUZ+KAhGBZTf9+pRPfOkELX8PvCc7TQBEhprFzyuxvGzHOc9oqejSfssDKCZU5
	 TaiAbKB0rX2IICv/QzjfWtFSWAkwX46jhNEA9l5y38YcYLPMviGWHnP39cCO4W2Lmh
	 lS9wXAieUDT4qAmeeE/2k81+ocuKT43CIyd+v+R4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0596F8025F;
	Mon,  1 Nov 2021 10:25:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3DE2DF80269; Mon,  1 Nov 2021 10:25:33 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE1ECF8012E
 for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2021 10:25:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE1ECF8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="IhLW7DAI"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A17x9GY021956;
 Mon, 1 Nov 2021 04:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=d92gC9rldCHNeDoHyF/luQbU1iABob/up3KBMIZIVa8=;
 b=IhLW7DAIQlhrSZ8IUglGJB28I+ByQOPzCzxTNWsapd9MbeFvM+nUXy6537sSUIopDfqT
 xMyt5AscIeEKMc4cQQccSgtfMFe5inKf4Ri6Qdg+RkUpOnZ3y692F4WCc6I9AciRbPzx
 aq8XXr/aflGGRI81OA/rGbVG/3c+MGMrztuZJz/5/81jYZDa3ieHIkKBtanIfMRSqP5U
 61KyM2A6FFMEmQIc0A715mxqHJCo1OTBaU41H4SPKB3Qx8WtLtlz3ZY39sWjQWEQrRPH
 EDYTutucMIHNoPilm3NiCDt2IyVKEbsyzv6mREOaaIlNlaJOD4S0ZyfMv2KZxcSx0nxf CA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3c25f3rfbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 01 Nov 2021 04:25:21 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.12; Mon, 1 Nov
 2021 09:25:19 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.12 via
 Frontend Transport; Mon, 1 Nov 2021 09:25:19 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A9481B2F;
 Mon,  1 Nov 2021 09:25:19 +0000 (UTC)
Date: Mon, 1 Nov 2021 09:25:19 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: David Rhodes <drhodes@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs35l41: DSP Support
Message-ID: <20211101092519.GI28292@ediswmail.ad.cirrus.com>
References: <20211029214028.401284-1-drhodes@opensource.cirrus.com>
 <20211029214028.401284-2-drhodes@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211029214028.401284-2-drhodes@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: odP7K28YgdGPgntmxgt56Wjh9_DtZU97
X-Proofpoint-ORIG-GUID: odP7K28YgdGPgntmxgt56Wjh9_DtZU97
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 broonie@kernel.org, brian.austin@cirrus.com, david.rhodes@cirrus.com
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

On Fri, Oct 29, 2021 at 04:40:28PM -0500, David Rhodes wrote:
> Support for HALO DSP and firmware
> 
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
