Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2AFC531C7
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:38:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F0B8601F8;
	Thu, 23 Jul 2026 12:38:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F0B8601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784803130;
	bh=zOctzmxC590ZWmAN/zDSmglDSYRgcegcBfHjAsjnokA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qIq9LYwzPZB7AIdlaBtVcUyzghHg3NLyUuBj4PgWlNqOtsPDwX30klcbea3UNExQO
	 qG0DH8Q6rwAkcxWRev9M+J5sgasgaH/nqKHxaTSKo1HwOi0RX0qFFgG9BtPhXBAgCL
	 GjSCSw241jQ2eP2Z/D70oaGYu4Zyx9C8I/42/9/s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A28CF8056F; Thu, 23 Jul 2026 12:38:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DC27F805FF;
	Thu, 23 Jul 2026 12:38:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 134E6F8056F; Thu, 23 Jul 2026 12:38:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784803084;
	b=kvrkT6r1lp57UyM9dRxhGbqyMPkv0PJGWsnnNyIuH98urSdswyCe2k6jRM+OyGDG/V8u
	 in2+2iibizFq6YC7E51DADHq05G2jK1e84lr54MZulE+mde+YkRl15gqmh/T3reh3UO2O
	 Kail45jd1HQS503xeiQr81VXR/x+Qg2culahortitgvz3t28AiGEMFUIhhCtYGN7FxxnI
	 QP9mv8QF38kdUGQyZFECFr4T1iiQpioPFsNSJi351WKUJ7oraaYBtBBPosPU1negDp+Kr
	 /91dQfnndWZ8n0JMGMMa2Vfn1BcQm7Z7VjMmIWivhmHlQBhiD/6jXCFrheTmoTldv1g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784803084;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=zOctzmxC590ZWmAN/zDSmglDSYRgcegcBfHjAsjnokA=;
	b=a/kDjmivpfm4vajNRKmgAFenZO5HVnJDpjLhwWI9Z0jvxx1Uq2hXlBPCe7Q2oSPlVnAe
	 euDdk9aWwvcgmFz0hp4XDDW/FtxAlb+JMhU1PFn4SoFgvc4FRYXKRpgoUlm1Nb59yx2dR
	 d4eJe9stvdUiYWP3OaYWZezVX3I8VjObSlfrIOYK4imF9XI1BPY6G8m9E2qAClhrjtzJe
	 f0UguFOn0SPdl9uiAkFOKDV8Su+/godcTU6GBPWa33fYVM3QrkQ1uuWgQV25LJOzzBKDF
	 sRjpNetEFfo5s4EmMwibz9d0f6YufrBY7Gt5X+ntwFBblgyxP9F+8n35dhgOWpdKedQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xvvUXchN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=YUE6S55c;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xvvUXchN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=YUE6S55c;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 50975F8045D
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2026 12:38:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50975F8045D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xvvUXchN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=YUE6S55c;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=xvvUXchN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=YUE6S55c
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E61F7B011;
	Thu, 23 Jul 2026 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784803082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzzHFjZLDt8okWaJULgSZvYd0cjktA8zMlgIQ/uhUXQ=;
	b=xvvUXchN1Ph4IvmZNeAd1JFmR2Sq19Q35BRUl684HI60GhaSPXzLXbDWRiLl/hY0sb944E
	S2CoAKNtMfbajkxfw7Eztj9f9donXaIBiYXaDBtfIwfnL0GL+oAwna0UUd+GhkxMX2rOQ5
	sPg2NRhWqlpvXhAxn4covRXSL/xuZ3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784803082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzzHFjZLDt8okWaJULgSZvYd0cjktA8zMlgIQ/uhUXQ=;
	b=YUE6S55ccLxZGCnXl+jYCk/eDEX8J7+vqgK496EknJR2kcaTm4K80UVaGievWSjliAgRgK
	OdnJKm8m/7dj6ZDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xvvUXchN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YUE6S55c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784803082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzzHFjZLDt8okWaJULgSZvYd0cjktA8zMlgIQ/uhUXQ=;
	b=xvvUXchN1Ph4IvmZNeAd1JFmR2Sq19Q35BRUl684HI60GhaSPXzLXbDWRiLl/hY0sb944E
	S2CoAKNtMfbajkxfw7Eztj9f9donXaIBiYXaDBtfIwfnL0GL+oAwna0UUd+GhkxMX2rOQ5
	sPg2NRhWqlpvXhAxn4covRXSL/xuZ3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784803082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzzHFjZLDt8okWaJULgSZvYd0cjktA8zMlgIQ/uhUXQ=;
	b=YUE6S55ccLxZGCnXl+jYCk/eDEX8J7+vqgK496EknJR2kcaTm4K80UVaGievWSjliAgRgK
	OdnJKm8m/7dj6ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C649779B5;
	Thu, 23 Jul 2026 10:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4H1BBQjvYWqOBQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 23 Jul 2026 10:38:00 +0000
Date: Thu, 23 Jul 2026 12:37:57 +0200
Message-ID: <87wlumdm9m.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: Add quirk to another Razer Blade 16
In-Reply-To: <0cd8c77a82a4481ca9409ac68f1041e8@realtek.com>
References: <0cd8c77a82a4481ca9409ac68f1041e8@realtek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4E61F7B011
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: PRXI5LBHAMVT2LIATELIOTANRVNSLGUD
X-Message-ID-Hash: PRXI5LBHAMVT2LIATELIOTANRVNSLGUD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PRXI5LBHAMVT2LIATELIOTANRVNSLGUD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 23 Jul 2026 09:15:44 +0200,
Kailang wrote:
> 
> Hi Takashi,
> 
> Razer Blade 16 had another SSID.
> The patch will add quirk to another machine.

Applied to for-next branch now.  Thanks.


Takashi
