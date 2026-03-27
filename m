Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9E710ED645
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:51:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07F77601F5;
	Fri, 27 Mar 2026 10:50:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07F77601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774605059;
	bh=53a41wdNiZykrcO85FR0JPy5LIV5+oXpCjM+w+1s9vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LiWf3wuYDxD822I7tBDb5AW3TWiXvn4Z7xEnlETdkjuaX5aH3EbenyOI4rrGNhPK2
	 2yYO5Fg3EzT/57s47r08tYc8lRwZIY8ReZEoLjAn3zdrEhlv1iKqr3Rd79cVZH+hUU
	 wE0ZTt2Z7XMrPUYP7ezAEYb/m9DBPqJuN126HNDI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EA5BF805E1; Fri, 27 Mar 2026 10:50:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3ABBFF805EF;
	Fri, 27 Mar 2026 10:50:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8119DF804F3; Fri, 27 Mar 2026 10:50:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3DC87F8016D
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 10:50:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DC87F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=WlE9eR9w;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rLqTwm46;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=vkJO6gvA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fDWzYSQQ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A23144D250;
	Fri, 27 Mar 2026 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774605003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0BlUW8LPEGjH4PEq6eEuDBNhs4AdhJ6JV8lLbkRq4c=;
	b=WlE9eR9wSrP71hudjXQiZkatGgGAh1PzOqvl6zSMJZQ40n7DPYNzweCPPYg/QS1S+Kf/BQ
	l0JbYdtcHjPlhXJwD2WnBXTxPrrW/RKCpzWYOj0WgEd7IfRygfsxxLxvUOEnlX/ZTpJwQP
	eqtJ0cEP3WnE16Nhx0XSW3RRoU+of/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774605003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0BlUW8LPEGjH4PEq6eEuDBNhs4AdhJ6JV8lLbkRq4c=;
	b=rLqTwm463HxSffypYBMuTUgOWKrYfA/RjnVdtTk2AgadCSBv971socACzUjbcq8/5RL5Kb
	mBa3u3InAz0YPWAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774605002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0BlUW8LPEGjH4PEq6eEuDBNhs4AdhJ6JV8lLbkRq4c=;
	b=vkJO6gvAr0xSL7F8e0sljZW33n6Q8tSUV8rf4Ti/SbxN7UGLaVQw6yrvt37cOfdNW6G2N2
	NINNYJQEi7pE42m577nAFhOyqQXSsPyqr3T7cobwJWTQYoB0TDXdTzyuksKAW7zgOLoS8h
	wboT6T9pl98NFZJzeMgJHkwPMbzb1Zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774605002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0BlUW8LPEGjH4PEq6eEuDBNhs4AdhJ6JV8lLbkRq4c=;
	b=fDWzYSQQ+ySRtCeoO0zuoKuj0MQ/ij+pVimPi5ua6NDt8Cj/ux1P5eNks0fA4vWGIHRldT
	MOvLuv/DsukzrCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 821334A0A2;
	Fri, 27 Mar 2026 09:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A45iHspSxmmnNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 09:50:02 +0000
Date: Fri, 27 Mar 2026 10:50:02 +0100
Message-ID: <87bjg9sit1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dima Art <artdima93@gmail.com>
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Victus 15-fa2xxx
In-Reply-To: 
 <CACHgFRk+WSTAhhm4BbWwfqUMVCTJL4uTLK9+=8D6odKMq8BxAQ@mail.gmail.com>
References: 
 <CACHgFRk+WSTAhhm4BbWwfqUMVCTJL4uTLK9+=8D6odKMq8BxAQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: YSEUF4AC2Z6NJ626LV2OGYCUGXSPPPHD
X-Message-ID-Hash: YSEUF4AC2Z6NJ626LV2OGYCUGXSPPPHD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YSEUF4AC2Z6NJ626LV2OGYCUGXSPPPHD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 24 Mar 2026 23:25:03 +0100,
Dima Art wrote:
> 
> The HP Victus 15-fa2xxx (subsystem ID 103c:8dcd) uses two TAS2781
> amplifiers connected via I2C bus at addresses 0x36 and 0x37.
> Without this quirk, the amplifiers remain uninitialized causing
> mono audio output with no bass.
> 
> Tested on HP Victus 15-fa2xxx (HP-VictusbyHPGamingLaptop15_fa2xxx--8DCD)
> with kernel 6.19.0-9-generic on Ubuntu 26.04.
> 
> Signed-off-by: ardima93@gmail.com

The Signed-off-by line must be with a real name or a known identity,
as it's a legal requirement.

And, more importantly...

> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ alc269_fixup_tbl[] @@
> +    SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx",
> ALC245_FIXUP_TAS2781_I2C),

... the patch content itself looks broken, likely due to your mailer
setup.  Please try to fix it.

Also, for the kernel patch submission, please send to
linux-sound@vger.kernel.org instead of alsa-devel ML.
Last but not least, you shouldn't Cc to stable ML at posting, but put
Cc-to-stable around your signed-off-by tag in the patch description,
instead.


thanks,

Takashi
