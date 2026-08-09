Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6CCC5AC80
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Aug 2026 10:33:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B7CE60210;
	Sun,  9 Aug 2026 12:33:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B7CE60210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786271601;
	bh=6xrASBm3Y7AkSRoVnHd9D6RfojGgmUE1OBOOAz0zxys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G6dzskWaheSOhGCvdoTT4KxZTgvKCDqd9EaSbgE6++NEB8jnQQfvwExkYn+XTMFQq
	 vjBhEUpAALhmdkgwZA17QR45juiqc0X5mRVOuD85tlzsa1rgokxn3HNa7/q9Zv0zyf
	 /4JW3RYYMrs1u0GtF1gyydFUvPoE7ppSpN7CVJEk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 691C8F80600; Sun,  9 Aug 2026 12:32:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A03B0F805F5;
	Sun,  9 Aug 2026 12:32:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D3A9F8026A; Sun,  9 Aug 2026 12:32:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786271553;
	b=VrlvLwrkYT8FpgQ4/RDZZNU4thVtFUuJKKJaA2VuGPNJ89Puhc2Sm5xAitO+Do8HsF3R
	 MJt6Fs/xxC7fUP/QXapJsmsUSFMXKAHA4D6Z7aQQ0GVFsv8DlsibwHKfi+DY9dMkaQUZe
	 N/Vg/MEo/pGpqa0PxBL0gRupeJtmoKyhrOCvxnd8CTHkCoRyUfQbsLPNFAPI8Kd42ZIMe
	 HDDnrOrZlcqv/Ixemk3dB1s8M7c8CNsz1D/gmCDNBT6pj8PWNGQ4oj97rm2FINxL+Zaze
	 IpJ62t7mj3oOhioE8nFAZxSdWW2T/UI00xDca/ZB4zBObetA+mbuKPDrcYpcwJefzmQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786271553;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=6xrASBm3Y7AkSRoVnHd9D6RfojGgmUE1OBOOAz0zxys=;
	b=cpkxPmgXy1J+egL30pYEUGJ9gRWo7SVm2rxH/PDTjQizYKICxjebbhQQdLC9oCMjJ4Xr
	 TR++zF8jihMct1DaE0kyaDxZXqrQsXERnoKygkz1tQKlMlP0oppEMTn7d08KYPdyeYn/F
	 3ljQHsyYiOBeTlkhFT4Lx9wqndkUEUCCyh1DTTqAeJCa6snbt76QLI7KUGg43ifdSm1Ur
	 WIhqrzMEuLiFtAYOWhaKVpIwed3mJGH/mt21V7DqU4vLvhBQfpiFGnpX7Nonxhtmlch50
	 jXSMDbfWfks3uA+Y9PEDl+9dyfrqQI0pHCsyCc7J4HFLUr+D2LMIJzdqz/9jzavgFxA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CtcJiqy+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6UlpKQXq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Ux1hMmn4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wykG51KZ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1ABBF80153
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 12:32:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1ABBF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CtcJiqy+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6UlpKQXq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Ux1hMmn4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wykG51KZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED9F642E3;
	Sun,  9 Aug 2026 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786271547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pA3N3adI2xecsM0ROd9IQKLhipSOphxYDmdbwVn6vVo=;
	b=CtcJiqy+mwvfdDgW+aTZTlpHRP7Vf3wWx1e+rwB2s7MlGOjRrhIpK3T3jg5SP/wgYXNo+y
	fWs8BodkVoCxpPsG0nthHFH2eBSSZ7htD80ZFn0CD4KGkbVbxhg1IUhCg2an0GlSlqZd0S
	IHPDsC/tofKb6JP1JXlFJjk+7ZDZgBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786271547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pA3N3adI2xecsM0ROd9IQKLhipSOphxYDmdbwVn6vVo=;
	b=6UlpKQXqGwSA6qgqY3AUrSlSJk8X9byvI3bCgqva7opkKv035St0mXzRs0Qs/2vsIgalSF
	+n6n4QIH3zmIK0DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ux1hMmn4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wykG51KZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786271542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pA3N3adI2xecsM0ROd9IQKLhipSOphxYDmdbwVn6vVo=;
	b=Ux1hMmn4vpKdZ/yZTVRb1msVtWTQWb9yzG59CPXhlx02ERQhelPoGdcltAdztII4FKg7ef
	UJ7v19SNNLrJKDW/c34Lb0xdXTOddiSrQUyN+8Km25wq7S83VJJ0r8RhTVCsOwMwpAY5Ox
	a/8tZENPxKVZkum3HPM//WXFoRXS05w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786271542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pA3N3adI2xecsM0ROd9IQKLhipSOphxYDmdbwVn6vVo=;
	b=wykG51KZBHH5EIGbLD7cPB9igGEM/GHflYKnJwpC6FoCieH8d8QqsSzTo/4nVbCNvaLcQz
	NgPKMas+F0B8sDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD732779B2;
	Sun,  9 Aug 2026 10:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kxfJMDZXeGr/XwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 09 Aug 2026 10:32:22 +0000
Date: Sun, 09 Aug 2026 12:32:22 +0200
Message-ID: <87cxvra8jt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bramwel Barack <bramwelbarack89@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP 250 G8
 (0x85f3)
In-Reply-To: <20260808182018.5148-1-bramwelbarack89@gmail.com>
References: <20260808182018.5148-1-bramwelbarack89@gmail.com>
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: ED9F642E3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: ASBM47KOQDCXOKHC4Q766DNTN4CKQRSQ
X-Message-ID-Hash: ASBM47KOQDCXOKHC4Q766DNTN4CKQRSQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ASBM47KOQDCXOKHC4Q766DNTN4CKQRSQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 08 Aug 2026 20:20:18 +0200,
Bramwel Barack wrote:
> 
> Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>

Could you give more explanations why your patch is required what it
does?  Please resubmit with the proper patch description.

And, at the next time, please submit to linux-sound@vger.kernel.org
instead of alsa-devel ML.  alsa-devel ML is mostly for user-space
stuff while the former is for the kernel patches.


thanks,

Takashi
