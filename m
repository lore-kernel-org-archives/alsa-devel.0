Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112AC56208
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:59:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 572796023E;
	Thu,  6 Aug 2026 13:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 572796023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786017557;
	bh=wqJNhNhA6tXOy42Tm8NfXxdydFu0e7SMlQxPrTHEuWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MaxM8Zo7+tO1lQOqIMxO3OeqThm6tKYUwWiSp/Utr2LT6zPdog3gZZWZWeXqIySg8
	 BL5Yq1ejPKMwd+hOL5/iR3TgMMuPSqWfdm39UAL3KJ1nOT1yVIlM17E1M6YNMDiYR8
	 EZd6BAdEJqN2qujLFn4mr8m6KEgiD3Zg4b02w9xw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2846F805FF; Thu,  6 Aug 2026 13:58:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6923DF800B5;
	Thu,  6 Aug 2026 13:58:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40DDCF8055A; Thu,  6 Aug 2026 13:58:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786017516;
	b=RDTPqkH0wymrjNKtKyKuZpNB7wupciELmixn16hcVRZkk4Per98bzkUTuLHW0zRHmAI/
	 cryXoA+dZHKLBjsTNynl7eyoRq8rNOOY5H8iImSe/ndPfIZL2SRDnG2Yj4wYBVzSn+Ci3
	 vbD3y4bcVAPWPPUKB+K6i1py/V3KJQNfBkV9TKx8A6ze9mC1ZX17Sw7seuRNKHsxvWSqW
	 eiCmzpVcehXCWFNHx1c1RIjIIYc4nYGJJe0vh3uWkf2E6dh4LybGz6ZNLBsJvrD1Ccfwl
	 96lf46BCx0aAHhB4KSWFGIRmzCYEib6pIOb1yGr+djHzbb+nrqrhCvF9N5iyeSM40eQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786017516;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=wqJNhNhA6tXOy42Tm8NfXxdydFu0e7SMlQxPrTHEuWo=;
	b=TBA0zZwF7sHJ+a2a6JrN/t6NfXpycRUL8Y0TNYSN+LRNiZ2eD05eZxlLWwnM09te8khv
	 3klinXtgDDc82WPt0vDH/f7bCzjcQFcGi9/bgktEoddHkWFsdNKOPLfsG3Tkusstg4qP6
	 MDISGVaqNadB8Zh0HSXFrZ/8Q08epx4d3Mnx4Hf28osq7dtCoRFqZdUanMyttZ9oWvvh9
	 zrkvw5bhIjEWZUrS4DlL+ISniKfMJWpX9g611nE633tYKTozGzTGUztHzS2U3UZcrwjY/
	 /m5O+RVNljVC4hU+wQyM/WUVw548ZQhPpjK4JbX1OtnfMJLaX3lpFXYRW5nL+jICbkA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=S+wkLN3P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Xmns0Vk7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=UJ8TtI4h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zDHXjxwx;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7CB84F800B5
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 13:58:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CB84F800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=S+wkLN3P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Xmns0Vk7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=UJ8TtI4h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zDHXjxwx
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57C1C3E00;
	Thu,  6 Aug 2026 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786017508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pt0n8szYPdqMXxJE6JrS5bUjss2KnssZIJ2lB7QBjHk=;
	b=S+wkLN3Pkc2WgTH6H4LtuqQW2W+Tap7w8ozWR+Tm9avvjoJrmowcyYCjdKANenH52/c0jg
	unMvD7odi/QAPWMzRF/R9rqCALJ36XSqkjwIcAmOBSdNd6BWbtpNBE8W/7e2FbL2TW93Ev
	uwTQCf1gkdDImMrMsRyN4UzLwsnYRpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786017508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pt0n8szYPdqMXxJE6JrS5bUjss2KnssZIJ2lB7QBjHk=;
	b=Xmns0Vk7BnGXTCBPwVCXvbArGTqm3MCVQz5p2zsQsFz/bSyn6bbuUkUZ4kgWEteue/iavh
	sHDYyHLT3ZxRmJDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UJ8TtI4h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zDHXjxwx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786017504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pt0n8szYPdqMXxJE6JrS5bUjss2KnssZIJ2lB7QBjHk=;
	b=UJ8TtI4hlTy90jaYLRhMWqo78NqmKr92lTkJc/mazYrWHVgJPwvtS0SvutgQ8/1LBHIWT6
	lUJJxprMqGZVfuGBf0sDWYPD4+Ac10UPYNeXzqB14ucx77ICfqWaoyMaOH1reX8BKHyl5W
	QmwyA0wl6SsegYejrGP9Mhd3rcQ+il4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786017504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pt0n8szYPdqMXxJE6JrS5bUjss2KnssZIJ2lB7QBjHk=;
	b=zDHXjxwxIrZZuyyblm59ek1eQsUmHneN3HGFyA4uEF5/LgAN1tOaNeIzFNqwZ8uQZzSRj2
	sqBu7Nt//5F3v6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 298F8779B6;
	Thu,  6 Aug 2026 11:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C3vuCOB2dGocQQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Aug 2026 11:58:24 +0000
Date: Thu, 06 Aug 2026 13:58:23 +0200
Message-ID: <877bm3ea00.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-rc6
In-Reply-To: <2f848fd70985d9c1bbee65eb39a99b4f@kernel.org>
References: <2f848fd70985d9c1bbee65eb39a99b4f@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 57C1C3E00
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: TFKR626GOQVQWZ65UDJT4DNP4RSWSEWR
X-Message-ID-Hash: TFKR626GOQVQWZ65UDJT4DNP4RSWSEWR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TFKR626GOQVQWZ65UDJT4DNP4RSWSEWR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 06 Aug 2026 13:49:27 +0200,
Mark Brown wrote:
> 
> The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:
> 
>   Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc6
> 
> for you to fetch changes up to 33c5aaf693d3fb78f6b8a9658939b72b7638243d:
> 
>   ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults tables (2026-08-05 13:34:37 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.2
> 
> A moderately large set of fixes, but mostly unremarkable:
> 
>  - A series of robustness fixes for the SOF code that came from testing.
>  - Fixes for user visible issues with some of the Qualcomm controls.
>  - Fixes to the register default tables in Cirrus drivers which ensure
>    correcy syncing on resume.  This is a wider problem which will be
>    fixed with a regmap core change but I'd already applied these, the
>    rest of the fixes will come in the merge window.
>  - Making the existing RT645 driver user selectable so it can be used
>    with more machines.
>  - Quite a few new AMD laptop quirks.
>  - A MAINTAINERS update for SpacemiT.

Pulled now.  Thanks.


Takashi
