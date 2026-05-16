Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06CDCD4F21
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2026 13:41:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D43560204;
	Sat, 16 May 2026 15:41:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D43560204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778938907;
	bh=TITm35/ifVZPy2M1UNvDev2oQdtCV0e2dyIli5exy4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cPWUz/T+udgp+dW9j1cXfsJmVbEqR/Odvb3YSyirtlT+XwvfqWELQhHyTp/YU/Sp5
	 RgDDI1Obt/REx7WVqW+7OCwThoD9JBegZUEmPkqitgK0V+e6LxjtNehVDzENRMjd49
	 gK1hGi2Zrlx2ibsGOT6i0JlLD6vkrDV2hbNJhXYA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1F1DF805E8; Sat, 16 May 2026 15:41:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BA23AF805E8;
	Sat, 16 May 2026 15:41:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC203F80217; Sat, 16 May 2026 15:41:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91CA5F800AE
	for <alsa-devel@alsa-project.org>; Sat, 16 May 2026 15:41:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91CA5F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=t7HFHRYs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hxVcHEGd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=t7HFHRYs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hxVcHEGd
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 833D25F500;
	Sat, 16 May 2026 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778938863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aQ0hheo+mYyOZTX9kqcdfYRosMxK3IdXk3nJT3/RN8A=;
	b=t7HFHRYsRVlyDhYg8rdbloXC0zhXWKaroZhElTgRIevKmTaaoWv3V8/o+WCgTqfEu8Ynfk
	ri2hNAh+cgjHaBw4Tz0BhPxyoIkWVeg3xDHG43eCo/xkHJSwZkCErHnkiag1wn8nx4DoOR
	4xxuKOyiTKxAEIvfRC9/lbjgRBlzAIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778938863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aQ0hheo+mYyOZTX9kqcdfYRosMxK3IdXk3nJT3/RN8A=;
	b=hxVcHEGdJlG+LPFjgQbkJRTfcwWP1wZy4SViTIjD+gFIhIKnWrYr1QSiZsqqEbBcY5+JaD
	6cKaESn7Wnk1G2AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t7HFHRYs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hxVcHEGd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778938863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aQ0hheo+mYyOZTX9kqcdfYRosMxK3IdXk3nJT3/RN8A=;
	b=t7HFHRYsRVlyDhYg8rdbloXC0zhXWKaroZhElTgRIevKmTaaoWv3V8/o+WCgTqfEu8Ynfk
	ri2hNAh+cgjHaBw4Tz0BhPxyoIkWVeg3xDHG43eCo/xkHJSwZkCErHnkiag1wn8nx4DoOR
	4xxuKOyiTKxAEIvfRC9/lbjgRBlzAIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778938863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aQ0hheo+mYyOZTX9kqcdfYRosMxK3IdXk3nJT3/RN8A=;
	b=hxVcHEGdJlG+LPFjgQbkJRTfcwWP1wZy4SViTIjD+gFIhIKnWrYr1QSiZsqqEbBcY5+JaD
	6cKaESn7Wnk1G2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54E33593A8;
	Sat, 16 May 2026 13:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjcxEu9zCGqKXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 16 May 2026 13:41:03 +0000
Date: Sat, 16 May 2026 15:41:02 +0200
Message-ID: <87tss7xyj5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "eziogale@gmail.com" <eziogale@gmail.com>
Cc: Takashi Iwai ` <tiwai@suse.com>,
	Jaroslav Kysela ` <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: ca0132: add generic parser fallback for broken DSP path
In-Reply-To: <a1dd5dfd-8678-4dd9-b6af-68a1e078168a@gmail.com>
References: <a1dd5dfd-8678-4dd9-b6af-68a1e078168a@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 833D25F500
Message-ID-Hash: IPCL6ZXT2VFFXUMVPMNGQZW6M3SKGD4F
X-Message-ID-Hash: IPCL6ZXT2VFFXUMVPMNGQZW6M3SKGD4F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IPCL6ZXT2VFFXUMVPMNGQZW6M3SKGD4F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 10 May 2026 11:38:49 +0200,
eziogale@gmail.com wrote:
> 
> Some CA0132 implementations (e.g. Gigabyte GA-Z170X-Gaming G1)
> produce white noise when using the DSP firmware path. Add a
> QUIRK_GENERIC path that uses the standard HDA generic parser
> instead, with custom pin configs that disable the broken auto-mute
> from HP jack detection.
> 
> Also applies VREF_50 on the mic pin and adds an init_hook for
> suspend/resume stability.
> 
> Kernel version: 6.18.24
> The PCI SSID this was tested on: `1458:a046`
> it's been tested with PulseAudio and speaker-test
> That the DSP path (QUIRK_SBZ) remains unchanged for cards that work with it.
> 
> Thanks

