Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F3BC43458
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:54:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98C6E60248;
	Thu,  9 Jul 2026 11:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98C6E60248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783590894;
	bh=m3Lc3+Oc1qBRVfLCMDEsqwTXWA86jJIU3BOlWWenvBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hQZBID05Qf4oA6aJk6jEoaKs8mtLPkiTrzn35y6MVyeavfKBSBw9mrv2s7hSUfQlx
	 ljppD/xjwZwVuWQVK9jHVZubhEHCyaT75xPCr//LZ9vutll7IEXz0+IC7Rrhv/m6E3
	 Hd34PazU1pw15OSlIfsDlc304ssRMH7+7nX4zTvY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EAE9CF805FB; Thu,  9 Jul 2026 11:54:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE1BDF80600;
	Thu,  9 Jul 2026 11:54:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2437F80495; Thu,  9 Jul 2026 11:54:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783590848;
	b=jq+bHq/ZyWc9d4Bgdv4Ahj3Zm2E+IvjMR/IaQQlJr1AUIrwt2jy9OI2TIQ6JXZiP16L7
	 YjZBgYPIDggP0l/OlYSkLk0wkT+RbQLmIlILaDFISxrorFOdl0NYtA7VgJkCIml9gA0j/
	 PgT/NupQI0mWdn6mPywjfZyqsRa2j4RuvLbX/d5mT/jTesK+yhHey5lzBv00INqwZZtCm
	 fHWjvqN3uAk+uumySYSNevE4xf8XzuqW8sF+2/Xf6e2dOiAgPslCnE53NUVFmV93SOQLq
	 /saP0CB4gtO5HcnnkOtKoZMVQJOOVvRloo06bjm6Y6h6b8Tb0dCVR4dMBq6BRzXMRmA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783590848;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=m3Lc3+Oc1qBRVfLCMDEsqwTXWA86jJIU3BOlWWenvBE=;
	b=jgoCdvwtcwE0Kk3QWkoI86nudRlipgaveV+PzxDwTvQ2CGDLpwikH3L1HQ7tYuKgQX3j
	 Pk0vM4Kb5MIOY7Y1wARzJA+2FhYxxx/a6sMfjCyYFOwvAnwvuFymF/VIV1cK8cjTlAYQC
	 D/PYKHL9pUYsw1yw5U1CH58+z+i/ApteVTGu3nYf3gFjVAlp6o7vpAzvEMpS3LalYgBGI
	 tgWLybNdJHiIMJQPUX9gBwTJsW+v6yceYmlZQ6VZecn9L50Ne3LnjHa4Rd8pyM1Q5AGwZ
	 frp8hWEAsxGpgWWh+4qfxRRUShvkP12/Xfh0ie2JmSBiEK0b+6LTK/GaEH8V3jzkt5A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=nmItsD0o;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=70vbigcc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=nmItsD0o;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=70vbigcc;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 593EFF800D0
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 11:54:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 593EFF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=nmItsD0o;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=70vbigcc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=nmItsD0o;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=70vbigcc
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A55D3760DE;
	Thu,  9 Jul 2026 09:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783590846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uEnaQVm8VJFHX88WggnsJZccyjvT/jg7ZFgaTqD4PU=;
	b=nmItsD0oh8sGqPTW84f3WDpBJG8WPFV2VwfKweBiI81AeHgoo1JfWZh7+QVXY37pZZL+um
	w8Fd34PWG9F5kysPpWH2zgw37PFVBb/lwjmh+4UdCPCHQrDDcy4eEu1JhAp/yiIah/GAP3
	jAEKuviQRExSEhd29ebfVZE8PNPe1nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783590846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uEnaQVm8VJFHX88WggnsJZccyjvT/jg7ZFgaTqD4PU=;
	b=70vbigccTYvQ+qvR01oj4QU8dzQU7/lqxg4nZrwvk3ebt69Wci+ITO7OZrcEeTLQRlEwA1
	3chFPj3EViuDLTCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783590846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uEnaQVm8VJFHX88WggnsJZccyjvT/jg7ZFgaTqD4PU=;
	b=nmItsD0oh8sGqPTW84f3WDpBJG8WPFV2VwfKweBiI81AeHgoo1JfWZh7+QVXY37pZZL+um
	w8Fd34PWG9F5kysPpWH2zgw37PFVBb/lwjmh+4UdCPCHQrDDcy4eEu1JhAp/yiIah/GAP3
	jAEKuviQRExSEhd29ebfVZE8PNPe1nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783590846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uEnaQVm8VJFHX88WggnsJZccyjvT/jg7ZFgaTqD4PU=;
	b=70vbigccTYvQ+qvR01oj4QU8dzQU7/lqxg4nZrwvk3ebt69Wci+ITO7OZrcEeTLQRlEwA1
	3chFPj3EViuDLTCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D8B2779AA;
	Thu,  9 Jul 2026 09:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CT5IHb5vT2rbWAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 09 Jul 2026 09:54:06 +0000
Date: Thu, 09 Jul 2026 11:54:06 +0200
Message-ID: <87wlv432v5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jussi Laako <jussi@sonarnerd.net>
Cc: Salvador Blaya <tiniebla6@gmail.com>,
	alsa-devel@alsa-project.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] snd-usb-audio: commit da3a7efff64e ("ALSA:
 usb-audio: Update for native DSD support quirks") breaks DSD playback on
 Musical Fidelity M6s DAC (2772:0502), plays ~8.8% fast
In-Reply-To: <0B949249-CB61-4D76-BD4B-6C9B467E97D6@sonarnerd.net>
References: 
 <CAOdyq+qFaqCh=tK_wNnA64hv5pQuA1Y09ANxQ=xK8yR-t4mf9Q@mail.gmail.com>
	<4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
	<87bjcg4nyh.wl-tiwai@suse.de>
	<0B949249-CB61-4D76-BD4B-6C9B467E97D6@sonarnerd.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org,lists.linux.dev];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: YH2AQOLVQLWUXE6KEHZNAW6ZVVBND6QV
X-Message-ID-Hash: YH2AQOLVQLWUXE6KEHZNAW6ZVVBND6QV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YH2AQOLVQLWUXE6KEHZNAW6ZVVBND6QV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 09 Jul 2026 10:34:44 +0200,
Jussi Laako wrote:
> 
> This is of course OK for me if it works. The newer Musical Fidelity devices work fine. For example M3x, M6x, M8x, MX and likely upcoming new ones.
> 
> So I would rather go with blacklisting broken ones.

OK, I'll submit the fix patch.


Takashi
