Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF75CA0FE1
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Sep 2023 08:51:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 176BFAE9;
	Fri,  1 Sep 2023 10:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 176BFAE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693558307;
	bh=o2ik4xOGLBrCJFCPO5Jm6ne5I0fAPvhucePL+hjEX1c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rTNJFbbxt6M/IO9M+3UPi8hSG7XsrZQRXwXPGIqr2Fjn0HPgZ8jcrp55pgQTgqhaA
	 5CGmpvPxktRsn0TAjBnaP2pRh2CLfNqwtssjDG+uCQ7r8nHcQgg+sLhDsqBVgBInGs
	 dfj+Aageh0knKbMPAD6yRwtjCjhEbe7HAf2LXXUg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ADD53F80527; Fri,  1 Sep 2023 10:50:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E0D7F80236;
	Fri,  1 Sep 2023 10:50:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD139F8023B; Fri,  1 Sep 2023 10:50:26 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1D0FDF80236
	for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2023 10:50:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D0FDF80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=KYh5W0Pw
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3814hqbh004037;
	Fri, 1 Sep 2023 03:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=dfrKDxDDZZ2VDjG
	lcPEe3RlSfsXnC0lxELdtB+CyKEY=; b=KYh5W0PwkRvIKS8Lc1SRMnX0SCN/kH3
	AUPZbOt6L9Kb9jT6oqOO7428GsNq0xBaBiw1e+vIZYrCV+C6uSbXM4fz+V/2B/nT
	KbtoqevfDThA2kB5gB/V3xAiaag9ojzDZpNr3Da9ALIELWW7Y/3FYrcEpga+RWkS
	FpVwsGKcH83GaFDD6FqbT3pDkvuP4PL+ysuPI0rdmUhotpcWWy1vTth1ooUBqB47
	prPRohw14J3gNE5L4R1YrkBxSeM1fPqwUTbVtyDKtT3oO2waSvy+4mCF0/WtoZsG
	88YaWn0BgBzT/vOxSM7ooGoLCBPcfKiiz9q16Nns5k9E7bu8a3kqaUA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyg4mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Sep 2023 03:50:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 1 Sep
 2023 09:50:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 1 Sep 2023 09:50:10 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DE29EB06;
	Fri,  1 Sep 2023 08:50:10 +0000 (UTC)
Date: Fri, 1 Sep 2023 08:50:10 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
CC: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring
	<robh+dt@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] ASoC: cs35l45: Analog PCM Volume and Amplifier
 Mode controls
Message-ID: <20230901085010.GA103419@ediswmail.ad.cirrus.com>
References: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
 <20230831162042.471801-2-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831162042.471801-2-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: V64ASNJaKUtF6pKuRxGirmonRv3-nXiw
X-Proofpoint-GUID: V64ASNJaKUtF6pKuRxGirmonRv3-nXiw
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: FKVHGYYALFMOCFY5276MPDJKPMX5DS65
X-Message-ID-Hash: FKVHGYYALFMOCFY5276MPDJKPMX5DS65
X-MailFrom: prvs=4608688732=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FKVHGYYALFMOCFY5276MPDJKPMX5DS65/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Aug 31, 2023 at 11:20:40AM -0500, Vlad Karpovich wrote:
> Adds "Analog PCM Volume" control with supported values
> 0 = 10dB,1 = 13dB,2 = 16dB and 3 = 19dB.
> The amplifier can operate either in Speaker Mode or Receiver Mode
> as configured by the user. Speaker Mode has four gain options
> to support maximum amplifier output amplitude for loud
> speaker application. Receiver Mode has further optimized
> noise performance while maintaining sufficient output to support
> phone receiver application. While configured in Receiver Mode,
> the analog PCM Volume control is disabled and
> the analog gain is fixed to 1dB.
> 
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
