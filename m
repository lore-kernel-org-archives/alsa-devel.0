Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83DCCD5BD2
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2026 09:05:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68FCE6023E;
	Fri, 29 May 2026 11:05:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68FCE6023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780045556;
	bh=oAI2HnBa91IdOP8uFMsFUGbz61PW3+ayH4MvShh9JKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=d4Wt1RAG+B8+w4PPHK6l2H9kPP5IeH9CRl7JQ089UDB63gYgbiPoMYSyi24BswVg+
	 vE54IFxrLfCHc8/Org1kYx1ScheoHW8KphdybOo9lrKq/NRewy65HXaRLoCBJFn5+L
	 6eyYEQHTptNlBDOtPOM6PoX/k86BersMCkd7Y53o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1000DF805EC; Fri, 29 May 2026 11:05:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BA2BFF805E9;
	Fri, 29 May 2026 11:05:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 170FBF804D6; Fri, 29 May 2026 11:05:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC021F801F5
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2026 11:05:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC021F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=lASCuvwJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HG/zy9rh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=lASCuvwJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HG/zy9rh
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2272366EED;
	Fri, 29 May 2026 09:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780045514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTvrWopiALdf/Qehr/WukRyqCCEGhGFmiDdypIAyMc=;
	b=lASCuvwJf573Or2wm8kPHCLH62IyJZwspzQ6Vwk7GPgAExhX+PEo2fK9SbPSjs7JIpo3KO
	PVG2PxWUdilW6v+03jDOUZS9twwTW5D0CXL/aNQQbpgEYVZpbcxfdrSFhQFLdFs4MFmWKB
	7L0fHFA+gNbbte7I/bDc51zJTEENBm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780045514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTvrWopiALdf/Qehr/WukRyqCCEGhGFmiDdypIAyMc=;
	b=HG/zy9rhNZyc21QvMtNIddEn7ML4o8PXyaKleSVSekZ5rUKhreAmkVWQXyHvcueVW7/ptc
	DkhkhDWfspdTOhBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780045514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTvrWopiALdf/Qehr/WukRyqCCEGhGFmiDdypIAyMc=;
	b=lASCuvwJf573Or2wm8kPHCLH62IyJZwspzQ6Vwk7GPgAExhX+PEo2fK9SbPSjs7JIpo3KO
	PVG2PxWUdilW6v+03jDOUZS9twwTW5D0CXL/aNQQbpgEYVZpbcxfdrSFhQFLdFs4MFmWKB
	7L0fHFA+gNbbte7I/bDc51zJTEENBm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780045514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTvrWopiALdf/Qehr/WukRyqCCEGhGFmiDdypIAyMc=;
	b=HG/zy9rhNZyc21QvMtNIddEn7ML4o8PXyaKleSVSekZ5rUKhreAmkVWQXyHvcueVW7/ptc
	DkhkhDWfspdTOhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE3AC779A7;
	Fri, 29 May 2026 09:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5C72OMlWGWoFPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 May 2026 09:05:13 +0000
Date: Fri, 29 May 2026 11:05:13 +0200
Message-ID: <87y0h2r3g6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: ocean <zhouoceanhy@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
In-Reply-To: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: TUUZ5UXMP5EHBYH66BOWJJT2P7YWAYIP
X-Message-ID-Hash: TUUZ5UXMP5EHBYH66BOWJJT2P7YWAYIP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TUUZ5UXMP5EHBYH66BOWJJT2P7YWAYIP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 29 May 2026 06:11:47 +0200,
ocean wrote:
> 
> From: Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
> 
> FEVM FA880 PRO mini PC uses Conexant CX20632 codec. The internal
> microphone is connected to pin 0x1e. In order to make it work,
> we need to force ADC 0x14 connection to 0x1e (connection index 3).
> 
> This patch adds a new quirk CXT_FIXUP_CX20632_INTMIC to force
> the connection selection on initialization, and applies it
> for the SSID 2014:8004.
> 
> Signed-off-by: Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>

If a hard-wire is needed, usually we correct the routes before
parsing (e.g. correcting the connection list), so that the parser
would wire via the expected route.

How does the original topology look like and how it should be changed?


thanks,

Takashi

> ---
>  sound/pci/hda/patch_conexant.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 2d4094be83ab..5e2279267104 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -300,6 +300,7 @@ enum {
>  	CXT_PINCFG_SWS_JS201D,
>  	CXT_PINCFG_TOP_SPEAKER,
>  	CXT_FIXUP_HP_A_U,
> +	CXT_FIXUP_CX20632_INTMIC,
>  };
>  
>  /* for hda_fixup_thinkpad_acpi() */
> @@ -343,6 +344,15 @@ static void cxt5066_increase_mic_boost(struct hda_codec *codec,
>  				  (0 << AC_AMPCAP_MUTE_SHIFT));
>  }
>  
> +static void cxt_fixup_cx20632_intmic(struct hda_codec *codec,
> +				     const struct hda_fixup *fix, int action)
> +{
> +	if (action != HDA_FIXUP_ACT_INIT)
> +		return;
> +
> +	/* Force ADC 0x14 to internal mic pin 0x1e (conn index 3). */
> +	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_CONNECT_SEL, 0x03);
> +}
> +
>  static void cxt_update_headset_mode(struct hda_codec *codec)
>  {
>  	/* The verbs used in this function were tested on a Conexant CX20751/2 codec. */
> @@ -1035,6 +1045,10 @@ static const struct hda_fixup cxt_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = cxt_fixup_hp_a_u,
>  	},
> +	[CXT_FIXUP_CX20632_INTMIC] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = cxt_fixup_cx20632_intmic,
> +	},
>  };
>  
>  static const struct hda_quirk cxt5045_fixups[] = {
> @@ -1140,6 +1154,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
>  	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
>  	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
>  	SND_PCI_QUIRK(0x1d05, 0x3012, "MECHREVO Wujie 15X Pro", CXT_FIXUP_HEADSET_MIC),
> +	SND_PCI_QUIRK(0x2014, 0x8004, "FEVM FA880 PRO", CXT_FIXUP_CX20632_INTMIC),
>  	HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
>  	HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
>  	{}
> @@ -1165,6 +1180,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
>  	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
>  	{ .id = CXT_FIXUP_HP_A_U, .name = "HP-U-support" },
> +	{ .id = CXT_FIXUP_CX20632_INTMIC, .name = "cx20632-intmic" },
>  	{}
>  };
>  
