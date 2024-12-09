Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDD9E77181
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:25:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9202218D;
	Mon,  9 Dec 2024 17:25:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9202218D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733761538;
	bh=G7P4WFySdM9J6B3gL7v7zq13XcU+IF+zjj7ttGGoZSk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=teNDbTThXNbldX4P6t906ZrB3nBmY+Cef+ABZcrMd56+30RktnvxOo9EXDc5BdQvt
	 n0hRdstEix3zPDuZe/4QsFWvgajHithbJRk3wYqbgcdhrm/xAWJZhLUjMPAMdxXzIo
	 FZYUpsPIXM3qSW/Ab800s4EQwEPI1JenM+Z7gcqU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FDA0F8065A; Mon,  9 Dec 2024 17:24:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4B84F80614;
	Mon,  9 Dec 2024 17:24:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C1ACF80482; Mon,  9 Dec 2024 10:52:59 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3F450F80087
	for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2024 10:52:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F450F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=Y+NzqaSn
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id
 4B97SI8a010517;
	Mon, 9 Dec 2024 03:52:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Ut6LcVsTIG0oZHILjN
	iw4Y5NRvtVX4JYmOtGu6tel8w=; b=Y+NzqaSnCn1hSJqEGDNt0snTrcrGE1RT3T
	8flZij+Jcn5ehw4PL96FJTG7FTPmibGaIiXVk9FtR7h1Ne0ACfqsUFG4fHW8Cg9U
	iPFJL7rRU0vhK7yAaoEyPJNPZc5uDba1jCnUZaBTprgvvaYxQL+pDN9UZ/i7+YFs
	aVYKt/l5FE60PEIecIZm7QPkyGSnRK5uRhQR1vcM1fQY/c63ibCkwDSNuEFLXXe9
	CCHETHwl1N7UYNbBUYtTdeH8oTP3lNPGwKuns28Hh6HnaKPgOt+UHxbBi+n6InzL
	sZYmXna/XDh/rSYWqbtnIUCUf46gmoHy5t6UqU77Xb8BMROs0M/w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43cknk9v33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 03:52:54 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 9 Dec
 2024 09:52:53 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Mon, 9 Dec 2024 09:52:53 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 337D6820248;
	Mon,  9 Dec 2024 09:52:53 +0000 (UTC)
Date: Mon, 9 Dec 2024 09:52:52 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: =?iso-8859-1?B?Ik51bm8gU+Ei?= <nuno.sa@analog.com>,
        =?iso-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?=
 <u.kleine-koenig@baylibre.com>,
        Daniel Mack <daniel@zonque.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
 Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Takashi
 Iwai" <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-rpi-kernel@lists.infradead.org>, <linux-sound@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 00/17] ASoC: remove snd_soc_dai_set_tristate()
Message-ID: <Z1a99HJuL04nWuqx@opensource.cirrus.com>
References: <87wmg9mhkk.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87wmg9mhkk.wl-kuninori.morimoto.gx@renesas.com>
X-Proofpoint-ORIG-GUID: 6sC2AuF3yPVyGwHQRs2Fhx6Ba-fI5Urq
X-Proofpoint-GUID: 6sC2AuF3yPVyGwHQRs2Fhx6Ba-fI5Urq
X-Proofpoint-Spam-Reason: safe
X-MailFrom: prvs=9073d7692b=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Hits: implicit-dest
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
Message-ID-Hash: WGYBDSDKG4O2QLEG5A3ZUMKVKDEEAETV
X-Message-ID-Hash: WGYBDSDKG4O2QLEG5A3ZUMKVKDEEAETV
X-Mailman-Approved-At: Mon, 09 Dec 2024 16:24:22 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WGYBDSDKG4O2QLEG5A3ZUMKVKDEEAETV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Dec 09, 2024 at 07:38:52AM +0000, Kuninori Morimoto wrote:
> Hi Mark
> 
> snd_soc_dai_set_tristate() has added in v2.6.27 (2008/Oct) by this commit
> 
> 	8c6529dbf881303920a415c2d14a500218661949
> 	("ALSA: asoc: core - add Digital Audio Interface (DAI) control functions.")
> 
> But it has never been used during this 16 years.
> Let's remove it.

We have definitely used it in out of tree code for some phones in
our times. Whilst I don't feel super strongly, I would say it seems
like fairly reasonable functionality and it does no harm, so I
would vote to keep it.

Thanks,
Charles
