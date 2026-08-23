Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C12DC5DF8C
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2026 08:58:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3BB160245;
	Sun, 23 Aug 2026 10:58:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3BB160245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787475506;
	bh=3yEF8Awo7U3aEZgkuo7607yUpRLu4p5aPuP8ZN9/fQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=h+YnmipKHNEvFabmhIvLHnVy2JiDTG4GKRCV1dPK9Wbi2nIBYCzmxCIFOuyNKihzS
	 nXPcVjtx+7Pj3PTV2TkKemIACtLY0gaxf/t6oK4IoUZW80gg4oFSGC95KTqeRbhDI0
	 fO0pJAbkWaPnRvDUVrY+uosBJfwHyqNIFKnmhhvQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 238D8F805F8; Sun, 23 Aug 2026 10:57:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A914F805FF;
	Sun, 23 Aug 2026 10:57:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EDE3F8055B; Sun, 23 Aug 2026 10:57:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787475460;
	b=RB7Cn3V779ddGs5GUZvBu/d/3mGCmUPmmHnByxkyQCRg7xtSp2AUZVMxoXUzYIb3qaUg
	 gJy79LJvUDn9CvXIHGmIOvI7pn2RJaSPd0KoEP+8vZ5qTYhuWCTvyBnjnOT3ciiRkuD0K
	 +vGQ7NYSgmtSOWm/GAA5SgdOIIgJwCpq1ZCb2ota+En4uVKEu49PqGRbiGiwIi2laIvwT
	 hnaooFCBTl82bV80C6alVOvIrs71+ck4K6OfifgqQQ5ABbTa+cEUSmEeUbJZ/wnPShvyV
	 ckkpLtWKGsyte7yKZwq/B8Amj1tN/84MR8lp6sIXgUTYgoq36KnI0Z9KqVAJw3m8Tiw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787475460;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=3yEF8Awo7U3aEZgkuo7607yUpRLu4p5aPuP8ZN9/fQg=;
	b=hvftqFSIh1VYLGPCN55aprrrjUnrkLvVOHj9SJhzTUe+F+t9KiFAlMwxzaIW5xs3xY/B
	 Gft6J/v7Tgp10Ck8zD8MwT/WESUzMk9YAkG5bkzT71+WkGoapIYlb8Gw1IrfwKcKvd7uB
	 /7GKEfxgajDhQqmz6nGdfqNsNhe9kQjkqzHrImAnly1E6bxcwgrcMo4hCp7y/N+pGoPY9
	 u4XeaT9P3sEYKVywwUjcaXFniEe7hdJbG+GsQmSJZV4Gm0t8FS4GihIN4GAKXRDXSErjJ
	 ETWDM4iVeG5jB5rbChkeXOqPO2FO3NVTT09g+nst7zHPEFka4PEiBaRVCDY2FS+NqhA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=OR55lZ4s;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HeyaKHiy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=VqRzfylN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="/iJEQZu2";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 06ED6F80075
	for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2026 10:57:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06ED6F80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=OR55lZ4s;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HeyaKHiy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=VqRzfylN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=/iJEQZu2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D3A7861D2;
	Sun, 23 Aug 2026 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787475453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxNW4IRzXyWK0vkj4m74M3luPnlArT9L/wG846cgGro=;
	b=OR55lZ4sqU7slBZvkk2k6q459PczwkY1HFnYJQg2elvmQCrNtyyGYovugBpWDi1+l/c9R3
	F6IqcwRE3nRb02R4igpJFCrYxQEinTz9PXBWPRjWfF1rlWlvAsILgnnlQ6qd6fKmnPuDI9
	1w9BfXVcAARpJ6cidZTRCkddVMmEyDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787475453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxNW4IRzXyWK0vkj4m74M3luPnlArT9L/wG846cgGro=;
	b=HeyaKHiyAtA+oEYvqFW9BjgrQRkU7VF4Tm80mFxsfOZPAni+4l5NJO4kDhv7ZJ0hGXIKju
	qhzVkNhZkuC6gvDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VqRzfylN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/iJEQZu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787475449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxNW4IRzXyWK0vkj4m74M3luPnlArT9L/wG846cgGro=;
	b=VqRzfylNqNTORJGfhNzLnw+9IQN4y/Wta8Un8g8PhW+zfHREBqBEpB3qVZmY0HbB1cIwuZ
	Dou/baw0C5ksouilHBqA2mfHK2Uj8nQXViJ/w6SWEo6aGX+v/AlMgzsDscK6+PHX9LtSNd
	9T9SOyUccuotbXGDnGg88dL1HkKgK6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787475449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxNW4IRzXyWK0vkj4m74M3luPnlArT9L/wG846cgGro=;
	b=/iJEQZu25Mj+WHPPIdwbyFJQqvEBJz0tSvGtoc8Wu1GyYMVWVgOfKT4V/MBV4N2TfkLPp8
	91mfFAcU7Vu5cxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F384213332;
	Sun, 23 Aug 2026 08:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F8kZOfi1imoYBwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 23 Aug 2026 08:57:28 +0000
