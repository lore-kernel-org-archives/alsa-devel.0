Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B70DC61DC2
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:22:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4CA160277;
	Thu, 27 Aug 2026 16:22:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4CA160277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787840572;
	bh=iLXQLGoUqI41trrhyHxHfyWaPwKf76iBzswWgMqkjVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GIZ/JoGlLzSz2EGqR64rU97zmk/gZVg0nlIwLV+nvsqBxl6Bz03L0GVQhATIvoKdH
	 Gq85a8vqiUyKng9Qnr371c+Nw0xMDTdooq34jP4nXJpJsaeFXytIbwRHr0bOjcJiWl
	 cm5VaKcMGDcDly6yy0f861A5MN9FwRVygl3YkuRc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B016F805EF; Thu, 27 Aug 2026 16:22:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE0A6F805F4;
	Thu, 27 Aug 2026 16:22:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7AE8F8047D; Thu, 27 Aug 2026 16:22:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787840527;
	b=qmu5H+4nyoWbTU9hWO7Rp/B80EYMbE+cBBbRo4NpP8iZAkzhF15+fGZa+SDej2QO0h4e
	 QWKcE23CQ0qhDEOf9O+RG2jeUkNYoH7xke6aNV/awTiwGJGWaYylR/p2pV1s4bM9DT6t1
	 D9ZBKW29E3XFpSMuuQ0zADNp47Nk8HvzRIoHeN3bSDjbzOOkD8FXM6V5s1fcogBUkUJZh
	 v/vyQHtVbgZxQlGo80KgGZN+h/rELeYSHsS2Ch4KebOX3hCZad8tFYEUzdzdCRB2H7LNY
	 kz/WseJd+fh+HsyR4btWtCoyw2Lf49URGs8mQgIrM6bR+WIjxM0DZPP31FUJeDQLU5w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787840527;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=iLXQLGoUqI41trrhyHxHfyWaPwKf76iBzswWgMqkjVE=;
	b=jixMVOQIQeU2tKfuRMDe71eQingj6u6mTu5P2RhetWZmUTRIWBbI5e9PGdOW+cIFBZ8a
	 ZB3oJwRslkh4Z/hqZY97FtcTvNZ6EjLbhy5VtQ7dS3QsAg4NcAQCUOVyzeHK7HjuM68L1
	 m4Jl7zVYFTs4TZQvF7qEJ9WHFcIN0qIDFDQMwpA9+9TuK2RLYw+P3OLo409JHnAQNZkr8
	 D4rn2NcJhzMYG3jBDi0qepecVr10voLUBKCBKezBacZMSZV0whrzVW8Q4+/6YzldrtNsi
	 pueOAV8NIPCaa/ZzaINioB6aR604cGakqqgf4hRu4NQtJXdxo0EcMaINiTzyagtHdAQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=IxngVlih;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=xyxlj1L1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=iO1MlaUM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rC67KEJe;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 89480F8011B
	for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2026 16:22:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89480F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=IxngVlih;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=xyxlj1L1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=iO1MlaUM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rC67KEJe
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA89621B35;
	Thu, 27 Aug 2026 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787840521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OWXyMeKMXqN2dVxCykJf11aI931uGdM6loO15quzjQ=;
	b=IxngVlihtz4Az6hbVqez388ZKVoa9jpcTH7TYmjD+yqR1P1r6rER//I3eDfO9aKDbwkIbP
	xdhKH4wXtvXJ8y5zBwykEN/VEH3kVDzuy0VqwRtXad5fF570IKRhU74BxFBghpsWudlqFw
	NgRSbHRGEKkpEpFFyqPKUGCm1FwIKnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787840521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OWXyMeKMXqN2dVxCykJf11aI931uGdM6loO15quzjQ=;
	b=xyxlj1L1D5JEkfWDe493p/y75/QIqRJgrnn+RxnePJMLVOF/1eo16/pRTgC/mTxN29bzx3
	iBsB4ae49VFzTBCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iO1MlaUM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rC67KEJe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787840517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OWXyMeKMXqN2dVxCykJf11aI931uGdM6loO15quzjQ=;
	b=iO1MlaUMR+kN3mqgZKldwq8PPpQ+lgZtj2O8Tz9ukM3X075m/ubuCLPydIslam/T7/tvCU
	SvIUmW3l29gu/JlZQmSjj6gO/+A1oZAbch/oq1/MgLXXxVj12gqkOnVHFI9RE/OyCQ1w4M
	4LfM/A0m+IJeRxdInxa/TjfSIDJZkbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787840517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OWXyMeKMXqN2dVxCykJf11aI931uGdM6loO15quzjQ=;
	b=rC67KEJebSK+mPhu0RcDzg4qlvg1qQpotq2SoQSHtZz5AzedvGCJ7xF6Sroa3YzcCRZTcT
	+KCRCznszJ4y+5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8441C1352C;
	Thu, 27 Aug 2026 14:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rZnhHgVIkGoFJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 27 Aug 2026 14:21:57 +0000
Date: Thu, 27 Aug 2026 16:21:57 +0200
Message-ID: <87zey7ej96.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-merge-window
In-Reply-To: <b334f5b2d0e7c0c73107f54bfee509b1@kernel.org>
References: <b334f5b2d0e7c0c73107f54bfee509b1@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AA89621B35
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: OK6RB4MUF34GMUPE624XGQD7SF2T5XLT
X-Message-ID-Hash: OK6RB4MUF34GMUPE624XGQD7SF2T5XLT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OK6RB4MUF34GMUPE624XGQD7SF2T5XLT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 27 Aug 2026 15:22:59 +0200,
Mark Brown wrote:
> 
> The following changes since commit 0c7aeb0f5eceb95b5887bd8e83fef865e5a49a13:
> 
>   ASoC: tas2783-sdw: do not treat read-only Controls as writable (2026-08-14 16:20:47 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-merge-window
> 
> for you to fetch changes up to 15596a87fcc6fa07a162858e5fd00ba31752096b:
> 
>   ASoC: amd: acp-config: change quirks to cover all ASUS FA401EA variants (2026-08-27 00:15:37 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.3
> 
> A fairly big batch of fixes that came in during the merge window.
> There's a lot of quirks for x86 systems and a bunch of driver specific
> fixes, the most critical being the fixes for Tegra's register
> definitions.  It turned out that they had been relying on the regmap
> default handling bugs that were fixed in v7.2 and so audio was fairly
> badly broken, unfortunately the issue wasn't noticed in time for
> release.

Pulled now.  Thanks.


Takashi
