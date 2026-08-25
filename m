Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F2BC5DF94
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:59:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09C6A602A8;
	Tue, 25 Aug 2026 09:59:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09C6A602A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787644791;
	bh=xWtaWC64IcHuC0Wkm7oh+alVlvSwds1BSDMSukgILW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UIqoC9EmHFpwdxpkOHKn77K36fLsNGXEVTqGJ8X//NkCy3L1ghdYXTKvURiB04r3X
	 QFeoULRgTgTKxIEseIKg06kSCO3ACoMHi1c9zfnBkY7Zbv1HXZczkhsH9W9VXdzYq1
	 bzlAqgwJuinCWukthAHRtEkC4cNLK5xhB0+FZtfs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 432C6F805FF; Tue, 25 Aug 2026 09:59:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 735C9F805F6;
	Tue, 25 Aug 2026 09:59:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3BA45F8027B; Tue, 25 Aug 2026 09:59:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787644742;
	b=AeImMGwwZpe8niqeWgt2XCFR7HsmrzSCo+Neg+BqK5l/hGFrSv2/2dAPR01beUS6IiOr
	 CPch4DQMUi27dH/HciH2laUfXDhLyoJo+dAeU0/z68JWcWAETRoNsfDzwBoo48oAH5mJr
	 LgId1s0O5iMKRaveO3cNZK/0PfsRRMHzI5AZZiy7kBJZHa1P06tuTD18JUVrmeHGDGIUU
	 TCTAfPHR4i190UKQQdiFtye19F7WPzpi27u8rCh2gO8u9Am0vMtShrqao/RGmc+u+ZWwL
	 mg64J6tT2NZRGpczdBXh43sldUndRJbJoocZkeQELK4ei5UlRtVraKidXFmRwgFQglw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787644742;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=xWtaWC64IcHuC0Wkm7oh+alVlvSwds1BSDMSukgILW4=;
	b=Xdckr5HDlqnqSsIxaluG5u1AvVd8J8H0wbePse6gdNZLqrZKR81P1dOnkyb/ZS3If2uw
	 4EOe79noG4/QmOiRNPNRVm1+0jGE3aKCx5gfLjayiz8VvccdSW2uyy3W6kX6UChz96p8R
	 JySH3U1NLwPFF1oibPZON03sUFAt5LqTkf2k8quN+AZmYAIfCZ201DiiVTZDUnYDCtjPO
	 44E1X1MIzPvSU8RbBEolRYiFJErE+IhG4PIterQO1fgLvTeC5Y6IcTMVDiP9da7Y/tfCt
	 9nqyv11jryIFt0epfr7hB7S64Mxe6WWcKYhirrpsLGbpnQGpUo2dz4EndBoZlaoFcGA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=dzlCQ3Gz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="/epkEQOs";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Vsteqs7j;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=QtJxQguN;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F19AAF800B6
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2026 09:58:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F19AAF800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=dzlCQ3Gz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=/epkEQOs;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Vsteqs7j;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=QtJxQguN
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 348CC1F78B;
	Tue, 25 Aug 2026 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787644735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09YSDPPs+gAAsXa+RQimZvLD5+OxnKfd8Qhwhzr3pPc=;
	b=dzlCQ3GzVZwBWe4ZGNG9b3CrUQwVP9VhbkalRaZFI61ilfUYW0FZwjxaWf3VUtxvLHVryO
	Ts3XB9aQXI9PG7TQRXRl5sC9KCj4UxbFh/y8qI0F6oLyqb2aCb3l7BghCxk/OCTminT80U
	5QS5VXMmcAu6hEdI2l3E8YpQb5lGr8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787644735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09YSDPPs+gAAsXa+RQimZvLD5+OxnKfd8Qhwhzr3pPc=;
	b=/epkEQOsWONv69lzDOwTRCo4ntvi2SeAUtjnw9Wlt8m1eczFU47o7b99AU83vKNhdWxEZc
	N0HLBWJ3rMlFO5DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787644731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09YSDPPs+gAAsXa+RQimZvLD5+OxnKfd8Qhwhzr3pPc=;
	b=Vsteqs7jhGnRZHnlMYf0ggDvkYL6cEeldJUdqd0lU4VeKMvYRwdaZrINkCsZJsrizyLwPT
	W3W4D+rVbH4KXOgQj87WV2QjIJ1t5cbVOe29zfSH5+VZ33Z5xNbwRt5ix1f4/DDfkOalHo
	wQh9yH73hRHdk07OzzZaNrqicZWbY5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787644731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09YSDPPs+gAAsXa+RQimZvLD5+OxnKfd8Qhwhzr3pPc=;
	b=QtJxQguN/BpzfkrR4eTZ1w4wiC4SeeQB1ZUKinJvv7canoToLGt9VPF3r+XAUfF7HJuKY3
	czv/9FhTx9/n+gDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EABF913332;
	Tue, 25 Aug 2026 07:58:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNjpNjpLjWrHbwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Aug 2026 07:58:50 +0000
Date: Tue, 25 Aug 2026 09:58:50 +0200
Message-ID: <87jypetyv9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?=22Habil_Eren_T=FCrker=22?= <habilerenturker@gmail.com>
Cc: perex@perex.cz,	tiwai@suse.com,	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,	Habil Eren =?ISO-8859-1?Q?T=FCrker?=
 <habilerenturker@hotmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Fix speaker mute LED for HP Laptop
 15-fd0039nt
In-Reply-To: <20260824094256.3758-1-habilerenturker@hotmail.com>
References: <20260824094256.3758-1-habilerenturker@hotmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,alsa-project.org,vger.kernel.org,hotmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: C2NTH6FPPQDWN3UT274WYLGABFBXT75Y
X-Message-ID-Hash: C2NTH6FPPQDWN3UT274WYLGABFBXT75Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C2NTH6FPPQDWN3UT274WYLGABFBXT75Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 24 Aug 2026 11:42:28 +0200,
Habil Eren Türker wrote:
> 
> HP Laptop 15-fd0039nt (SSID 103c:8bb6) needs a quirk to control the
> speaker mute LED via VREF100 on NID 0x1a (active-high).
> 
> This patch replaces the previous ALC236_FIXUP_HP_MICMUTE_LED_ONLY
> with ALC236_FIXUP_HP_15_FD0XXX, which covers both mic mute (GPIO0)
> and speaker mute (NID 0x1a) LEDs.
> 
> Use spec->no_shutup_pins instead of a custom shutup hook, as suggested
> by Takashi Iwai.
> 
> Fixes: e711ebfadc9a ("ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt")
> Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
> Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>
> ---
>  sound/hda/codecs/realtek/alc269.c | 51 ++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 01b87267f..a2a3341c3 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -1364,14 +1364,49 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
>  	alc_fixup_hp_gpio_led(codec, action, 0x08, 0x10);
>  }
>  
> -static void alc236_fixup_hp_micmute_led_only(struct hda_codec *codec,
> -				const struct hda_fixup *fix, int action)
> +/* Patch for HP 15-fd0xxx (8BB6) Speaker Mute LED & Mic-Mute LED */
> +
> +static unsigned int hp_8bb6_power_filter(struct hda_codec *codec,
> +					  hda_nid_t nid,
> +					  unsigned int power_state)
> +{
> +	if (nid == 0x1a)
> +		return AC_PWRST_D0;
> +	return snd_hda_gen_path_power_filter(codec, nid, power_state);
> +}

Better to give a bit more comment about this power filter, as it's not
clear why keeping the power of NID 0x1a.

Also, the patch contained trailing whitespaces.
Please run scripts/checkpatch.pl before resubmission.


thanks,

Takashi
