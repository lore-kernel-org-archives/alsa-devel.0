Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08D8C982D7
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Sep 2026 15:03:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1174860204;
	Sat, 19 Sep 2026 17:03:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1174860204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789830222;
	bh=heGF8PDSMDjoXy6QWIqmvfwQc1QxCtJrM7caSutJZTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=scmWe/rVa3FJij6zYxrm420yO0bpXQ5Ez8yqgOgxZSuo/S3ddAMnqGnyyJsaCLmSV
	 hRnV4+SpfTtlJzuDxjLD4IVzWJeBl5dsYRMHKrsKbJcL08LO4tvjiDoy14XHW+lu5g
	 4Y4yA8YPyAao512QKJ79wQ5778inBxQMJmT410E0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1645F805FD; Sat, 19 Sep 2026 17:03:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B38DF80602;
	Sat, 19 Sep 2026 17:03:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D77B6F80557; Sat, 19 Sep 2026 17:03:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789830178;
	b=e/UL9oDZsrGHo5xPppgsDdreEWFCNW4CIQwro+WkBSzp8RQNAHh8cL9rugMVKxsPeqMk
	 bpYBems2Lp7tiHDQdGq3qnhfvdOPgC6G+g1G/LY7yD6hvOKezUXUbvZ05EAUbncI21pMY
	 sYtWdu56IOCTASkc2mQq+LuBAYYX4Ti+322Ly8TFMzydTHSgBCsW4AuTB5HtgwIrD13/T
	 nyOqxH4EngIVOjf8ZqnlfpwKVX7Nhj9wHPudoEtdPbPLdB+hoaOUikbrlYelfMEjhoEXh
	 SOxmgEzuE2QaWRvelVIR1EVHoCdT6e3/dlpXCN3573NwNdLzhA96GNdsoJ3I/6aZP8Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789830178;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=heGF8PDSMDjoXy6QWIqmvfwQc1QxCtJrM7caSutJZTk=;
	b=sDlD3ZFMsj3G9TAPsseSWYRMRqedNQQktkJMdzBwCbTM4tShEyblfb7vsineJ4QWWq2D
	 Ct6gRtDn1BjTbbWznC4X/LCgBUeNAPbvlyH9WBa9+aA7Jz+Y88/hDvhwAda33eW6AcHMS
	 OOrLoFwN0knjsROhR3VVWAjd0WI4jhTzDzsWrUjG3oalcx1ONuy3YNSAJRqvufdLN99Io
	 wDfTO/J3pQp/ZqEWi6EIAQSdbXNUQqEE6qLZr2BI/cZvgImXBprEEfVeTsT5+T2W1opyZ
	 MyDd62rJFmVVeg+vQ7Ky6KycrX18rieAaS08IrXgWvNzd2bIARJx7qevj2ctam0D2CA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6D6AEF80448
	for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2026 17:02:57 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id DCEB241020;
	Sat, 19 Sep 2026 17:02:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz DCEB241020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1789830176; bh=4MdakDMFxO2de9lb84IBpqhPlToDwNunJMPLSqZx56s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LOGe5RGgPr6i65iYjAxyG1rnF1oP/NG6qjUdHKoj2vIzt0TJq/TKB+aAQVKthB/7d
	 65JUx4sLU7Me2KVUG/BR7LgRVggTiaMsX0BX7JirjBuX1sPhaUwCZ9bTrTMzuLDyKa
	 u3n34yDQpRvBBGCKRL9QNCzeUz87hbAo/PXzug5g=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Sat, 19 Sep 2026 17:02:52 +0200 (CEST)
Message-ID: <f3961c4b-3aba-46b3-844b-0fcd3ad9ce73@perex.cz>
Date: Sat, 19 Sep 2026 17:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alsa-lib: Revert "A try to fix one rouding problem in
 refine"
To: George Matsumura <gorg@gorgnet.net>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
References: <20260919072437.ecc0cf4d5c702127dc77ac0e@gorgnet.net>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <20260919072437.ecc0cf4d5c702127dc77ac0e@gorgnet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: BJXWVZRCQQNPL2CMYMD6N2QXEKESGE52
X-Message-ID-Hash: BJXWVZRCQQNPL2CMYMD6N2QXEKESGE52
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BJXWVZRCQQNPL2CMYMD6N2QXEKESGE52/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 9/19/26 16:24, George Matsumura wrote:
> Greetings,
> 
> When attempting to use ALSA directly (without any sound server such as
> pulseaudio) with a configuration using the plug plugin, using parameters
> where sample rate resampling is necessary, snd_pcm_hw_params or
> snd_pcm_set_params may fail, returning EINVAL.
> 
> This is because refinement rule 7 in pcm_params.c requires the
> period_time to remain an interval rather than a single value if
> period_time does not perfectly divide period_size. The code that was
> introduced with this change converts the interval to one of its extrema,
> leading to -EINVAL, indicating an empty inteval, being returned by
> snd_pcm_hw_rule_mulkdiv.
> 
> I encountered this when attempting to play 44100 Hz audio with firefox
> and deadbeef in a configuration that required the plug plugin to
> resample the audio to 48000 Hz for a slave dmix plugin. The follwing
> debug output (enabled with RULES_DEBUG in pcm_params.c) was produced at
> the end of configuration:

Can you replicate this issue with aplay (use similar stream parameters as 
firefox)? Please, show the exact command to reproduce this.

Also, only "if block" should be eventually reverted. The debug prints should 
be preserved.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat
