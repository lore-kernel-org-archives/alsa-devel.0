Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F755CD4F3C
	for <alsa-devel@archiver.kernel.org>; Sun, 17 May 2026 19:54:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1F47601FA;
	Sun, 17 May 2026 21:54:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1F47601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779047677;
	bh=/wV4XxQdP0PjgkDwJcvXfBPOEu8LeW1/6h+4y5Xv5M8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=okFHnrmm/OJT/FhsOWz843JA4uMVGl6saG9wr4VoSrWImYhHt70Vc/wv8vtMaPCV1
	 OvmeAkflK/bVrVSKgqM6g5v0LA6c/3zb9/MsiBO5QlkFaX8axyDJZJqD+X58bLGR+h
	 AxMUd+tF83plbMqgj+8Is7gRDOSRTy0SQBPlLqss=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 001D1F805EE; Sun, 17 May 2026 21:54:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A59FF805EE;
	Sun, 17 May 2026 21:54:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32233F804FF; Sun, 17 May 2026 21:53:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EE989F8003C
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2026 21:53:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE989F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=hgjAUqqJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ei2fWyZd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=hgjAUqqJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ei2fWyZd
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E15E678F2;
	Sun, 17 May 2026 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779047629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACf2On0j3K3QsgbS8ta8A1Ncw5ni8kZf+ubvlJWbUb8=;
	b=hgjAUqqJc1McFSViX3SSgckAhhDpdmlxNANm5WgF9qPTjvgZF0uO8/bCMEi7eK16XgTbqh
	xpXbBz21ju5jP+lE5qG1dJHwJDcWnkfU6dadhiyh+0ZNgmm2Pb9+UC77sC5AGiqzu4M0uG
	kPAAVonwEG2SAbyuyaqOa/xXcMQCS30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779047629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACf2On0j3K3QsgbS8ta8A1Ncw5ni8kZf+ubvlJWbUb8=;
	b=ei2fWyZdRE6EVrKUIKfwPjWPz/pQz3oZRAKk8OlAUTvdTICy8/F6cVuAxIHQu395NFL2Za
	O/c9IS3EZ0sTL2Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779047629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACf2On0j3K3QsgbS8ta8A1Ncw5ni8kZf+ubvlJWbUb8=;
	b=hgjAUqqJc1McFSViX3SSgckAhhDpdmlxNANm5WgF9qPTjvgZF0uO8/bCMEi7eK16XgTbqh
	xpXbBz21ju5jP+lE5qG1dJHwJDcWnkfU6dadhiyh+0ZNgmm2Pb9+UC77sC5AGiqzu4M0uG
	kPAAVonwEG2SAbyuyaqOa/xXcMQCS30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779047629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACf2On0j3K3QsgbS8ta8A1Ncw5ni8kZf+ubvlJWbUb8=;
	b=ei2fWyZdRE6EVrKUIKfwPjWPz/pQz3oZRAKk8OlAUTvdTICy8/F6cVuAxIHQu395NFL2Za
	O/c9IS3EZ0sTL2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04C3C593A8;
	Sun, 17 May 2026 19:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wHUWO8wcCmq6ZQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 17 May 2026 19:53:48 +0000
