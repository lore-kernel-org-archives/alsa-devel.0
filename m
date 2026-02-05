Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06483ECD980
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:35:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 878F6601F1;
	Thu,  5 Feb 2026 16:35:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 878F6601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770305751;
	bh=dRc+JLQGih210Q0+nbXjpV+4Pn1T9oY6M4gWBoCnGm8=;
	h=Date:From:To:Subject:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Pr9qPAc0ubpk14TBQNY/DR3pmWqI4bJvL0kg6xCDZSEjdF2D+SbP2DJMhmPK3HOJE
	 Gvedh4tM5R1u0QsF+wzG2fx7fWHGD3fEUXjReySrJ44xXzJ3rE86SnOTG9O3bTRAvP
	 2JgK7NCmMnO1laPFfLC9ZfNeY9JhBd6nLdGHp2C8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5221EF805F2; Thu,  5 Feb 2026 16:35:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E308F805F6;
	Thu,  5 Feb 2026 16:35:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84237F8051E; Thu,  5 Feb 2026 16:34:31 +0100 (CET)
Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6C207F8016E
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2026 16:34:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C207F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=xwax.org header.i=@xwax.org header.a=rsa-sha256
 header.s=swing header.b=kaCGKDEf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
	s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:To:From:Date:Cc:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=Dw+c2RJZ8mrYjNeYPuJsnMqGbfA1432i+UK694t+3jQ=; b=kaCGK
	DEfbCtT9ju2jxWTGGPv8LWF6UjumErWdPTYeLuiLn0m4alxIN3tIk4bnkYskN0tRyq3rGbvCUmgCp
	TyMgZ4dtJ13JNEICuI/6ANujroxXuFGQUN/eog54sLPD50Ln35y8j2tCGheSSHrS4KUzlxX5C50jG
	vMnVNsIK633c=;
Received: from cpc93786-hari17-2-0-cust786.20-2.cable.virginm.net
 ([82.36.99.19] helo=stax)
	by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2 (FreeBSD))
	(envelope-from <mark@xwax.org>)
	id 1vo1N0-00000000Eyx-3mEJ
	for alsa-devel@alsa-project.org;
	Thu, 05 Feb 2026 15:34:14 +0000
Received: from localhost (stax.localdomain [local])
	by stax.localdomain (OpenSMTPD) with ESMTPA id 940d7208
	for <alsa-devel@alsa-project.org>;
	Thu, 5 Feb 2026 15:34:14 +0000 (UTC)
Date: Thu, 5 Feb 2026 15:34:14 +0000 (GMT)
From: Mark Hills <mark@xwax.org>
To: alsa-devel@alsa-project.org
Subject: Re: Can't resample into ALSA plugin
In-Reply-To: <b7b70838-2452-8481-e9ae-f9001ddaf74e@xwax.org>
Message-ID: <3ef6ee0a-ed02-0283-0e0e-d38eb02fcb63@xwax.org>
References: <b7b70838-2452-8481-e9ae-f9001ddaf74e@xwax.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID-Hash: H4BLYCTT7GHTFWWHMR6HIV7MY7JWKW2W
X-Message-ID-Hash: H4BLYCTT7GHTFWWHMR6HIV7MY7JWKW2W
X-MailFrom: mark@xwax.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H4BLYCTT7GHTFWWHMR6HIV7MY7JWKW2W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 11 Jan 2026, Mark Hills wrote:

> I've written an ALSA plugin (ioplug) of the form below.
>
> My plugin offers only S16, 48000Hz.
>
> I expected a "plug" device would take the application's request and
> resample to 48000Hz, but instead it fails:
>
>   $ aplay -D plug:mytest cd-audio.wav
>   Playing WAVE 'cd-audio.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>   aplay: set_params:1456: Unable to install hw params:
>   ACCESS:  RW_INTERLEAVED
>   FORMAT:  S16_LE
>   SUBFORMAT:  STD
[...]
>
> Modify the plugin 48000Hz to be 44100Hz and negotiation passes, so it
> suggests the rate is the problem (not some other parameter like period
> size)

Following up my own mail to help the others looking at these archives:

The root cause seems to be my plugin not offering 
SND_PCM_ACCESS_MMAP_INTERLEAVED, which I assume is required by the "plug" 
to do rate resampling and feed into it.

I couldn't find this in any documentation, searching or AI chat, and the 
ALSA code for negotiating the plug is non-trivial so perhaps someone has 
an explanation or rationale if it could fall into this for some other 
reason.

Here's the culprit code:

> SND_PCM_PLUGIN_DEFINE_FUNC(mytest)
> {
>       struct state *s;
>       snd_pcm_ioplug_t *io;
>       unsigned access = SND_PCM_ACCESS_RW_INTERLEAVED;
[...]
>       snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS, 1, &access);

Many thanks,

-- 
Mark
