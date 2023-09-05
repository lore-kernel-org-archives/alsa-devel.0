Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3831FC83F2C
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Sep 2023 09:39:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B2EF86F;
	Tue,  5 Sep 2023 11:38:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B2EF86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693906739;
	bh=yH440hBSypvnsEG8whka12+uqLT3YERnQhzJBCUBVlQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Q2S4J2MsglhmPa+dqCgssetekBhP1QoQ4Lk4793LO4k3MwV26LEv1HKBC6nB+bNHj
	 HptbbkbKxFmX1cDTgyqY85R1XcWn6PJCVYI1a+Lp5ss/wEJMDmOw//Wg3ASd2yx98E
	 3WHILRBiZhDg+MMqAY/vd5HQWjfVnZ5dZd7LTM2E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A49FDF80431; Tue,  5 Sep 2023 11:37:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B4F6F80494;
	Tue,  5 Sep 2023 11:37:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46800F80494; Tue,  5 Sep 2023 11:37:40 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26A51F8047D
	for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2023 11:37:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26A51F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=U8o7zn4Y
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3858RFWp030223;
	Tue, 5 Sep 2023 04:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=Nl4QMc496QpBt0c
	q5gJy1r26oYZLrCNIKMt/zibjNd8=; b=U8o7zn4YtXalQqmp0rajIdCGXhSShPo
	F3ck7vTn0PbodHF2htKMYr/oNo3q2GukBAyQw4G4vhcSppVsDzELTpDjbOqGSIrw
	57UGvwEUue56OFhFnlip6imF5On1DVtcBXpwC42QZBu98HSsjSd6b+WZ5Rl9PylL
	3Ox35owSn7dBSQHFUriIgBJaGio+mkRi3pq6UPe18vj8RB8M8LM10BE2dg9681Wp
	5S6yJWqP4ePMCssTTeftDe0fix6lXwQVWZfneRp7gQXiWiP+euwAH+bj8BpR9Rtt
	7j5jtgSsD9ItRVDKZ+8Mp9gLoxlBkA7t3Kk/hKgGavQrm1sBW08PjCg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sv1fhts3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Sep 2023 04:37:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 10:37:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 5 Sep 2023 10:37:26 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 163B115B9;
	Tue,  5 Sep 2023 09:37:26 +0000 (UTC)
Date: Tue, 5 Sep 2023 09:37:26 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Liam
 Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH 7/9] ASoC: cs35l41: Verify PM runtime resume errors in
 IRQ handler
Message-ID: <20230905093726.GI103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-8-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902210621.1184693-8-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: qXIMc21SVk7immCT0baunBGLQXl-grCt
X-Proofpoint-GUID: qXIMc21SVk7immCT0baunBGLQXl-grCt
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: BLNNYITXBCHXL2XHMSIFASEWUZUWBARH
X-Message-ID-Hash: BLNNYITXBCHXL2XHMSIFASEWUZUWBARH
X-MailFrom: prvs=4612d7e67e=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BLNNYITXBCHXL2XHMSIFASEWUZUWBARH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, Sep 03, 2023 at 12:06:19AM +0300, Cristian Ciocaltea wrote:
> The interrupt handler invokes pm_runtime_get_sync() without checking the
> returned error code.
> 
> Add a proper verification and switch to pm_runtime_resume_and_get(), to
> avoid the need to call pm_runtime_put_noidle() for decrementing the PM
> usage counter before returning from the error condition.
> 
> Fixes: f517ba4924ad ("ASoC: cs35l41: Add support for hibernate memory retention mode")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
