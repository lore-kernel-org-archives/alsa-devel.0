Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8DAC5AC80
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Aug 2026 10:31:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C462860200;
	Sun,  9 Aug 2026 12:31:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C462860200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786271472;
	bh=TBDabGiPe89/GXEvr1X0Zop4B48hsrGO3bWXoBsxL6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PC39Zx0I5gHGyrrFwYSq1qEPWXYC1XzPZ3hT3J1R1Ah8EiG/CV7Wz54183YHk9Fuu
	 HrFxkao1zkLHmn+kDNKyVZROBzrDk/N54ai12VmJjfNHSiDWjpWzBaWIdLGR3y2N4y
	 HV9isxowmyZE9PZyzB9Eg06AgiBujmGYAvCKEy48=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5392F805FA; Sun,  9 Aug 2026 12:30:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 388C7F805EC;
	Sun,  9 Aug 2026 12:30:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D11FF8026A; Sun,  9 Aug 2026 12:30:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786271427;
	b=IvUJWmKjrPaJu8xSZufTKdvUyGXfFNVUlnCpbhMoV8Gy3qZL9RH5fsHKCpZHCqeeglqE
	 /pwP1UiWv1L1kJpASinZ0AMgGOhrOULVMXjeOPZkEinkK7SrygTcPGYQ4IbT97wVSrmoG
	 ndnLU7YchGLf7OZ0DcTrnzwTFkhFOkyvM9ADe4+BChWbVb3GUXGtgI98bWltLdJYBGgsj
	 ZRGIQSr5VVZitCwNuSHk2BzWpzViDCn0J3cjjIeaArH+peiCpRJoMf4XV3IfGCerti6UK
	 8EWk4pJm4GC0sqGRZx/b3o7zEkgB2C+YEYZT0Omc78hje9b3EwhVB7HPZtRTsNjS4sg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786271427;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=TBDabGiPe89/GXEvr1X0Zop4B48hsrGO3bWXoBsxL6g=;
	b=QCkyPa6IUPJuH3PTSFUyIgOuZfv+eCXp2Dm2rIuI+cnbOKSurdDWjB8EdBYT2/am7rzU
	 vgcZwqeBFOlGFDSPneM6QHRB30Ze83CR7ZO6E8plVL83Wd5fjkAVfQRqvx5PitzQ0qgsn
	 e1Vn/hPV7ATdwrTdPHKzx1UY7Hl9VpErYHZOIe0MQfzSVE56C5ZVxMen0xgyggQ7Z3ZD+
	 K44bM3rNhFwzmV5HoMQlkVtq9k3MRYOszKJSa8DmZB99/tDx/fiDhSM1tV5e9DsbbhWU1
	 s7i/qy52Jf+gkwRnqbmVHVlw6Og+qU1XqtCaJ0zD6zfg6dJWLvFAi4005U0VB652SGA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="e5PCd/UE";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IFTinSrF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=0H2aa9ox;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=XoLYFUIX;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B109F80153
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 12:30:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B109F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=e5PCd/UE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IFTinSrF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=0H2aa9ox;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=XoLYFUIX
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 097CD8130E;
	Sun,  9 Aug 2026 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786271421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9UcVgACT95dfu7aNdTddGu4dM1yDgUtGS+iL8Ptzx0=;
	b=e5PCd/UESNGtH+kgxq7kJhL4vAPqGnoPIqBWXvWzGgWUCE4RaWmv7n/89mtLwcs7yDy1qd
	vow9Oi+reFUycD6npv2tHSLMVXgqYNpILykI9g/LyFUIZsyTf1+Wn7lR2FKpzeJnnWAZbY
	Z8iMA5jr6aA14GGFHIy65B0KEKBklRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786271421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9UcVgACT95dfu7aNdTddGu4dM1yDgUtGS+iL8Ptzx0=;
	b=IFTinSrFDW2VdZEcXjTn8DmWvIma2C+xByBpZy641pH3c1fAKjflBFQLoV7aawOqAp0Ph2
	2laChX2VbdfnnwCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786271417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9UcVgACT95dfu7aNdTddGu4dM1yDgUtGS+iL8Ptzx0=;
	b=0H2aa9oxl0S95TkBSGARHCGK9LBPZRY/cMpVFGb8aRfIsFICWXhHRwJguvcGuIxYY9MvnT
	ZRhEhBFwaH6E4zYOExDek30t0LHV/CwWJEUvZBOfXTVmclF9rQ+/vqUE5Ec3K1r9qehGVu
	qYlTxCaedH0Eo206GOqWUG5a00n4sM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786271417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9UcVgACT95dfu7aNdTddGu4dM1yDgUtGS+iL8Ptzx0=;
	b=XoLYFUIXfM4WP6VgI9KQLSoPwyWuehToUKsL+9aPhKqdfpkpatLKmA/bJwRIKCTk7SASuC
	vuXE2aknltn62tDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9057779B2;
	Sun,  9 Aug 2026 10:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AbJML7hWeGoLXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 09 Aug 2026 10:30:16 +0000
