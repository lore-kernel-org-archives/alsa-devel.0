Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09E6CD8CAA
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:00:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1B96601DF;
	Tue,  9 Jun 2026 13:00:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1B96601DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781002834;
	bh=TT7JYzwNGvuPEyqDxfK54zdScEoRa0KapBc/2ImjBdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QOyZ4qffzLYqJcOQhJo0zRxHHLAKcJKbHSG6OhDbEGvnf+j6e/VqNvm8GpJn1NrtN
	 nV6/4AYnwYQNmBRghGM2ivTc1CJMvsUKrytkD5ScBiTG0zAyvJcTRIlvQ1Hu5DWZ72
	 NyJdAUXMFzj4sU2kLiHcTS1eF57sAYeY0JNjmrR4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44797F805F7; Tue,  9 Jun 2026 12:59:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B9D1F805F3;
	Tue,  9 Jun 2026 12:59:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2738F80496; Tue,  9 Jun 2026 12:59:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781002787;
	b=C+0rWr72o8cpYmyGxK3tvQM92+DXno9DercHGAMp6+5Ee2dG0nj22MF3C5Ni/VoQ6Asm
	 PPIei09oftKByd7k6ksIWE2lpivB4cew7CTBT0SsKaIeWRXpHu89AcRs94bIi+09OReMS
	 7/c811odXnJMyUi7Q8NTfYrBtmMxmZDyminZ0388G25eoRv+dFtebB0PLKIbLITSzri70
	 sNbOiXW4tAEojomdmkmtjPR6lNtYizcz72t8Lzyfaps/b84T2TWhwviKk44reHC8URcFv
	 uKyO0pYIMRPsWYky/PPhoZjGfLlUZ8DSt23xy9TzYop4LNM3RZIE+icCE0+4uUOLxgA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781002787;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=TT7JYzwNGvuPEyqDxfK54zdScEoRa0KapBc/2ImjBdw=;
	b=QUn+KmeAt5XUHkPrGBpYAHBj9wB1InsEyXkXWKTJvBCG/5rV1ViD+pX0bMvC58hw/Sx0
	 Wrg8TKGnQvYz+jW7sQWnZ+6vKNjZ9TykA5vaAPEtNam5/Wm7VhQ+xAyAcR0XH33vZKcOo
	 C5Alq5v3EFGaRCOSiH0ScaPDdv4foZRotJOR4yWK8716InyvpOq8e1NERBJmt7aMpJMBZ
	 P61u4Gh++XKh9gYT7WpBY4BXrIWAYOo97Layr2esKjdPjSV93pDem2SyQNK/DLC9zaC1i
	 ix4V7HHNOiSSQPMhLYIMQQPGQlZ2zaHk6hXkjnetqxjnf+mV95MgmJnGZ6D2D766Sfw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=AAElOWBR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dkd95XqW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=AAElOWBR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dkd95XqW;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3BC93F8001F
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 12:59:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BC93F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=AAElOWBR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dkd95XqW;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=AAElOWBR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dkd95XqW
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3282E75AF1;
	Tue,  9 Jun 2026 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781002785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRx/lNI6OwkSxWrNeVCrLPbTsacAdWB6Z06xnf8VVrw=;
	b=AAElOWBRkJIVWA1bR5Ei2DvUbXMExbcI4LyQMq4WGfPCo+qkhoCqeidTZWCxOPHOcCDklB
	1UsGjlcOPkxqzz2fw4QXRXZlau3h1Ub7qafKXETFjPtxuJ6Y/aHMTyYtEN0KhRWcgfMEHZ
	+zOeftn1JiKyWKUlxpeYCjlsmSNU5vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781002785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRx/lNI6OwkSxWrNeVCrLPbTsacAdWB6Z06xnf8VVrw=;
	b=dkd95XqWBRizCOLARwitlqDS45mV9vFoQUfa0ayO/yxRBevvyUCijS5Nk0jDMKZ5I9rCNi
	vURROSFNrT5UBnCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781002785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRx/lNI6OwkSxWrNeVCrLPbTsacAdWB6Z06xnf8VVrw=;
	b=AAElOWBRkJIVWA1bR5Ei2DvUbXMExbcI4LyQMq4WGfPCo+qkhoCqeidTZWCxOPHOcCDklB
	1UsGjlcOPkxqzz2fw4QXRXZlau3h1Ub7qafKXETFjPtxuJ6Y/aHMTyYtEN0KhRWcgfMEHZ
	+zOeftn1JiKyWKUlxpeYCjlsmSNU5vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781002785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRx/lNI6OwkSxWrNeVCrLPbTsacAdWB6Z06xnf8VVrw=;
	b=dkd95XqWBRizCOLARwitlqDS45mV9vFoQUfa0ayO/yxRBevvyUCijS5Nk0jDMKZ5I9rCNi
	vURROSFNrT5UBnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F9AA779A7;
	Tue,  9 Jun 2026 10:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g5scByHyJ2ozfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 09 Jun 2026 10:59:45 +0000
Date: Tue, 09 Jun 2026 12:59:44 +0200
Message-ID: <87cxy06ktb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gigi Furnari <gigi.furnari@hotmail.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH REQUEST] hda/realtek: Add fixup for HP Spectre x360
 16-f1xxx (103c:891c, ALC245)
