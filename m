Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D920CD8C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 09:46:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4FF5601C9;
	Sun,  7 Jun 2026 11:46:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4FF5601C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780825574;
	bh=lIiWgSID/xwMi+59IWKCPuqc22kL8ZE5lM2hOP1tO/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HUgYwb8szQGUjUdeFB+d4Y+UGEdIzqJE+t3FV57HMgRdv0Jzp8v0HKcF64tr8mbnj
	 dm68bBmy3GnyBHUBXLQhv/WUSr3h+4lbk+bAgDqdWPiCecNBZvJUiyuNh2xNW94jls
	 FzIU4AUKn1KdYU456Mt5wOL/ohP/0nyeTOmkyTas=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A63EAF805FD; Sun,  7 Jun 2026 11:45:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 62B3EF805FE;
	Sun,  7 Jun 2026 11:45:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D008F8055B; Sun,  7 Jun 2026 11:45:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780825531;
	b=FzhSgeoOPkzqbmiR7HgqedHLKN7y3Qq9VCLlnayj2zeisAQj9THdkjVcuXb77MIlzV0T
	 x6rFZos9osaPrEGwOHz0RGlY/FqM7D3vsfoKb+F4RbXu1SlhJLKrre/CEm/Gf5esos/C+
	 dB9qeg96/QAwvJEyPVFXIo/hv0m65c0ojIeGiPSwek9AII366vi3f4e9FBHIQIN8192XC
	 DvhAN9GWMAhgJUBzIE9DUekd8TR1xHZo8F59N95r7wf6CGZ8oJ4lx96vJJLL21x5S4HQ8
	 7/mZW2emxLdRqimaj20k78cWoLCOcVPOe8U45CDGHGJS2HhGJCDFb0QuaSUJYzqN7Bw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780825531;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=lIiWgSID/xwMi+59IWKCPuqc22kL8ZE5lM2hOP1tO/M=;
	b=OfzqtJ7p0r/h2XQlIn9USefgftke/OlfrlLOwUhG3lKH+gGl7509VS/2vrfXMwCrTXw6
	 IINyqbGVkajMWbrMC1E/hfNzoEmss0IIZvjuu+tFafPhUlbOou3+iBkfakhYhRUc9QP4b
	 OB1l/y5qCPcygM8/lLxc0kWowsU/AU2igHnpTrG0Ta5vPCIXrcTHXgQSR/fhCeoMUEtXq
	 I8IzqFpAC5VDhO4GVCemjYn1xxIxU9mXuvuhWhdtqZvyAQFrKqk8R/AZiq3fCflCTZXpg
	 vBuwX3HSK2UhTNowEz9alsdalRVzyNOgcFBvqntC5ro3G3G8KUYfLvkfXH29bUcq7pQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=s01ZUdqj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=B4l+nRVe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=s01ZUdqj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=B4l+nRVe;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 63B96F8001F
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 11:45:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63B96F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=s01ZUdqj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=B4l+nRVe;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=s01ZUdqj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=B4l+nRVe
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 821B16AA4E;
	Sun,  7 Jun 2026 09:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780825529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clU5o8M085Z8kf7IhVKxV6YyEfPfwP0ImtrG0Bw1nAQ=;
	b=s01ZUdqjhc5hfOkiP5FGQWZacOXWRekugFAM2/+ayJUCp8t2sa+a8HABW+YFoZCDL6u+vO
	PfOkX5HmSiIFyVsQjKz0s2v46IMiH39hh+1VKHgA4PW0JbnolwA4cSYcCGXVbjEooPGak/
	KQ6j0ncuel6cvXqliPzPG9vb6+qvmL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780825529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clU5o8M085Z8kf7IhVKxV6YyEfPfwP0ImtrG0Bw1nAQ=;
	b=B4l+nRVeEJwKiMFPTNm1BUyTR4L4lZOV7YMSgTCu1QsCITaPGJsaXQAZgge3h89dZtyE6x
	KLfUbRew7Ie73VDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780825529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clU5o8M085Z8kf7IhVKxV6YyEfPfwP0ImtrG0Bw1nAQ=;
	b=s01ZUdqjhc5hfOkiP5FGQWZacOXWRekugFAM2/+ayJUCp8t2sa+a8HABW+YFoZCDL6u+vO
	PfOkX5HmSiIFyVsQjKz0s2v46IMiH39hh+1VKHgA4PW0JbnolwA4cSYcCGXVbjEooPGak/
	KQ6j0ncuel6cvXqliPzPG9vb6+qvmL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780825529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clU5o8M085Z8kf7IhVKxV6YyEfPfwP0ImtrG0Bw1nAQ=;
	b=B4l+nRVeEJwKiMFPTNm1BUyTR4L4lZOV7YMSgTCu1QsCITaPGJsaXQAZgge3h89dZtyE6x
	KLfUbRew7Ie73VDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D080779A7;
	Sun,  7 Jun 2026 09:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cgaPELk9JWo3PAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 07 Jun 2026 09:45:29 +0000
Date: Sun, 07 Jun 2026 11:45:28 +0200
Message-ID: <87a4t6smyv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ALSA: es18xx: check control allocation before private
 data setup
In-Reply-To: <20260607074219.3-1-ruoyuw560@gmail.com>
References: <20260607074219.3-1-ruoyuw560@gmail.com>
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
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: JRDHFYKFPJ5GIE6RGO6Y53E6CUYRMCV3
X-Message-ID-Hash: JRDHFYKFPJ5GIE6RGO6Y53E6CUYRMCV3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JRDHFYKFPJ5GIE6RGO6Y53E6CUYRMCV3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 07 Jun 2026 09:42:19 +0200,
Ruoyu Wang wrote:
> 
> snd_es18xx_mixer() creates controls with snd_ctl_new1() and then stores
> bookkeeping pointers or sets private_free before calling snd_ctl_add().
> snd_ctl_new1() can return NULL on allocation failure, so those writes
> can dereference a NULL control pointer.
> 
> Check the returned control pointers before using them and return -ENOMEM
> on allocation failure.
> 
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> v2:
> - Rebase on sound.git for-next.
> - Resend only es18xx; the other v1 patches are already in for-next.

Applied to for-next branch now.  Thanks.


Takashi