Date: Sun, 23 Aug 2026 10:57:28 +0200
Message-ID: <87ld9xw6x3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?=22Habil_Eren_T=FCrker=22?= <habilerenturker@gmail.com>
Cc: perex@perex.cz,	tiwai@suse.com,	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,	Habil Eren =?ISO-8859-1?Q?T=FCrker?=
 <habilerenturker@hotmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt
 speaker mute LED
In-Reply-To: <20260821205717.3219-1-habilerenturker@hotmail.com>
References: <20260821205717.3219-1-habilerenturker@hotmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,alsa-project.org,vger.kernel.org,hotmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Queue-Id: 3D3A7861D2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: IJEOYLG5P2F6QL5VF5BM44MFZNWHQSLY
X-Message-ID-Hash: IJEOYLG5P2F6QL5VF5BM44MFZNWHQSLY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IJEOYLG5P2F6QL5VF5BM44MFZNWHQSLY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 21 Aug 2026 22:57:06 +0200,
Habil Eren Türker wrote:
> 
> HP Laptop 15-fd0039nt (SSID 103c:8bb6) has a speaker mute LED that is
> controlled via VREF100 on NID 0x1a. Unlike standard implementations, this
> device requires PIN_VREF100 (0x24) to turn the LED on and PIN_IN (0x20)
> to turn it off, with active-high polarity.
> 
> The existing ALC236_FIXUP_HP_MICMUTE_LED_ONLY quirk only handles the
> microphone mute LED, so this patch adds a new fixup
> ALC236_FIXUP_HP_15_FD0XXX that covers both:
> - Mic mute LED via GPIO0 (active-low)
> - Speaker mute LED via NID 0x1a VREF100
> 
> The patch also adds a custom power_filter to ensure the pin remains
> powered during suspend, and a shutdown hook to restore the pin state.
> 
> Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
> Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>
> ---
>  sound/hda/codecs/realtek/alc269.c | 59 ++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 01b87267f..d19935be3 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -1364,16 +1364,57 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
>  	alc_fixup_hp_gpio_led(codec, action, 0x08, 0x10);
>  }
>  
> -static void alc236_fixup_hp_micmute_led_only(struct hda_codec *codec,
> -				const struct hda_fixup *fix, int action)
> +/* Patch for HP 15-fd0xxx (8BB6) Speaker Mute LED & Mic-Mute LED */
> +
> +static void hp_8bb6_shutup(struct hda_codec *codec)
> +{
> +	snd_hda_shutup_pins(codec);
> +	snd_hda_set_pin_ctl(codec, 0x1a,
> +			   snd_hda_codec_get_pin_target(codec, 0x1a));
> +}
> +
> +static unsigned int hp_8bb6_power_filter(struct hda_codec *codec,
> +					  hda_nid_t nid,
> +					  unsigned int power_state)
> +{
> +	if (nid == 0x1a)
> +		return AC_PWRST_D0;
> +	return snd_hda_gen_path_power_filter(codec, nid, power_state);
> +}
> +
> +static int hp_8bb6_speaker_mute_led_set(struct led_classdev *led_cdev,
> +					 enum led_brightness brightness)
> +{
> +	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
> +	unsigned int val = (brightness == LED_OFF) ? PIN_IN : PIN_VREF100;
> +
> +	snd_hda_set_pin_ctl_cache(codec, 0x1a, val);
> +	return 0;
> +}
> +
> +static void alc236_fixup_hp_15_fd0xxx(struct hda_codec *codec,
> +				      const struct hda_fixup *fix,
> +				      int action)
>  {
>  	struct alc_spec *spec = codec->spec;
>  
> -	if (action == HDA_FIXUP_ACT_PRE_PROBE)
> +	switch (action) {
> +	case HDA_FIXUP_ACT_PRE_PROBE:
>  		spec->micmute_led_polarity = 1;
> -	alc_fixup_hp_gpio_led(codec, action, 0x00, 0x01);
> -}
> +		alc_fixup_hp_gpio_led(codec, action, 0x00, 0x01);
> +		spec->mute_led_polarity = 0;
> +		snd_hda_gen_add_mute_led_cdev(codec, hp_8bb6_speaker_mute_led_set);
> +		codec->power_filter = hp_8bb6_power_filter;
> +		codec->power_save_node = 0;
> +		spec->shutup = hp_8bb6_shutup;
> +		break;
>  
> +	case HDA_FIXUP_ACT_INIT:
> +		if (spec->gen.vmaster_mute.hook)
> +			snd_hda_sync_vmaster_hook(&spec->gen.vmaster_mute);
> +		break;
> +	}
> +}

Hmm, the whole workarounds look too much.
For example, power_save_node is already turned off as default in
alc269_probe().

And, if the pin-shutup causes a problem, you can simply set
spec->no_shutup_pins flag.

And, this is an enhancement of the existing quirk entry, you can
mention the relevant commit, too.


thanks,

Takashi
