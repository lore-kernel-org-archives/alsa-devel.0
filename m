Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368C9CA5FA2
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:31:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38923601E6;
	Mon, 28 Sep 2026 14:31:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38923601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790598707;
	bh=Vuxtkf7j4I8md8eMmltEaduv+GAv8YOsB53uEg2AVdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EzOil0sYepvK5Rmn6Urbf3QfHJDs8z7kDzJbUQFCIc1uXwbL4UMFi1J29CAPiAqYl
	 TaUyjW2RQ1YWLHnQUGTeOVjcr9si8Z6c+mYPoquL6W7RL1tIO2dSRZAP1fxHonM6rp
	 StI8BzqyY/Mem7n5FT2gGIu8tdCQfgetIkkSGbNs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECAAEF805FF; Mon, 28 Sep 2026 14:31:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9901F805FF;
	Mon, 28 Sep 2026 14:31:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 736CFF80525; Mon, 28 Sep 2026 14:31:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790598665;
	b=pdEyhX25IqLnSH0fAgY7YAgbQcFUFLnABpigexMaZLXZyPWqsnBbhymX4nBRNALPQ9QU
	 lJ1T72LZqyYKEfIDk301CRLf1jfNZbgR/3mKoVFCXRtI4OJS7pbLajY2xTOZ3Q+U+A2OV
	 6jQ7WwU41jrkbjMM2ui2L5bIh2itNGP4rQrZJk2KTnldpXqhO88rbey8bF/yDJGNl1jYI
	 dUyQkV6+srRnN7AtbkmN/ZdjnWtei0na14X8MPIU/ZXKpbZnoy4dBD88e6MjiGVmWe+kO
	 v6IKAhTxNJT/9bDtz2GlhFsRSfxFuFiXkI2tiVl3xBlJ8IAKYnKXqZA9BeQleIXy92Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790598665;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=Vuxtkf7j4I8md8eMmltEaduv+GAv8YOsB53uEg2AVdY=;
	b=sNt4ivd4neXBtBNdBtfbTyUNJAt4rTiv0rsKNDrzoJXJ8BupuhXoFPbGyzrdTcAzi70f
	 jAIu47cjDLzAwEixBCx55DjPO24atld9MaqR/1/tmg0a2p1r+2+z6dw4FcHo8lyWYpQPS
	 Jfs0r7l/Sif1Oh+B8/7EIIpHB/K0zuym3JnondrReCFsBGCXjr7WS6H3bz0C2llGChA8Y
	 ufF2sPZIC+CR0eLPI+ucQPfNif4m6W+8fiS9Ux0JPDbONBAhbfK66Sw9b2mFGsDPTgQDS
	 pyofYfbF+042kZrFX+ghG1e6LzRY6OCWwPW3Bbdk7o2OBOm2GgLpP5j9mWxFKgaBoxw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xB15uWS+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="/JqPuooI";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=TQhfhJX2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZjT9bxuh;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 304FEF8026A
	for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2026 14:31:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 304FEF8026A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xB15uWS+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=/JqPuooI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=TQhfhJX2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZjT9bxuh
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CCEE1FA8E;
	Mon, 28 Sep 2026 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790598663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3c2n8FaJjevpcMCkhdAqcmNXsq3K09j/1xS1+Ghg3g=;
	b=xB15uWS+MtYDUsiyL/ziS8sq37bsc0jJvgqnXK1bxWFVh9mCJyBWTGi3+muVCK+uJigBNm
	5nVAr8HGbzEYuzyO5z327onE5DjXay1kzhknox8+sPvHknOgepG8wujwJGeMlZy0I00/ib
	gsoOYMXtRbATIr7/bgq9PRQulgiYVgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790598663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3c2n8FaJjevpcMCkhdAqcmNXsq3K09j/1xS1+Ghg3g=;
	b=/JqPuooIg1aEpWBLtLUfnfUDPWS0ow5NHve+XAxSLi9F7aV/d6aEnfBOfTzG3XJl2xhxqq
	gB97ve6p9zysvbBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790598659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3c2n8FaJjevpcMCkhdAqcmNXsq3K09j/1xS1+Ghg3g=;
	b=TQhfhJX2SBRLQ5hdCv+bKD8EPwIMx3+9y4HXIlyhFpSlJRP1yL1rXuTY0ubeEdrkijsYzL
	Xta/iG8gyqeIEgRZStVOeTKDhTSChehxIWEf0kRLARB3uAahB7EOYPNPFGNofOrKRUvGvo
	EUnfmyOo0Ch6QvJ9v+PJ6j1qk2AWDgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790598659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3c2n8FaJjevpcMCkhdAqcmNXsq3K09j/1xS1+Ghg3g=;
	b=ZjT9bxuhJWYYB/5BiK8K6qlR/hQtAfkfC243fUhcsm54rf5WCcOSdJC2vcuAZ8LO5CPG4p
	BaIpETptm3zSGkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E14C4133F3;
	Mon, 28 Sep 2026 12:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h91rLAJeumpmfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 12:30:58 +0000
