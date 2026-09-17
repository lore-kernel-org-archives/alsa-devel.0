Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68108C982C1
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:17:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84406601F4;
	Thu, 17 Sep 2026 08:17:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84406601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789625850;
	bh=+SaYIkjszGm680I8xtpkzFNCXZBAGF+XLOF92Oz7f+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=u2t6pPU6waDBJDQy0cj7dmu1JQI/rWjifi4NvdiDmmFsSMNCthrqFQ2ZVx0YHkytv
	 1Jh1iRW2Q8QuSh/cJzaD5KOBQgkuHBsJdi0POroGCMRWSvknyHL6a9+KVWXS1N1uti
	 j8BmrB9kvQ4HaPXxnhp4Q39ycEEIpp2ZcJjeaXsw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EFAA9F80601; Thu, 17 Sep 2026 08:16:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE815F80600;
	Thu, 17 Sep 2026 08:16:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F10DFF80537; Thu, 17 Sep 2026 08:16:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789625807;
	b=YDdUaRSkocKezcudWLHcxFxgcQwrEPbzebadgAhWJCKW0lXNN2i9KRSP44B7lhprcmDE
	 /JkJldrhgFMUMr+r7hbn+nt+DWFCfe2JMPTiktU6woUYDVfkI77EBGxsKFBUhAyLSuy+8
	 KohdYQKXKqvVPentPbxB57pZXVMgRXa5fF5fyRJQNzspd8kl0ta4vAhr5EsqtgM1MWBIK
	 mXmollgeGZdI0bjReqhYjO/ZqtValYXUbHv5F++3G5mYFUJgcOebQ51ieBVfeiMXNmC6G
	 oN3egw2Hjvpdx6r/lRxnHnuGtkTZIuYVW6cNoIcp6pdXk1yWuf8BK2FatkSH4lHp2VA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789625807;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=+SaYIkjszGm680I8xtpkzFNCXZBAGF+XLOF92Oz7f+I=;
	b=p8vWFMQV2pCIxOxe0/rDWIV/6zK2Z46IincM+q1QWyfrf/RaBpZO/icuOnWcI14duB/6
	 F1MIL4Ot5VS7OarcjCK4K11cEk9TdJQdP80upp08u3dgdBnXu1Lti0kDOpOan7DhxRGOL
	 AHcQ+9OzfJDhKSCW5W0ict2edmqf39/CLN+dynJqcg3vfxq/CvmcuSy1PdPaJ+KnNdta3
	 1B/ynvRO1L8nU5pw28KVr0fM80P8R57cVIBWKzhDEC2ncro8fzoXxuL6KIax/B9B4qkgi
	 ziO4u1X2mza9dSh7VHNu1iD11MIx+he7KPeNtdLb9epVRsUKIWN6wsu0IRraKi9W30g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Qc+3eHCS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hyuPSHQ7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=vxmsiTf8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=flxFWrKX;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7518FF8007E
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 08:16:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7518FF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Qc+3eHCS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hyuPSHQ7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=vxmsiTf8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=flxFWrKX
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84FBE21D7E;
	Thu, 17 Sep 2026 06:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1789625801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmUo4B2eX5MRFWLUX9iQypCTcGBjjs6+bctWrUEKews=;
	b=Qc+3eHCSw5Ijfbb02nYkNgYueMvo/b0/83SENguqgU1Rt8jIS6BzDJV5pF+l1cDrM/68ti
	PcuV0GxNDk9SrnAmCi+OcWWsGuU+maZP13n3X4s873dvWt09ANmoEEENzfNTW7KVUohS/1
	NgpeQFLNjQWTxR8JXN1XOsO/AGN1ZDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789625801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmUo4B2eX5MRFWLUX9iQypCTcGBjjs6+bctWrUEKews=;
	b=hyuPSHQ7CC28jF3EO2oveMo4RyemlhX3Pyp6foNRRSGgu+BBmA/0O8kNMDEJgNfl1BGBQ0
	FwcRmGL62LYL2WAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1789625797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmUo4B2eX5MRFWLUX9iQypCTcGBjjs6+bctWrUEKews=;
	b=vxmsiTf85XBdaQ5Mr0K0Pypc862DgKeNWIo984JSIA98DmYqyx+iWH99VWAqO1YJ6xRR75
	QtjxHiOSRBOHgS+bRRDhwkvMNtM5t/Os9gYHvos7TQhV+tYPYvi7AIgkpHRgDD2+rs1m0l
	Zp6yo1u7+o9mK9B2dv/zJZ9ytws52yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789625797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmUo4B2eX5MRFWLUX9iQypCTcGBjjs6+bctWrUEKews=;
	b=flxFWrKXyOIaX/Eo+kr+na2ld58QfxKlrKLdOHB7la72FuIiYNx3zBIY6tS92wpzF1nbVn
	XTxMSeCceNaESzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4452C13786;
	Thu, 17 Sep 2026 06:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 925HB8WFq2rWSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 17 Sep 2026 06:16:37 +0000
Date: Thu, 17 Sep 2026 08:16:36 +0200
Message-ID: <87v784ierf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc3
In-Reply-To: <3413f10580c07752cd34ce5a1557e8c3@kernel.org>
References: <3413f10580c07752cd34ce5a1557e8c3@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
Message-ID-Hash: XQ324OJ2BHAFMNPIGGOT3RQUKQGGHMQT
X-Message-ID-Hash: XQ324OJ2BHAFMNPIGGOT3RQUKQGGHMQT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XQ324OJ2BHAFMNPIGGOT3RQUKQGGHMQT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 16 Sep 2026 23:23:52 +0200,
Mark Brown wrote:
> 
> The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:
> 
>   Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc3
> 
> for you to fetch changes up to 940e8fe8535d22ce67dd2fb9588e6c55a31d7d03:
> 
>   ASoC: adau1977: small fixes to make the driver more usable (2026-09-16 20:09:57 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.3
> 
> A relatively large pile of fixes here, a lot of driver specific stuff
> that's broadly unremarkable plus a few core fixes from Richard that fix
> issues where SoundWire systems with multiple CODECs on the same link
> would configure the CODECs to use the same bus slots leading to broken
> audio.

Pulled now.  Thanks.


Takashi
