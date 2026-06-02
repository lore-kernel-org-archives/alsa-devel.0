Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8689CD6E5D
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:39:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB89160223;
	Tue,  2 Jun 2026 13:39:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB89160223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780400379;
	bh=a5LLOI7oYEeyjOTU1OTequ6L48Ggtu0ql9GStnMeVB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UG0cL9XXiDWVFtUUU4BA11nXP8WiqZ77xKwjPqzVMoFlkx8BGv3r0vxP0Musgnw02
	 Ej6YMcSNcl4gfLN6aJeDgxY6GQIMxnLPudsEiMgM///L+pDXqYqCis8o37i6GQFnYC
	 KJQKKWNm/SpbmaM+2GAyf/y4J9ondlqhffXRkKHg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D600F805F6; Tue,  2 Jun 2026 13:39:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 56F96F805FA;
	Tue,  2 Jun 2026 13:39:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF399F804F2; Tue,  2 Jun 2026 13:39:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B3638F8016E
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 13:38:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3638F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=vOrC7/pU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ank+4RDr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=vOrC7/pU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ank+4RDr
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C78C26BDF2;
	Tue,  2 Jun 2026 11:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780400335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gm5GfGl1A9A8L5yITPe+3jwD/lBiLB14WVuVwrziEhk=;
	b=vOrC7/pUz7Pe3A5gNrUhQfHl7rQzlley3AXoC3wCvj4gHkwMtRIx2k9iEgvaptN3Y82vP3
	Rfl4zUlg2Fh6Ga/0RYWW+/iNO87QyCB2izSFpJt/vFMrHoC6J4U7HoRuc4IkPeu+52ofK3
	zCYpBEnopfxwXKqvLR0kUKC0IchujUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780400335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gm5GfGl1A9A8L5yITPe+3jwD/lBiLB14WVuVwrziEhk=;
	b=ank+4RDrV1nL2iYF+8BH/DYokk96sC82dhX4Onv428j8ecI3lB48D17CQX3P04arz8Tl7r
	KjMj7Im70ijBviCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vOrC7/pU";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ank+4RDr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780400335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gm5GfGl1A9A8L5yITPe+3jwD/lBiLB14WVuVwrziEhk=;
	b=vOrC7/pUz7Pe3A5gNrUhQfHl7rQzlley3AXoC3wCvj4gHkwMtRIx2k9iEgvaptN3Y82vP3
	Rfl4zUlg2Fh6Ga/0RYWW+/iNO87QyCB2izSFpJt/vFMrHoC6J4U7HoRuc4IkPeu+52ofK3
	zCYpBEnopfxwXKqvLR0kUKC0IchujUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780400335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gm5GfGl1A9A8L5yITPe+3jwD/lBiLB14WVuVwrziEhk=;
	b=ank+4RDrV1nL2iYF+8BH/DYokk96sC82dhX4Onv428j8ecI3lB48D17CQX3P04arz8Tl7r
	KjMj7Im70ijBviCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B387D779A7;
	Tue,  2 Jun 2026 11:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P8otK8/AHmrnTQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 02 Jun 2026 11:38:55 +0000
Date: Tue, 02 Jun 2026 13:38:47 +0200
Message-ID: <87a4tdyxx4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cliff Brady <brady725@gmail.com>
Cc: linux@hohmatik.de,
	alsa-devel@alsa-project.org
Subject: Re: Creative X-Fi hw20k2 (SB0880) that appeared in kernel 6.12.85
In-Reply-To: 
 <CAFGAnONFP+=y3p2VQ_ciZzX_d=wjKP0jZf-JfVK1p1_EAz2ZXA@mail.gmail.com>
References: 
 <CAFGAnONFP+=y3p2VQ_ciZzX_d=wjKP0jZf-JfVK1p1_EAz2ZXA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C78C26BDF2
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: XUL3XVJEJDAHRC3B57PSNLQCBZCSZFPN
X-Message-ID-Hash: XUL3XVJEJDAHRC3B57PSNLQCBZCSZFPN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XUL3XVJEJDAHRC3B57PSNLQCBZCSZFPN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 02 Jun 2026 13:32:42 +0200,
Cliff Brady wrote:
> 
> 
> Hi Takashi,
> 
> I'm writing to report a regression on the Creative X-Fi hw20k2 (SB0880) that
> appeared in kernel 6.12.85, and which I believe is related to commit
> b045ab3dff97 ("ALSA: ctxfi: Fix missing SPDIFI1 index handling").
> 
> Hardware:
>   Card: Creative X-Fi 20K2, model SB0880 (PCI ID 1102:000b)
>   Driver: snd_ctxfi
>   Kernel: 6.12.85 (Home Assistant OS 17.3, generic x86-64)
> 
> Symptom:
> After upgrading from HAOS 17.2 (kernel 6.12.77) to HAOS 17.3 (kernel 6.12.85),
> the X-Fi analog outputs produce no audio when accessed via PulseAudio.  HAOS
> 17.1 (kernel 6.12.67) X-Fi analog outputs also  successfully produced audio
> when accessed via PulseAudio  The PA sink reports RUNNING and all ALSA mixer
> controls are at full volume and unmuted, but no audio is heard from any analog
> output channel (front, rear, side, center/LFE).
> 
> Diagnosis:
> PA opens the device with device.access_mode = "mmap+timer". Direct ALSA access
> via speaker-test bypassing PA produces audio correctly on all channels.
> Forcing PA to close and reopen the PCM device via pactl suspend-sink /
> resume-sink restores audio, suggesting the mmap buffer handshake between PA
> and the ctxfi driver is failing silently on device open.
> 
> The issue is reproducible every time PA opens the device fresh (e.g. after pa
> restart or sink resume from suspended state following idle timeout). The
> suspend/resume workaround reliably restores audio each time.
> 
> Hypothesis:
> The out-of-bounds array access fixed by commit b045ab3dff97 in
> daio_device_index() for hw20k2 may have been inadvertently masking a
> pre-existing deficiency in the ctxfi mmap implementation. With the fix in
> place, mmap+timer mode is negotiated successfully at the PA/kernel interface
> but audio transfers silently fail. A possible fix would be to set
> SNDRV_PCM_INFO_NO_MMAP in the hw20k2 PCM capabilities, forcing PA to fall back
> to read/write mode which works correctly.
> 
> Kernel was working: 6.12.77
> Kernel regression introduced: 6.12.85
> 
> I am happy to test any patch or provide further diagnostics.

Could you check the latest 7.0.x kernel?  There are a few more fixes
for ctxfi recently.


Takashi
