Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE90CD98CF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:35:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98017601A0;
	Mon, 15 Jun 2026 20:35:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98017601A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781548555;
	bh=ApRAvi7Nywv2gqyuY6pOh3b7XUek4mBjIND9Zi9Pnw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sBX/u9jsX3nzdamtrY+yBXS53SZiuLt0hGf9KOJB4JHV0p0R2pvRpMpT2EufTcqDN
	 j/jcZfbaL1pAUJPpb04ICbg5fUU9mHoY+0jHjHmkQKbImv2nej1BQNoUCASzb/T0NF
	 ZPSO9j4VxENZKXvtfBzFyCf6Oevi4lM3S17TbQxg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4F17F805FE; Mon, 15 Jun 2026 20:35:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AA78F80600;
	Mon, 15 Jun 2026 20:35:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7519BF8047D; Mon, 15 Jun 2026 20:35:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781548515;
	b=VwTmdmF+/m3tCCR6ALLOzUkzhG4YutrKBv0u3NWJtddwk9waxuMpThAbCx0zk/HENVM9
	 mEh5SGe7xj4WnVCO7TfueraHNETIMEEPTVPqmZGiTHXe1+eFPd2NdReMXcslGVhS1cd7P
	 90dw77Sxw7ctJS+MrCvnz8yQd5TxNDpnI1vvHpKeNsFmilicOSXDhknJ0n0suWuQAn6sa
	 hF2pwRsnnLkKkdcQdkOEWClHEominI0qrYSYi77KmGdsW7kvZL0vmRo4FTvne/Lc3Q6tC
	 /vLK8kSh4N7fzmP3LHC3a5YNOnUfjo6P3lpfnaGF/yjDg11ss05Jy6SQY7Jdl4cVGow==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781548515;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=ApRAvi7Nywv2gqyuY6pOh3b7XUek4mBjIND9Zi9Pnw4=;
	b=cCUiCkx4iuN4tPFKFiK+mklrdttUXcDLyl1YPSKmoVZSAzCbc5kFNcBRdT68bVP9EqrR
	 Y3szBcCwzsbPwXWgJYFh6Uz2/GK8FOr7vlUk3U/zWAEaq2cTOv1fFShGNIc+NXqCfq/NT
	 /Y6VF9Ox4/xNjZM1Nk1tuOvAYf+AGH9kXB5qVVizD45qfhuzWNs0BIm4NR1B2/1loC1ZL
	 GPId3JBS3+0vIstg3O37vPiEvlYL1dhnR2ccXE5JEYoKblC8h+2dO8pS6iHmSA7HwzYXV
	 P6xMLP8LIvkzSzW4X0sWVGK5o0g5LpBktrVxqTYCpparWwxutbpDgArRiaF1GWQVkqQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=fK8nE3Rk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SxbjfsZ8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=fK8nE3Rk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SxbjfsZ8;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 06866F80038
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2026 20:35:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06866F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=fK8nE3Rk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SxbjfsZ8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=fK8nE3Rk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SxbjfsZ8
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCECA6AEC4;
	Mon, 15 Jun 2026 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781548512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okFSlXFrgGUn7DCyrUClTuTmJWMYurc5ucqR0mwgRt0=;
	b=fK8nE3RkiaayALf4Wp+iE/KPWZxCj7Ob2107D8ZhNcvrAeCUYwueOTG45tX9Gy+7m9SOHC
	5q0oEUq4HbNe5zHC6yu8HQ54VqagMJDwIFAuE7tkiNrgC8Wvr+2GgtyGLP+vGaWEeaKLj9
	z0aYQCEZnXvHFR845kFRh77A8OH6SK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781548512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okFSlXFrgGUn7DCyrUClTuTmJWMYurc5ucqR0mwgRt0=;
	b=SxbjfsZ8W9nVrNQem7MFIkdnhekEm6zNTBFuiQ0fklrXgWnut8TDQ+M4IuOKnkE/0JVqv8
	SaOSWWyOYnst5QDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781548512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okFSlXFrgGUn7DCyrUClTuTmJWMYurc5ucqR0mwgRt0=;
	b=fK8nE3RkiaayALf4Wp+iE/KPWZxCj7Ob2107D8ZhNcvrAeCUYwueOTG45tX9Gy+7m9SOHC
	5q0oEUq4HbNe5zHC6yu8HQ54VqagMJDwIFAuE7tkiNrgC8Wvr+2GgtyGLP+vGaWEeaKLj9
	z0aYQCEZnXvHFR845kFRh77A8OH6SK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781548512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okFSlXFrgGUn7DCyrUClTuTmJWMYurc5ucqR0mwgRt0=;
	b=SxbjfsZ8W9nVrNQem7MFIkdnhekEm6zNTBFuiQ0fklrXgWnut8TDQ+M4IuOKnkE/0JVqv8
	SaOSWWyOYnst5QDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CD10779A7;
	Mon, 15 Jun 2026 18:35:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cnyeJOBFMGqGYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 15 Jun 2026 18:35:12 +0000
Date: Mon, 15 Jun 2026 20:35:12 +0200
Message-ID: <87a4svslcv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC updates for v7.2
In-Reply-To: <ade83b6e856043bf84685b229f85a4d4@kernel.org>
References: <ade83b6e856043bf84685b229f85a4d4@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: KJQIMOAQYZURC6MTKEBTPHKOHEWWNNY4
X-Message-ID-Hash: KJQIMOAQYZURC6MTKEBTPHKOHEWWNNY4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KJQIMOAQYZURC6MTKEBTPHKOHEWWNNY4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 15 Jun 2026 19:04:15 +0200,
Mark Brown wrote:
> 
> The following changes since commit 310628484ef06f95c5589374fade917a5689787b:
> 
>   spi: rzv2h-rspi: Fix SPDR read access width for 16-bit RX (2026-06-10 16:39:13 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v7.2
> 
> for you to fetch changes up to 4346d91cfa47b0d9303533edde8acd33e4b9ca40:
> 
>   ASoC: dt-bindings: Fix RT5677 "realtek,gpio-config" type (2026-06-14 01:03:38 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Updates for v7.2
> 
> There's been quite a lot of framework improvements this time around,
> though mainly cleanups and robustness rather than user visible features.
> The same pattern is seen with a lot of the driver work that's going on,
> there are new features but a huge proportion of this is bug fixing and
> cleanup work.  We also have a good selectio of new device support.
> 
>  - Improvements to SDCA jack handling from Charles Keepax.
>  - Use of device links to make suspend handling more robust from Richard
>    Fitzgerald.
>  - Use of a new helper to factor out a common pattern in SoundWire
>    enmeration from Charles Keepax.
>  - Slimming down of the component from Kuninori Morimoto.
>  - Simplification of format auto selection from Kuninori Morimoto.
>  - Lots of conversions to guard() from Bui Duc Phuc.
>  - Addition of a simple-amplifier driver supporting more featureful GPIO
>    controller amplifiers than the previous basic driver from Herve
>    Codina.
>  - Support for AMD ACP 7.x, Cirrus Logic CS42448/CS42888, Everest Semi
>    ES9356, Mediatek MT2701 and MT8196, Renesas RZ/G3E, Spacemit K3,
>    Texas Instruments TAC5xx2 and TAS67524.

Pulled now.  Thanks.


Takashi
