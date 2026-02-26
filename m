Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05981FD461F
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:42:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9190E601DB;
	Thu, 26 Feb 2026 07:42:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9190E601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772088129;
	bh=jU0OCOPqpgEAbQanjzcEdjHPZ7tP7xBD9LWiJhfb+M0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QJdUhU6Qv4xtz7nnFwpZRDL5L3uM4ahDLa81moR0CX5NFO7CqGrD0kLoceRCimkyO
	 o46k3YluvEefGT6reMYgoPU1yCBtOrC1xMcawMitLo7zpEU1My3OtiYgSAFhx5k+2q
	 35w6GXrqpzILfvdLTR2Ab4sPAEsMwJTbfxcBK00Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A18BEF805EC; Thu, 26 Feb 2026 07:41:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CA83FF805F2;
	Thu, 26 Feb 2026 07:41:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46734F8051E; Thu, 26 Feb 2026 07:41:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5306F800AE
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2026 07:41:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5306F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=IaV7S6J7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LxYeXuaz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=IaV7S6J7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LxYeXuaz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 939B65BF0B;
	Thu, 26 Feb 2026 06:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1772088082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9TXg55130/yue/G4bzqEHqacMuhU4XxyeY+Q5AsRGU=;
	b=IaV7S6J7okrb/rtuf1/srUDhO5112u0mOHMByieP3c9lQ3VWQu2kh/Uwj5a1f1TXRccaHV
	+k5wEpVySRPwHX4+wSKhw8GKq9a3nYIRJhMxlniKgjkvP3yTPNjl9W3L3heFz7mu8c0Kkg
	ZMVsVckcSgikVdbRa+eZiRKJeH7+XY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772088082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9TXg55130/yue/G4bzqEHqacMuhU4XxyeY+Q5AsRGU=;
	b=LxYeXuazOvS5xwLkcuzwYBHZIQ2ozurdu9m5czJsR/PH2cOxRDZ9QHIHZn7PLDrOLPdDvx
	bdODSoQKRNez5HCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IaV7S6J7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LxYeXuaz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1772088082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9TXg55130/yue/G4bzqEHqacMuhU4XxyeY+Q5AsRGU=;
	b=IaV7S6J7okrb/rtuf1/srUDhO5112u0mOHMByieP3c9lQ3VWQu2kh/Uwj5a1f1TXRccaHV
	+k5wEpVySRPwHX4+wSKhw8GKq9a3nYIRJhMxlniKgjkvP3yTPNjl9W3L3heFz7mu8c0Kkg
	ZMVsVckcSgikVdbRa+eZiRKJeH7+XY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772088082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9TXg55130/yue/G4bzqEHqacMuhU4XxyeY+Q5AsRGU=;
	b=LxYeXuazOvS5xwLkcuzwYBHZIQ2ozurdu9m5czJsR/PH2cOxRDZ9QHIHZn7PLDrOLPdDvx
	bdODSoQKRNez5HCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68CAD3EA62;
	Thu, 26 Feb 2026 06:41:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id psZdGBLrn2kQJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 26 Feb 2026 06:41:22 +0000
Date: Thu, 26 Feb 2026 07:41:22 +0100
Message-ID: <878qcgc8h9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Matt DeVillier <matt.devillier@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/ca0132: Set HP/Speaker auto-detect default from
 headphone pin verb
In-Reply-To: 
 <CAFTm+6DLcNvZYUT+8rU3tYoOwdbJQHufza_ChsoXmV8ep6fpjg@mail.gmail.com>
References: 
 <CAFTm+6DLcNvZYUT+8rU3tYoOwdbJQHufza_ChsoXmV8ep6fpjg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 939B65BF0B
Message-ID-Hash: WXGR52PCEYINTR3FZLEVVUVP43NWYX75
X-Message-ID-Hash: WXGR52PCEYINTR3FZLEVVUVP43NWYX75
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WXGR52PCEYINTR3FZLEVVUVP43NWYX75/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 25 Feb 2026 18:36:45 +0100,
Matt DeVillier wrote:
> 
> From 79d54b6b2b2410ac3c169329b93607042b137693 Mon Sep 17 00:00:00 2001
> From: Matt DeVillier <matt.devillier@gmail.com>
> Date: Wed, 25 Feb 2026 11:25:18 -0600
> Subject: [PATCH] ALSA: hda/ca0132: Set HP/Speaker auto-detect default from
>  headphone pin verb
> 
> HP/Speaker auto-detect (VNID_HP_ASEL) has been off by default for every
> CA0132 device since the driver was added in 2012. vnode_lswitch is
> always initialized to 0 in ca0132_init_chip(), and no quirk or other
> code path enables it. As a result, headphone jack detection works only
> after the user manually turns on "HP/Speaker Auto Detect" in alsamixer,
> which is not obvious on laptops with combo jacks (e.g. Google Link,
> Alienware).
> 
> Change the default to follow the headphone pin config: if the pin verb
> has presence detect enabled (no AC_DEFCFG_MISC_NO_PRESENCE) and the
> codec supports it (AC_PINCAP_PRES_DETECT), enable HP_ASEL by default.
> This lets firmware (coreboot, UEFI, etc.) express whether the headphone
> jack supports insertion detection. Devices with combo jacks can default
> to auto-detect; devices with fixed/no jack leave it off.
> 
> Signed-off-by: Matt DeVillier <matt.devillier@gmail.com>

The code change looks OK, but the patch seems malformed by your
mailer, and can't be applied cleanly.

Also, the mailing list for the kernel patch submission is
linux-sound@vger.kernel.org, not alsa-devel ML.

Please fix your mail setup and resubmit to the right address.


thanks,

Takashi


> ---
>  sound/hda/codecs/ca0132.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/sound/hda/codecs/ca0132.c b/sound/hda/codecs/ca0132.c
> index dd054aedd501..ca6cb57347ea 100644
> --- a/sound/hda/codecs/ca0132.c
> +++ b/sound/hda/codecs/ca0132.c
> @@ -9816,6 +9816,15 @@ static void ca0132_config(struct hda_codec *codec)
>   spec->dig_in = 0x09;
>   break;
>   }
> +
> + /* Default HP/Speaker auto-detect from headphone pin verb: enable if the
> + * pin config indicates presence detect (not AC_DEFCFG_MISC_NO_PRESENCE).
> + */
> + if (spec->unsol_tag_hp &&
> +     (snd_hda_query_pin_caps(codec, spec->unsol_tag_hp) &
> AC_PINCAP_PRES_DETECT) &&
> +     !(get_defcfg_misc(snd_hda_codec_get_pincfg(codec, spec->unsol_tag_hp)) &
> +       AC_DEFCFG_MISC_NO_PRESENCE))
> + spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID] = 1;
>  }
> 
>  static int ca0132_prepare_verbs(struct hda_codec *codec)
> -- 
> 2.51.0
