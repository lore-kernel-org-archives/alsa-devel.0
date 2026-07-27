Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF07C54F51
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:59:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA5EC60232;
	Wed, 29 Jul 2026 10:58:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA5EC60232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785315549;
	bh=0RB8M3MC/b4jokRNNWex9mQt0HjF+6onHpRwDwd9syA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=M89KOkHlvjcoCwet0PwcPH1PdoFfXFrNDfYCCHqrhkdxQgFqHaM6/tVtuJ+WxEbYT
	 9f2L2oxtDtvb1Fwtsdu1xsAFeBY5IqWm1R2tcX7RdP31IEliouxXWNZEibqB8nRd2J
	 REJFW+x6Ns1EAVrLW26CpAyHxEx2LNzeWfO495Ls=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA518F8068E; Wed, 29 Jul 2026 10:57:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CC2D3F8059F;
	Wed, 29 Jul 2026 10:57:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42EFCF80526; Mon, 27 Jul 2026 18:45:17 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785170716;
	b=EFD7lmiKOaUWHFKSPRqkSj4uafwY8g8KhU/W2GJh8tzymenzAXonEh7tXkcHhIZsfz7s
	 QHqOkxfINVN5hmA/wxswdz8xjYWsvjy7L+2OCKzc4yMK/CvwfR7DWiOnst9xFNY/6ixV4
	 aL/8V4Ah8Ez/SJ6MbDWyHcteGzLmpOEFBOw0ctJU4HpnVWSFr4JPIVZcXbauoosQl0Vkt
	 p6S521JVJ9TYdpd4WF5IkHn8Lghlqb8OvRP5tqpRiE4ZFWPW0ZJJtWKLQF9buV8BXKC5Y
	 ErvJwOyzzlu8ydncDmjX+MfVez2H+S9rooSy8g5Ms53Llkb9OST9K9sz8WCDLmYBoNQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785170716;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=0RB8M3MC/b4jokRNNWex9mQt0HjF+6onHpRwDwd9syA=;
	b=YBVrs0xtLCrDzCzzomwr9lNLH6sRHSgp75qR4365yfsDWN0ykC2t1vS2lRMD5TS0J3G1
	 o2UuJfRO4lM3jC6t/cuR8cTjjFqu21eTJJf55NDdVZdBVwsZuxduR0hlDljTPGY98nLJX
	 Hib08xD5e3KePVKfUlUPJxO57q3TIQ5L5QCs7Ba3N8vpxnJYDYIWS+cmPtZnU/kSGPB0r
	 iBdj2SE4hi1VAw1RJDnWPximYPwzkdR1Dqh/Y5PDa0GFlRTzVlRmgfk5t8LNx0mTAooHe
	 aPF9l+XSv+kb7qfnW6lFUtNqqA7Qtc6EDpRx+GV6t0z2dwEjnDDGCK6W3C/RHUq8N+g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=odywitLI;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3AD6EF800BA
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2026 18:45:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AD6EF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=odywitLI
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EED6440ACC;
	Mon, 27 Jul 2026 16:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8571F00A3A;
	Mon, 27 Jul 2026 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785170711;
	bh=TKOOM86XxKOCiHijm3BsfizzFZ4rMc0SXPRk5xFvoJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=odywitLI+s0//F/MiCmIGi7NL1j8DHKu/J0GjlK6R/FNhPfe2I17CZOK76p8THDoq
	 s1IR7gy6eGUJiHM5UZJ49gjATegoakcBPyAAUyux5a1ar/1UEZ+jLYug2sK/O5WRIL
	 6/KPhDm6ogh+kxrohYvquZiOcJnlQ8xWa6esuWZYUpyujK7/H5ipQPsnL6eMA5FUd/
	 f/M6TjQ7j2lJ1jmsQSxK+mIhUzmEO3ptkSgRASBAvPMU7ZxLqy8JaAUlUI86V33CDC
	 9lyDyJVcuQVFQ2b11gtLEu/jAG9//BKZP/iNuvcgHRlu5AumgtxPw3GV6jZLty18P8
	 RxlhK+ml1hKTQ==
Message-ID: <97a17ad9-3e2c-4839-a28e-51706f321414@kernel.org>
Date: Mon, 27 Jul 2026 11:45:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUkVHUkVTU0lPTl0gc25kX2hkYV9p?=
 =?UTF-8?Q?ntel=3A_15s_audio_resume_delay_on_AMD_Conexant_SN6140?=
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
 <f8dd5c7c-7088-4860-a00f-2e63c87c78c9@kernel.org>
 <MWHPR04MB102980F54F9465597DC602D4792CD2@MWHPR04MB10298.namprd04.prod.outlook.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: 
 <MWHPR04MB102980F54F9465597DC602D4792CD2@MWHPR04MB10298.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: JT2AIZCOYKYZI5AZ4L6OTQSIFP77UOOE
X-Message-ID-Hash: JT2AIZCOYKYZI5AZ4L6OTQSIFP77UOOE
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:57:48 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JT2AIZCOYKYZI5AZ4L6OTQSIFP77UOOE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 7/25/26 20:07, Demon Player wrote:
> 
> Hi Mario,
> 
> As requested, I have uploaded the amd-s2idle reports to a GitLab work item:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5529
> 
> Please let me know if you need anything else.
> 

There are going to be more artifacts needed.  We'll continue the triage 
on that bug tracker.

Thanks,
