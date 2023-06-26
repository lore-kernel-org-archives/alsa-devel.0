Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831A0EB64D7
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jun 2023 07:58:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CE9183B;
	Mon, 26 Jun 2023 09:57:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CE9183B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687766294;
	bh=HJbGTjhSwdqzawzpBBmb2SkqBiQFF47bMKxU6+P2YGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GnStM/WPmllK6tPo86iLlCn3wn0BfVvf8mIR+K+FhfuREy3h/uojAe3DRhAPRurOa
	 XH2cbFxGD9hN5mrAlatpwpQ5EPzYIBTLbZZiktr1DEcibDX8aoe7yXa/vuOzos1AD8
	 kFe3+70P6Hg/NyFkRa1tPGB/Q5FrF5wSa+Z6sPOw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C688F80535; Mon, 26 Jun 2023 09:57:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45466F80246;
	Mon, 26 Jun 2023 09:57:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9FEFF80246; Mon, 26 Jun 2023 09:56:58 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2DBD4F80169
	for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2023 09:56:54 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B87A81E24;
	Mon, 26 Jun 2023 09:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B87A81E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1687766213; bh=IeCgRQNxrQ3a1y0bp9EimGNrftDyKTpDVhxmrEZe8Vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fpj8S7Js7MWRLdA0pP1JWmLs1UlFE7sg15ctxSBVvR9P3PBqF6uoj2NaScJLWKRum
	 P7lDcTvBWlAIXfL/SurcqZCYeHQ+C45RaGkJb7hF4Z8Yc6VMLaCQIsPP0+kGf/XsRS
	 e9xjePgclLpTi+P5j1FL5LlAn+Sm+Ww6Km2Mzfw0=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 26 Jun 2023 09:56:47 +0200 (CEST)
Message-ID: <4d0931bf-b356-6969-5aaf-b663d7f2b21a@perex.cz>
Date: Mon, 26 Jun 2023 09:56:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [BUG] ALSA: core: pcm_memory: a possible data race in
 do_alloc_pages()
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, Tuo Li <islituo@gmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org,
 Linux Kernel <linux-kernel@vger.kernel.org>, baijiaju1990@outlook.com
References: 
 <CADm8Tek6t0WedK+3Y6rbE5YEt19tML8BUL45N2ji4ZAz1KcN_A@mail.gmail.com>
 <877crqwvi1.wl-tiwai@suse.de>
 <CADm8Tenfy8joto5WLCqQWjfT8WimsbJgOss0hJe-ciyDRMrSXw@mail.gmail.com>
 <871qhywucj.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <871qhywucj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: KAWDQQLMSZLFJ35KD4U4ERQVKWVVJFAJ
X-Message-ID-Hash: KAWDQQLMSZLFJ35KD4U4ERQVKWVVJFAJ
X-MailFrom: perex@perex.cz
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KAWDQQLMSZLFJ35KD4U4ERQVKWVVJFAJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 26. 06. 23 9:33, Takashi Iwai wrote:
> On Mon, 26 Jun 2023 09:31:18 +0200,
> Tuo Li wrote:
>>
>>
>> Hello,
>>
>> Thank you for your reply!
> 
> FWIW, the simplest fix would be something like below, just extending
> the mutex coverage.  But it'll serialize the all calls, so it might
> influence on the performance, while it's the safest way.

It may be better to update total_pcm_alloc_bytes before 
snd_dma_alloc_dir_pages() call and decrease this value when allocation fails 
to allow parallel allocations. Then the mutex can be held only for the 
total_pcm_alloc_bytes variable update.

Eventually, total_pcm_alloc_bytes may be atomic.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

