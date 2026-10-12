Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1E0CA9EC5
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:42:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71DB460200;
	Mon, 12 Oct 2026 09:42:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71DB460200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791790961;
	bh=NBBbcLYulHLhK4CdFaRVal3Y0VsFJYEIZnfaMhg1H3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X7CL8Xk9V6ad84/oVUK/emgjsHCx9p9MMtPwrRAreGl0Qb9FTPVTHhfT+YvLueZq9
	 ghfWav+xSdPMKuX989W9EtZNdYIDGWhZ1biaFraLlCfIgokE8+tZWRVR4BG0UueaRZ
	 6dCYhKQDIFTcuDbCqspZlIKpxJS4/eFQRMjGM/oc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E3C6F805E7; Mon, 12 Oct 2026 09:42:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2ACE5F805D3;
	Mon, 12 Oct 2026 09:42:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D3F8F80526; Mon, 12 Oct 2026 09:41:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791790915;
	b=Xp8ZKhLg2rdQla1JLsYHylYVDJoJf3VHOT1wn0LwkiAvgRMajidL7mTsRXkrEUAfi0um
	 m89UbwTqhImBUK2dT4lITvs1Phq823Cx+7A8aI6sdPinDKTQWPTvsTuFCU1P3/0ILGqYs
	 CbZQBwfmc1uAlLGmXERtZkrAjyoq2wsJhU3F01Y3zRtAGSNHVwiTPmn2XgGA7yGMTu1RN
	 ThrEV3M+drblB70cy0YF7tadk6EEjnHKf9uGYaun/6C39IxwtOdO0fOeUH41TMXH2MpcQ
	 hJdsmwrtTfIyrxf0taiNnCrd5OIdMTGJBZsQV2w44kWiHk0/zQr9oIplG1glN0DH4HQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791790915;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=NBBbcLYulHLhK4CdFaRVal3Y0VsFJYEIZnfaMhg1H3U=;
	b=bdNnY6d7DcJzAeRnTR8fyNXUzy+5otxboppjdhVtKrJF3G6E4mj/S+E3cXs3SNgUP97y
	 GnhSMfEo3CrYiJKSPnCoUVas2lZv1VqOsfhqY/WloyiI+2gIGsy5EQZ64Hbn4L3tQ6GJv
	 KfOW+g9sDYA8Pb+pKRfhl+V5FHh/sK0/VljUdaNTl3m49DYThPPJWXx+whCcv19VI2yuW
	 VHfW8YBIu2Sw4UvTz/lbjUjAgExDdeJuO3nO/4+MOB9/UOLiZfskJZ2mvtz94KKlsOqoQ
	 ViTfvwUNhI3VVPzPnPKeyEnXYKqFwYIx3g8C4aG5BwJmVycebXxtEoZRuKTrt6TttHA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Q0XtQZsp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="z5xD/E86";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Q0XtQZsp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="z5xD/E86";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EFE13F80424
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 09:41:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFE13F80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Q0XtQZsp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=z5xD/E86;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Q0XtQZsp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=z5xD/E86
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 045911F76C;
	Mon, 12 Oct 2026 07:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791790913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK0RjV01j15XAfD1bslcrosVqxBWBkOyzhIpmWsbcP8=;
	b=Q0XtQZspd+UB+XcN4YGSK3oPEEIXT81drn/L8IXKcjhLLk5NvktQH+Z9WzvrkTVwsvhgjE
	wFCEDS9TpbkwInZW48x3d9pkHg166AX8URRrtvUmNKQbp5VifPHoH4Md4Kk8L1dJg5wNq2
	SPby+v6/WrXOrygTU4gpzmE9R43C+NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791790913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK0RjV01j15XAfD1bslcrosVqxBWBkOyzhIpmWsbcP8=;
	b=z5xD/E86GgZx526ltRl8k2GMps2YCBDEvIf6PlXkffkkpGAmauFb2e4e1JJnJa9jwx0S5K
	MoDtBPnzqxYz2oAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791790913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK0RjV01j15XAfD1bslcrosVqxBWBkOyzhIpmWsbcP8=;
	b=Q0XtQZspd+UB+XcN4YGSK3oPEEIXT81drn/L8IXKcjhLLk5NvktQH+Z9WzvrkTVwsvhgjE
	wFCEDS9TpbkwInZW48x3d9pkHg166AX8URRrtvUmNKQbp5VifPHoH4Md4Kk8L1dJg5wNq2
	SPby+v6/WrXOrygTU4gpzmE9R43C+NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791790913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK0RjV01j15XAfD1bslcrosVqxBWBkOyzhIpmWsbcP8=;
	b=z5xD/E86GgZx526ltRl8k2GMps2YCBDEvIf6PlXkffkkpGAmauFb2e4e1JJnJa9jwx0S5K
	MoDtBPnzqxYz2oAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AECE213314;
	Mon, 12 Oct 2026 07:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Qc6IUCPzGqAcAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Oct 2026 07:41:52 +0000
