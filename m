Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8148ECDE008
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:04:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB9BA601E7;
	Fri, 26 Jun 2026 13:04:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB9BA601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782471859;
	bh=EzRQM6OI2kppfwj8kWMT2isITc9GVWsvpHmLQyd6QX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PSxWxhNuPrW3YqbDtvBbUJcFr45eTvJe6lJcHn6XlKh0KsGuMvPthvcS8+8xXH8FT
	 DuRV+gvh6++J0e4kb26VxGK9fpNENhnw1LqnInMt2NX4RYdapFmrktTNzzlIU5rWlp
	 Gw9GrprIa77nx3MJpF/AbeaoN8PNIs+iUMxf10Tg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2252F80601; Fri, 26 Jun 2026 13:03:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17492F805F0;
	Fri, 26 Jun 2026 13:03:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7B6EF804FF; Fri, 26 Jun 2026 13:03:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782471812;
	b=Y66mkq7YczUgC0opqa+AaGN2ftbSI4AvTFfo6XtAhUj216Sdb72Qa+1duXG1oefVDSBg
	 aowPO0nniM4XST4XyaE/oyEnQcNI15xPdL2nJ0T6BXLk74yBMHdi7mYp8aN7vWS5jAevb
	 QwZeI2NUeD8aunDxAmR989MweJkr50V9mp3XxGfL3fEvGECJxwq3OPhg9CPoBtZ3dhXQ+
	 RFFX4VpSIOLmamKpw8qElh+z0tdcCK8OZA6FH8mlH6VNAasa75+ps0sPl8eQZocOm2AuK
	 c4WXQHyMY7bpfcxJ1wnsPlypCPlfp2boZbYjvYsoj35kjqSjHrUkunPWDFWoyHE3qiw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782471812;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=EzRQM6OI2kppfwj8kWMT2isITc9GVWsvpHmLQyd6QX4=;
	b=K+OeF2eKuL+XM1SQEV9QZtFWLXJcDyn60xIskk04/IBwDvQOZpOjHxeJlGm0wptmbL48
	 c0DvYDupz1nUKVIcrOavQcJ0PXuw770nu9rNy7YSONBz+IANuvAqGpE8ArYX2Tx+ZXpZ7
	 PpJ38PC+FSu6jKSqZ05vx0B4y5UoqXk4pGKdc9VdbnEp9aqGOSKJmorRWG/v03nICU1i4
	 MZsgG13ZqjlUfk+uydpA7SVnsrQ8w84Zr3vu8R+IYEQD0ppiH/VdkHP3Gd2AgiR11Jh/y
	 +VV86XcgQjggHe0cZ6FLebDeS4I/KjhXP8QkA2wbWg0ehHMaCqWbSBz1E9rVpn1g34A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=JvOeDnui;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PxqVVgGK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=JvOeDnui;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PxqVVgGK;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4BD5BF800D0
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 13:03:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BD5BF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=JvOeDnui;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PxqVVgGK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=JvOeDnui;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PxqVVgGK
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7896275B33;
	Fri, 26 Jun 2026 11:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1782471810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+A4ISRCw2qaxZ8t9GACjOAIzRGA5qLb/RtkUaiNEQI=;
	b=JvOeDnuiK9n68PM9RY4QmA4naapQXmH+p68PsvixoY96jhSIKwoHbDrnEW9WGK2t14zaA8
	uQLtHYs6cb0NsMwTAanfduugVFr1balT/rfv1Yc1IYr7zc2Yxpz/bLty69PTkc4eanURjK
	ApT0VdWzDWLwN+q1EbW5/zgg7hi8LQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782471810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+A4ISRCw2qaxZ8t9GACjOAIzRGA5qLb/RtkUaiNEQI=;
	b=PxqVVgGK6t5uczBACJuNei4BzJLL8Bw0VzUa2cbj34RvdF8MzmcDN/uh3RJhDA2+3ULKZe
	gVFcR47c7nKpG4CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1782471810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+A4ISRCw2qaxZ8t9GACjOAIzRGA5qLb/RtkUaiNEQI=;
	b=JvOeDnuiK9n68PM9RY4QmA4naapQXmH+p68PsvixoY96jhSIKwoHbDrnEW9WGK2t14zaA8
	uQLtHYs6cb0NsMwTAanfduugVFr1balT/rfv1Yc1IYr7zc2Yxpz/bLty69PTkc4eanURjK
	ApT0VdWzDWLwN+q1EbW5/zgg7hi8LQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782471810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+A4ISRCw2qaxZ8t9GACjOAIzRGA5qLb/RtkUaiNEQI=;
	b=PxqVVgGK6t5uczBACJuNei4BzJLL8Bw0VzUa2cbj34RvdF8MzmcDN/uh3RJhDA2+3ULKZe
	gVFcR47c7nKpG4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59AE4779A8;
	Fri, 26 Jun 2026 11:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N2LMFIJcPmrgHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Jun 2026 11:03:30 +0000
Date: Fri, 26 Jun 2026 13:03:26 +0200
Message-ID: <87bjcxtvgh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-merge-window
In-Reply-To: <8d888870bec370f9abaad606055cdb75@kernel.org>
References: <8d888870bec370f9abaad606055cdb75@kernel.org>
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
Message-ID-Hash: DI4QDT6YNBL3O2UH3CVYFPVFJWJHMCGL
X-Message-ID-Hash: DI4QDT6YNBL3O2UH3CVYFPVFJWJHMCGL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DI4QDT6YNBL3O2UH3CVYFPVFJWJHMCGL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 25 Jun 2026 19:01:19 +0200,
Mark Brown wrote:
> 
> The following changes since commit 4346d91cfa47b0d9303533edde8acd33e4b9ca40:
> 
>   ASoC: dt-bindings: Fix RT5677 "realtek,gpio-config" type (2026-06-14 01:03:38 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-merge-window
> 
> for you to fetch changes up to cf6f56990ea21172e085f0588e5bbf2089ce8f58:
> 
>   ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count (2026-06-25 14:56:27 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.2
> 
> We've got a good collection of device specific fix here, plus a couple
> of stand out things:
> 
>  - Richard fixed some special cases with the new device_link creation
>    by more gracefully handling any errors during creation.
>  - Charles did some light refactoring of the SoundWire interfaces to
>    fix some persistent randconfig issues that people kept running into.

Thanks, pulled now.


Takashi
