Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE29ACD8C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 07:28:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0181C601CC;
	Sun,  7 Jun 2026 09:27:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0181C601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780817286;
	bh=ELM/V8mLWLam82/ozs12Lgdw7MSyWYUa1St19CMZazI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SaG//cQLoEKuRcxjAy4EkJy/gPk1r5PSHTgZbHNcpLq6rwjEi8p5slL2NIPZAngYr
	 IBwEGM4uC7AhTmtG5yCmaG3hL6FmkhXfnEDNaFSEZUiEtbtJB9TwmFyLan8JVG7P9m
	 nLadWOJBRMsS8Q+F/069uT/grJ5DUELm9+MK/Bpk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4AB2DF805F0; Sun,  7 Jun 2026 09:27:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DCFBF805F0;
	Sun,  7 Jun 2026 09:27:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB970F8055B; Sun,  7 Jun 2026 09:27:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780817243;
	b=TAqnVidFsnXZYTqP68n9+PyFm5Np1KNEgZJDOM01JYCfeDjtRnux45dtoB13fZk6eAYI
	 serHEtXq/xCqfxkAJeLivbL8tSaq6ZIhRbU2BzwFfrAUw29Sh2ELiAJ5LUpCSVP0GeLh5
	 OjFBj1sSUxOEqrB+7V8Iyg/Yt3SywLdjaKSLhTVt1FHOqZS57c/31YIt0Aj4gI7OA4fJR
	 mOFhPuDGxMSQ8qzxo1s3GkV1g48UKzhcg0nmuyZ3hQ5IqrVTf171VbVzrP6b44kXAnqAj
	 lHnPXmLFVVQofa4zICewLUitYAjQ6H4EJHy/EdE2teqYj3yEmzV2R7U2XYKVEbGnIxg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780817243;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=ELM/V8mLWLam82/ozs12Lgdw7MSyWYUa1St19CMZazI=;
	b=kMwvMZgMP/r+jW8Dj8hoXVLxgQQz8i3jma9edt/hyDIyMz2zc8Mcp9hTRgaKyf7QbtOL
	 O16r7Rp9NDwxBPgKaE2CnUB6d0ctErbwaCbuXtZWeBgKMmLaAOnTxop+0im0GU8fuE3Rj
	 pMQ70lgPY+kzozJ37F9f6b2W1w2dPCq8yeAcveKokBy4VYdEEKkHF0s6LM2Wl61VXpE7H
	 csVVNdrPXaNC8z28NVIJ5NEaoeL8u9TKhmmoFLW9Z43qaZzibrI12tbQBk1i8iC7C/iFy
	 dxztOp7tMgucWguhfXz5MeZypj+toOoAkH61u+ul8MTsUDdSSBEkMGG6PZKcjTtDVDQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ZvOf+XU3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=RQPoPvti;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ZvOf+XU3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=RQPoPvti;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 701FBF8051D
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 09:27:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 701FBF8051D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ZvOf+XU3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=RQPoPvti;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ZvOf+XU3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=RQPoPvti
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D8A7759DE;
	Sun,  7 Jun 2026 07:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780817241;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MN6X68wuE2NUb1dGCNERufXCHI2FEX0dQzvkBx9IHVI=;
	b=ZvOf+XU3Bpd969WDgDWJtIMeFbwgHgNP42zLT+zc0xtY8S4qmAiYzdxD9QEaGHKdEIowU7
	ll1H7ymvDO2JcYjvfu9PQVED8G70FGjwWHqnMAyzeywWcF1mbI12obApj7OawKNcghWJHB
	EG7NOVySJcAvMfqIIUd6d4pfkSw4o68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780817241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MN6X68wuE2NUb1dGCNERufXCHI2FEX0dQzvkBx9IHVI=;
	b=RQPoPvtiRZedD12rMukvI/6bmIEQ+Fl2+Gs4PGB/s2icvcjgvRw7l0IN7Ewed+XdhUgkti
	14hBNP5eKIDX7GDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZvOf+XU3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RQPoPvti
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780817241;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MN6X68wuE2NUb1dGCNERufXCHI2FEX0dQzvkBx9IHVI=;
	b=ZvOf+XU3Bpd969WDgDWJtIMeFbwgHgNP42zLT+zc0xtY8S4qmAiYzdxD9QEaGHKdEIowU7
	ll1H7ymvDO2JcYjvfu9PQVED8G70FGjwWHqnMAyzeywWcF1mbI12obApj7OawKNcghWJHB
	EG7NOVySJcAvMfqIIUd6d4pfkSw4o68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780817241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MN6X68wuE2NUb1dGCNERufXCHI2FEX0dQzvkBx9IHVI=;
	b=RQPoPvtiRZedD12rMukvI/6bmIEQ+Fl2+Gs4PGB/s2icvcjgvRw7l0IN7Ewed+XdhUgkti
	14hBNP5eKIDX7GDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3297F779A7;
	Sun,  7 Jun 2026 07:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g9L8ClkdJWoOPQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 07 Jun 2026 07:27:21 +0000
Date: Sun, 07 Jun 2026 09:27:20 +0200
Message-ID: <87h5nestd3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] ALSA: check snd_ctl_new1() return before
 dereferencing
In-Reply-To: <20260607025613.3604194-1-ruoyuw560@gmail.com>
References: <20260607025613.3604194-1-ruoyuw560@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D8A7759DE
Message-ID-Hash: 3NBDEJONPJIDLIWWZ43TJI5PDP4MJZ6E
X-Message-ID-Hash: 3NBDEJONPJIDLIWWZ43TJI5PDP4MJZ6E
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3NBDEJONPJIDLIWWZ43TJI5PDP4MJZ6E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 07 Jun 2026 04:56:05 +0200,
Ruoyu Wang wrote:
> 
> Several ALSA drivers dereference the pointer returned by snd_ctl_new1()
> to adjust id.device, id.index, or store bookkeeping pointers before
> calling snd_ctl_add().  snd_ctl_new1() can return NULL on allocation
> failure, making these writes a NULL pointer dereference.
> 
> This series adds NULL checks to all affected call sites found by static
> analysis.
> 
> Ruoyu Wang (8):
>   ALSA: es18xx: check control allocation before private data setup
>   ALSA: gus: check PCM volume control allocation
>   ALSA: cmipci: check S/PDIF control allocations
>   ALSA: es1938: check control allocation before private data setup
>   ALSA: ice1712: aureon: check CS8415 control allocation
>   ALSA: ice1712: check pro S/PDIF control allocations
>   ALSA: ice1724: check S/PDIF control allocations
>   ALSA: ymfpci: check S/PDIF control allocations

Some of them seems to have been already applied or conflicting.
Please rebase on the latest for-next branch of sound.git tree and
resubmit.


thanks,

Takashi
