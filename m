Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF38E104950D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:10:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 846C7601E8;
	Wed, 11 Mar 2026 10:10:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 846C7601E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773220229;
	bh=LbTDSICWPX1EgjInlR71HslV68EN/XMbgr3M/cJo5hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SuK9naSgqnteG6sV6+YGiKQxToq7UfijogO8qI/pqoMYXkQzABkcQX/sEl9noms1J
	 GyFGneVm1QKwgqaQjdXvSf5GMAVz0T9U9tfsQeduyPIN1g5ZUrUvj8JeF+NfN2cezR
	 Iq5HIibZSnzp3u8WxnkCEi8ojtS2ZzKpUTkRZJ6k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F219F80588; Wed, 11 Mar 2026 10:09:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CF27F805F4;
	Wed, 11 Mar 2026 10:09:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6283F80552; Wed, 11 Mar 2026 10:09:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3C0DCF80171
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2026 10:09:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C0DCF80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=rzpka58l;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=d1HIxUZF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=rzpka58l;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=d1HIxUZF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0578B4D237;
	Wed, 11 Mar 2026 09:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1773220179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdFE0ZLCKh3iiTmfvlFo+vtjAzWhW3QI6pSFFVTQj2g=;
	b=rzpka58lTa+iLfK7QsNu/FCRVCRDQf2zWmimotHjg967Tj0Ui5MwgLJJzEphyW+TrN7uwz
	E9IRD6pPpB6EaqUProzhCLCF8qiobawUgVcGOlf4SGhwv7SoDwMcygwAzPN6MZNmXJXRwn
	EdZUI3sUT4So/wW95bUrOBK+nw2anF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773220179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdFE0ZLCKh3iiTmfvlFo+vtjAzWhW3QI6pSFFVTQj2g=;
	b=d1HIxUZF4Nl9qSgNd+zt+EQfpH4rZEAIVzPT1v1243W4eU6il/frzVMNYqU63HGUjH1a6/
	ctzzKrHvYf4QkFBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1773220179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdFE0ZLCKh3iiTmfvlFo+vtjAzWhW3QI6pSFFVTQj2g=;
	b=rzpka58lTa+iLfK7QsNu/FCRVCRDQf2zWmimotHjg967Tj0Ui5MwgLJJzEphyW+TrN7uwz
	E9IRD6pPpB6EaqUProzhCLCF8qiobawUgVcGOlf4SGhwv7SoDwMcygwAzPN6MZNmXJXRwn
	EdZUI3sUT4So/wW95bUrOBK+nw2anF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773220179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdFE0ZLCKh3iiTmfvlFo+vtjAzWhW3QI6pSFFVTQj2g=;
	b=d1HIxUZF4Nl9qSgNd+zt+EQfpH4rZEAIVzPT1v1243W4eU6il/frzVMNYqU63HGUjH1a6/
	ctzzKrHvYf4QkFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D43313F934;
	Wed, 11 Mar 2026 09:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YjtmMlIxsWlUQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 11 Mar 2026 09:09:38 +0000
Date: Wed, 11 Mar 2026 10:09:38 +0100
Message-ID: <87eclq4trh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Zack Fitch" <zack@internetuniverse.org>
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: enable dual-DAC on Gigabyte
 X570S/X870E ALC1220
In-Reply-To: <98643a1eb0aba1a7dbc0742fc831317e35581c5c@internetuniverse.org>
References: <98643a1eb0aba1a7dbc0742fc831317e35581c5c@internetuniverse.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: 6UHNQSHASSERGAF7IERLHYDR3EXZGU3T
X-Message-ID-Hash: 6UHNQSHASSERGAF7IERLHYDR3EXZGU3T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6UHNQSHASSERGAF7IERLHYDR3EXZGU3T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 11 Mar 2026 09:24:47 +0100,
Zack Fitch wrote:
> 
> Hi,
> 
>   Please consider the attached patch for the Gigabyte X570S/X870E Aorus
>   ALC1220 audio codec.
> 
>   Thanks,
>   Zack
> From 06deee185e29ee352ede90ea63fdb0448da242ac Mon Sep 17 00:00:00 2001
> From: Zack Fitch <zack@internetuniverse.org>
> Date: Wed, 11 Mar 2026 01:22:39 -0700
> Subject: [PATCH] ALSA: hda/realtek: enable dual-DAC on Gigabyte X570S/X870E
>  ALC1220
> 
> The ALC1220 codec on Gigabyte X570S Aorus Master and X870E AORUS
> XTREME AI TOP boards (subsystem 0x1458:0xa0d5) has two usable output
> paths:
> 
>   - Pin 0x14 (front HP): hardwired to mixer 0x0c -> DAC 0x02
>   - Pin 0x1b (rear line-out): 5 connections (0x0c 0x0d 0x0e 0x0f 0x26)
> 
> The existing ALC1220_FIXUP_GB_X570 quirk overrides 0x1b's connection
> list to {0x0c} only, forcing both outputs onto DAC 0x02. It also does
> not suppress auto-mute, so inserting headphones silences the rear
> line-out.
> 
> Desktop users need both outputs active simultaneously with independent
> DAC routing for per-application audio (e.g., Discord to headphones,
> music to speakers).
> 
> Add ALC1220_FIXUP_GB_AORUS_NO_AUTOMUTE which:
>   - Does NOT restrict 0x1b's connection list, allowing the generic HDA
>     parser to assign DAC 0x03 (via mixer 0x0d) as an independent output
>   - Sets suppress_auto_mute so front HP insertion does not mute rear
> 
> The coefficient writes from gb_x570 are not required for audio output
> on these boards, as confirmed by testing with model=generic and by
> reverse-engineering the Windows Realtek driver which applies no
> board-specific handling for this subsystem ID.
> 
> Tested on: Gigabyte X870E AORUS XTREME AI TOP
>   ALC1220 codec, subsystem 0x1458:0xa0d5
>   AMD Ryzen HD Audio Controller [1022:15e3]
>   Kernel 6.18.13-arch1-1
> 
> Signed-off-by: Zack Fitch <zack@internetuniverse.org>

