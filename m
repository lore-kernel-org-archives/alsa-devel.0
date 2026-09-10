Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DAFC79F9F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:10:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 941656029D;
	Thu, 10 Sep 2026 20:10:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 941656029D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789063832;
	bh=TIY2DRwIUel2JmFzBcTRhTtlXPCv+8lD9fyY0kjNguI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TcJSZF29gouJcgXv/B1hynP7I91dg0AGyLvTxauZ145Tly1c0Y9PiykFB4oSvHxd3
	 mhWletsqM2xFgR1hoR4KQw9gePVMqGmrzyLnm+BJytx4K3JpsE5PY388gsWMAQ9zpL
	 p9nfnAUgBvyD/c6qZmP4dddYT5E7N5e3pRWcuULo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0582F805F3; Thu, 10 Sep 2026 20:09:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59F8FF805F8;
	Thu, 10 Sep 2026 20:09:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D5A8F8051D; Thu, 10 Sep 2026 20:09:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789063788;
	b=BgA3aY4Ij33QqXV7m4n77riO/vWLjkOBOmmywYWxWTn895j2y6w1h9Xi/ib1md8ADR+f
	 6HGXuFNc9c/0b+bV4U5ljjESzThIYrKb/zkfN68UOGDgGtdbRbetDrJDF49JZ9dOZmfSh
	 76WDltwNg+DLiXYurBiDC/a98gYkGifa6p+3IfHvq/Luc9toUy1bR6CsXZ3JF8E6gAliD
	 aN2wbWyLjebUg5g4+ZPzIilAN2HJdNmY0IhIC2OgW+/Delv1Mcx3DqN7rVvZF3GlKHhoC
	 0mHgGfeNVqqq+GLPY9YPWDobFLlXeEm1JzbdJiq1VMyy+g8IXAOmks+h9jfQA/s5OxA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789063788;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=TIY2DRwIUel2JmFzBcTRhTtlXPCv+8lD9fyY0kjNguI=;
	b=ObeBDsWlA1hZPq6Jjgre8brW64956mNX4vAYFHN+ea7DAWsFecIXlwvFTV+OOQ296ouI
	 8Q8uSOGkXSQXKCNf4KKfh4NNt/GScZP2VlvBcnBShz8yvJ5DI8iIU4bMFZLFj5DHariJC
	 aehIPwaEhg4fh92QYOtxalAohihJ5QSrTbSCdIPnEJ3JLOFur+GTJcm7rqZ6d3wONZRak
	 3iHFdThZaIAzPMJgR8zlGw9yQ78pdRifNS5KkYvrjt8oRTOJ6OiL/VlN9tMOogu2+2FDZ
	 DkfIM4QcQ0tVQxlKt9jRMSyC4cc/8PUK4lKijb5iMV0ochvUSZtCOLG6bMrgrmFlztQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=cORVIucs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=QZ19D2ea;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=KpOjbzWV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Nu6ERrvU;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 84B5FF80272
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 20:09:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84B5FF80272
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=cORVIucs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=QZ19D2ea;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=KpOjbzWV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Nu6ERrvU
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 879CC21940;
	Thu, 10 Sep 2026 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1789063782;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLWAUBbJkkwy6xeYweWeyAwVekbsq8Rp/XPHLrn8e2M=;
	b=cORVIucssf6L02QEHzyo3WpBdqlaF8c83xm/h83g5BkR18i28n3HKEA1Gpd3pC6gOoMPV5
	DnHGpWNKC9L6Snl9Y9cHBxKLDiilWhlWYWaKxZZeNFhOzE//8N0awGFMLuPLrLK3hEWnbE
	qAD22TiVzZmquPz76f9SYmrZmIUgMkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789063782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLWAUBbJkkwy6xeYweWeyAwVekbsq8Rp/XPHLrn8e2M=;
	b=QZ19D2eaNJEzo01jJQV1CH/gGP1RvOgnmfCd7q12uOqtbQbc2Me3Klh6toiwaphPbWNPgk
	ORPEy2KqrO+odNDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1789063778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLWAUBbJkkwy6xeYweWeyAwVekbsq8Rp/XPHLrn8e2M=;
	b=KpOjbzWVsBhXPkpdmci1hdt7ST8iS4hQ3GOHkS7eOTgu3bxMtctW7iCNkDCTymuRlGl9Mv
	gjLGxaOFIPzxYIPYap5D0WUmJ5N6050+yMfEJv1Ll1+VQJfmjkD/U5CSm/y+Z0agYkoo9y
	3BgsDRb1fghYMA1Da8p0fDr82+kVs5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789063778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLWAUBbJkkwy6xeYweWeyAwVekbsq8Rp/XPHLrn8e2M=;
	b=Nu6ERrvUZLd+STW5RPDuN1tznnrLjEChIFPokVOL+KDK9PEFzck2qiZxp1J6+9iDVimtU7
	ml33v5g5nhVh+sBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DAC81326D;
	Thu, 10 Sep 2026 18:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8sK1DWLyomrYNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Sep 2026 18:09:38 +0000
Date: Thu, 10 Sep 2026 20:09:37 +0200
Message-ID: <87o6e5j7vi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cristian Verde <verde.cristian2005@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add bass speaker quirk for Lenovo Yoga
 Pro 7 14IRH8
In-Reply-To: <20260910174251.22302-1-verde.cristian2005@gmail.com>
References: <20260910174251.22302-1-verde.cristian2005@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: URQPRZWI4URFYF4BNKWAUDDKH367KHRQ
X-Message-ID-Hash: URQPRZWI4URFYF4BNKWAUDDKH367KHRQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/URQPRZWI4URFYF4BNKWAUDDKH367KHRQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 10 Sep 2026 19:42:51 +0200,
Cristian Verde wrote:
> 
> The Lenovo Yoga Pro 7 14IRH8 suffers from missing bass speaker output and
> broken volume scaling (5% volume plays as loud as 100%). The system shares
> the PCI SSID 0x17aa:0x3852 with the older Lenovo Yoga 7 14ITL5, causing the
> ALSA driver to mistakenly match on the PCI subsystem ID and apply
> ALC287_FIXUP_YOGA7_14ITL_SPEAKERS. That quirk only powers on the amplifier
> without routing the 4-speaker DAC pins.
> 
> Add a fixup helper that disambiguates models by checking the HDA codec
> subsystem ID (codec->core.subsystem_id). When the Yoga Pro 7 14IRH8's codec
> SSID (0x17aa:0x38b1) is detected, apply ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
> which properly configures pin 0x17 as a speaker output and hooks it to the DAC
> volume controls. Fall back to ALC287_FIXUP_YOGA7_14ITL_SPEAKERS for older
> hardware sharing 0x3852.
> 
> Signed-off-by: Cristian Verde <verde.cristian2005@gmail.com>

This doesn't apply cleanly on the latest code.
Please rebase to sound.git tree for-linus branch (or at least 7.3-rc2)
and resubmit.


thanks,

Takashi
