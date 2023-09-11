Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4498FEE57DF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Sep 2023 13:06:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B915A86F;
	Mon, 11 Sep 2023 15:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B915A86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694437577;
	bh=2sXd8kSX8ch72WsL/rwxjZu+OOhvLp0UL+NPOLJCI6U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QcyfPgXrKNpR1csE6/FUk5cujPH/jFqvnB8/mvjUcXA2xker5l/1zpBjMY4OZt0hb
	 8FS0AHtsOfka3O+7i14Jtj3zQC2kYayr8L8EiSGrAPWH3s4Mo+CFZ5qJA3I3M8gUMe
	 N562lw7ipEV3udNhlW6s8q5omrszlf6i2ExDwDnU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2D42F80549; Mon, 11 Sep 2023 15:04:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF854F80549;
	Mon, 11 Sep 2023 15:04:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A4CBF80425; Mon, 11 Sep 2023 15:04:55 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9B84DF801F5
	for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2023 15:04:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B84DF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=JGhJozYk
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38BBmDlB032392;
	Mon, 11 Sep 2023 08:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=t9rLgJyqGBBWmI5mVTftAC82FZUKd++pMb8l16x//Is=; b=
	JGhJozYkAgX5SttnFoUGkzWkwwwCbjZQA6EaSEC50bqZvb+WLRktIYcUUKf8XxXm
	I9szVhBHU6CW7qKzjNP0imMhup+e+G9gJwoSfdbgbFB7C3krBZJ2oQA28sdOSVD1
	FCvcEMffegOa8uQbCs9uuaWkpI+f+ATFIWWkBQRMCnzeR2gvPCq9oGfdVjkRnOwh
	gqJbzGuXm03QcvO1w83vTjRS5ipYcyVf5YmhRqAFVrDUBL82Bi9Ojv+goPiA6ugw
	QA5VEbgHkEuTOBRIDgGdOJiHgw3lPTf0KBtm80UKD8J7YhYwHNvliad/uMvywM3F
	YY5IJzakOiRBE2PpXhvvRg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t0p3xj4jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 08:04:48 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 11 Sep
 2023 14:04:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 11 Sep 2023 14:04:43 +0100
Received: from [198.90.251.125] (edi-sw-dsktp-006.ad.cirrus.com
 [198.90.251.125])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4C83C11AA;
	Mon, 11 Sep 2023 13:04:43 +0000 (UTC)
Message-ID: <f03eac55-04ac-b99f-f545-ef8bb7e80f42@opensource.cirrus.com>
Date: Mon, 11 Sep 2023 14:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mtd: cs42l43: use modern PM macro helpers
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>,
        James Schulman
	<james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>, "Lee
 Jones" <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC: Arnd Bergmann <arnd@arndb.de>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20230911111623.705640-1-arnd@kernel.org>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230911111623.705640-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qehUIOxXHOmuDR3xb9R94T1SvScaXpGn
X-Proofpoint-GUID: qehUIOxXHOmuDR3xb9R94T1SvScaXpGn
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: J3I6JOF3RPHWTOWA562YILXIOWMWT6LC
X-Message-ID-Hash: J3I6JOF3RPHWTOWA562YILXIOWMWT6LC
X-MailFrom: prvs=4618f18b96=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J3I6JOF3RPHWTOWA562YILXIOWMWT6LC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 11/09/2023 12:16, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The old SET_SYSTEM_SLEEP_PM_OPS/SET_RUNTIME_PM_OPS macros required enclosing
> the function definitions in an #ifdef or marking them __maybe_unused:
> 
<SNIP>

>   
>   EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> -	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> -	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> +	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
>   };

Charles already sent a patch for this. We're waiting for Lee to merge it.
https://lore.kernel.org/all/20230822114914.340359-1-ckeepax@opensource.cirrus.com/
