Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115F2E9A048
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Feb 2026 11:20:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE3E160218;
	Thu, 19 Feb 2026 12:20:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE3E160218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771500026;
	bh=FjOkPsGbN4s4Su+CYzVznz7JyOTyYiVuXecUkjB4rNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kGHOZwkcCjxnWakubE4q8udCDq2K3O6hjqQwvL29cvwfuIqXyySxTtdmaskwJuiQf
	 UhMYUjUZIGhkrxHTk9agjPv+/QrKXNenaRRRHve5KMF53LZ090ztUyZJLnVvmgi6Ab
	 jAHssrzsjHL58rqsiiyEaWa7UypLYfUt3DS94jJk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CECADF805E0; Thu, 19 Feb 2026 12:19:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 71857F805EE;
	Thu, 19 Feb 2026 12:19:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77E77F804F2; Thu, 19 Feb 2026 12:15:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C105F80162
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2026 12:15:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C105F80162
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=MywSJr8l;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fGMuUtzO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=MywSJr8l;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fGMuUtzO
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 360C53E72B;
	Thu, 19 Feb 2026 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1771499720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQiic+ltJqXJbFNe/QslgbxttZVSruLQ1cWohoJ4F5M=;
	b=MywSJr8lT9sWLwbjUAKcuMKfdNCG0NuQu//GjI3HPsz6hdJ/po1as1hw3F5gMrv6Af/pRN
	kSaK6lS6zqzTrCZVHs0fyLnD7Q+0MYFPe8tSUDnmccNlOTErYXJdhe9eD6eKy7pH6DBB8f
	2I3n95wJWqHJe2He41bF5YKQjcrlxlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771499720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQiic+ltJqXJbFNe/QslgbxttZVSruLQ1cWohoJ4F5M=;
	b=fGMuUtzOdyZMxJlunJ0npxaKYAi/LTZPHHlHekvYcImEJRO+TXXdoHMIHRIPLerPJmGfEF
	/pk9DstEURHkZCDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1771499720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQiic+ltJqXJbFNe/QslgbxttZVSruLQ1cWohoJ4F5M=;
	b=MywSJr8lT9sWLwbjUAKcuMKfdNCG0NuQu//GjI3HPsz6hdJ/po1as1hw3F5gMrv6Af/pRN
	kSaK6lS6zqzTrCZVHs0fyLnD7Q+0MYFPe8tSUDnmccNlOTErYXJdhe9eD6eKy7pH6DBB8f
	2I3n95wJWqHJe2He41bF5YKQjcrlxlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771499720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQiic+ltJqXJbFNe/QslgbxttZVSruLQ1cWohoJ4F5M=;
	b=fGMuUtzOdyZMxJlunJ0npxaKYAi/LTZPHHlHekvYcImEJRO+TXXdoHMIHRIPLerPJmGfEF
	/pk9DstEURHkZCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3E4E3EA65;
	Thu, 19 Feb 2026 11:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y0AzOsfwlmnEIAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 19 Feb 2026 11:15:19 +0000
Date: Thu, 19 Feb 2026 12:15:19 +0100
Message-ID: <87ldgpq914.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.0-merge-window
In-Reply-To: <5ea3e80b81adbf418f63285ac0f0ea8f@kernel.org>
References: <5ea3e80b81adbf418f63285ac0f0ea8f@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: ADZYFRJKX75MN2OOKLV3NXKF7IOF33HE
X-Message-ID-Hash: ADZYFRJKX75MN2OOKLV3NXKF7IOF33HE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ADZYFRJKX75MN2OOKLV3NXKF7IOF33HE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 19 Feb 2026 00:41:03 +0100,
Mark Brown wrote:
> 
> The following changes since commit f8f774913b4b599169381073f6674e20976e5529:
> 
>   ASoC: SOF: ipc4-control: Set correct error code in refresh_bytes_control (2026-02-09 12:27:28 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-merge-window
> 
> for you to fetch changes up to 80ca113671a005430207d351cb403c1637106212:
> 
>   ASoC: dt-bindings: asahi-kasei,ak5558: Fix the supply names (2026-02-18 17:12:41 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.0 merge window
> 
> A reasonably small set of fixes and quriks that came in during the merge
> window, there's one more pending that I'll send tomorrow if you didn't
> send a PR already.

Thanks, pulled now.

I'm going to send a PR tomorrow afternoon, so it'd be appreciated if
you can send a missing one earlier.


Takashi