The idea sounds reasonable, and most of the changes look OK.
Could you submit a patch in a proper format (with a proper
Signed-off-by tag)?

About the code changes:
> --- /home/ezio/tmp/kernel/linux-6.18.24/sound/hda/codecs/ca0132.c.0	2026-05-02 09:19:21.217137158 +0200
> +++ /home/ezio/tmp/kernel/linux-6.18.24/sound/hda/codecs/ca0132.c	2026-05-10 11:21:41.933355825 +0200

A patch should be applicable with -p1 option.

> @@ -24,6 +24,7 @@
>  #include "hda_local.h"
>  #include "hda_auto_parser.h"
>  #include "hda_jack.h"
> +#include "generic.h"

I guess you need also add the selection of
CONFIG_SND_HDA_CODEC_GENERIC in Kconfig, too.

>  #include "ca0132_regs.h"
>  
> @@ -1060,6 +1061,8 @@
>   */
>  
>  struct ca0132_spec {
> +	struct hda_gen_spec gen;
> +
>  	const struct snd_kcontrol_new *mixers[5];
>  	unsigned int num_mixers;
>  	const struct hda_verb *base_init_verbs;
> @@ -1175,6 +1178,7 @@
>  	QUIRK_AE5,
>  	QUIRK_AE7,
>  	QUIRK_NONE = HDA_FIXUP_ID_NOT_SET,
> +	QUIRK_GENERIC,

Better to put QUIRK_GENERIC before QUIRK_NONE.

>  static void ca0132_codec_remove(struct hda_codec *codec)
>  {
>  	struct ca0132_spec *spec = codec->spec;
>  
> +	if (ca0132_quirk(spec) == QUIRK_GENERIC) {
> +		snd_hda_gen_remove(codec);
> +		return;
> +	}
>  	if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
>  		return dbpro_free(codec);
>  	else

Better to replace with switch().

> +	if (ca0132_quirk(spec) == QUIRK_GENERIC) {
> +		struct auto_pin_cfg *cfg = &spec->gen.autocfg;
> +
> +		snd_hda_gen_spec_init(&spec->gen);
> +
> +		snd_hda_apply_pincfgs(codec,
> +			(const struct hda_pintbl[]) {
> +				{ 0x0b, 0x41014111 },
> +				{ 0x0c, 0x414520f0 }, /* SPDIF out */
> +				{ 0x0d, 0x01014010 }, /* lineout */
> +				{ 0x0e, 0x41c501f0 },
> +				{ 0x0f, 0x411111f0 }, /* disabled */
> +				{ 0x10, 0x411111f0 }, /* disabled */
> +				{ 0x11, 0x41012014 },
> +				{ 0x12, 0x37a790f0 }, /* mic */
> +				{ 0x13, 0x77a701f0 },
> +				{ 0x18, 0x500000f0 },
> +				{}
> +			});
>  
> +		ca0132_init_chip(codec);
> +
> +		err = ca0132_prepare_verbs(codec);
> +		if (err < 0)
> +			goto error;
> +
> +		err = snd_hda_parse_pin_def_config(codec, cfg, NULL);
> +		if (err < 0)
> +			goto error;
> +		err = snd_hda_gen_parse_auto_config(codec, cfg);
> +		if (err < 0)
> +			goto error;
> +
> +		spec->gen.init_hook = ca0132_generic_init_hook;
> +		spec->gen.automute_speaker = 0;
> +		spec->gen.automute_lo = 0;
> +
> +		snd_hda_sequence_write(codec, spec->spec_init_verbs);
> +		return 0;
> +	}

It's a too big block, and better to be factored out as a function.
The verb table should be also defined outside the argument, too;
otherwise it looks too hackish.

> @@ -10014,6 +10077,10 @@
>  {
>  	struct ca0132_spec *spec = codec->spec;
>  
> +	if (ca0132_quirk(spec) == QUIRK_GENERIC) {
> +		return snd_hda_gen_build_controls(codec);
> +	}
> +
>  	if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
>  		return dbpro_build_controls(codec);
>  	else
> @@ -10024,6 +10091,10 @@
>  {
>  	struct ca0132_spec *spec = codec->spec;
>  
> +	if (ca0132_quirk(spec) == QUIRK_GENERIC) {
> +		return snd_hda_gen_build_pcms(codec);
> +	}
> +
>  	if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
>  		return dbpro_build_pcms(codec);
>  	else
> @@ -10034,6 +10105,10 @@
>  {
>  	struct ca0132_spec *spec = codec->spec;
>  
> +	if (ca0132_quirk(spec) == QUIRK_GENERIC) {
> +		return snd_hda_gen_init(codec);
> +	}
> +
>  	if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
>  		return dbpro_init(codec);
>  	else

All those seem better with switch().


thanks,

Takashi
