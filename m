Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22785C83F12
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Aug 2023 10:05:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 558F1825;
	Tue, 29 Aug 2023 12:05:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 558F1825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693303554;
	bh=dlqU/tuEznNQlbt0KN90+QEYWtjRB0f0LJC50uQ9vd4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TUSummDDp7J53BBq6ICCwve9CwpgIg5f67X1SQBaUbY/fQRtR5DH9y37Lnr51lvlE
	 OLMdeCjW6lE2L4AYBKAdXj1puBsZmeptMUfS8b8TUFV/4EBrOLP15AZu16xuS7Q7Ae
	 56tMb76IAS3+v82rp0kjVqcXg8q7742YHPC0VVDg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75213F800F5; Tue, 29 Aug 2023 12:04:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 31F0FF800F5;
	Tue, 29 Aug 2023 12:04:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8FB6F80158; Tue, 29 Aug 2023 12:04:33 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 541AAF800F5
	for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2023 12:04:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 541AAF800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=awtHp5/D
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37TA4RFb031776;
	Tue, 29 Aug 2023 05:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=u9hqaXuOFL5v6nc
	N7D6ugpoWF0WNT2DLXEHoDCgk5S0=; b=awtHp5/DLU5WTv5mFtNucOz205WDqTA
	Suc1W8ReXRmuHF44NK/ZZNSC0byVQAPgQHUgkUYiS5kYG4CAyyQfNzCYwMhIvllp
	kLOHJc8KL+rdlgoDUZ7LQDaZmrlIghgejMhSL95eRsIiAoPPsiz/58SgjjFLWNYs
	MXdQHN4nUqIn7BckWSqUJ2lf6IUHsK4GI99niKGyU6/59bXR+Bck1VEmkDB7dMXy
	xSEMrwTDihK6o+Be+RKudRKkEAdtOP3T/vO40TiEFNoRQzK0FvBk1pkzwdN2v3Gi
	6fsTevv2qs7uxzX6A7pK//wUiY2IpdLhySYww2HQ8B/K6iixdEj+bUw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj2s9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 05:04:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 29 Aug
 2023 11:04:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 29 Aug 2023 11:04:25 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 71AD415B6;
	Tue, 29 Aug 2023 10:04:25 +0000 (UTC)
Date: Tue, 29 Aug 2023 10:04:25 +0000
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
        <devicetree@vger.kernel.org>,
        <RicardoRivera-Matosricardo.rivera-matos@cirrus.com>
Subject: Re: [PATCH 1/7] ASoC: cs35l45: Add support for Chip ID 0x35A460
Message-ID: <20230829100425.GP103419@ediswmail.ad.cirrus.com>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: x7d0QwZ9GEWB7LVPnwW5UviVJFxlrWhQ
X-Proofpoint-GUID: x7d0QwZ9GEWB7LVPnwW5UviVJFxlrWhQ
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: EATOTOKE6DMSAK2UPYQNY57VIW26JYDD
X-Message-ID-Hash: EATOTOKE6DMSAK2UPYQNY57VIW26JYDD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EATOTOKE6DMSAK2UPYQNY57VIW26JYDD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Aug 28, 2023 at 12:05:19PM -0500, Vlad Karpovich wrote:
> The 0x35A460 chip is a different variant of the cs35l45.
> 
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
