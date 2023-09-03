Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B26C83F2C
	for <alsa-devel@archiver.kernel.org>; Sun,  3 Sep 2023 19:44:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 294B23E8;
	Sun,  3 Sep 2023 21:43:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 294B23E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693770252;
	bh=yHRfrQqW6DWlTtxYiXB/iyde1f7Oa7TZKGs6JxFZJuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=k2ac83Mp02BF+IJ6u0mTJtihsasXBCblZmmeDjJhW5Oc8E26vzRc858QWsI+T8DxH
	 HKGuhUemEg6ZT5kpsuuUhhf5Ee1gZ5YLXaxf59DfqE8hTtbYFTuqjc40DbScyp+zND
	 TwCAQoF9HzgOSd51dZWSc1PbsS/LjN5PXIlP5oeY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C12BF80549; Sun,  3 Sep 2023 21:43:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E631F8047D;
	Sun,  3 Sep 2023 21:43:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06E54F8047D; Sun,  3 Sep 2023 21:43:08 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr
 [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D339F800F5
	for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2023 21:42:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D339F800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256
 header.s=t20230301 header.b=IwniJbf3
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id csznqEPtQewmQcsznq9Uxm; Sun, 03 Sep 2023 21:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1693770178;
	bh=GE0Tfzjpz86rKqx1XQM/i0q6J5a2RTGmwR3F95mdOYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IwniJbf3qMuGb2ARD6r1f7GT0OL6OG8OZ05zadRj8NGirUDd/LVZKeZaYIvY2ZyWn
	 G7ojOq6ps7KJuSVuuAt36R9tz1riTb4ICbEn06SjSRDsB7KgDETBOJUlqzffkWVgPn
	 28tsZdlhscrsWqNmRV83IRqjBCCgNdsqCYPnrrd3fLVZnkKm67qO6NYCpv2SJKdNyN
	 +gk1X8g/OTCsNvV5fOn3fPftCVAGAPnZhllEq9LWMmxLwScCLHtRA5HjtZJDJzjtUq
	 Z4nTBiLpIa4cqUQk9AjmRu253i7OJd4rtqunF5v0czGxh/LEiEFyZrsr/PaFGJFS0L
	 bekWIOkJ1FTBg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 21:42:58 +0200
X-ME-IP: 86.243.2.178
Message-ID: <a0387d53-a08f-5e0c-c3a5-681ab5545150@wanadoo.fr>
Date: Sun, 3 Sep 2023 21:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: usb-audio: Fix a potential memory leak in
 scarlett2_init_notify()
Content-Language: fr, en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 alsa-devel@alsa-project.org
References: 
 <fc275ed315b9157952dcf2744ee7bdb78defdb5f.1693746347.git.christophe.jaillet@wanadoo.fr>
 <871qffmj2d.wl-tiwai@suse.de>
 <8cde2320-517f-3a38-8c3f-f807791c6c52@wanadoo.fr>
 <87sf7vkybk.wl-tiwai@suse.de>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <87sf7vkybk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UQFJTRDTRJ3G5XSSSHJM4GRHUIKWBU6J
X-Message-ID-Hash: UQFJTRDTRJ3G5XSSSHJM4GRHUIKWBU6J
X-MailFrom: christophe.jaillet@wanadoo.fr
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UQFJTRDTRJ3G5XSSSHJM4GRHUIKWBU6J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Le 03/09/2023 à 18:37, Takashi Iwai a écrit :
> On Sun, 03 Sep 2023 17:04:47 +0200,
...

> Indeed.  The fix would be rather a oneliner like below, though:

Looks much better than mine :)

I let you send the patch, it is your solution.



Just for my understanding, how is snd_ump_ops used, especially .open?
I've not been able to figure out where it was called.

In alloc_midi_urbs(), if usb_alloc_coherent() fails, then 
ctx->urb->transfer_buffer could be anything because usb_fill_xxx_urb() 
is not called.
So there could be an edge case where your fix could still be incomplete.

For the start_input_streams() caller, this is fine, because the 
corresponding memory is kzalloc()'ed in start_input_streams() at some 
point, but I've not been able to check for snd_usb_midi_v2_open().

CJ

> 
> --- a/sound/usb/midi2.c
> +++ b/sound/usb/midi2.c
> @@ -265,7 +265,7 @@ static void free_midi_urbs(struct snd_usb_midi2_endpoint *ep)
>   
>   	if (!ep)
>   		return;
> -	for (i = 0; i < ep->num_urbs; ++i) {
> +	for (i = 0; i < NUM_URBS; ++i) {
>   		ctx = &ep->urbs[i];
>   		if (!ctx->urb)
>   			break;
> 
> That was the intended behavior of free_midi_urbs().
> 
> 
> Takashi
> 