Date: Mon, 12 Oct 2026 09:41:52 +0200
Message-ID: <87wlrngybj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Gon=E7alo?= Miranda <me@goncalom.dev>
Cc: alsa-devel@alsa-project.org,
	perex@perex.cz
Subject: Re: [PATCH] ALSA: hda/conexant: Add quirk for Acer Aspire Go 16 mic
 mute LED
In-Reply-To: <20261011113709.25174-1-me@goncalom.dev>
References: <20261011113709.25174-1-me@goncalom.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: HVJQFPXU2ZVJGPAVH3AIVV2Z7AFW4TYJ
X-Message-ID-Hash: HVJQFPXU2ZVJGPAVH3AIVV2Z7AFW4TYJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HVJQFPXU2ZVJGPAVH3AIVV2Z7AFW4TYJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 11 Oct 2026 13:37:09 +0200,
Gonçalo Miranda wrote:
> 
> The Acer Aspire Go 16 (AG16-71P) uses a Conexant SN6180 codec
> (subsystem ID 0x1025:0x1937) with the microphone mute LED wired
> to GPIO4. Add a quirk entry so the kernel drives the LED in sync
> with the microphone mute state.
> 
> The fixup reuses the existing cxt_setup_mute_led() helper with
> mask 0x10, matching the behavior verified on the hardware.
> 
> Signed-off-by: Gonçalo Miranda <me@goncalom.dev>
> ---
>  sound/hda/codecs/conexant.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
> index 40da2832b..f66bae098 100644
> --- a/sound/hda/codecs/conexant.c
> +++ b/sound/hda/codecs/conexant.c
> @@ -283,6 +283,7 @@ enum {
>  	CXT_FIXUP_HP_SPECTRE,
>  	CXT_FIXUP_HP_GATE_MIC,
>  	CXT_FIXUP_MUTE_LED_GPIO,
> +	CXT_FIXUP_ACER_ASPIRE_GO_MUTE_LED,
>  	CXT_FIXUP_HP_ELITEONE_OUT_DIS,
>  	CXT_FIXUP_HP_ZBOOK_MUTE_LED,
>  	CXT_FIXUP_HEADSET_MIC,
> @@ -786,6 +787,13 @@ static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
>  		cxt_setup_mute_led(codec, 0x10, 0x20);
>  }
>  
> +static void cxt_fixup_acer_aspire_go_mute_led(struct hda_codec *codec,
> +					      const struct hda_fixup *fix, int action)
> +{
> +	if (action == HDA_FIXUP_ACT_PRE_PROBE)
> +		cxt_setup_mute_led(codec, 0, 0x10);
> +}
> +
>  static void cxt_fixup_hp_a_u(struct hda_codec *codec,
>  			     const struct hda_fixup *fix, int action)
>  {
> @@ -985,6 +993,10 @@ static const struct hda_fixup cxt_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = cxt_fixup_mute_led_gpio,
>  	},
> +	[CXT_FIXUP_ACER_ASPIRE_GO_MUTE_LED] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = cxt_fixup_acer_aspire_go_mute_led,
> +	},
>  	[CXT_FIXUP_HP_ELITEONE_OUT_DIS] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = cxt_fixup_update_pinctl,
> @@ -1098,6 +1110,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
>  	SND_PCI_QUIRK(0x103c, 0x82b4, "HP ProDesk 600 G3", CXT_FIXUP_HP_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x103c, 0x836e, "HP ProBook 455 G5", CXT_FIXUP_MUTE_LED_GPIO),
>  	SND_PCI_QUIRK(0x103c, 0x837f, "HP ProBook 470 G5", CXT_FIXUP_MUTE_LED_GPIO),
> +	SND_PCI_QUIRK(0x1025, 0x1937, "Acer Aspire Go 16", CXT_FIXUP_ACER_ASPIRE_GO_MUTE_LED),
>  	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
>  	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
>  	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),

The fixup table is sorted in PCI SSID order.  Please put the new entry
at the right position.

Also, the correct place for the sound kernel patch submission is
linux-sound ML (linux-sound@vger.kernel.org) instead of alsa-devel ML.
The latter is only for user-space stuff now.  Please resubmit to the
former ML, instead.


thanks,

Takashi
