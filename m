Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371F606A31C
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=PqV1t1g/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=baUheQVG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OYXAjad7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=baUheQVG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OYXAjad7
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 787C9601FF;
	Tue, 17 Nov 2026 09:56:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 787C9601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794905821;
	bh=fXyXCHnefYojSy5u/nOa29rs7rTNxoJ4gfehCf7/36Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PqV1t1g/WsD7LSmtzhDFCFrfnukFDJgMo4ZStetop5wx1RD93xozbuEvkG81pknP3
	 fxTm0vcoE5qyPAoirJoGRbdJj7zro7ZfHjQuc5uCBA5MCAmeOYmlpPokDO0YRd/VGE
	 HD2KK6fO7Xi1AtqiBnJUhZkSCuy9Q7aoczRmD9wM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74776F805D7; Tue, 17 Nov 2026 09:56:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3279BF805EF;
	Tue, 17 Nov 2026 09:56:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F27CDF805A8; Tue, 17 Nov 2026 09:56:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794905771;
	b=dIR4WO0alhEI1butVfe+4e9R4Yi01vYNeGhUJEkIrXPntbYV6YKw8v8mUEdRyF73ldyW
	 aDu+RKKGcm/daRlxpYGS2L3jawNL0GTLXOCLJuVTIdinI1auTclGAwNCmzHkOvFsgpXQo
	 Lio68WYna3WxJBI1d4nu0uALfkZoiNExCPmbb8rp2Y8DODAddP9+Lc3eOjc/ZOhkG9hKb
	 dhYe1I8/Gs2dgmbwG6tOdCdsfQva7tqYi8J43s/E6X9aRFSrGq6q4nuN1l/TbWyL+cJu/
	 yBSOIwt4duKyHVBrQhk+p8NsH3ReFxXVJsQ6oKgrzvPJsfp936M3MlGsYNvk8BGlehw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794905771;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=fXyXCHnefYojSy5u/nOa29rs7rTNxoJ4gfehCf7/36Y=;
	b=S0k4wQElPrWyjkDCSo6NNr6m3I3JiIY9maBWaGxHx5L+wp58ZtgQKENBJF7p7gijnotd
	 l7uE6bKuB0o12gLMzl8dsl6oeACneldxJ7clx/n7B87luDNmWpYbC12e40nK5a1iYg2d0
	 n+quVs1OtD2ZYo3E2UJtsAVFABfZ7JCZQuFgRO7a5UNhLH3d7bu9QjjpM4B3BSipuJsGP
	 flYXEQlb7wvhdGCohieHkqfu3XEhX3FfOT+g5+0ekybEcgNCSigzzjwIGd01cK6LJi1iF
	 L5S3EWFzfm16vfC3+TXCOPsU9fq7hH9KOL1dwUdxTQRB3M9K5AGuouGo7UsALxT7eLA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=baUheQVG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=OYXAjad7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=baUheQVG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=OYXAjad7;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 48FC1F80510
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2026 09:56:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48FC1F80510
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=baUheQVG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=OYXAjad7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=baUheQVG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=OYXAjad7
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21155221ED;
	Tue, 17 Nov 2026 08:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1794905769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ur32DdfOvs+5Wrm9nLHjNLlSmiMojBpVaTC6KaKH0FU=;
	b=baUheQVGdW/UuPntTjI9KV+EOI3gOpqw2chUKQONvlUPoyHonSPMUsV84HJmrfcHtEBqqk
	73JCngEtDzS9M2LjVBA9zfx/u1BCafcPZ8Cwg6q0KAPGwmUF4EdXjbstW2YJMrRjUc9KfS
	EpP0kM61Jqi31bpJBOHw3PiKwuUNPJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794905769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ur32DdfOvs+5Wrm9nLHjNLlSmiMojBpVaTC6KaKH0FU=;
	b=OYXAjad76FtJAbvmYkBfonAoafAKUJU6Xi3n/JjcU71bawBLYcIsLPPaXCG0jN1eWXueHi
	pCPloT7sHsH+GQDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1794905769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ur32DdfOvs+5Wrm9nLHjNLlSmiMojBpVaTC6KaKH0FU=;
	b=baUheQVGdW/UuPntTjI9KV+EOI3gOpqw2chUKQONvlUPoyHonSPMUsV84HJmrfcHtEBqqk
	73JCngEtDzS9M2LjVBA9zfx/u1BCafcPZ8Cwg6q0KAPGwmUF4EdXjbstW2YJMrRjUc9KfS
	EpP0kM61Jqi31bpJBOHw3PiKwuUNPJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794905769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ur32DdfOvs+5Wrm9nLHjNLlSmiMojBpVaTC6KaKH0FU=;
	b=OYXAjad76FtJAbvmYkBfonAoafAKUJU6Xi3n/JjcU71bawBLYcIsLPPaXCG0jN1eWXueHi
	pCPloT7sHsH+GQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D40E71334C;
	Tue, 17 Nov 2026 08:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KCbzK6gW/GonXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 17 Nov 2026 08:56:08 +0000
Date: Tue, 17 Nov 2026 09:56:08 +0100
Message-ID: <87zev7zviv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: ptrnt@proton.me
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP ProBook 455 G8 mute
 LED
In-Reply-To: 
 <7MuWwdxL8P9sa_U2G1ztBAaV6q-vlnX-VE6W_awGFtxOQWXQ12kIoRUqrnlwkQH_gE1Vy6Fg1jutNWO9MuVteVwQq6vf4DKZdVOfa3gB0TQ=@proton.me>
References: 
 <7MuWwdxL8P9sa_U2G1ztBAaV6q-vlnX-VE6W_awGFtxOQWXQ12kIoRUqrnlwkQH_gE1Vy6Fg1jutNWO9MuVteVwQq6vf4DKZdVOfa3gB0TQ=@proton.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[proton.me:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: P4CQHT25YOFQXFFQVZABK2SUSLZL4MRV
X-Message-ID-Hash: P4CQHT25YOFQXFFQVZABK2SUSLZL4MRV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P4CQHT25YOFQXFFQVZABK2SUSLZL4MRV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, 17 Nov 2026 05:30:44 +0100,
ptrnt@proton.me wrote:
> 
> 
> The F5/F8 mute-LED keycap indicators do not light up on this model
> (SSID 103c:8a91) because it is missing from the
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk table, even though
> sibling ProBook/EliteBook models (G6 through G11) already use it.
> 
> Signed-off-by: Roman Popov <ptrnt@proton.me>

The patch is inapplicable due to the tabs/spaces breakage.
Could you fix your mailer setup and resubmit?


thanks,

Takashi
