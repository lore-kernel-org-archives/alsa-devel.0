Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782CEC54E90
	for <alsa-devel@archiver.kernel.org>; Sun, 25 May 2025 07:43:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC80C601E9;
	Sun, 25 May 2025 09:42:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC80C601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748158989;
	bh=EiTBAm8Cjq1dLNwa50SlUHY34S7BzE2h5cLFgVj6BoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V4FMTwGo/go71kejmsTOEa1rrU6xef4zwAH1DUNlG5nDQLNBAci/JwXAOwssUTPJO
	 uek5GAIGL0aUeTofv4Cv2nWaTbrUUIJp24BHk8zQaLSK/rCjAPbv4KxlmkZRZ/QZIi
	 rtSgAdWn+dMM0vgV4beYVSU5MeGylXSSy6fRSPQw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 218DFF805BE; Sun, 25 May 2025 09:42:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F146F805B6;
	Sun, 25 May 2025 09:42:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3CBEF80236; Sun, 25 May 2025 09:42:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CC577F800C1
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2025 09:42:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC577F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=GhQNrpVv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6iL6es4l;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=GhQNrpVv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6iL6es4l
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1EEC1FDF4;
	Sun, 25 May 2025 07:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1748158949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IyQEsu8+Kc0Z0N3KtOYPqaTrUjwc2vl9a/GydsJEmiM=;
	b=GhQNrpVvb9Gk53VauKAGy22M8mlt0r1rzn0YwfCTlz0902l2De2wia5dFRRbiTtzopyRSD
	JR8K9juUm8sm778A3GhMcbVNCPw7M4VLKlcQeH8mP+cM/P6KWGxB6pbk2fZeAXolsecIm3
	fHW1uKK5TiLuRSp7GYpRWigFVlrot4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748158949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IyQEsu8+Kc0Z0N3KtOYPqaTrUjwc2vl9a/GydsJEmiM=;
	b=6iL6es4lM8rsSXbKc7DedezIvfPWEgP+6K/dae7dFgCZ90yds4O4xo42GzRQSkfmOVQ20H
	5ella6BsfWjUiXCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1748158949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IyQEsu8+Kc0Z0N3KtOYPqaTrUjwc2vl9a/GydsJEmiM=;
	b=GhQNrpVvb9Gk53VauKAGy22M8mlt0r1rzn0YwfCTlz0902l2De2wia5dFRRbiTtzopyRSD
	JR8K9juUm8sm778A3GhMcbVNCPw7M4VLKlcQeH8mP+cM/P6KWGxB6pbk2fZeAXolsecIm3
	fHW1uKK5TiLuRSp7GYpRWigFVlrot4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748158949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IyQEsu8+Kc0Z0N3KtOYPqaTrUjwc2vl9a/GydsJEmiM=;
	b=6iL6es4lM8rsSXbKc7DedezIvfPWEgP+6K/dae7dFgCZ90yds4O4xo42GzRQSkfmOVQ20H
	5ella6BsfWjUiXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E64313794;
	Sun, 25 May 2025 07:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rCZtH+XJMmiJZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 25 May 2025 07:42:29 +0000
Date: Sun, 25 May 2025 09:42:28 +0200
Message-ID: <874ix9rva3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v6.15-rc7
In-Reply-To: <c5f1dacf2885ff4eb1c04fa0faadd0b9.broonie@kernel.org>
References: <c5f1dacf2885ff4eb1c04fa0faadd0b9.broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.26 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.16)[-0.816];
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: CEEUJLJNLKW2EZWZRGOIBTKMWP62CW2R
X-Message-ID-Hash: CEEUJLJNLKW2EZWZRGOIBTKMWP62CW2R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CEEUJLJNLKW2EZWZRGOIBTKMWP62CW2R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 25 May 2025 00:34:38 +0200,
Mark Brown wrote:
> 
> The following changes since commit 7dd7f39fce0022b386ef1ea5ffef92ecc7dfc6af:
> 
>   ASoC: SOF: Intel: hda: Fix UAF when reloading module (2025-05-14 16:34:48 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.15-rc7
> 
> for you to fetch changes up to 688abe2860fd9c644705b9e11cb9649eb891b879:
> 
>   ASoC: qcom: sdm845: Add error handling in sdm845_slim_snd_hw_params() (2025-05-20 10:24:59 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v6.15
> 
> A couple more small fixes for v6.15, both of which could also easily
> wait until the merge window.

This was already pulled.


thanks,

Takashi
