Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7681FCD8CB2
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:27:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6680F601F6;
	Wed, 10 Jun 2026 09:27:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6680F601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781076435;
	bh=H+bg+E6P/tdk5FY4WpHj1bA3gH4mehb+F/ZGzU1E0SU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KBqN+W1Xmh3KW6gZsMa+zUFB4EJLlDGWfQxSIQqiixevrGnoiLPaq5ATMNyghhUz9
	 GdHGlpXy5dvQ8A6Dq7JKPUx8MAt8uBFAB2sxtcK/sRoYtxUZnolFawD1jPlzgjCZvE
	 9sJGmqQa9d4HN1T/v15qD4fCumZKJQkSzQ34Ng4E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7064F805F7; Wed, 10 Jun 2026 09:26:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EB27F805EB;
	Wed, 10 Jun 2026 09:26:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8796F8058C; Wed, 10 Jun 2026 09:26:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781076384;
	b=Imf0N2BeNI/bZ16vx9XX6X/eTJjB4W6gxUuIyWkLqwSSDqLuDqPn0RVsDspky/vPYRzi
	 pf8UDgbDqOwhL/dsF9X4j3r9eXE63UZdlUSzI/xy95q22kOc/4hy/oW5zL+N0rVgaNXeg
	 q+biZu9aDpH8rKZtVPGAjPgzAbGepiaKPKPgnQz4tUzRucTvNCJJyoMsn9KIQtu+5Eo5J
	 dOc8wK8gM/4YIv3UnfQ3fvKYgKWCMoepgvk6nU1TjD1SYzjdmozIxSDQthyDbrx8w74nP
	 0i7qB0SvwZFvPA1z4gP/eavJL8BYtvqyXu+qhtTvvzU6HRdDz/Jf9mBAtjf2NvRNpsg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781076384;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=H+bg+E6P/tdk5FY4WpHj1bA3gH4mehb+F/ZGzU1E0SU=;
	b=a3LCkszHrqCcLFRj8D5Eb+resVzAjghHrGbrjKHq6hMvxAkiQVklw3V0awX2bQG8FVQ6
	 nwMh9D9UfN60OCDL9BQ5WS5cveIjG7wdFlYr1kvSPmJXtpsmoQmZWq83bUKA7frgoGQZX
	 PUtmdU2wQfAFW2xMvppNB6fHOgK+i5zBswgaya60rR+gaTjq6el6DsfeyjC4BpQP/dnMI
	 aOdzPGMolKkh3Yp8D3bRipWOsu1V905aVgj7usPtWIXaMm4xmcSBW6UyMkttsmC34iRF9
	 TWKQJLNHwAsnSNX9UCLb1MzEPRDt3aDfI3n2IFvq913v/uKjXzkLTsclb8JpQvY8CnQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=f3shgDVp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=E8K0VYWD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=f3shgDVp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=E8K0VYWD;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8573FF801F5
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 09:26:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8573FF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=f3shgDVp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=E8K0VYWD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=f3shgDVp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=E8K0VYWD
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50B416AC65;
	Wed, 10 Jun 2026 07:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781076382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42yBvqWz0T5buHPr3bPCo+C8AJ1Iktry46hKmaRY+h8=;
	b=f3shgDVpkiOCymCO/L39qzDNaPUYUxb1z0FAdG+GO3AmnNVlSIKV/5+D24Dn4VoT8k03eB
	TnnLxD/P613C2BlYDeNJagluF3jbhJJEmqBorCRWNIaYLI6NEO6EOjjzxRFp0fvp996whI
	ZzgyXfo7ZwJaFBkzQjxaNIQMFeuBsok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781076382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42yBvqWz0T5buHPr3bPCo+C8AJ1Iktry46hKmaRY+h8=;
	b=E8K0VYWDlbs3e5HpvOzut1iODA+SMpaabY1xhlYLKwRK/FtxrVsDFpLWYoZDNXaNbSc+98
	taLgW8mO0tO8nABA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f3shgDVp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E8K0VYWD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781076382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42yBvqWz0T5buHPr3bPCo+C8AJ1Iktry46hKmaRY+h8=;
	b=f3shgDVpkiOCymCO/L39qzDNaPUYUxb1z0FAdG+GO3AmnNVlSIKV/5+D24Dn4VoT8k03eB
	TnnLxD/P613C2BlYDeNJagluF3jbhJJEmqBorCRWNIaYLI6NEO6EOjjzxRFp0fvp996whI
	ZzgyXfo7ZwJaFBkzQjxaNIQMFeuBsok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781076382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42yBvqWz0T5buHPr3bPCo+C8AJ1Iktry46hKmaRY+h8=;
	b=E8K0VYWDlbs3e5HpvOzut1iODA+SMpaabY1xhlYLKwRK/FtxrVsDFpLWYoZDNXaNbSc+98
	taLgW8mO0tO8nABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BDB2779A7;
	Wed, 10 Jun 2026 07:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IRNBCZ4RKWrtQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 10 Jun 2026 07:26:22 +0000
Date: Wed, 10 Jun 2026 09:26:21 +0200
Message-ID: <87se6u6ele.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: furstblumier <seal@furst.blue>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz
Subject: Re: [PATCH RESEND] ALSA: hda/realtek: Add quirk for HP 255 15.6 inch
 G9 Notebook PC
In-Reply-To: <20260609201706.502075-1-seal@furst.blue>
References: <20260609201706.502075-1-seal@furst.blue>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 50B416AC65
Message-ID-Hash: ZBR6XNFWJCPUBMEEPVA4P4EKSMTR2XHE
X-Message-ID-Hash: ZBR6XNFWJCPUBMEEPVA4P4EKSMTR2XHE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZBR6XNFWJCPUBMEEPVA4P4EKSMTR2XHE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 09 Jun 2026 22:17:06 +0200,
furstblumier wrote:
> 
> The HP 255 15.6 inch G9 Notebook PC (PCI SSID 103c:8a1b) uses the
> ALC236 codec but lacks an entry in the quirk table, causing the kernel
> to fall back to a null SSID match (103c:0000) and skip the necessary
> fixup. Add a quirk entry using ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
> matching the HP 255 G8 which uses the same codec and fixup. This fixes
> the mute-button LED and fixes an issue with unplugging and replugging a
> headset jack not being recognized as an audio sink.
> 
> Signed-off-by: Furst Blumier <seal@furst.blue>

Applied to for-next branch now.  Thanks.


Takashi