In-Reply-To: 
 <AS8P250MB0887C48FD62B9F2A5B882565F41F2@AS8P250MB0887.EURP250.PROD.OUTLOOK.COM>
References: 
 <AS8P250MB0887C48FD62B9F2A5B882565F41F2@AS8P250MB0887.EURP250.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [4.20 / 50.00];
	MSBL_EBL(7.50)[your@email.com:email];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	FREEMAIL_ENVRCPT(0.00)[hotmail.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,email.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: GNGWQCD3B2ULAHAVTBFCDPP6TMCWT25X
X-Message-ID-Hash: GNGWQCD3B2ULAHAVTBFCDPP6TMCWT25X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GNGWQCD3B2ULAHAVTBFCDPP6TMCWT25X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 07 Jun 2026 21:16:47 +0200,
Gigi Furnari wrote:
> 
> 
> The HP Spectre x360 2-in-1 Laptop 16-f1xxx (PCI SSID 103c:891c) uses
> a Realtek ALC245 codec. Without a fixup, the upper speakers (node 0x14)
> are silent because their pin configuration is set to N/A (0x411111f0)
> and the amplifier GPIO is not initialized.
>  
> The codec layout is:
>   Node 0x14: upper speakers, connected to DAC 0x02, EAPD present
>   Node 0x17: lower speakers, connected to DAC 0x06 (active)
>   Node 0x21: headphone out, connected to DAC 0x03 (active)
>  
> The fix overrides the pin default config for node 0x14 to mark it as
> an internal fixed speaker, and chains to the existing
> ALC245_FIXUP_HP_X360_AMP fixup which toggles GPIO0 to enable the
> amplifier -- the same mechanism used by the HP Spectre x360 14
> (103c:87f7).
>  
> Note: the driver currently reads PCI SSID as 103c:0000 instead of the
> correct 103c:891c (the codec reports Subsystem Id: 0x103c891c correctly
> in /proc/asound/card0/codec#0). This means no device-specific fixup is
> applied without an explicit model parameter. This patch adds the quirk
> entry so the correct fixup is applied automatically once the SSID
> reading issue is resolved, and can be used with model= in the meantime.
>  
> Signed-off-by: [Your Name] <your@email.com>
> ---
>  
> HOW TO APPLY (context lines abbreviated; apply against current mainline):
>  
> In sound/pci/hda/patch_realtek.c:
>  
> 1) In the enum (near ALC245_FIXUP_HP_X360_AMP), add:
>    ALC245_FIXUP_HP_SPECTRE_X360_16,
>  
> 2) In alc269_fixups[], after the ALC245_FIXUP_HP_X360_AMP entry, add:
>  
>  [ALC245_FIXUP_HP_SPECTRE_X360_16] = {
>   .type = HDA_FIXUP_PINS,
>   .v.pins = (const struct hda_pintbl[]) {
>    { 0x14, 0x90170110 }, /* upper speakers */
>    { }
>   },
>   .chained = true,
>   .chain_id = ALC245_FIXUP_HP_X360_AMP,
>  },
>  
> 3) In alc269_fixup_tbl[] (keep sorted by PCI SSID), add:
>  
>  SND_PCI_QUIRK(0x103c, 0x891c, "HP Spectre x360 16-f1xxx",
>         ALC245_FIXUP_HP_SPECTRE_X360_16),
>  
> ---
> Full diff (line numbers are approximate; verify against current tree):
>  
>  sound/pci/hda/patch_realtek.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ enum (around ALC245_FIXUP_HP_X360_AMP line) @@
>   ALC245_FIXUP_HP_X360_AMP,
> + ALC245_FIXUP_HP_SPECTRE_X360_16,
>  
> @@ alc269_fixups[] (after ALC245_FIXUP_HP_X360_AMP block) @@
> + [ALC245_FIXUP_HP_SPECTRE_X360_16] = {
> + .type = HDA_FIXUP_PINS,
> + .v.pins = (const struct hda_pintbl[]) {
> + { 0x14, 0x90170110 }, /* upper speakers */
> + { }
> + },
> + .chained = true,
> + .chain_id = ALC245_FIXUP_HP_X360_AMP,
> + },
>  
> @@ alc269_fixup_tbl[] (sorted position after 0x891b if present, else near
> 0x891c) @@
> + SND_PCI_QUIRK(0x103c, 0x891c, "HP Spectre x360 16-f1xxx",
> + ALC245_FIXUP_HP_SPECTRE_X360_16),

The code change itself looks OK, so could you try to resubmit in a
proper format with sign-off?  The spaces in the patches got broken by
your mailer, and you might need to fix the mailer setup (at best
submit via git-send-email).  As a last resort, you can use an
attachment, too.

> ADDITIONAL NOTE FOR MAINTAINER:
>  
> The codec correctly reports Subsystem Id: 0x103c891c in
> /proc/asound/card0/codec#0, but dmesg shows:
>   snd_hda_codec_alc269: ALC245: picked fixup for PCI SSID 103c:0000
>  
> This SSID mismatch (0000 vs 891c) means the quirk table is never
> consulted. The root cause appears to be in how the HDA subsystem ID
> is read on this Alder Lake platform -- a separate bug that may need
> investigation in hda_codec.c or the Intel HDA driver.

This should have been already addressed recently by the fix commit
0aacce7c32e4 ("ALSA: hda: Avoid quirk matching with zero PCI SSID").
Let me know if the issue still persists even with this fix.


thanks,

Takashi
