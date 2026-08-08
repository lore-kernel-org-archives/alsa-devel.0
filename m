Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB4DC55174
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:15:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71FDB60203;
	Sat,  8 Aug 2026 17:15:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71FDB60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786202119;
	bh=giXO5jsxI/68HDtSzHty4UK+ud7/lA3c9Ff4c3eo/Qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QjRlDYyftnOHU8a/NHa37HUrRpSfKO6EyXlgGy68N1UHG99d2V9AlsRVrBTB20usI
	 TUttDR4UI+KfiwnFQ0EUGbcTzruqC1ebiSEuMpS9BSIf+X81yeFN0g6OikA6IrUgNd
	 FLC6TJlC2WWHlg5RE1DQIDw1P9OzJjWOUIe+x3Xc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43A64F805F8; Sat,  8 Aug 2026 17:14:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE03BF805F0;
	Sat,  8 Aug 2026 17:14:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B0A1F80571; Sat,  8 Aug 2026 17:14:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786202073;
	b=CAU3ZBtEFobQVW+xyRGxxB4cYMk6Z8j1WPiaPLF27NIXzTYDMwkmfwmMmN6K0LTyFLwS
	 xRpa9/D4MNKoHO9c4Cst+B924vVtne5JF9qaMyTpFbHSBlVaBPFKS+UK1FH0uTDM6uanJ
	 Or9axnKJFIaklDqzol63brWUUYRb+tFFSBw76vyMLxfcsfugUD2ToWdNHwQYaZldnXETr
	 pnzhUcVPMBLg6iJ0KtwD3gmuNI2xsfzm6Ecf5tdXQEAO/ZbFAoJ7qfX5aIylZPt4oFfzX
	 wMO+IfOX6LOi64sQ41IHBG08jyntejQcN/A9Z7NYTxmjdF1uPtDixF+BEC7kpkVm06g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786202073;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=giXO5jsxI/68HDtSzHty4UK+ud7/lA3c9Ff4c3eo/Qo=;
	b=Wjq03aBMYSrTrz6WhNOyirf2MmtD4GiX2FSdilppaVHe1cKLdENPMdGeXNTuGng3/dMv
	 SCKUVeHdKgTqG7I0+hPGL4Mfx7ENqsB5bS7k2jZEawzAX7mYr9XAaZJMmb2RpUmg0w9vR
	 sjYcPiHTmQDdXl3TihtVgnpsMLCIyT+5p3BIkLI7cMwSjuOwh95jCH5FPx6GKO/cz0aS5
	 DjDjqYA1gFj+5A6or1BxMyxRcQfHQN+mbjKBoKrYTIntIc6+ZwzeavCOMQlpQ9Yp1k6ST
	 gfvdQiTxy5pQPP2Xfi4bbyQ5Q9+xhWwXaSDsryXDXVrw5dUuZNXkqgULUC/MIh9bgXA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CzSVnrKC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0W29tZ9+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=svjPz7Eo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=nBsFcWN4;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C0A28F8012B
	for <alsa-devel@alsa-project.org>; Sat,  8 Aug 2026 17:14:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0A28F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CzSVnrKC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0W29tZ9+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=svjPz7Eo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=nBsFcWN4
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E76FC80F0C;
	Sat,  8 Aug 2026 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786202067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDW+i6uxXoRg6x8cDyqCdnmLyX7qZ2ZG6lSUlZ4W5YM=;
	b=CzSVnrKCvHOHh4fqWfWZcRDwl67hS7B546QKHJmVDZzAsK0Tml85eK8GKDmgiUcFVyZwGC
	mmDA6wiSwKntg70bwhssBf4cmgnTZcZKZ6MaiC6C7Zyh0jRErzIqZQRmEjbmIrTwSqx+Dp
	o+Xffg8Dbjr8uwsjEoDWx/LcWfdSdaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786202067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDW+i6uxXoRg6x8cDyqCdnmLyX7qZ2ZG6lSUlZ4W5YM=;
	b=0W29tZ9+2uLScHFGNH2RUOkmodnkIZkFJ05ymzGk3XADSC7tObe4sv9SBYq87HSCFoojw3
	3reC7lZYByPPGNAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=svjPz7Eo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nBsFcWN4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786202062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDW+i6uxXoRg6x8cDyqCdnmLyX7qZ2ZG6lSUlZ4W5YM=;
	b=svjPz7Eo6e5ygSOV0zMu2iESp0hakqakxcGjp2LX4Cu9tSpvTPzyHq8NZYLUYsdDo3q1QO
	kLcL1Idv1SAZZvN31QTzr4Loh7J+HR5rcGEssyIAgNCoZKptZc95KH01XzSZlpZEHh6iwn
	xhHKfqzJ1YgEauLask+6a8kERPl3CBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786202062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDW+i6uxXoRg6x8cDyqCdnmLyX7qZ2ZG6lSUlZ4W5YM=;
	b=nBsFcWN49+sr27VnIS3M5KwoN4NqgIx/Ie3gpnMsm3SS0ZkX0vSuWdQIzkGY5nhx/5kzZK
	1XgXeadLPoapziAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5ECB779B2;
	Sat,  8 Aug 2026 15:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0bbCKs5Hd2odaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 08 Aug 2026 15:14:22 +0000
Date: Sat, 08 Aug 2026 17:14:22 +0200
Message-ID: <87se4oabld.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: JJ Macalinao <jj@macalinao.org>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: add QUIRK_FLAG_ALWAYS_SET_RATE for
 Mackie DLZ Creator XS
In-Reply-To: <20260808070902.835360-1-jj@macalinao.org>
References: <20260808070902.835360-1-jj@macalinao.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E76FC80F0C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: 4D3CU2NPS7U4KNKXOZPMXE5RVVNAMGJT
X-Message-ID-Hash: 4D3CU2NPS7U4KNKXOZPMXE5RVVNAMGJT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4D3CU2NPS7U4KNKXOZPMXE5RVVNAMGJT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 08 Aug 2026 09:09:02 +0200,
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
> initialisation is involved.
> 
> The device is self-powered, so the resulting state survives a USB replug:
> initialising it on any host that issues the write leaves it working on
> Linux until it is power-cycled, which made the failure look intermittent.
> 
> Add a quirk flag rather than dropping the early exit, since the opposite
> requirement also exists in-tree: QUIRK_FLAG_FIXED_RATE suppresses rate
> setting for single-rate devices (JBL Quantum610/810).  The two behaviours
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
>  sound/usb/clock.c    | 3 ++-
>  sound/usb/quirks.c   | 3 +++
>  sound/usb/usbaudio.h | 6 ++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> index 2e0c18e352..647bf55b1b 100644
> --- a/sound/usb/clock.c
> +++ b/sound/usb/clock.c
> @@ -626,7 +626,8 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip,
>  	}
>  
>  	prev_rate = get_sample_rate_v2v3(chip, fmt->iface, fmt->altsetting, clock);
> -	if (prev_rate == rate)
> +	if (prev_rate == rate &&
> +	    !(chip->quirk_flags & QUIRK_FLAG_ALWAYS_SET_RATE))
>  		goto validation;

With QUIRK_FLAG_ALWAYS_SET_RATE, calling get_sample_rate_v2v3() is
rather useless, and we can skip it?  e.g.

	if (!(chip->quirk_flags & QUIRK_FLAG_ALWAYS_SET_RATE)) {
		prev_rate = get_sample_rate_v2v3(chip, fmt->iface, fmt->altsetting, clock);
		if (prev_rate == rate)
			goto validation;
	}


thanks,

Takashi
