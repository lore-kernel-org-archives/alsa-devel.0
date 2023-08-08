Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C2DC04A6A
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 17:56:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B601F829;
	Tue,  8 Aug 2023 19:55:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B601F829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691517363;
	bh=5Fu6qH9qKQ6+4wX2RsBXoK4UmvoTjpp3eRHoJPK5zB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fjLo8P++xnww1sNPgEE4x7QfyAFLYx8U7yD0ga12CQF5z/gwMSL7YmkRajk+L7vag
	 TjdyTmv9C3Kvpf0yqaHoVCL+bkEJDdATtUf8mVkqC6YJMDlo2n7JNxbhxJAHHe1WCE
	 k8LyKEfxAd+VgDfh+csjqqCa/zu6+hPTLn72aoMM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BDA9F800B8; Tue,  8 Aug 2023 19:55:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A215F80154;
	Tue,  8 Aug 2023 19:55:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1058FF80534; Tue,  8 Aug 2023 19:55:08 +0200 (CEST)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 370AAF800B8;
	Tue,  8 Aug 2023 19:54:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 370AAF800B8
Received: from [185.238.219.14] (helo=[192.168.44.45]); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qTQv0-0004FA-Vs; Tue, 08 Aug 2023 19:54:55 +0200
Message-ID: <47437162-e1bd-58c1-9f34-ca4b661c3e34@leemhuis.info>
Date: Tue, 8 Aug 2023 19:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression fix not progressing towards mainline/stable
Content-Language: en-US, de-DE
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Cc: sound-open-firmware@alsa-project.org, LKML
 <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Alsa-devel <alsa-devel@alsa-project.org>
References: <661fcece-a83c-cb24-1b37-5d8693b1fb94@leemhuis.info>
 <98188012-8e07-4bb1-be1c-04d6c0f5260a@linux.intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <98188012-8e07-4bb1-be1c-04d6c0f5260a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: 
 webpack.hosteurope.de;regressions@leemhuis.info;1691517301;264282f5;
X-HE-SMSGID: 1qTQv0-0004FA-Vs
Message-ID-Hash: WZK4HQCXC7HWSCKFLYHCIFVNE3ZQGUC3
X-Message-ID-Hash: WZK4HQCXC7HWSCKFLYHCIFVNE3ZQGUC3
X-MailFrom: regressions@leemhuis.info
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WZK4HQCXC7HWSCKFLYHCIFVNE3ZQGUC3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 08.08.23 13:03, Péter Ujfalusi wrote:
> On 08/08/2023 09:10, Thorsten Leemhuis wrote:
>>
>> I'm talking about about the fix "ASoC: SOF: intel: hda: Clean up link
>> DMA for IPC3 during stop" for this ticket:
>> https://github.com/thesofproject/linux/issues/4455
>>
>> Two more tickets about it:
>> https://github.com/thesofproject/linux/issues/4482
>> https://bugzilla.kernel.org/show_bug.cgi?id=217673
>>
>> It seems the fix is ready and reviewed for two weeks now,  [...]
>
> We take regressions (and user reports) seriously and trying our best to
> provide fixes asap.
> We do prioritize bug fixes over features but in this case for some
> reason the review process took longer than it usually does and the patch
> has not been sent upstream. [...]

Happens, thx for taking care of it!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