So this model doesn't need any former x570-specific COEFs after all?

Also, what's the reason to suppress the auto-mute inevitably?  By
plugging the headphone, all speaker outputs should be suppressed --
that's the default designed behavior.  If user wants to use the
speaker outputs, they can simply turn the mixer swith "Auto-Mute Mode"
to "disabled" on the fly.

Last but not least, you don't need to add extra model string just for
a single use case.  If user wants to apply the same for another model,
they can pick it up by passing the SSID alias.


thanks,

Takashi

> ---
>  sound/hda/codecs/realtek/alc882.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/codecs/realtek/alc882.c b/sound/hda/codecs/realtek/alc882.c
> index 529fecd5ba..6b61719b96 100644
> --- a/sound/hda/codecs/realtek/alc882.c
> +++ b/sound/hda/codecs/realtek/alc882.c
> @@ -54,6 +54,7 @@ enum {
>  	ALC887_FIXUP_BASS_CHMAP,
>  	ALC1220_FIXUP_GB_DUAL_CODECS,
>  	ALC1220_FIXUP_GB_X570,
> +	ALC1220_FIXUP_GB_AORUS_NO_AUTOMUTE,
>  	ALC1220_FIXUP_CLEVO_P950,
>  	ALC1220_FIXUP_CLEVO_PB51ED,
>  	ALC1220_FIXUP_CLEVO_PB51ED_PINS,
> @@ -211,6 +212,20 @@ static void alc1220_fixup_gb_x570(struct hda_codec *codec,
>  	}
>  }
>  
> +/* Gigabyte X570S/X870E Aorus boards: enable independent DAC routing
> + * by not restricting pin 0x1b's connection list, and suppress auto-mute
> + * so front headphone insertion does not silence rear line-out.
> + */
> +static void alc1220_fixup_gb_aorus_no_automute(struct hda_codec *codec,
> +					       const struct hda_fixup *fix,
> +					       int action)
> +{
> +	struct alc_spec *spec = codec->spec;
> +
> +	if (action == HDA_FIXUP_ACT_PRE_PROBE)
> +		spec->gen.suppress_auto_mute = 1;
> +}
> +
>  static void alc1220_fixup_clevo_p950(struct hda_codec *codec,
>  				     const struct hda_fixup *fix,
>  				     int action)
> @@ -514,6 +529,10 @@ static const struct hda_fixup alc882_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc1220_fixup_gb_x570,
>  	},
> +	[ALC1220_FIXUP_GB_AORUS_NO_AUTOMUTE] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc1220_fixup_gb_aorus_no_automute,
> +	},
>  	[ALC1220_FIXUP_CLEVO_P950] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc1220_fixup_clevo_p950,
> @@ -635,7 +654,7 @@ static const struct hda_quirk alc882_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
>  	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_GB_X570),
>  	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_GB_X570),
> -	SND_PCI_QUIRK(0x1458, 0xa0d5, "Gigabyte X570S Aorus Master", ALC1220_FIXUP_GB_X570),
> +	SND_PCI_QUIRK(0x1458, 0xa0d5, "Gigabyte X570S/X870E Aorus", ALC1220_FIXUP_GB_AORUS_NO_AUTOMUTE),
>  	SND_PCI_QUIRK(0x1462, 0x11f7, "MSI-GE63", ALC1220_FIXUP_CLEVO_P950),
>  	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
>  	SND_PCI_QUIRK(0x1462, 0x1229, "MSI-GP73", ALC1220_FIXUP_CLEVO_P950),
> @@ -718,6 +737,7 @@ static const struct hda_model_fixup alc882_fixup_models[] = {
>  	{.id = ALC887_FIXUP_ASUS_BASS, .name = "asus-bass"},
>  	{.id = ALC1220_FIXUP_GB_DUAL_CODECS, .name = "dual-codecs"},
>  	{.id = ALC1220_FIXUP_GB_X570, .name = "gb-x570"},
> +	{.id = ALC1220_FIXUP_GB_AORUS_NO_AUTOMUTE, .name = "gb-aorus-no-automute"},
>  	{.id = ALC1220_FIXUP_CLEVO_P950, .name = "clevo-p950"},
>  	{}
>  };
> 
> base-commit: fd7df93013c5118812e63a52635dc6c3a805a1de
> -- 
> 2.53.0
> 
