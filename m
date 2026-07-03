Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CF5C43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:12:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E1DB601F1;
	Fri,  3 Jul 2026 10:12:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E1DB601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783066340;
	bh=K3UkdqA6x90/19ybEpxWHBdCxpOj02tBQ+NjlOyhqm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hj7sTgUIZhfI44iGk7J20deXMiQpTG9fQiNEEE+fGzWQGWgjKaq/b0AHSU75sghf0
	 9NBCQZMWaQBy4PoiMFvkIii4uCEf96Ol4SvgS7S2Y6ubxmkW27KY5+O0T8CN3elYtp
	 8lzdAd3IMx57eayA6f7ka7AUXHq6tCuRrc3eD+iA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC8FCF805F6; Fri,  3 Jul 2026 10:11:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F8B6F80579;
	Fri,  3 Jul 2026 10:11:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D750F80579; Fri,  3 Jul 2026 10:11:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783066296;
	b=rgbHjOKc2Gj45eFTuJRr0Rbp15OESWQzGsbxUCpaSXhN2Dzb93vSlNz0zX67a+4aJ2N9
	 qvUUd6PxxFQ64wr9XzJNaH5wCXeaVcJqTdTgEtg8GXoXxu7erB4TzoFmD4kw9Ep93Dnlx
	 RBUyhonrHOMsvGu1pVZdxcHpxzA6a95jhwoxcI/qb01KpryV9UdM2MOXJnqGrtBNyV1ql
	 hlTb+FggYGl6UYtLyhG+l5ErFRd73izqc89JQxDc5HYjvtOdBnjSqc1wNIChDwFhzwsLp
	 /JN0823eryyHmA9zQ7B2assXdpHx3ZRL3xvXrbE8bWUZMGgZHmpYG3rSpp7oTiQuZ4A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783066296;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=K3UkdqA6x90/19ybEpxWHBdCxpOj02tBQ+NjlOyhqm4=;
	b=Gxf9ka2IFSljmsRNCZuKAZxfhBerKDq+YsoBmXEbNdu2m3KytWkW0jRlpgs/Y0FrDvsT
	 ncAYrwAUHtriZBuKsRZgpQR/9RUuVXDXdVV77EVCVYuC0BQqLLdOhwevd6KOF8O9adJR4
	 xgHMFifRU1fj3Slm2S4Y8MJiQjjWGdCHqpmMHSUOsoJdsTy+41lhYM6Sq5SMUgEPVZivN
	 NdoDmZBCr9Iu4hvQdhFCaA7TgYYxrgeyGBpDdvFL9omDoZRdPbLDfiEAwoUcCK4B63+U/
	 zTI0e3WHk22LOQ3Mrw2k4QInjXjD1E+2QD6uQqMCnsuJZqCFQahjPhbsPysAUBfSdPw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=uQT8tRYb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vOaWzADa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=uQT8tRYb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vOaWzADa;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0BF44F8011B
	for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2026 10:11:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BF44F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=uQT8tRYb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vOaWzADa;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=uQT8tRYb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vOaWzADa
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18C0F759C8;
	Fri,  3 Jul 2026 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783066293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOsRXdSFzaRInUwhRrnPKQlvllUI2sVG6gCSQxNTHx4=;
	b=uQT8tRYbzaPxKSipCxCxghS2CvLN52zBP7nKgIQU6SwpZDvTeXU48eh3FoLZaXtMZ2xDYH
	QhUTJKRLJ75fVGW0KAabMWWcdBLbmQYPIfbYLcYZMaiJGza9JWd7TCnFsYvqLM3WDfj6dI
	OJyekK5gChetbUXYUr/UgFDzJQvLeaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783066293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOsRXdSFzaRInUwhRrnPKQlvllUI2sVG6gCSQxNTHx4=;
	b=vOaWzADayvyo6JTD9hn8nTa4tSO/4pHPIJnHK9bVYKOoEEwjaiN5hw9AFkI1ukgtAPSrxB
	sZXUTekNVqJ/W0Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783066293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOsRXdSFzaRInUwhRrnPKQlvllUI2sVG6gCSQxNTHx4=;
	b=uQT8tRYbzaPxKSipCxCxghS2CvLN52zBP7nKgIQU6SwpZDvTeXU48eh3FoLZaXtMZ2xDYH
	QhUTJKRLJ75fVGW0KAabMWWcdBLbmQYPIfbYLcYZMaiJGza9JWd7TCnFsYvqLM3WDfj6dI
	OJyekK5gChetbUXYUr/UgFDzJQvLeaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783066293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOsRXdSFzaRInUwhRrnPKQlvllUI2sVG6gCSQxNTHx4=;
	b=vOaWzADayvyo6JTD9hn8nTa4tSO/4pHPIJnHK9bVYKOoEEwjaiN5hw9AFkI1ukgtAPSrxB
	sZXUTekNVqJ/W0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7EF3779AC;
	Fri,  3 Jul 2026 08:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wIxZN7RuR2qQJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 Jul 2026 08:11:32 +0000
Date: Fri, 03 Jul 2026 10:11:32 +0200
Message-ID: <875x2w8pcb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-rc1
In-Reply-To: <706f31e9c125d17fbca0a5ed648f4933@kernel.org>
References: <706f31e9c125d17fbca0a5ed648f4933@kernel.org>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: VORPQXSPNFDUINSXMHUHLJJLKURYMAUN
X-Message-ID-Hash: VORPQXSPNFDUINSXMHUHLJJLKURYMAUN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VORPQXSPNFDUINSXMHUHLJJLKURYMAUN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 02 Jul 2026 20:57:06 +0200,
Mark Brown wrote:
> 
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:
> 
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc1
> 
> for you to fetch changes up to 83245e7a436c04e511378af14dd81fd188b41541:
> 
>   ASoC: rsnd: src: Add missing scu_supply clock to suspend/resume (2026-07-02 18:56:38 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.2
> 
> A fairly standard set of driver specific fixes and quirks that have come
> in since the merge window, plus a MAINTAINERS update.  The tas675x
> READ_ONCE change is probably not actually fixing issues properly but we
> need a whole new approach to concurrency there and it came along with
> some good fixes.

Pulled now.  Thanks.


Takashi
