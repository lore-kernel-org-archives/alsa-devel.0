Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D42CC6B33
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:18:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 509E960232;
	Thu, 15 Oct 2026 17:18:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 509E960232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792077528;
	bh=mITcLME8QrCkaVocHYuqBS9Lza3cEgTwRwuIm2BoJ5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RMeB5FB4XRgbBvy/6QrzFESSyWk5JfM3fdJWTbz3LhMSC8CoTOeG/Nq/a2ktMmcrZ
	 XJryaFzGzwAIgdXSqJtyJqdKnXLYAdjRpl+IFc7K0ogs9z8Xo1b/mLoMkkz7XzTg6s
	 XJnSEe7rp2cfsxfeImeXTg0xjAxoP4BUd5J3eWWc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCC5EF805F3; Thu, 15 Oct 2026 17:18:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B277F80600;
	Thu, 15 Oct 2026 17:18:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A502F804CF; Thu, 15 Oct 2026 17:18:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792077487;
	b=RH3duGEAInom3PuoHQGWkWFe2pQhxOwOE5zF8TcwZT8eRPRb/suQOD7L6CU9dGepuOie
	 NLLFJzA45LXtnSc/n23V/Vj2/gAj+kfEtJ0BEs2locm9bqO+hBMWxtTA+7zn5AimArbn7
	 p5lM5IA/D04WVQOlXuYJDkiwV1X/Jb1LIRbXY0wGlgPWJi10abKO8QKZy4XxeXNMQHBWg
	 dxJzaE5LA6Vsne3Bux8d5t49EDdamJM4QOFihR9osBkTX2iQ7xdL3X5SRxb7+V4AOVK1e
	 JhdoiU08ENhBZBIKxRwQMKqQj6X6sr3z7HtduXDX2n3dhcGCUqBJlhbsrv7BC0DMHOw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792077487;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=mITcLME8QrCkaVocHYuqBS9Lza3cEgTwRwuIm2BoJ5c=;
	b=qw1LpF4Kl96Yt/3scy+Q/m8vJutjpD6EuKQ3XkwVrQNxd0YscjtsGC+gfxC0ePsliRbH
	 Szyp+kpKQAqsJE/M3JS65D0wKAlu4VitszH/60m966JZbWFjmcvs35LULSOKijlBQXdG4
	 Zxl8RweI77f5T68wGdmJm6rchIYJ1iE6a6x2ctsTrdaRuOwAkeJAgDtO+TCaVDgTlktQH
	 YGVahRIxzTYegGKXjhG9gr6RmEyo4DuLThVJfUtd5PbzXYxkAIKM6QOHVSPbFrZ9mfcGn
	 p5ZChCk4CIqK9T5FSMXrS8v1YiVC1BYCrl0qPsQJhlQA6vuyfwBeAF5FFIWbXsHECyA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Wuz7d0gW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=YMqki1gw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Wuz7d0gW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=YMqki1gw;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AEC66F8026D
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 17:18:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEC66F8026D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Wuz7d0gW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=YMqki1gw;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Wuz7d0gW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=YMqki1gw
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4EED1F86C;
	Thu, 15 Oct 2026 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1792077485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpT89qE6ibgw5hVmLJgOu0WmGnwDzjP7tOfFmQ4hfGA=;
	b=Wuz7d0gWYsRElW5xCwl8oXS5WzRnL3urUnA9oMY9hw4ucKmL12ahB7QhUs2/a+1Tt/KNFf
	O+2zFsgQvJPe9Y772XbiNCwGHEtioVqw7rLBJ8qyHkfwGfqCA8r1T0P+vOoyZmS0IRzLCq
	biBj2tMGPQXkqDO06tclyYpZvhrkMoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792077485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpT89qE6ibgw5hVmLJgOu0WmGnwDzjP7tOfFmQ4hfGA=;
	b=YMqki1gwB+pcANEZx7DTQjaUtOOQwZ0G0VUNbKcpGMFOh44FrO5GXaPZOMRHdFfBuHuksR
	tXJAsmngYFI3McDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1792077485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpT89qE6ibgw5hVmLJgOu0WmGnwDzjP7tOfFmQ4hfGA=;
	b=Wuz7d0gWYsRElW5xCwl8oXS5WzRnL3urUnA9oMY9hw4ucKmL12ahB7QhUs2/a+1Tt/KNFf
	O+2zFsgQvJPe9Y772XbiNCwGHEtioVqw7rLBJ8qyHkfwGfqCA8r1T0P+vOoyZmS0IRzLCq
	biBj2tMGPQXkqDO06tclyYpZvhrkMoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792077485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpT89qE6ibgw5hVmLJgOu0WmGnwDzjP7tOfFmQ4hfGA=;
	b=YMqki1gwB+pcANEZx7DTQjaUtOOQwZ0G0VUNbKcpGMFOh44FrO5GXaPZOMRHdFfBuHuksR
	tXJAsmngYFI3McDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84DC513223;
	Thu, 15 Oct 2026 15:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mX8tFq3u0GoFRwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Oct 2026 15:18:05 +0000
Date: Thu, 15 Oct 2026 17:18:03 +0200
Message-ID: <87qzhr6lhw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc7
In-Reply-To: <bdcee80ff1b48cbbcfacaa3eb404fbca@kernel.org>
References: <bdcee80ff1b48cbbcfacaa3eb404fbca@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: FXR3HG3MFVFI6UKKS5OI6T5ZLSF75DH4
X-Message-ID-Hash: FXR3HG3MFVFI6UKKS5OI6T5ZLSF75DH4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FXR3HG3MFVFI6UKKS5OI6T5ZLSF75DH4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 15 Oct 2026 15:09:26 +0200,
Mark Brown wrote:
> 
> The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:
> 
>   Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc7
> 
> for you to fetch changes up to 2a31b5378c6db9c4a8d399e5d10d32cd4b732bef:
> 
>   ASoC: amd: yc: disable MSI on resume (2026-10-13 14:32:22 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.3
> 
> There's a relatively large block of fixes for errors in register field
> definitions here, resulting from an audit done after review of a prior
> series.  The fixes themselves are very small and can be directly checked
> against the datasheets.  Other than that we've got some driver specific
> fixes, the AMD fix is a little large but fixes a clear issue and won't
> affect other systems.

Pulled now.  Thanks.


Takashi
