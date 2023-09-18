Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5ADCD37B0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 12:00:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 160B8820;
	Mon, 18 Sep 2023 13:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 160B8820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695038401;
	bh=GQSfMFUjFfnIYSrhZZU1IfRCV+sDNN9NyOfTrr/Zus8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BrAgGkLLULPxzcB60UWTzEDy2LHiP509fcF7EAj+pqHZJBcUh4YOTmnlL2iFwfWRF
	 FCVJVTus06+E+NT0I5KrrFH08rBxd353+s33MF8VIU3fHlAqNHWD/he8l6X51lEjMJ
	 hJSywzSSCe7l7Rd0biZSwh69fsazyYyZOppEOoFE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3911F8025A; Mon, 18 Sep 2023 13:58:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 61F79F800AA;
	Mon, 18 Sep 2023 13:58:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0CF6F801F5; Mon, 18 Sep 2023 13:58:44 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 09DB3F80125
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 13:58:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09DB3F80125
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=W5bI63EN
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38I4SDXm011029;
	Mon, 18 Sep 2023 06:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=6D1hNWb0NwMrs+h
	MpvEy1DKtRWavZMCve85QMiFW5p0=; b=W5bI63EN5Nuqr72LhdB+zLkXRHVxQmd
	47CkcjnTNJcx6eSL88s+eOtmZnWJysVoFu2kyGbCFOM+RqehhpQS7r3FuIKs1s9L
	o4n5PrW21yfxuqEUJxVI7hmmwhtKgljvqmeEe0w7crmm1C5lnb2G5yZURZoqVOar
	UA50DmUWK3rtxsZJuon24TsLE/UnSWT3gxtxPKA1uOLimg79TDLkC8bIjxeQmNEK
	B1246Nx4yIDftIJMi+bmBy1phEJuVa822YPkYzpNlHpRgkg2TkRW3gd0I65d5yGa
	qWW/PYPtBz4TR9CF5cgS7kGJRFLu2Os4OW3m8aKFEp0fb6hZZDjm0GA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry28ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Sep 2023 06:58:38 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 12:58:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 18 Sep 2023 12:58:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B0B4111AB;
	Mon, 18 Sep 2023 11:58:35 +0000 (UTC)
Date: Mon, 18 Sep 2023 11:58:35 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soundwire: bus: Add explicit include for irqdomain.h
Message-ID: <20230918115835.GY103419@ediswmail.ad.cirrus.com>
References: <20230915142900.34498-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230915142900.34498-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 6plhEUYbEd_fsI-DZNUiCBDqbXjByfl2
X-Proofpoint-ORIG-GUID: 6plhEUYbEd_fsI-DZNUiCBDqbXjByfl2
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: HV5B6ZHT4CBYEFE7QYZNKHCNVFBL6HUA
X-Message-ID-Hash: HV5B6ZHT4CBYEFE7QYZNKHCNVFBL6HUA
X-MailFrom: prvs=4625b791e1=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HV5B6ZHT4CBYEFE7QYZNKHCNVFBL6HUA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Sep 15, 2023 at 03:29:00PM +0100, Charles Keepax wrote:
> This header should be explicitly included, to make sure it is included
> for all Kconfigs.
> 
> Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

This doesn't quite fix the issue let me respin.

Thanks,
Charles
