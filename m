Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1092CCD8C90
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:53:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4750601EF;
	Wed, 10 Jun 2026 19:53:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4750601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781114031;
	bh=t+2KI1oayOj61N7hYH6J+8e6FZFeoz8f1YXTc/aF6Ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I9CXFAR5fMDOyFubmCcZYBOWX22JNldEoNXZlD0T9Zg/SB2cZmSEHg0HTzLET4Or8
	 Czck+qu2YBCr8xhheoC2YsUn9CgBkC0ptNqLNA922xACS3uvAQD7zv5T1IG6vzJ9PK
	 basYF8nQpDuQAiK2+CLsVIO7EQ0FBlmjd7SoGnCU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54B12F805EA; Wed, 10 Jun 2026 19:53:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 15B48F805F7;
	Wed, 10 Jun 2026 19:53:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDD8BF8058C; Wed, 10 Jun 2026 19:53:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781113990;
	b=r1M5w9lvBqySTUmgmdd+n5fh24KK0eGlAQQAZy3ki1bXLze2y7sL0vUEpZyHeK423p7B
	 HxRxnkxtHsRSRyDRrm6ygiQWw+96GIj3OcCuvHmAwCfT94MjyH6l+nx3LlMgX61AFDBP1
	 dIRxQ9qhNd0YU/ck46F5A5463agUZjNPAFbaVYrlZJg8JebSEZ24FHlvI8IZPwPgFcnO9
	 S7GLXYHSWtnINcAZBvvIeMbr+ULoy3OP6pBYL4TKn6pFfeFTpFQ6aszUKMPdIkCLzAGML
	 RaGsvYtYW4eccWI4w2kgbBmdrE1rTPFIOj2dLCuQfO/kHpB7/BneNOfoos87um71obg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781113990;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=t+2KI1oayOj61N7hYH6J+8e6FZFeoz8f1YXTc/aF6Ps=;
	b=XtLaHEBhjFWVkQER510Oa6Ui9bzhYrWBZRFtQMgddBl5BTqvPWfo+UyWJMk1L+s05XuD
	 uzQebjc4BGNyn5vekiQyL7QGIBvODvzNGFohPD6jVgt9xZbLGvgJx/Gy5GnoskWUDeL6c
	 MrOXQyHHoHlhwC5FD7Mq914JcALtiMQQOwN7zIFZRJb1mbgDBvaNv/LPWR+2aguxK0tKw
	 ZPUIxYEo9ZQL0UlzkSbKENy+0Jhhw3/JjsuVoHsZx8B016ATHNfcKtmWvvLY3tWoUv5gs
	 s45khx8ap1RCCVr1YL74lskWY/8/N9ATAFtYG9XD9WATfEuHuH6AHb6k5ppc+dCC7QQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=QNQoMdbu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=KiGMaGN8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=QNQoMdbu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=KiGMaGN8;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F39DFF801F5
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 19:53:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F39DFF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=QNQoMdbu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=KiGMaGN8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=QNQoMdbu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=KiGMaGN8
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30412759F8;
	Wed, 10 Jun 2026 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781113988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUciNjrtJsRjnxy3CnD+ewXR7F8FfJG5PQ4eTGUyd3A=;
	b=QNQoMdbu4A/kCh8fpE/Uy1bghklZFq9A9ADMnNdUjhaKaB0nnLglpnsL45QxyB7M0R/AfB
	Drsd55QUzlAyQmiupPCKP3nuchXgNb8sdRp0xga/E6hL+RnWq4YNmcXa2Bqs/RWsePE53+
	Og2arpd9mkNaQ4bOFQYxipX2IDpWqJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781113988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUciNjrtJsRjnxy3CnD+ewXR7F8FfJG5PQ4eTGUyd3A=;
	b=KiGMaGN8g90NbAr9M7GG7PkP8K48adBUlEuF6gToOUse09mFFbi3A7SJe0ScfDVGsBSYv6
	M1GBb2jAL9FxuVCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781113988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUciNjrtJsRjnxy3CnD+ewXR7F8FfJG5PQ4eTGUyd3A=;
	b=QNQoMdbu4A/kCh8fpE/Uy1bghklZFq9A9ADMnNdUjhaKaB0nnLglpnsL45QxyB7M0R/AfB
	Drsd55QUzlAyQmiupPCKP3nuchXgNb8sdRp0xga/E6hL+RnWq4YNmcXa2Bqs/RWsePE53+
	Og2arpd9mkNaQ4bOFQYxipX2IDpWqJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781113988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUciNjrtJsRjnxy3CnD+ewXR7F8FfJG5PQ4eTGUyd3A=;
	b=KiGMaGN8g90NbAr9M7GG7PkP8K48adBUlEuF6gToOUse09mFFbi3A7SJe0ScfDVGsBSYv6
	M1GBb2jAL9FxuVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05AEF779A7;
	Wed, 10 Jun 2026 17:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0zqWO4OkKWqTLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 10 Jun 2026 17:53:07 +0000
