Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DD5C531C9
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:13:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BD0060218;
	Fri, 24 Jul 2026 23:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BD0060218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784927579;
	bh=+nizwDeG+1kJYzR1smRhk8dFW94xvgwgY/3S1X2YHPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V00lDD0aTbKfSgoekzt5sbkPu8G6st8X0I79T42n4BX4XhheE8NJhpeqRKB0nG6wH
	 GAhqVxwRAy5mQEJKM1/1s2bvgB65fSHzYPPFt8qv2Nn97yprIdzVqS9BQeJpdYv3X1
	 6XYU6RbRBXNng21UzQuBQpIgE0hhWMjPRxc2gHck=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51825F80659; Fri, 24 Jul 2026 23:12:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CA0DF8064F;
	Fri, 24 Jul 2026 23:12:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D14C8F805BF; Fri, 24 Jul 2026 18:51:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784911892;
	b=oETKBQGjHXEZ64W9bKLM2Xf8uzOw7Pdaars88oeWvbrnWzHYhSlneMHuHWEWFgin0phj
	 AZns0yaKitmC39oKJ0hiqXr2rdLpsDqeI4mg23N3SXJKPx8kwf8i41sr+lU4yv8PbmfAY
	 SjfeNmDQqleO+q7FRk2TNtOWNZrnovh7ijSMhQBJsbkWEYpLlF6Vm4y0OgbacAYmHxKPZ
	 tCSK9LB10HSsjC+pfFdkRQgmbeHrSOWMwnOtFmJOm5ORn/PzfNS41Sxk3yLIPbm1AbHxQ
	 bMceI5VBP0lPxo0dCOeGUoNDz0ZaJo5H2n8UUug7Aqs/Iiehe4v4Ovnvi78qU1WlThQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784911892;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=+nizwDeG+1kJYzR1smRhk8dFW94xvgwgY/3S1X2YHPE=;
	b=pEErvo9U3QQ8NHbYxPF22kTZJVd2JzdZSea0vNuMZ2X/v2d2mlDdvXyWkcUU4hCfrs2s
	 LgqRtz1AGndDcjHuk0OLD7VEkLGmSWfwJlcE+E+ujfZeGMOsSWT67JRuLToJu8eEzWlqj
	 O+0P+JHW0elov/bduuDW6A80+sj2Nya6jtWojuho/f3Ah1/RKnl1Ey/cy8l3zm/GJHZWW
	 InusO7iW8uIQLPXmOsM0MZMDbtbh9h8qJAKfBA0Nd8bHbfZgmEVdg11S0eWQFaWPulr3i
	 Tq8aEhM1NK98Vmdm+TdFt4gyw9dVNWuyW/8kee5oCJfwYBgV0NhRUqTUCnlHw3hhvsw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ACiegJql;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2B8BDF800AC
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2026 18:51:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B8BDF800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ACiegJql
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 75F65436BD;
	Fri, 24 Jul 2026 16:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89B41F000E9;
	Fri, 24 Jul 2026 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911887;
	bh=6DaUHSrWjgsQtlgDMux59Kr3eqRtmX4eV1O33te3wRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ACiegJqlc2wifyeDQmtbASArtoOeemSzPemVnPsdq87/olSOcLMSij8aIOyr/Qs5l
	 R+4RUZF4+lZ10KT6X6hrwk30bLpWgiTz5YAsfGGltcxvMT+WU0xrg1aJQ2rCLJgbYA
	 QDBBd8Bn+eb43fXwlhbg5VyGKbhWklwHNfVA1wZAYa2wN8yh8TK3sJ+RzfPYtIoKim
	 w+qHmXnRSEAfiaOl4hHzXzpTzBHordv8KFo3MzHI9eucJFlYiYzSkoi6mPNvpMww+/
	 +hOR0bXLdl7TASi5VCX/OxxWxtEx+ABjCvVL737bQgobBCqvJOfvnu5e6K8qF3MzDO
	 tWqqLpF3A0p3g==
Message-ID: <f8dd5c7c-7088-4860-a00f-2e63c87c78c9@kernel.org>
Date: Fri, 24 Jul 2026 11:51:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIHNuZF9oZGFfaW50ZWw6IDE1?=
 =?UTF-8?Q?s_audio_resume_delay_on_AMD_Conexant_SN6140?=
Content-Language: en-US
To: Demon Player <DemonPlayer0@outlook.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "regressions@leemhuis.info" <regressions@leemhuis.info>,
 Mingyou Chen <qby140326@gmail.com>,
 "Vijendar.Mukunda@amd.com" <Vijendar.Mukunda@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: 
 <MWHPR04MB102982652A66D828B734EBC4C92CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
 <MWHPR04MB1029801AFD77D790D33C53E1592CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: 
 <MWHPR04MB1029801AFD77D790D33C53E1592CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: WLXOAB24NWAK5IOWQSSPAISK4T5UZGP3
X-Message-ID-Hash: WLXOAB24NWAK5IOWQSSPAISK4T5UZGP3
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:11:49 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WLXOAB24NWAK5IOWQSSPAISK4T5UZGP3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 7/24/26 06:31, Demon Player wrote:
> 
> Subject: Re: [REGRESSION] snd_hda_intel: 15s audio resume delay on AMD Conexant SN6140
> 
> Hi,
> 
> Please allow me to correct a detail in my original report.
> 
> The suspend state used during testing is S2idle (Modern Standby), not S3 (Suspend to RAM).
> 
> I confirmed this with:
> $ cat /sys/power/mem_sleep
> [s2idle]
> 
> All bisect and test results were conducted under the S2idle state. The regression remains reproducible exclusively under S2idle.
> 
> Apologies for the confusion. Please let me know if any additional logs are needed.
> 

Can you please capture an amd-s2idle report with the commit vs without 
the commit?  Share both.  This will help explain a few things.

https://pypi.org/project/amd-debug-tools/

Ideally please attach the reports to a bug either:

https://bugzilla.kernel.org/
or
https://gitlab.freedesktop.org/drm/amd/-/work_items

Thanks!
