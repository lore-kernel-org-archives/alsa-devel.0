Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ACF1061B00
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:28:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6FBB601F2;
	Mon, 30 Mar 2026 16:28:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6FBB601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774880925;
	bh=3Qv5nmjoSmZ0pp0dE0J1c+PXbYOXg5kKCWvdELQIZR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QXrVEQFzkz/rWFA1zTYq3rY/lNpc8K/WqnNqxbIkO31+KOI9/0SJm46Q+M0bu0HLp
	 krpWXUmve09gRfC6Wok8uxr0lEOGhqCCiBKwDE8d5rblIJXhQy502s+C1QQM7fDOqA
	 itjnIOoiPd0SYIxlCmsDpHltI2ACWugsb9+kWqNA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82892F805F5; Mon, 30 Mar 2026 16:28:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C87A9F805F2;
	Mon, 30 Mar 2026 16:28:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E653DF8052D; Mon, 30 Mar 2026 16:28:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8C0F2F80087
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 16:27:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C0F2F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=KJj5/2ZS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gp4BPisH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=KJj5/2ZS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gp4BPisH
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 384FA4D21A;
	Mon, 30 Mar 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774880876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFNaZ8U6ldqxbl+/RxTw/4opCLZ+TIRBM2lsFmFUkEQ=;
	b=KJj5/2ZSlyuMBELJ4J0CzrBcSqNcmZv5tVRhULupEoJAkP62J0vMXy1cMGba6tTOyy7WtW
	gTt/Q8Jzpxuau4zloVJfrai0k2il5fHbQ9aHMZZr0mNZ9UPyyCBw8U1Ca4m4RzeYPYyBPV
	R5WGY5VhpFz1U7Wa7HC4CeszM4YGLUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774880876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFNaZ8U6ldqxbl+/RxTw/4opCLZ+TIRBM2lsFmFUkEQ=;
	b=gp4BPisHLUurSGFdU94vebFNbHHxJPVonCdYI1alBX0HzYAeTIK7j01Lcw5ApkaZ5DWNDt
	B3nes9A29rYuRRAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="KJj5/2ZS";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gp4BPisH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774880876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFNaZ8U6ldqxbl+/RxTw/4opCLZ+TIRBM2lsFmFUkEQ=;
	b=KJj5/2ZSlyuMBELJ4J0CzrBcSqNcmZv5tVRhULupEoJAkP62J0vMXy1cMGba6tTOyy7WtW
	gTt/Q8Jzpxuau4zloVJfrai0k2il5fHbQ9aHMZZr0mNZ9UPyyCBw8U1Ca4m4RzeYPYyBPV
	R5WGY5VhpFz1U7Wa7HC4CeszM4YGLUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774880876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFNaZ8U6ldqxbl+/RxTw/4opCLZ+TIRBM2lsFmFUkEQ=;
	b=gp4BPisHLUurSGFdU94vebFNbHHxJPVonCdYI1alBX0HzYAeTIK7j01Lcw5ApkaZ5DWNDt
	B3nes9A29rYuRRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB9AC4A0A2;
	Mon, 30 Mar 2026 14:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r1hhMGuIymmWWQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Mar 2026 14:27:55 +0000
Date: Mon, 30 Mar 2026 16:27:55 +0200
Message-ID: <87se9htms4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Linux-ALSA <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	arun@asymptotic.io,
	wim.taymans@gmail.com
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
In-Reply-To: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,kernel.org,linux.intel.com,alsa-project.org,vger.kernel.org,asymptotic.io,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 384FA4D21A
Message-ID-Hash: VPAOEAWYEEQCZK6UHIDFJ7ZVSSFKOWDA
X-Message-ID-Hash: VPAOEAWYEEQCZK6UHIDFJ7ZVSSFKOWDA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VPAOEAWYEEQCZK6UHIDFJ7ZVSSFKOWDA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 23 Mar 2026 14:34:16 +0100,
Péter Ujfalusi wrote:
> 
> Hi,
> 
> for years the discussion around jumpy, bursty DMA have been popping up
> and we always concluded that we are missing a good definition and agreed
> way between kernel and user space to handle this.
> 
> In ALSA it is expected that the DMA (hw_ptr) moves in steady small
> steps. There is a BATCH mode which tells that the DMA cannot report sub
> period size position, progression.
> The DMA bursting fits neither of this, it moves in bigger jumps (bursts)
> and it can as well can report position in byte level.
> 
> Typically these systems have DSP which can consumes data in various
> chunks, making the hw_ptr to jump. Over time the hw_ptr do move at the
> sampling rate, but when zooming in we can see:
> initial jump of X frames, hw_ptr stays static for about ~X frame worth
> of time then the hw_ptr jumps again ahead of X frames, and again, hw_ptr
> stops, ...
> 
> This can be a problem for user space which wants to write samples as
> close to hw_ptr as possible since if it is not aware of the bursty-DMA
> than it is possible that a burst will jump over the sw_ptr, causing xrun.
> 
> I was looking at what, how and where we should add this information in
> kernel and to take it in use by user space when I stumbled across the
> 'fifo_size' of hw_params struct.
> 
> It is only set by a few drivers:
> sound/arm/aaci.c
> sound/arm/pxa2xx-pcm-lib.c
> sound/soc/renesas/dma-sh7760.c
> sound/soc/starfive/jh7110_tdm.c
> sound/soc/tegra/tegra_pcm.c
> sound/soc/xtensa/xtfpga-i2s.c
> sound/usb/misc/ua101.c
> sound/x86/intel_hdmi_audio.c
> 
> It's definition is awkwardly a bit different in kernel and alsa-lib:
> in kernel it can be in bytes or frames, but in user space it is always
> in frames (snd_pcm_hw_params_get_fifo_size).
> 
> So far I could not find evidence that this is in active use by user
> space. Not used in alsa-utils, pipewire, pulseaudio at least and web
> search came back empty handed as well.
> 
> My proposal thus is to re-use, re-define extend the fifo_size as and
> indication that the hw_ptr _can_ jump at least fifo_size number of
> frames so applications must take this into account when doing direct
> update in ALSA buffer for low latency.
> 
> Or should we add a new member (carved out from the reserved section of
> hw_params struct) specifically for this purpose, like dma_burst_size,
> which likely going to be equal to fifo_size if both is filled by the driver.
> 
> Or a new flag (SNDRV_PCM_INFO_) that PCM devices can use to indicate
> that the DMA is bursting and in that case the fifo_size holds the number
> of frames that it is expected to jump.
> But we are slowly running out of bits and I'm not sure if it is a good
> idea to dual use in kernel internal bits for user ABI
> (SNDRV_PCM_INFO_DRAIN_TRIGGER, SNDRV_PCM_INFO_FIFO_IN_FRAMES)
> 
> https://github.com/thesofproject/linux/issues/5313
> https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4489

Sorry to be late in the game as I was off in the last weeks, and
slowly catching up.  So, I'm reading this thread from the beginning,
and wondering what is needed from user-space API POV.

First off, we do already have a way to report a fine-grained playback
pointer as "delay" even in jumpy hw_ptr updates as long as the driver
supports it; e.g. a few drivers for hardware with packet-based
transfers like USB-audio support that mode.  Doesn't it suffice for
your need?

And, if a more different parameter is required and defined, how an
application can use it?  An application can read/write PCM parameters,
write PCM data (either via mmap or write/ioctl), and sleep/wakeup via
poll() -- basically that's all.  Would the new parameter influence on
the poll wakeup behavior?  Or who controls in which way?


thanks,

Takashi
