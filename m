Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33CCE81BD3
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Feb 2026 17:20:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28ABC6020E;
	Mon,  9 Feb 2026 18:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28ABC6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770657618;
	bh=nAZH3Jq0CQ4l2bgqW3TGLnrsFn4eEi9GxRCUAoAX2s8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rh6S856jbt5YobhQUDbWlzo0MVY+NExIA0l1vg1eIAcWV1ePgi28dct/puXvcUwS9
	 g18nzZ6gDAI/O5Nig45SDTPj9c9x2d8mTV16MXlq3536nz1b/+HmTq9SW6G8mdxF+i
	 5WMi4BkJTV3KRuTfWlHQeWeD9Mdfti2Lvz4W0XDc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69DD5F805F3; Mon,  9 Feb 2026 18:19:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9B67F805EB;
	Mon,  9 Feb 2026 18:19:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76C48F80448; Mon,  9 Feb 2026 18:18:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E81BF800F3
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2026 18:18:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E81BF800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=jyIWc5qr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=K6r/S2Mp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=jyIWc5qr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=K6r/S2Mp
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 141943E70A;
	Mon,  9 Feb 2026 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1770657504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntHyHahQGnVK8zyogowtebQlw92yjJMQD2aX116/bVo=;
	b=jyIWc5qrUrVryQB0EZeyjXGqqQDrw37+5g92YplKblMCy582e+rQResL/QoLhlppg9IUII
	SFtI1tW7NmuABS0F3/26hBUCJgCxU1bsLdDFzuo3LEgzjXDlgj8hqIV9S0AYHKUAtKvcXL
	AluB7DRTmkq9PLBUL96jFy4S7BW+yWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770657504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntHyHahQGnVK8zyogowtebQlw92yjJMQD2aX116/bVo=;
	b=K6r/S2Mp4K5EFNKUw6j+Vbe1CGNsWgtVOpN4JdyKLSSlU56f0LSeuNBoEhGW8TD6ZKzCrv
	pUKKeC4OEVA+T0Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jyIWc5qr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="K6r/S2Mp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1770657504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntHyHahQGnVK8zyogowtebQlw92yjJMQD2aX116/bVo=;
	b=jyIWc5qrUrVryQB0EZeyjXGqqQDrw37+5g92YplKblMCy582e+rQResL/QoLhlppg9IUII
	SFtI1tW7NmuABS0F3/26hBUCJgCxU1bsLdDFzuo3LEgzjXDlgj8hqIV9S0AYHKUAtKvcXL
	AluB7DRTmkq9PLBUL96jFy4S7BW+yWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770657504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntHyHahQGnVK8zyogowtebQlw92yjJMQD2aX116/bVo=;
	b=K6r/S2Mp4K5EFNKUw6j+Vbe1CGNsWgtVOpN4JdyKLSSlU56f0LSeuNBoEhGW8TD6ZKzCrv
	pUKKeC4OEVA+T0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D91CD3EA63;
	Mon,  9 Feb 2026 17:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dr+MM98WimmTQwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Feb 2026 17:18:23 +0000
Date: Mon, 09 Feb 2026 18:18:23 +0100
Message-ID: <87wm0lzvhc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC updates for v6.20
In-Reply-To: <20260209162610.290911AC57EB@finisterre.sirena.org.uk>
References: <20260209162610.290911AC57EB@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 141943E70A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Message-ID-Hash: SINK3TL3QADOI4HQ5QQ3XI5BF65SLPIW
X-Message-ID-Hash: SINK3TL3QADOI4HQ5QQ3XI5BF65SLPIW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SINK3TL3QADOI4HQ5QQ3XI5BF65SLPIW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 09 Feb 2026 17:26:05 +0100,
Mark Brown wrote:
> 
> The following changes since commit 18f7fcd5e69a04df57b563360b88be72471d6b62:
> 
>   Linux 6.19-rc8 (2026-02-01 14:01:13 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v6.20
> 
> for you to fetch changes up to f8f774913b4b599169381073f6674e20976e5529:
> 
>   ASoC: SOF: ipc4-control: Set correct error code in refresh_bytes_control (2026-02-09 12:27:28 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Updates for v7.0
> 
> This release is almost all abut driers, there's very little core work
> here, although some of that driver work is in more generic areas like
> SDCA and SOF:
> 
>  - Generic SDCA support for reporting jack events.
>  - Continuing platform support, cleanup and feature improements for the
>    AMD, Intel, Qualcomm and SOF code.
>  - Platform description improvements for the Cirrus drivers.
>  - Support for NXP i.MX952, Realtek RT1320 and RT5575, and Sophogo
>    CV1800B.
> 
> We also pulled in one small SPI API update and some more substantial
> regmap work (cache description improvements) for use in drivers.

Thanks, pulled now.


Takashi
