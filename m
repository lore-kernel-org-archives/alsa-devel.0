Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AD510ED645
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:53:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FF16601FF;
	Fri, 27 Mar 2026 10:53:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FF16601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774605206;
	bh=SMr6u8uFq71snlbn8ZV6qWIuiyRiKSwhGR0fZtmmtBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=B8vyaozlT9l/aq02bPOS3sk6a6qZCbe3WOi0cVVw6v4w4T609mNzG9ujhHn2J7bBe
	 /GuccpMHT9O+GvPX2ocp18JLZ7APQhftaV2eGBST4JpcEONvoSFYA53/WnA0j0TOqo
	 BMs80+tmYeRBHCx0pS6hUL3ZTtJC+5AGA0nS5eaw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51E1BF805F4; Fri, 27 Mar 2026 10:52:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6ED6EF805E7;
	Fri, 27 Mar 2026 10:52:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB510F804F3; Fri, 27 Mar 2026 10:52:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B518F80212
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 10:52:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B518F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=GmBv1Bbj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ubTnVFoE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=GmBv1Bbj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ubTnVFoE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 907D55BCF9;
	Fri, 27 Mar 2026 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774605161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs7UhIkhdLQakbVrNX2HSsCN8BCm0GXrMbthi0vSTdQ=;
	b=GmBv1BbjWx20O7InL/xAu2u4yp7Ldg02ADRgjaE2+Z+JtPMRW6s+It/YOZCdA/rQBe905Z
	6AjbHnhB0rDDmDAt7UyNHaOPxwFn8ePn6qJNfJWZs8gFkbBAV4R8LiWIYNY3lB4Fj1K1x6
	GIWr1tY3hE1A5jV5qJDFDHT5qN4FAnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774605161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs7UhIkhdLQakbVrNX2HSsCN8BCm0GXrMbthi0vSTdQ=;
	b=ubTnVFoEx3X2hZnRwMUntudrp5W92nb8KtGXOeoHPQMf+bkaG6dC8jDJ4uuIYjo+ACYOO6
	RTB5UX/T9I37mxCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774605161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs7UhIkhdLQakbVrNX2HSsCN8BCm0GXrMbthi0vSTdQ=;
	b=GmBv1BbjWx20O7InL/xAu2u4yp7Ldg02ADRgjaE2+Z+JtPMRW6s+It/YOZCdA/rQBe905Z
	6AjbHnhB0rDDmDAt7UyNHaOPxwFn8ePn6qJNfJWZs8gFkbBAV4R8LiWIYNY3lB4Fj1K1x6
	GIWr1tY3hE1A5jV5qJDFDHT5qN4FAnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774605161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs7UhIkhdLQakbVrNX2HSsCN8BCm0GXrMbthi0vSTdQ=;
	b=ubTnVFoEx3X2hZnRwMUntudrp5W92nb8KtGXOeoHPQMf+bkaG6dC8jDJ4uuIYjo+ACYOO6
	RTB5UX/T9I37mxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68E624A0A2;
	Fri, 27 Mar 2026 09:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FlAvGGlTxmkONwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 09:52:41 +0000
Date: Fri, 27 Mar 2026 10:52:41 +0100
Message-ID: <878qbdsiom.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rocket Raccoon <rakketje1@gmail.com>
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga 7 2-in-1
 14AKP10
In-Reply-To: 
 <CAL76xbU81CKcbAD436djDbJ8P+xsj0r24i7phFG1YcSVr2n2JQ@mail.gmail.com>
References: 
 <CAL76xbU81CKcbAD436djDbJ8P+xsj0r24i7phFG1YcSVr2n2JQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: 3PKJFXXOYDWPASXONPZKLWHNGRATPX5U
X-Message-ID-Hash: 3PKJFXXOYDWPASXONPZKLWHNGRATPX5U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3PKJFXXOYDWPASXONPZKLWHNGRATPX5U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 25 Mar 2026 13:26:54 +0100,
Rocket Raccoon wrote:
> 
> The Lenovo Yoga 7 2-in-1 14AKP10 (PCI subsystem ID 0x17aa:0x391c) uses
> an ALC287 HDA codec paired with a TAS2781 amplifier connected via I2C.
> Without this quirk the amplifier is not initialised and internal speaker
> output lacks amplification.
> 
> Signed-off-by: Lucas <rakketje1@gmail.com>

The Signed-off-by line must be a real name or a known identity as it's
a legal requirement.  (Also it's better aligned with From line.)

> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index XXXXXXX..XXXXXXX 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -XXXXX,6 +XXXXX,7 @@ static const struct snd_pci_quirk alc287_fixup_tbl[] = {
>   SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo Yoga Pro 9 14IRP8",
> ALC287_FIXUP_TAS2781_I2C),
> + SND_PCI_QUIRK(0x17aa, 0x391c, "Lenovo Yoga 7 2-in-1 14AKP10",
> ALC287_FIXUP_TAS2781_I2C),
>   SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL",
> ALC287_FIXUP_13S_GEN2_SPEAKERS),

... and the patch seems not applicable cleanly.  Please fix your
mailer setup, too.


thanks,

Takashi