Date: Wed, 10 Jun 2026 19:53:07 +0200
Message-ID: <87y0gmjn98.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-2022-JP?B?GyRCPH4bKEJPY2Vhbg==?= <zhouoceanhy@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
In-Reply-To: 
 <CACYx1Soy=oqaZfX9A2NuvOdoghxPPyviFekk5giMMCJ5N+2NUQ@mail.gmail.com>
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
	<87y0h2r3g6.wl-tiwai@suse.de>
	<CACYx1SrnTfg6GKK2S1Vb13f9OWOq1x=VUDA=AFWs1CALsC_B2g@mail.gmail.com>
	<8733z7pv5e.wl-tiwai@suse.de>
	<CACYx1SobX420vGovUv-1WROW-Kh-sPvaFBj0vNfgQnVnDyOeZg@mail.gmail.com>
	<87fr32wwpv.wl-tiwai@suse.de>
	<CACYx1SqT5sL7MpsjnB16dPwhjyvhzjL3M0E6-ka0Rn-cSgqiqA@mail.gmail.com>
	<875x3usg00.wl-tiwai@suse.de>
	<CACYx1SqBnPiGkoRYQoBTPiR1nhVS3ha2i+ADGKfMSpSfaiC04A@mail.gmail.com>
	<CACYx1Sq87CJfYa6w-dFuDZigzDA73OEX9am2FhKS2P6OOxw97g@mail.gmail.com>
	<87se6xqyn1.wl-tiwai@suse.de>
	<CACYx1Soy=oqaZfX9A2NuvOdoghxPPyviFekk5giMMCJ5N+2NUQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[ocean-sudo];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: TBD5GNDLZ3METQBZD462N2TX3S4QPPYN
X-Message-ID-Hash: TBD5GNDLZ3METQBZD462N2TX3S4QPPYN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TBD5GNDLZ3METQBZD462N2TX3S4QPPYN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 10 Jun 2026 17:19:01 +0200,
周Ocean wrote:
> 
> Hi Takashi,
> 
> Thank you for the suggestions. I have tested the stock driver as requested.
> 
> Here are the results:
> 
> 1. Does the jack detection work for the rear jack? Yes, the jack
> detection works properly for the rear jack.
> 
> 2. Does the output from the rear work as-is? Yes, the output works
> normally. I primarily use this jack for an external TRS speaker.
> 
> 3. Changing the pin control of 0x1c: I plugged a TRRS headset (with a
> microphone) into the rear jack. Both the audio output and the headset
> microphone worked properly without any modifications. When I ran sudo
> hda-verb /dev/snd/hwC1D0 0x1c SET_PIN_WIDGET_CONTROL 0x00, the
> headphone output stopped as expected, and the microphone continued to
> work normally.
> 
> Based on these tests, the rear jack is a fully functional TRRS combo
> jack, and there is no hardware interference between the output (0x1c)
> and input (0x1b) pins.
> 
> The loud buzzing noise I reported earlier occurs only when a 3-pole
> TRS plug (like my external speaker or a standard headphone without a
> mic) is connected to the rear jack. It appears the hardware lacks
> proper impedance sensing to distinguish between TRS and TRRS plugs,
> and blindly leaves the mic input pin (0x1b) active. Since the TRS plug
> shorts the mic ring to ground, the active 0x1b pin captures ground
> loop noise.
> 
> This behavior is consistent with what I observe on Windows on the same
> machine: when a TRS speaker is plugged in, Windows shows a microphone
> device that captures no sound, likely because the pin is shorted to
> ground.
> 
> Given that this machine is a Mini-PC and the rear jack is mostly used
> for TRS external speakers, would applying a pin quirk to disable 0x1b
> (setting it to 0x40000000) be the most appropriate upstream fix?

Have you tried ctx_fixup_headset_mic, BTW?  I'm not sure whether this
is applicable to your model, but worth for a try.

If this doesn't work, then disabling the mic would be the simplest
solution.


thanks,

Takashi
