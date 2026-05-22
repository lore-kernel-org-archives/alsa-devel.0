Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567F6CD5BC0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 07:55:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6F4C6021A;
	Mon, 25 May 2026 09:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6F4C6021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779695741;
	bh=FG36n5rI8ytB4pzPFcI60c/5FReybSIcQ8cI/amvm2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=K7p67Sf2tuMFGXm7ZMjTUjAvuX8VKva4kthS9IXEH63UZzlJLNhy950JLnTq0X1IV
	 8o+u6eLPVDvXxJPh5owL+9eN8dRSLYbWs7R7eInBFuFwx+/dRfKSeLAolp3LW4AWzM
	 nfDR7/SyUEv/au4AFKDQTAD6aDTs23J8/ebOUhAo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F5DAF805F1; Mon, 25 May 2026 09:55:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 06BC2F805ED;
	Mon, 25 May 2026 09:55:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0240F80557; Mon, 25 May 2026 09:55:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5135AF8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 09:54:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5135AF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=u9iQAyNC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CdO+KYKZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=DVFvC7Z5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=V7DOtVEi
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AFEC6794F;
	Fri, 22 May 2026 08:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779437018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84cc6ARVjkJIeKL/WhtsX0tQyERjYN9aPbPG3YOx/I8=;
	b=u9iQAyNCNqGVbFD7Zr/aoVdpW8aqDJ08pmBBr73S6OQIOOf+y5a4YLSGcWqZ3c+WYDsTLD
	7FMUiZOeObsfTn/MKU22U3GVQy1U/p9SLFwRYRq3+uaXNhgGqpGnAB4aHGxlggYPp2YRJL
	+kl/jAt4antX1DJT6/dGm1oYXxZ6K3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779437018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84cc6ARVjkJIeKL/WhtsX0tQyERjYN9aPbPG3YOx/I8=;
	b=CdO+KYKZj0pifFETQL50YeIQHkw1Py+gFBLJZpHMwNotRD4jxBv4cSiGIThERJiipKz/HC
	jBuKstOnZK1I2IAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779437017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84cc6ARVjkJIeKL/WhtsX0tQyERjYN9aPbPG3YOx/I8=;
	b=DVFvC7Z5pZFgUwblwkm4d1woj4qnz5nlJreQDiX9AQGzXpn68hQwla9S9enSNnctMWGbBy
	ugeGVXRWn7+UCx7oeq7j5HKEPTyEPhl9krTBfZ3Y6cHV2F/J9IahCwxi08ioyO5Oy9uGWy
	fg738+BLyS10dT18tdskf6Ybh0lheFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779437017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84cc6ARVjkJIeKL/WhtsX0tQyERjYN9aPbPG3YOx/I8=;
	b=V7DOtVEiGsmW1Dt/6eHRE/4dMK1w+UBXgkF2jnScFyVfq1xNdixe7AoxF3TOc6x9M0j3dC
	GUK3XTYr6MJJVICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76601593A8;
	Fri, 22 May 2026 08:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P0G7G9kNEGr2bQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 22 May 2026 08:03:37 +0000
Date: Fri, 22 May 2026 10:03:37 +0200
Message-ID: <87o6i7j2g6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.1-rc4
In-Reply-To: <330b62a00eb5358e06742f419308fa7e@kernel.org>
References: <330b62a00eb5358e06742f419308fa7e@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: LSH6MEAJF3BTZSBVUV5H6URQ2BOXU5MC
X-Message-ID-Hash: LSH6MEAJF3BTZSBVUV5H6URQ2BOXU5MC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LSH6MEAJF3BTZSBVUV5H6URQ2BOXU5MC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 22 May 2026 01:22:11 +0200,
Mark Brown wrote:
> 
> The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:
> 
>   Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc4
> 
> for you to fetch changes up to 09e8f9a9aa19aa8c1b0cc7a0ebc68f6ecf86a660:
> 
>   ASoC: codecs: pcm512x: fix null-ptr dereference in pcm512x_overclock_xxx_put() (2026-05-21 19:28:24 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.1
> 
> A bigger batch of fixes than usual due to -next not happeing last week,
> this is mostly stuff for laptops - a lot of quirks and small fixes,
> mainly for x86 and SoundWire.  Nothing too big or exciting individually,
> just two week's worth.

Pulled now.  Thanks.


Takashi
 
