Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC1D10BA45D
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:22:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A0C2601C1;
	Fri, 27 Mar 2026 10:22:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A0C2601C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774603355;
	bh=s9XQ5kv5e+sY/W/Bdqv4K4Bni03vY8UbEJl/6hWk5wA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jujlghkW3p2sRzr4rPYlqBJ3byRMbgOHXu6ae/U1c9MF6cN0JH/I2GIm0FgbsiW5m
	 qs7WOclBudWz1demzgXWQsMz+qPfvFJdXlilHeWIfqsQ3S0Don73IrwL15ojicZg2w
	 OuK3hPmjSl9PJ0VnA49jk2UGWKzXZfWGxG9ASNrY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 986D2F805EE; Fri, 27 Mar 2026 10:22:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD460F805EE;
	Fri, 27 Mar 2026 10:22:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41430F804F3; Fri, 27 Mar 2026 10:21:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 19063F8025A
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 10:21:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19063F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Nh3uuOo5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0UPQr57A;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Nh3uuOo5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0UPQr57A
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21F5C4D1C7;
	Fri, 27 Mar 2026 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774603307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym+YAyRZYoHgguaVtrmW7eqlKvCM7BAFuE0LZ0RcAL4=;
	b=Nh3uuOo5OBcIRefTgOycM5IKz7+xHuu3TGPrwiQqpV8deIUjmng7SmxY2QxNMeerS3vK0J
	F9891UserV6lIr8xx1PrzoVDxITXh4Q1E9rg9Gz7oxXDx5OTvt4r8cUgBOCTUejaOPRosq
	4e2m9qE/JJqH/Ay7V54n1Sm9RKGu5EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774603307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym+YAyRZYoHgguaVtrmW7eqlKvCM7BAFuE0LZ0RcAL4=;
	b=0UPQr57A1aLm7x+G+W9XxXDB97JrO10xqSrDlZpkP/L2tbvFMjRhUfJLFzDOueNwrHRBu6
	CulJe2XY5OJ03iBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774603307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym+YAyRZYoHgguaVtrmW7eqlKvCM7BAFuE0LZ0RcAL4=;
	b=Nh3uuOo5OBcIRefTgOycM5IKz7+xHuu3TGPrwiQqpV8deIUjmng7SmxY2QxNMeerS3vK0J
	F9891UserV6lIr8xx1PrzoVDxITXh4Q1E9rg9Gz7oxXDx5OTvt4r8cUgBOCTUejaOPRosq
	4e2m9qE/JJqH/Ay7V54n1Sm9RKGu5EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774603307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym+YAyRZYoHgguaVtrmW7eqlKvCM7BAFuE0LZ0RcAL4=;
	b=0UPQr57A1aLm7x+G+W9XxXDB97JrO10xqSrDlZpkP/L2tbvFMjRhUfJLFzDOueNwrHRBu6
	CulJe2XY5OJ03iBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0F4C4A0A2;
	Fri, 27 Mar 2026 09:21:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fYi4NypMxmkuGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 09:21:46 +0000
Date: Fri, 27 Mar 2026 10:21:46 +0100
Message-ID: <87se9lsk45.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.0-rc5
In-Reply-To: <35eee6c4ded9dcae303afc38a82c36a1@kernel.org>
References: <35eee6c4ded9dcae303afc38a82c36a1@kernel.org>
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
Message-ID-Hash: 4UA6CJDFRJGXMCG4FWIEDB6PAHPNQTSV
X-Message-ID-Hash: 4UA6CJDFRJGXMCG4FWIEDB6PAHPNQTSV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4UA6CJDFRJGXMCG4FWIEDB6PAHPNQTSV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 26 Mar 2026 14:32:46 +0100,
Mark Brown wrote:
> 
> The following changes since commit c369299895a591d96745d6492d4888259b004a9e:
> 
>   Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rc5
> 
> for you to fetch changes up to d40a198e2b7821197c5c77b89d0130cc90f400f5:
> 
>   ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload (2026-03-26 11:16:03 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.0
> 
> This is two week's worth of fixes and quirks so it's a bit larger than
> you might expect, there's nothing too exciting individually and nothing
> in core code.

Pulled now.  Thanks.


Takashi
