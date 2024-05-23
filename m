Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42024C25B75
	for <alsa-devel@archiver.kernel.org>; Thu, 23 May 2024 11:37:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 646756C0;
	Thu, 23 May 2024 13:36:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 646756C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716464225;
	bh=RsRAxgtCygUgNHJsQhBo7tVIAJyPh/eD/4LRaq/+G7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ASfKIzPHoN9BgC/lsK1OI2NnMCOHgCGxfonrr9q1Sp9Fkj5DkwEGg47rtrZVAkHbk
	 u2QT9uX1WKxQQ4JsLcAyAtGL1w3FMSTE/NqEKxNlCjeDopnpUTNEehaAsva2nk2ucM
	 DZkd8rsqZYufJVSENInlI+iAAk9pcJnU0v9Qq2a4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4D80F805A8; Thu, 23 May 2024 13:36:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 847EBF804B2;
	Thu, 23 May 2024 13:36:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29F24F8026A; Thu, 23 May 2024 13:36:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3EBF4F80051
	for <alsa-devel@alsa-project.org>; Thu, 23 May 2024 13:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EBF4F80051
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=NlnGadG2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Fv1QfaDZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=NlnGadG2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Fv1QfaDZ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA75922603;
	Thu, 23 May 2024 11:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1716464172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhhEjdcH4WaOTJEZIfR5/Uon7VzyFCJi1b1I3aj174M=;
	b=NlnGadG2HoTrCnkyzfDR4Trm4N6dV6zcRBh2IjCKuJiwSFYhpWfpf0DKYhwRLAySOiied0
	x/TRAtTKTZ0p8bEdJEqrsBEZ7FncoK9fOqzLBMLH0ksbJtQPqgHB9MN/PxR4+/KAxiUbQN
	Bd9dZ4x6ebZuvLV0Ch9CIGJai04/f58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716464172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhhEjdcH4WaOTJEZIfR5/Uon7VzyFCJi1b1I3aj174M=;
	b=Fv1QfaDZ68lQDaKSiNdxfcgCuHh3U00C4dLHs3caCKt36pN+MCrRlhjSSvE2662g8b6rdL
	loGslI12OrURRkDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1716464172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhhEjdcH4WaOTJEZIfR5/Uon7VzyFCJi1b1I3aj174M=;
	b=NlnGadG2HoTrCnkyzfDR4Trm4N6dV6zcRBh2IjCKuJiwSFYhpWfpf0DKYhwRLAySOiied0
	x/TRAtTKTZ0p8bEdJEqrsBEZ7FncoK9fOqzLBMLH0ksbJtQPqgHB9MN/PxR4+/KAxiUbQN
	Bd9dZ4x6ebZuvLV0Ch9CIGJai04/f58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716464172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhhEjdcH4WaOTJEZIfR5/Uon7VzyFCJi1b1I3aj174M=;
	b=Fv1QfaDZ68lQDaKSiNdxfcgCuHh3U00C4dLHs3caCKt36pN+MCrRlhjSSvE2662g8b6rdL
	loGslI12OrURRkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C968213A6C;
	Thu, 23 May 2024 11:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nP+dMCwqT2YIZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 23 May 2024 11:36:12 +0000
Date: Thu, 23 May 2024 13:36:32 +0200
Message-ID: <87a5kgbvzz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v6.10-merge-window
In-Reply-To: <285471261b77e5d769b6bb55375edea3.broonie@kernel.org>
References: <285471261b77e5d769b6bb55375edea3.broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.28 / 50.00];
	BAYES_HAM(-2.98)[99.90%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: D6CARTBRMVW7YTOIYC24KTPXW67BCBN7
X-Message-ID-Hash: D6CARTBRMVW7YTOIYC24KTPXW67BCBN7
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D6CARTBRMVW7YTOIYC24KTPXW67BCBN7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 23 May 2024 13:24:23 +0200,
Mark Brown wrote:
> 
> The following changes since commit c3c5ac4bd7d7019f2e3ad1720572d53226fe656e:
> 
>   ASoC: Intel: updates for 6.10 - part7 (2024-05-10 12:30:12 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.10-merge-window
> 
> for you to fetch changes up to 737ce4fb96206f999ddea7530145fc0e8abd5d31:
> 
>   ASoC: dt-bindings: stm32: Ensure compatible pattern matches whole string (2024-05-21 12:35:12 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v6.10
> 
> A bunch of fixes that came in during the merge window, all driver
> specific and none of them especially remarkable.

Pulled now.  Thanks.


Takashi
