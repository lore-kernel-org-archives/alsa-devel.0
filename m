Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D5BE98FAC
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:05:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98604601E9;
	Thu,  9 Apr 2026 07:05:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98604601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775711118;
	bh=CdOARQ7xdKOTAz/gWlc7aLMoFrq3OZCQGPT7C3xGY7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rmGmIzBuA1SWF0z1sOs7al4+amUWUgFtv9kpmtXViLPqArAyWVGsnT7kbjT4bcpbI
	 BfzlOg1mCmkdWxhJKnTu0/P02GL61H7LedZnCoGbmtA7gSWuugZHJZ0osGnQnXz+ZD
	 GZ1zrzgcLpIAP2wMhR2Zt/YRLXlgdz+lz8av9OWo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BBAEF805F0; Thu,  9 Apr 2026 07:04:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FA00F805F2;
	Thu,  9 Apr 2026 07:04:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12F6EF8052D; Thu,  9 Apr 2026 07:04:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4C494F8027B
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 07:04:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C494F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=f208/IiB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=MW8Iu39d;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=f208/IiB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=MW8Iu39d
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39AE85BCE6;
	Thu,  9 Apr 2026 05:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1775711061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PowfDnVnjDbaEsC+/Y1jCiSqzUffPCN8GETcyH+Anfw=;
	b=f208/IiB+y3K/OFPxdwmcPB/cJvgPGEnM9w/Kcu6zY/XP71wjqxzBmbWS3W2erUVd+jksj
	U5IaAt/TcAuhDFH8daaKMxqRP5DVRRYLNCT1c0qHzXUdbp5pmO9jNEdUKw17jhCh++noym
	xGeTDhk9pCqE2yynZjudNSOywBLud1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775711061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PowfDnVnjDbaEsC+/Y1jCiSqzUffPCN8GETcyH+Anfw=;
	b=MW8Iu39dnrFLKwKRyDRZ2qLRB0u5u9rCGa3EUpivQWubbGFB48ze+guw+6fI67icv42H16
	RuzT+VXixrQ5IyDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="f208/IiB";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MW8Iu39d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1775711061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PowfDnVnjDbaEsC+/Y1jCiSqzUffPCN8GETcyH+Anfw=;
	b=f208/IiB+y3K/OFPxdwmcPB/cJvgPGEnM9w/Kcu6zY/XP71wjqxzBmbWS3W2erUVd+jksj
	U5IaAt/TcAuhDFH8daaKMxqRP5DVRRYLNCT1c0qHzXUdbp5pmO9jNEdUKw17jhCh++noym
	xGeTDhk9pCqE2yynZjudNSOywBLud1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775711061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PowfDnVnjDbaEsC+/Y1jCiSqzUffPCN8GETcyH+Anfw=;
	b=MW8Iu39dnrFLKwKRyDRZ2qLRB0u5u9rCGa3EUpivQWubbGFB48ze+guw+6fI67icv42H16
	RuzT+VXixrQ5IyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14AB14A0B3;
	Thu,  9 Apr 2026 05:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b7XFA1Uz12l4QQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 09 Apr 2026 05:04:21 +0000
Date: Thu, 09 Apr 2026 07:04:20 +0200
Message-ID: <874ilklo6j.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.0-rc7
In-Reply-To: <20260408221922.6194F1AC52C7@finisterre.sirena.org.uk>
References: <20260408221922.6194F1AC52C7@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 39AE85BCE6
Message-ID-Hash: 5LLDW63PWEPXG653OQQ73LFWN5EI2FMO
X-Message-ID-Hash: 5LLDW63PWEPXG653OQQ73LFWN5EI2FMO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5LLDW63PWEPXG653OQQ73LFWN5EI2FMO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 09 Apr 2026 00:19:17 +0200,
Mark Brown wrote:
> 
> The following changes since commit 591cd656a1bf5ea94a222af5ef2ee76df029c1d2:
> 
>   Linux 7.0-rc7 (2026-04-05 15:26:23 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rc7
> 
> for you to fetch changes up to 6b6f7263d626886a96fce6352f94dfab7a24c339:
> 
>   ASoC: amd: acp: update DMI quirk and add ACP DMIC for Lenovo platforms (2026-04-08 17:04:47 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.0
> 
> A somewhat larger set of fixes than I'd like unfortunatey, not from any
> one place but rather spread out over different drivers.  We've got a
> bunch more fixes for the SDCA interrupt support, several relatively
> minor SOF fixes, a few more driver specific fixes and a couple more AMD
> quirks.

Pulled now.  Thanks.


Takashi
