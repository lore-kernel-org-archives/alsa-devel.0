Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C01CD4F3D
	for <alsa-devel@archiver.kernel.org>; Sun, 17 May 2026 19:50:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D810D6013C;
	Sun, 17 May 2026 21:50:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D810D6013C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779047418;
	bh=ED/IhnZmfmk340VQ7v/DrnYNmuNCn8kVEfpdVrH06g0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IuBwtLeZQB2xxtxFfk5EZ9klGh8zs0HueAIBEQebaTGe57W35XJpLsBWiq83Jq3mR
	 5rYJWrk6h0xRDxBpu2eIZ6fjqEO/WbsZt33wIL2kmSf3nhipH2cniCtP5WVwmjrxDS
	 0C1AX2c8duFPcIHsvku2uQnZNwdx13Mg91PcmqU0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D976F805EF; Sun, 17 May 2026 21:49:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E6F8F804FF;
	Sun, 17 May 2026 21:49:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 534A3F804FF; Sun, 17 May 2026 21:49:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3A698F8003C
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2026 21:49:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A698F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=vDigHXol;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=v3KERloS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=vDigHXol;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=v3KERloS
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BA906AD5B;
	Sun, 17 May 2026 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779047369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUDOpbtBBLCesti4O1F32n9KZv1NZ5UKAxativOCUf4=;
	b=vDigHXolKhhMcSwRggAd8U7glkDnA5LhBbJGbSJGFZaOnMSw+8+24KSmZbmlk6wi0nLMR6
	ZrUDu7S+TwXwLntmnzHufH9UUTmisRZGqQRfQJr/Kl2R+kHAFnGZQsiR39ANMR2HBIQI6V
	xP1GyrttwavNv3a5bjg0+H7ukUldH1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779047369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUDOpbtBBLCesti4O1F32n9KZv1NZ5UKAxativOCUf4=;
	b=v3KERloStdjzUsJZuNvGlcW1eBwpJTl3xJPiyvhKmuUHIRTQQk3j3bEMsRutEfupRYGq9F
	RaEQiA8sz1BUsWBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779047369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUDOpbtBBLCesti4O1F32n9KZv1NZ5UKAxativOCUf4=;
	b=vDigHXolKhhMcSwRggAd8U7glkDnA5LhBbJGbSJGFZaOnMSw+8+24KSmZbmlk6wi0nLMR6
	ZrUDu7S+TwXwLntmnzHufH9UUTmisRZGqQRfQJr/Kl2R+kHAFnGZQsiR39ANMR2HBIQI6V
	xP1GyrttwavNv3a5bjg0+H7ukUldH1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779047369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUDOpbtBBLCesti4O1F32n9KZv1NZ5UKAxativOCUf4=;
	b=v3KERloStdjzUsJZuNvGlcW1eBwpJTl3xJPiyvhKmuUHIRTQQk3j3bEMsRutEfupRYGq9F
	RaEQiA8sz1BUsWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71257593A8;
	Sun, 17 May 2026 19:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mfaoGckbCmqmYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 17 May 2026 19:49:29 +0000
Date: Sun, 17 May 2026 21:49:29 +0200
Message-ID: <87ik8lerzq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: grxp <grxp323@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add HP OMEN 16-n0000 mute LED quirk
In-Reply-To: <20260516190734.34721-1-grxp323@gmail.com>
References: <20260516190734.34721-1-grxp323@gmail.com>
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: LWPZSTCEKVCLFZUP6IBUOXKMBABYPTGE
X-Message-ID-Hash: LWPZSTCEKVCLFZUP6IBUOXKMBABYPTGE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LWPZSTCEKVCLFZUP6IBUOXKMBABYPTGE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 16 May 2026 21:07:34 +0200,
grxp wrote:
> 
> The HP OMEN 16-n0000 laptop uses an 
> ALC245 codec with a mute LED controlled by a coef register.
> Add the corresponding quirk to enable the mute LED.
> After testing, the LED brightness is consistent with Windows.
> 
> Signed-off-by: grxp <grxp323@gmail.com>

The Signed-off-by tag (and From tag, too) must be with either a real
name or a known identity as a legal requirement. 
Please correct it and resubmit.


thanks,

Takashi