Date: Mon, 28 Sep 2026 14:30:58 +0200
Message-ID: <87eced5zi5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dany Patoine <dany_patoine@hotmail.com>
Cc: alsa-devel@alsa-project.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION 6.14 -> 7.0] ALSA snd-ctxfi: no PCM playback on
 Creative X-Fi Titanium HD (EMU20k2 / SB1270)
In-Reply-To: 
 <DM6PR02MB5433F3C2A156335B6ED47756EA8E2@DM6PR02MB5433.namprd02.prod.outlook.com>
References: 
 <DM6PR02MB5433F3C2A156335B6ED47756EA8E2@DM6PR02MB5433.namprd02.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[hotmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: 3HRKC2GZFYU5EKUWBLCCQSSOQRFMV4LK
X-Message-ID-Hash: 3HRKC2GZFYU5EKUWBLCCQSSOQRFMV4LK
X-MailFrom: tiwai@suse.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3HRKC2GZFYU5EKUWBLCCQSSOQRFMV4LK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 28 Sep 2026 01:51:04 +0200,
Dany Patoine wrote:
> 
> Hello,
> 
> I am reporting a playback regression in the snd-ctxfi driver affecting a
> Creative Sound Blaster X-Fi Titanium HD. The card works perfectly on kernel
> 6.14 but produces no audible PCM playback on kernel 7.0.
> 
> HARDWARE
> - Card:   Creative Sound Blaster X-Fi Titanium HD (model SB1270)
> - Chip:   EMU20k2 / CA20K2
> - PCI:    02:00.0 Audio device [0403]: Creative Labs EMU20k2
>           [Sound Blaster X-Fi Titanium Series] [1102:000b] (rev 03)
> - Driver: snd_ctxfi (with module option use_system_timer=1)
> - System: ASUS P8H67-M PRO, Intel Core i5-2400, x86_64
> 
> SOFTWARE
> - Distribution: Linux Mint 22.3 (Ubuntu 24.04 "noble" base)
> - Sound server: PipeWire + WirePlumber
> - WORKS:  kernel 6.14.0-37-generic  (Ubuntu HWE)
> - BROKEN: kernel 7.0.0-31-generic and 7.0.0-34-generic (Ubuntu HWE 7.0)
> 
> SYMPTOM
> On 7.0, PCM playback produces no audible output, through BOTH paths:
> 
>   (a) Direct ALSA, bypassing PipeWire:
>         speaker-test -D plughw:CARD=XFi,DEV=0 -c 2 -t sine -f 440
>       completes with exit code 0, but no sound is produced.
> 
>   (b) The normal PipeWire path (default sink = the X-Fi):
>       also completely silent.
> 
> Details of the failure mode:
>   - kernel 7.0.0-31: truncated / choppy fragments with use_system_timer=1,
>     and total silence with use_system_timer=0.
>   - kernel 7.0.0-34: total silence with use_system_timer=1.
>   - No xrun and no error is logged; playback appears to stall silently.
> 
> On kernel 6.14.0-37, the exact same commands and configuration
> (use_system_timer=1) produce clean, continuous audio.
> 
> RULED OUT (all verified while booted on the failing 7.0 kernel)
>   - Card detection: OK. snd_ctxfi loads without error; `aplay -l` lists
>     card "XFi [Creative X-Fi]" with all PCM devices (Front/WaveIn,
>     Surround, Center/LFE, Side, IEC958 Non-audio).
>   - Mixer / routing: Master 98%, PCM 100% (no playback mute), Front [on]
>     100%, "Analog Output" = Speakers. PipeWire's default sink is the X-Fi
>     at 94% and is not muted.
>   - use_system_timer: both values tested (0 and 1), neither gives
>     continuous sound on 7.0.
> 
> RELATION TO A KNOWN FIX
> This appears to be DISTINCT from the EMU20k2 regression fixed by commit
> e9418da50d9e ("ALSA: ctxfi: Limit PTP to a single page"): that issue only
> affected PulseAudio while direct ALSA (speaker-test) kept working. Here,
> direct ALSA is ALSO silent, so it looks like a different problem.
> 
> WHAT I CAN PROVIDE
> These kernels are Ubuntu-packaged, not vanilla mainline. On request I can:
>   - provide full dmesg from a 7.0 boot and `alsa-info.sh` output,
>   - test a vanilla mainline 7.0.x / 7.1.x kernel,
>   - test any candidate patch,
>   - perform a git bisect between 6.14 and 7.0 if that would help.

Could you verify the latest 7.3-rc5 kernel to see whether the
regression is still present at first?  If the bug is still there,
please go bisection.


thanks,

Takashi
