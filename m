Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C01C83F17
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:00:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C26EF60191;
	Thu, 10 Jul 2025 12:00:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C26EF60191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1752141649;
	bh=TtLlzQqd5tZvNnxw3qyfQUR7Ez3lkqF6UaW2GqdHwAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=J64V/hP8Smvh8ERx6ZOQ35MbBb+U8ThuOgoEmYOH2zLPDJyA8ZocvXJTyDv8npHHi
	 KP4iTyDpD3zt9EkzdwyS1GCKlQcgqsqpNCwE9fQj+MwI4YFj/riqBPn+7oxJNnUmyz
	 6lldEDp525Zc7baxh0Q7DXm5tMKGF9SjTQbygpoQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82169F8057B; Thu, 10 Jul 2025 12:00:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C162AF805BD;
	Thu, 10 Jul 2025 12:00:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8C85F80526; Thu, 10 Jul 2025 12:00:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 56A5AF800B5
	for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2025 11:59:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56A5AF800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ZCaEufIS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=MAPAj1p7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ZCaEufIS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=MAPAj1p7
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2498F1F453;
	Thu, 10 Jul 2025 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1752141596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4daigcXA6tja+Mm6/mzxvC5Qfz85uJL8Hw8olTbMzBw=;
	b=ZCaEufISCMWZSNfeuv9eJs5WFe4jDTrnMj5PM9knCLBjFgh+m7qU7AuDHon3Ylk2mpd+lH
	JQkS/PxXqgs8rFBasf5qwKS3AkGGMe2ihybjt2toMjThQwL1BKjszfT45oT8skb4jwxfPb
	vAH4RuO9gvZ29qSc38Saq6QVtm5tUFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752141596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4daigcXA6tja+Mm6/mzxvC5Qfz85uJL8Hw8olTbMzBw=;
	b=MAPAj1p7p0iU/iQ1n9iGMYvHNeaktwLoKgBU5LoTT3AwxXEfoTqFiXe6QF87sUMz1WChDc
	Oaif5FhGY5k73nDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZCaEufIS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MAPAj1p7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1752141596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4daigcXA6tja+Mm6/mzxvC5Qfz85uJL8Hw8olTbMzBw=;
	b=ZCaEufISCMWZSNfeuv9eJs5WFe4jDTrnMj5PM9knCLBjFgh+m7qU7AuDHon3Ylk2mpd+lH
	JQkS/PxXqgs8rFBasf5qwKS3AkGGMe2ihybjt2toMjThQwL1BKjszfT45oT8skb4jwxfPb
	vAH4RuO9gvZ29qSc38Saq6QVtm5tUFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752141596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4daigcXA6tja+Mm6/mzxvC5Qfz85uJL8Hw8olTbMzBw=;
	b=MAPAj1p7p0iU/iQ1n9iGMYvHNeaktwLoKgBU5LoTT3AwxXEfoTqFiXe6QF87sUMz1WChDc
	Oaif5FhGY5k73nDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 020FD136DC;
	Thu, 10 Jul 2025 09:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 453sOhuPb2jyVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Jul 2025 09:59:55 +0000
Date: Thu, 10 Jul 2025 11:59:55 +0200
Message-ID: <87bjpsxt5w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v6.16-rc5
In-Reply-To: <cb13b10edfb1dac2bb7bee3d2f50f44c.broonie@kernel.org>
References: <cb13b10edfb1dac2bb7bee3d2f50f44c.broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 2498F1F453
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: IRQ2RTMALY6VWBDNVEKZN5PDDXSRZWR3
X-Message-ID-Hash: IRQ2RTMALY6VWBDNVEKZN5PDDXSRZWR3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IRQ2RTMALY6VWBDNVEKZN5PDDXSRZWR3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 10 Jul 2025 10:53:07 +0200,
Mark Brown wrote:
> 
> The following changes since commit 3b3312f28ee2d9c386602f8521e419cfc69f4823:
> 
>   ASoC: cs35l56: probe() should fail if the device ID is not recognized (2025-07-03 12:22:27 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.16-rc5
> 
> for you to fetch changes up to a609bd74b8680dba62c44f7e6d00d381ddb2d3c0:
> 
>   ASoC: Intel: avs: Fix NULL ptr deref on rmmod (2025-07-08 14:54:40 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v6.16
> 
> Two patches here, one quirk for an AMD system and a fix for an issue on
> remove of the AVS driver.

Pulled now.  Thanks.


Takashi
