Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13528C55160
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:07:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA3CE60202;
	Thu, 30 Jul 2026 14:07:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA3CE60202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785413234;
	bh=39mfrrpfYdFv4mNaGGv6I1NIPYSXv2dHfa/zMKTuNTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=An5CkJSSI6xUrJxhX7jLfTMebEkUbNuCBDUuOym+dngb9V8CMndrr/+C0jBOK02DW
	 fqvMb1SRBXHG9XpEwjrTCH/WSDDCAHYb9If91hOFs/iMuKLRqTZ8KywjPagNM04rMt
	 dYvMt3tzZZoobHQNI+tYP/8IvazM71L8Rb0VTYxw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF4E0F805FD; Thu, 30 Jul 2026 14:06:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F81BF805FB;
	Thu, 30 Jul 2026 14:06:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B299FF80496; Thu, 30 Jul 2026 14:06:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785413193;
	b=hf0nNQqfFRJAenq2WoF8otRtDkOMH1Ilr7Fzr6rNyN7/wy4F2Bl6vRdHzLaWu/OxCs0F
	 eHLGKcDm2SCYG5YZ6ZbsdAMwdQ3mAp5ld4ntjm+g1+s0V0wNs9y+QRi478pGBKWhGSCE6
	 /GbDfP/gahEZPWfxPr9w+XrVrVweRU8wjQulf6UXWoSbmga7QzQBNfsgX2GLKRnqoXl1W
	 MesZI+dq9o3jg8DMXQOqNlNA4/lyg39pb/NzyX+k+WTvWnIISI6CxRKn+KFv+pCbeNGUs
	 +caty4u6/auK6zoQUYAMhGlXVZYX4aNPNQ/IAzyZw9u79Ql7TMGS941YTHbkx6T76EQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785413193;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=39mfrrpfYdFv4mNaGGv6I1NIPYSXv2dHfa/zMKTuNTs=;
	b=jRzFl44NIXueseK8ne/2/53ZhgCDw98m8g+zIFyWiy6PiuOq9j0FFtWyyOeipnlrduF3
	 7UH14K6dvkhDPTc+uupIkVq8LV1ZtBqxwS71g80XOIHGHyJEezmRzNBdYbA31LjSZtOAQ
	 h3cdepeRPgVKsPDXJZmm5nuquBAt8++r1eWBGToByMpZ4XjXwcqf0+eyDKQQMSYN6x4gk
	 2xQcLPEqSeqS+Rn+Kj4Sn94s/KLm/IuidPbeXsciYm0CgQw0/tcVtcaUOYyfvWZFdbjop
	 4zw3vQhsd9drgAdlY/pF2YptnymZNVf/PC23I6fDB9MudhsodVqXDMnT5bIRK5/0XFA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=LjB0PdZ5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=awZhKw2m;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="KMVH2/2Y";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fz0584Yb;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 59EAEF800FE
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 14:06:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59EAEF800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=LjB0PdZ5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=awZhKw2m;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=KMVH2/2Y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fz0584Yb
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48AC54044;
	Thu, 30 Jul 2026 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785413187;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uies+4fiZtJGLP+ytvUX5c7RGybkh/5ohePC6REuE/0=;
	b=LjB0PdZ52gOoV9QV6X65WnZhCU1XnoePl7qZdaHNSuzYdE/MczVNWv8hd4IPlNbzLfkR74
	5II3HOAUkBHSKcPx1kU5HDpUQ+Z02BWwXrswt7YmOP5IfQihdzOxh7u2CwJWnjkkJPV4YV
	5BV8stZ3QCaq7RCD2MVpTpm3f4gq+wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785413187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uies+4fiZtJGLP+ytvUX5c7RGybkh/5ohePC6REuE/0=;
	b=awZhKw2m4hyGf7YX8tP3FeAUJI4++lqvth8nqCuTNiF6JEyyg+YzTkcAPwwyq1IjxnuFh1
	sVGQY1qoV5TV1QBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785413183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uies+4fiZtJGLP+ytvUX5c7RGybkh/5ohePC6REuE/0=;
	b=KMVH2/2YYBY9BlogjzdGJ3nK46qG3CbvDrPTwHdpPKBPQmq82BW862VmbcYkmTYspMtj8p
	RRKHv5MRmRnJGQJDMfSXJFLFDe790XwyyxyrFBnIqQhxn7AWooSc6zs9ec1rIMtCQgYvJ9
	a3Yu+ZhY7Cf/LF5Jj6fv4fVLHhbipGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785413183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uies+4fiZtJGLP+ytvUX5c7RGybkh/5ohePC6REuE/0=;
	b=fz0584Yb2Cei/Ieo9lvJVLZ26jRQ5l0/eU2b6qrLSd5/gfcbT1x4mGEhILc/j8EIb1qqpG
	tOcRb7c8uoiO8zDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 211E8779D0;
	Thu, 30 Jul 2026 12:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ShnZBj8+a2oREwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 30 Jul 2026 12:06:23 +0000
Date: Thu, 30 Jul 2026 14:06:22 +0200
Message-ID: <87cxw43cn5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-rc5
In-Reply-To: <036cc4fbb2a3c0ffc45ac4373f6f5c9e@kernel.org>
References: <036cc4fbb2a3c0ffc45ac4373f6f5c9e@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: WIL5J7UNQLTX2MHELBBIDDETHMAR4HGA
X-Message-ID-Hash: WIL5J7UNQLTX2MHELBBIDDETHMAR4HGA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WIL5J7UNQLTX2MHELBBIDDETHMAR4HGA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 30 Jul 2026 13:49:18 +0200,
Mark Brown wrote:
> 
> The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:
> 
>   Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc5
> 
> for you to fetch changes up to d0ecbedd6a70f2fe768d46de740265dc8a4424e3:
> 
>   ASoC: rt722: reset codec to fix abnormal sound (2026-07-29 23:27:37 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.2
> 
> This is a relatively large set of updates, the biggest batch of things
> is Charles' fixes for the SDCA code which have been through a number of
> iterations on the list and deal with a bunch of issues that have been
> seen as we get more real world usage of SDCA.  We also have the usual
> device specific fix and quirk traffic that we tend to see, there's a
> small pile of fixes for the tas2562 driver since I saw some bugs while
> reviewing fixes sent by Haidar Lee but it's nothing too remarkable.

Pulled now.  Thanks.


Takashi