Date: Sun, 17 May 2026 21:53:44 +0200
Message-ID: <87h5o5ersn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "eziogale@gmail.com" <eziogale@gmail.com>
Cc: Jaroslav Kysela ` <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/ca0132: add QUIRK_GENERIC path for Gigabyte,
 GA-Z170X-Gaming G1
In-Reply-To: <2f45fd6e-0a5b-4f47-9f2b-75d8b323ced8@gmail.com>
References: <a1dd5dfd-8678-4dd9-b6af-68a1e078168a@gmail.com>
	<87tss7xyj5.wl-tiwai@suse.de>
	<2f45fd6e-0a5b-4f47-9f2b-75d8b323ced8@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: YW2YQLC76UTCJPQYWZVGHFHWWUAQXS45
X-Message-ID-Hash: YW2YQLC76UTCJPQYWZVGHFHWWUAQXS45
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YW2YQLC76UTCJPQYWZVGHFHWWUAQXS45/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 17 May 2026 18:29:51 +0200,
eziogale@gmail.com wrote:
> 
> Some CA0132 implementations (e.g. Gigabyte GA-Z170X-Gaming G1) produce
> white noise when using the DSP firmware path.
> 
> Add a QUIRK_GENERIC path that uses the standard HDA generic parser
> instead, with custom pin configs.
> 
> This patch applies against v6.18.24.

You seem to have put your Signed-off-by tag at a wrong place.
It must be put here instead.

The code change itself looks OK, but the indentation tabs and spaces
seem incorrect.  If it's not in your original code, it must be due to
your mailer.  Try to fix your mailer setup and resubmit.


thanks,

Takashi

> ---
>  sound/hda/codecs/Kconfig  |   1 +
>  sound/hda/codecs/ca0132.c | 111 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 99 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/hda/codecs/Kconfig b/sound/hda/codecs/Kconfig
> index addbc94..dcf340e 100644
> --- a/sound/hda/codecs/Kconfig
> +++ b/sound/hda/codecs/Kconfig
> @@ -69,6 +69,7 @@ comment "Set to Y if you want auto-loading the codec
> driver"
> 
>  config SND_HDA_CODEC_CA0132
>      tristate "Build Creative CA0132 codec support"
> +    select SND_HDA_GENERIC
>      help
>        Say Y or M here to include Creative CA0132 codec support in
>        snd-hda-intel driver.
> diff --git a/sound/hda/codecs/ca0132.c b/sound/hda/codecs/ca0132.c
> index dd054ae..92fc93f 100644
> --- a/sound/hda/codecs/ca0132.c
> +++ b/sound/hda/codecs/ca0132.c
> @@ -24,6 +24,7 @@
>  #include "hda_local.h"
>  #include "hda_auto_parser.h"
>  #include "hda_jack.h"
> +#include "generic.h"
> 
>  #include "ca0132_regs.h"
> 
> @@ -1060,6 +1061,8 @@ enum dsp_download_state {
>   */
> 
>  struct ca0132_spec {
> +    struct hda_gen_spec gen;
> +
>      const struct snd_kcontrol_new *mixers[5];
>      unsigned int num_mixers;
>      const struct hda_verb *base_init_verbs;
> @@ -1174,6 +1177,7 @@ enum {
>      QUIRK_R3D,
>      QUIRK_AE5,
>      QUIRK_AE7,
> +    QUIRK_GENERIC,
>      QUIRK_NONE = HDA_FIXUP_ID_NOT_SET,
>  };
> 
> @@ -1292,6 +1296,20 @@ static const struct hda_pintbl ae7_pincfgs[] = {
>      {}
>  };
> 
> +static const struct hda_pintbl ca0132_generic_pincfgs[] = {
> +    { 0x0b, 0x41014111 },
> +    { 0x0c, 0x414520f0 }, /* SPDIF out */
> +    { 0x0d, 0x01014010 }, /* lineout */
> +    { 0x0e, 0x41c501f0 },
> +    { 0x0f, 0x411111f0 }, /* disabled */
> +    { 0x10, 0x411111f0 }, /* disabled */
> +    { 0x11, 0x41012014 },
> +    { 0x12, 0x37a790f0 }, /* mic */
> +    { 0x13, 0x77a701f0 },
> +    { 0x18, 0x500000f0 },
> +    {}
> +};
> +
>  static const struct hda_quirk ca0132_quirks[] = {
>      SND_PCI_QUIRK(0x1028, 0x057b, "Alienware M17x R4",
> QUIRK_ALIENWARE_M17XR4),
>      SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
> @@ -1304,6 +1322,7 @@ static const struct hda_quirk ca0132_quirks[] = {
>      SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
>      SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
>      SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7",
> QUIRK_R3DI),
> +    SND_PCI_QUIRK(0x1458, 0xA046, "Gigabyte GA-Z170X-Gaming G1",
> QUIRK_GENERIC),
>      SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
>      SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI),
>      SND_PCI_QUIRK(0x3842, 0x1055, "EVGA Z390 DARK", QUIRK_R3DI),
> @@ -1325,6 +1344,7 @@ static const struct hda_model_fixup
> ca0132_quirk_models[] = {
>      { .id = QUIRK_R3D, .name = "r3d" },
>      { .id = QUIRK_AE5, .name = "ae5" },
>      { .id = QUIRK_AE7, .name = "ae7" },
> +    { .id = QUIRK_GENERIC, .name = "generic" },
>      {}
>  };
> 
> @@ -9882,14 +9902,57 @@ static void sbz_detect_quirk(struct hda_codec
> *codec)
>      }
>  }
> 
> +static void ca0132_generic_init_hook(struct hda_codec *codec)
> +{
> +    struct ca0132_spec *spec = codec->spec;
> +
> +    snd_hda_sequence_write(codec, spec->spec_init_verbs);
> +}
> +
> +static int ca0132_generic_probe(struct hda_codec *codec)
> +{
> +    struct ca0132_spec *spec = codec->spec;
> +    struct auto_pin_cfg *cfg = &spec->gen.autocfg;
> +    int err;
> +
> +    snd_hda_gen_spec_init(&spec->gen);
> +
> +    snd_hda_apply_pincfgs(codec, ca0132_generic_pincfgs);
> +
> +    ca0132_init_chip(codec);
> +
> +    err = ca0132_prepare_verbs(codec);
> +    if (err < 0)
> +        return err;
> +
> +    err = snd_hda_parse_pin_def_config(codec, cfg, NULL);
> +    if (err < 0)
> +        return err;
> +    err = snd_hda_gen_parse_auto_config(codec, cfg);
> +    if (err < 0)
> +        return err;
> +
> +    spec->gen.init_hook = ca0132_generic_init_hook;
> +    spec->gen.automute_speaker = 0;
> +    spec->gen.automute_lo = 0;
> +
> +    snd_hda_sequence_write(codec, spec->spec_init_verbs);
> +    return 0;
> +}
> +
>  static void ca0132_codec_remove(struct hda_codec *codec)
>  {
>      struct ca0132_spec *spec = codec->spec;
> 
> -    if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
> +    switch (ca0132_quirk(spec)) {
> +    case QUIRK_GENERIC:
> +        snd_hda_gen_remove(codec);
> +        return;
> +    case QUIRK_ZXR_DBPRO:
>          return dbpro_free(codec);
> -    else
> +    default:
>          return ca0132_free(codec);
> +    }
>  }
> 
>  static int ca0132_codec_probe(struct hda_codec *codec,
> @@ -9906,14 +9969,21 @@ static int ca0132_codec_probe(struct hda_codec
> *codec,
>      codec->spec = spec;
>      spec->codec = codec;
> 
> -    /* Detect codec quirk */
> -    snd_hda_pick_fixup(codec, ca0132_quirk_models, ca0132_quirks, NULL);
> -    if (ca0132_quirk(spec) == QUIRK_SBZ)
> -        sbz_detect_quirk(codec);
> -
> +    /* These must be set before any path is taken */
>      codec->pcm_format_first = 1;
>      codec->no_sticky_stream = 1;
> 
> +    /* Detect codec quirk */
> +    snd_hda_pick_fixup(codec, ca0132_quirk_models, ca0132_quirks, NULL);
> +    switch (ca0132_quirk(spec)) {
> +    case QUIRK_SBZ:
> +        sbz_detect_quirk(codec);
> +        break;
> +    case QUIRK_GENERIC:
> +        return ca0132_generic_probe(codec);
> +    default:
> +        break;
> +    }
> 
>      spec->dsp_state = DSP_DOWNLOAD_INIT;
>      spec->num_mixers = 1;
> @@ -10014,36 +10084,51 @@ static int
> ca0132_codec_build_controls(struct hda_codec *codec)
>  {
>      struct ca0132_spec *spec = codec->spec;
> 
> -    if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
> +    switch (ca0132_quirk(spec)) {
> +    case QUIRK_GENERIC:
> +        return snd_hda_gen_build_controls(codec);
> +    case QUIRK_ZXR_DBPRO:
>          return dbpro_build_controls(codec);
> -    else
> +    default:
>          return ca0132_build_controls(codec);
> +    }
>  }
> 
>  static int ca0132_codec_build_pcms(struct hda_codec *codec)
>  {
>      struct ca0132_spec *spec = codec->spec;
> 
> -    if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
> +    switch (ca0132_quirk(spec)) {
> +    case QUIRK_GENERIC:
> +        return snd_hda_gen_build_pcms(codec);
> +    case QUIRK_ZXR_DBPRO:
>          return dbpro_build_pcms(codec);
> -    else
> +    default:
>          return ca0132_build_pcms(codec);
> +    }
>  }
> 
>  static int ca0132_codec_init(struct hda_codec *codec)
>  {
>      struct ca0132_spec *spec = codec->spec;
> 
> -    if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
> +    switch (ca0132_quirk(spec)) {
> +    case QUIRK_GENERIC:
> +        return snd_hda_gen_init(codec);
> +    case QUIRK_ZXR_DBPRO:
>          return dbpro_init(codec);
> -    else
> +    default:
>          return ca0132_init(codec);
> +    }
>  }
> 
>  static int ca0132_codec_suspend(struct hda_codec *codec)
>  {
>      struct ca0132_spec *spec = codec->spec;
> 
> +    if (ca0132_quirk(spec) == QUIRK_GENERIC)
> +        return 0;
> +
>      cancel_delayed_work_sync(&spec->unsol_hp_work);
>      return 0;
>  }
> -- 
> 2.54.0
> 
> Signed-off-by: Ezio Galeazzi <eziogale@gmail.com>
> 
> 