Date: Sun, 09 Aug 2026 12:30:16 +0200
Message-ID: <87fr0na8nb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: JJ Macalinao <jj@macalinao.org>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: usb-audio: add QUIRK_FLAG_ALWAYS_SET_RATE for
 Mackie DLZ Creator XS
In-Reply-To: <20260808172726.1107550-1-jj@macalinao.org>
References: <1c54822e-8147-4ffe-b033-aa4ab966c872@macalinao.org>
	<20260808172726.1107550-1-jj@macalinao.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: WQNB2DMMNZ2UBYGNWUUXP2NNOCUD7OZW
X-Message-ID-Hash: WQNB2DMMNZ2UBYGNWUUXP2NNOCUD7OZW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WQNB2DMMNZ2UBYGNWUUXP2NNOCUD7OZW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 08 Aug 2026 19:27:26 +0200,
JJ Macalinao wrote:
> 
> set_sample_rate_v2v3() returns early when the clock already reports the
> requested rate:
> 
> 	prev_rate = get_sample_rate_v2v3(chip, fmt->iface,
> 					 fmt->altsetting, clock);
> 	if (prev_rate == rate)
> 		goto validation;
> 
> A device advertising exactly one sample rate always takes this branch, so
> it never receives a SET_CUR for CS_SAM_FREQ_CONTROL at all.
> 
> The Mackie DLZ Creator XS (0a73:003a, 14 in / 4 out, 48 kHz only) requires
> that write.  Without it the device drops off the USB bus roughly 0.2-1.8 s
> into any stream, clearing its port CONNECTION bit; captured audio is
> byte-correct until the instant it vanishes.
> 
> USBPcap traces of a cold-booted device on Windows show SET_CUR 48000 issued
> unconditionally on every stream start, followed by clean streaming.  The
> device is otherwise driven with plain class-compliant UAC2 - it also works
> on iOS, which cannot load a vendor driver - so no vendor-specific
> initialization is involved.
> 
> The device is self-powered, so the resulting state survives a USB replug:
> initializing it on any host that issues the write leaves it working on
> Linux until it is power-cycled, which made the failure look intermittent.
> 
> Add a quirk flag rather than dropping the early exit, since the opposite
> requirement also exists in-tree: QUIRK_FLAG_FIXED_RATE suppresses rate
> setting for single-rate devices (JBL Quantum610/810).  The two behaviors
> are device-dependent and cannot both be the default.
> 
> A/B on identically cold-booted hardware, same kernel, same port, repeated
> twice:
> 
>   without the flag  device dropped after 5-6 s, then again after 3-4 s
>   with the flag     20 s playback followed by 20 s of 14-channel capture,
>                     960000 frames, zero re-enumerations
> 
> This change was developed with an AI coding assistant.  The assistant did
> the trace analysis that located the bug and wrote the patch and this
> changelog; the hardware testing, the cold-boot cycles and the decision to
> submit were the author's.  Several earlier hypotheses it proposed - URB
> queue depth, isochronous packet under-allocation, endpoint start ordering -
> were disproven by measurement before this one.
> 
> The bug was located with usbmon on Linux and USBPcap on Windows, by
> diffing an enumeration capture of a cold-booted device on each host.
> Verified on physical hardware by the A/B above.
> 
> Assisted-by: Claude-Code:claude-opus-5
> Signed-off-by: JJ Macalinao <jj@macalinao.org>
> ---
> v2: skip the GET_CUR entirely when the flag is set, per Takashi's review,
>     rather than issuing it and discarding the result.
> 
>     prev_rate is initialized to 0 because it is still read below - the
>     !cur_rate fallback and the TEAC 0x0644 block. That is not a new state:
>     get_sample_rate_v2v3() already returns 0 when the GET fails, so both
>     paths handle it today.
> 
>     Retested on cold-booted hardware, same unit and port: 20 s playback
>     followed by 20 s of 14-channel capture, 960000 frames, no
>     re-enumeration.

Applied to for-next branch now.  Thanks.


Takashi
