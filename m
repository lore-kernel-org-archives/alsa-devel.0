Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EADEC7EE29
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jun 2023 13:25:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 465AEAE8;
	Tue, 13 Jun 2023 15:24:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 465AEAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686662716;
	bh=9j6+21qxfghNTh8H6Uo20cvp0i4uRCoBz58+Pij1eB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VyHNHD/Hni70+jyNchZPukXZ/Vz9kYtZl7y4FnL4tJoH6E2HOX6YcCs0HL82XL4xH
	 4Kh4uMrqD5tSlaFhu7SviK1Z0qUAbsL7zlPlS8TO6d3mfduLlqK31jHn6KX6LQLPSr
	 17hKCyCKeDS5mspy8g1w8Wqqnkt5PDqv9hBcs7F0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28FAEF80533; Tue, 13 Jun 2023 15:24:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B26CDF80149;
	Tue, 13 Jun 2023 15:24:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3662F80149; Tue, 13 Jun 2023 15:24:00 +0200 (CEST)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 74545F800ED
	for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2023 15:23:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74545F800ED
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1q9401-00032v-61; Tue, 13 Jun 2023 15:23:53 +0200
Message-ID: <8f00c62e-7e9b-4b5b-c1a3-2562117795e9@leemhuis.info>
Date: Tue, 13 Jun 2023 15:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ASoC: tegra: Fix Master Volume Control
Content-Language: en-US, de-DE
To: Jon Hunter <jonathanh@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>,
 Sameer Pujar <spujar@nvidia.com>
Cc: alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230613093453.13927-1-jonathanh@nvidia.com>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230613093453.13927-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: 
 webpack.hosteurope.de;regressions@leemhuis.info;1686662637;ee109bf9;
X-HE-SMSGID: 1q9401-00032v-61
Message-ID-Hash: DZ4CDHFR5MDW3M4BUENDMU7AZ4EAZKQB
X-Message-ID-Hash: DZ4CDHFR5MDW3M4BUENDMU7AZ4EAZKQB
X-MailFrom: regressions@leemhuis.info
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DZ4CDHFR5MDW3M4BUENDMU7AZ4EAZKQB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 13.06.23 11:34, Jon Hunter wrote:
> Commit 3ed2b549b39f ("ALSA: pcm: fix wait_time calculations") corrected
> the PCM wait_time calculations and in doing so reduced the calculated
> wait_time. This exposed an issue with the Tegra Master Volume Control
> (MVC) device where the reduced wait_time caused the MVC to fail. For now
> fix this by setting the default wait_time for Tegra to be 500ms.
> 
> Fixes: 3ed2b549b39f ("ALSA: pcm: fix wait_time calculations")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 3ed2b549b39f
#regzbot title ASoC: tegra: Master Volume Control broken
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
