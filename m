Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4D9FF8867
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2026 05:51:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F1D5601FD;
	Wed, 29 Apr 2026 07:51:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F1D5601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777441899;
	bh=Ks8xqUo4nFunsJDzaFT8wRLJsrM8THAtbBp+OlBeEKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NRTjHgHEIjomHAz2HQzJf7all+TBGNmj5LwzIBJsXUhrk9F/DY+eAbq8D1qg3kLxi
	 viTx/V/Wj9NAmv+TgfdHkK8zytp6nwQhCYH/jnoUJ+PR+cPVhOSeS5TfRdIAjRfP3u
	 KtITRUWCjEGvabAD3V+fmRDw5xe6X3S9KRwYWn1c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39087F805F8; Wed, 29 Apr 2026 07:51:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 54C14F805E2;
	Wed, 29 Apr 2026 07:51:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09375F80544; Wed, 29 Apr 2026 07:50:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98FACF80073
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2026 07:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98FACF80073
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=2WVLYpka;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+Hl5HztV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=2WVLYpka;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+Hl5HztV
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8BE46A7FC;
	Wed, 29 Apr 2026 05:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1777441851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfkzRoCTWbtx83JlfJ9OhSs1yOQfzIK3aCQ6jA1q3VE=;
	b=2WVLYpkaMdwkLt8nrgdSz++Zkn019/7QjyM/c3fJMrnw4bj4c5HA81r4r8Wlab6POYokWa
	I2UwY2tE01z+aTeyRbfgrXMsWQJnHEcLvCeemmE7uIWaQYo+6glHm6TsJQYOPqEMP0iaF7
	paRa571z0il+OOYkQomDQqFoha9Js+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777441851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfkzRoCTWbtx83JlfJ9OhSs1yOQfzIK3aCQ6jA1q3VE=;
	b=+Hl5HztViF7et0Ito3/fHmw6O7Zf7aJPpiepX/QXlVTws9gV/3HqE4FFJLfBGKY6iXC+/m
	uuEC4yraCrieBgDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1777441851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfkzRoCTWbtx83JlfJ9OhSs1yOQfzIK3aCQ6jA1q3VE=;
	b=2WVLYpkaMdwkLt8nrgdSz++Zkn019/7QjyM/c3fJMrnw4bj4c5HA81r4r8Wlab6POYokWa
	I2UwY2tE01z+aTeyRbfgrXMsWQJnHEcLvCeemmE7uIWaQYo+6glHm6TsJQYOPqEMP0iaF7
	paRa571z0il+OOYkQomDQqFoha9Js+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777441851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfkzRoCTWbtx83JlfJ9OhSs1yOQfzIK3aCQ6jA1q3VE=;
	b=+Hl5HztViF7et0Ito3/fHmw6O7Zf7aJPpiepX/QXlVTws9gV/3HqE4FFJLfBGKY6iXC+/m
	uuEC4yraCrieBgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A83CE593B0;
	Wed, 29 Apr 2026 05:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9yiqJzuc8WmfLwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Apr 2026 05:50:51 +0000
Date: Wed, 29 Apr 2026 07:50:51 +0200
Message-ID: <874ikuqpqc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.1-rc1
In-Reply-To: <20260429054234.CBC321AC5855@finisterre.sirena.org.uk>
References: <20260429054234.CBC321AC5855@finisterre.sirena.org.uk>
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
Message-ID-Hash: BSGTL5IS24T3HLQSIWNI6HH5BPJA2PN6
X-Message-ID-Hash: BSGTL5IS24T3HLQSIWNI6HH5BPJA2PN6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BSGTL5IS24T3HLQSIWNI6HH5BPJA2PN6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 29 Apr 2026 07:42:28 +0200,
Mark Brown wrote:
> 
> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:
> 
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc1
> 
> for you to fetch changes up to 03dcb5b68a96b51157ec2d17042fa2f0106828ae:
> 
>   ASoC: spacemit: adjust FIFO trigger threshold to half FIFO size (2026-04-29 11:41:32 +0900)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.1
> 
> We've had quite a lot of fixes come in this past week, all driver stuff
> rather than any broad systematic issue.  All quite routine stuff.

Thanks, merged now.


Takashi
