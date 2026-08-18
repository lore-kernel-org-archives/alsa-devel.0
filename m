Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD237C5DF67
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:38:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C4B460268;
	Tue, 18 Aug 2026 08:38:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C4B460268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787035114;
	bh=1jX2VIHiJA9hLWEyijv4zXx0lBKYE+xYihqoZYGdHzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gJ9XGinQ1gWCF8BbIGT+uQihAnU5yD8BQGjeUxuC5Tm526kNExbkS3LUn2vVg37/F
	 Vh39p1YYCs2DDcpH94g6r0ZZRPske+0mhRneb9l5Wu8GQ8QuIjLWW8eO/x/kVH5jjG
	 6jNPUgJEPdC8s1LUzjh1rsIYYLmwpNb3tBQUKv/8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1043F805FB; Tue, 18 Aug 2026 08:37:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E63C0F805EC;
	Tue, 18 Aug 2026 08:37:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C07FDF8055C; Tue, 18 Aug 2026 08:37:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787035066;
	b=PwZ5Qh80bXPDFjlld+wdJEckLJWthD1vJc5FOnxbTJbF+4Wi8oEtFNgPz7NtqVXouhx9
	 OAtXCICP5XHvNve6Owx8z/YUf8G2GgeEwA0OLGGGdD7Xc0WD113y7vS0dJUCBCUmVsFs6
	 J2klWp+rS5XDCjt/jXGt95Rv/i9CXkUk8UION1Dfoq7FF+1Fs9AxInGr9j29qs3y0Wb5t
	 Ku4+puGzLUrCbJk86baJ5+PwSKNAP16qyixD6XYArSsqMK2XLc9CKhlo52ZzlMvZx2rum
	 FKSAMko9nZnDeXJhLW5EaveokD9Nn3xRajylbcAZBXIXe/WKVFZMAFfMkWWOwjS/Vcw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787035066;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=1jX2VIHiJA9hLWEyijv4zXx0lBKYE+xYihqoZYGdHzc=;
	b=S3HR+FXYLZETK3xM24BK7jumg+49pCB1tRTJyN1Zs/NCXOY/0Uc0oCbXF+4UBAnFG877
	 2DhTs2aON/q1Mvj/D4Y3pFGKVHGpWUVAhuAzSLmthn6UbpvwmD+DS1awDSDsmVMAJWhni
	 2JWYm4omlG8T/i9ZfNc5d2U4EOlq44xU/xZXduFCSd6MTy8oDg67ljXaI3PmyMfKozvqF
	 7yjqrtL7YUb3dbtXTFhJ47khw8VbvOMXr+a8Qo34yEsLEq8yPpMsvfmGZbCgqyIRqg9qy
	 veg32yZFUr2GwW67Ho6qlbddzb6hCRfgDU6qSgxfbgRGRW1cElNszab+XB7sq/FaxNA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ot8BdM2Q;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Z7rNvmWV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="Mag/5isp";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6FC5EBCq;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 529A4F801F7
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2026 08:37:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 529A4F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ot8BdM2Q;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Z7rNvmWV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Mag/5isp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6FC5EBCq
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6ACFE3E16;
	Tue, 18 Aug 2026 06:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787035060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WnQpjpZf8I5E5MkOkP51kBtoAkJqyz70IowLt8TLp2Y=;
	b=ot8BdM2QVG54p7O1mt0BW7t7Mfx4mOTICjpF/y7L49IBluq5BnAOtzYoOLAzMytMOsYSKO
	B8VVlWvkpW0RJuVfoRq34ejCSyOd6sj2U8SJbhd0KA6MVRIG3yOYlC+qG9YGa1Gy2K15Y2
	IaWjfEt8vkD2gb3EdfJIYhfYUcPT+aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787035060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WnQpjpZf8I5E5MkOkP51kBtoAkJqyz70IowLt8TLp2Y=;
	b=Z7rNvmWVQRIFFfsd1dJ5OoypUuh/MsyP1JljhhM6Hk5+2JCAyIJzWeLA0Pf+J+TetJnKsb
	P+m/BLVT9GPh/ZCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787035056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WnQpjpZf8I5E5MkOkP51kBtoAkJqyz70IowLt8TLp2Y=;
	b=Mag/5isplyGTITyWODy9wdXvU6/eAUREnvhn2FZ7uPQXn6xt52/ruVw+pPMr6kdyiWWKCp
	bKMLka2Jk3GB3ZKay8vZ4yb04x2T7CRwDSnDGmY4+hH+ZjDXujSO3r+7P2i2kHITvK2Hhe
	DMxFGKS2ho82FI3Rl/2bJswXTlCY9nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787035056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WnQpjpZf8I5E5MkOkP51kBtoAkJqyz70IowLt8TLp2Y=;
	b=6FC5EBCqVwUvxgSIsx1ZiWkjlYpw0WpxjcKnLiGk0IrilpciVi2mK1PAm8kpGs3+s7pKvg
	i48GrCv+ITIQfsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4600622BA;
	Tue, 18 Aug 2026 06:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f+heD7D9g2omKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Aug 2026 06:37:36 +0000
Date: Tue, 18 Aug 2026 08:37:35 +0200
Message-ID: <87lda4q6hc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC updates for v7.3
In-Reply-To: <c95b9b429426c579bc4230e8b2ae489c@kernel.org>
References: <c95b9b429426c579bc4230e8b2ae489c@kernel.org>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: KTMBBQH3I774XAPRNLYKY2PUD5G2XOOJ
X-Message-ID-Hash: KTMBBQH3I774XAPRNLYKY2PUD5G2XOOJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KTMBBQH3I774XAPRNLYKY2PUD5G2XOOJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 17 Aug 2026 18:52:14 +0200,
Mark Brown wrote:
> 
> The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:
> 
>   Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v7.3
> 
> for you to fetch changes up to 0c7aeb0f5eceb95b5887bd8e83fef865e5a49a13:
> 
>   ASoC: tas2783-sdw: do not treat read-only Controls as writable (2026-08-14 16:20:47 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Updates for v7.3
> 
> A very busy release, a combination of a lot of new device work and more
> people than usual doing various subsystem wide improvements in the code.
> The main subsystem level change is the work Morimoto-san has been doing
> to get automatic DAI format selection more widely deployed, and even
> that is largely changes in the drivers to enable use of the feature
> rather than framework work.
> 
>  - Conversions of a lot of drivers to use the automatic DAI format
>    selection code from Morimoto-san.
>  - Many fixes and code improvements from bui duc phuc and Morimoto-san.
>  - Fixes for ordering problems in register default tables from Peter
>    Ujfalusi.
>  - Changes to use auto-cleanup for firmware to improve robustness from
>    Takashi Iwai.
>  - Support for firmware on more Awinc devices.
>  - Many changes in the Qualcomm driver stack, mostly around new platform
>    support.
>  - Support for AMD ACP7.B/F, Cirrus Logic CS35L62, Loongson 2K0300,
>    Meson GX formatter and interface, Qualcomm LPI MI2S, SM8475 and
>    WSA855 and Realtek RT1321 VA1/2 and RT766/7.

Pulled now.  Thanks.


Takashi
