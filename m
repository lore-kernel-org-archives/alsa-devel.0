Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78744C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:38:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDE316022C;
	Wed,  1 Jul 2026 09:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDE316022C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782891488;
	bh=qwRMZybapf+FQa4g4Z+m5PwmNLdcPwxxBxAVLMjsZCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=R9eOSfUSIPXHr12J0dp+EJR5p8P9x9yelQWQDlC9JFvC6PNPV8F1T3MMo6cr566cN
	 wtuFnLhNgOVvEyifSrrQy+xVrt/EpLySqjO34D7RjGJwgxZ9T/PImyxZxpZ6ADDQHV
	 8Jdf0aKAkvORQua/bMKXVi7SvV05Ytwpp1Vx2bsM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A20D4F805F8; Wed,  1 Jul 2026 09:37:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CB45AF805F9;
	Wed,  1 Jul 2026 09:37:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC8D6F8051F; Wed,  1 Jul 2026 09:37:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782891445;
	b=ARcTz7bSCtwqqX3J43ugJYl75PODUD0TuaPZvo0NzUwd6DDjQkE4tsNwuyWe8UeEwO/K
	 PH0RuDvHubHdxctwMWSKzy7+xxIBZmUoSvIDlfxBGFCppom0XnP9Ty8GVPLLWjKAQkzlK
	 WN6DRqArNSXM4UhqT8t3Y4q63tLqv+BdQ872JM4UwCZfxrxaFeLMV1WyPb0PkuR98SV+Y
	 w1TAL3kn+aK89bM4gMW0LI+h28CQildZhIhcON8CFkKQYsDcuHTvGRoeCgFdVE9izA41R
	 wxNVBKuyavp0VdL22GZNM+vXEmDA2mcJlWQAIizRBI8LWc6W0kS1/9Brfgbg0d6WiUA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782891445;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=qwRMZybapf+FQa4g4Z+m5PwmNLdcPwxxBxAVLMjsZCA=;
	b=LIvxMC2w3zMVYIt+Z6XjJpdP9AF4kU+qoCL9yZk9k4dkQY1JUwZX9DnF3/w7zu20ddQH
	 cq/ovWf2jUXrYers/hoRPVlg9aAfopgdUnhY6nJBTOPfDfcR7NP+YoyINL0KpgQ6q3MFJ
	 BO3E56iJkyiZsKIr73IVeNdqQEfKujc41TYtwj0dxHPv/tCjEOHMvlynE9M/pJ2oOI+TT
	 KtXR7iIAozcIG4lMwWNNQMw9mpA/9HuYPpmPPzjA+CuVbXmOtzONhornIjIKpHbR0/Q0+
	 uC8cfrOGJnp0NmNwaGKrb8iLRfmxLMqWTyn2p8C07mo0SdJ3x/Z1aN3OxyvWCv343+w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CocPU2nP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=mR2cN+Iq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CocPU2nP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=mR2cN+Iq;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE446F8027B
	for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2026 09:37:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE446F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CocPU2nP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=mR2cN+Iq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=CocPU2nP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=mR2cN+Iq
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 336B7759BC;
	Wed,  1 Jul 2026 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1782891443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs27xci25YTZZGqVi8bFQafrNLGwr7UR7sFsUi1gdtg=;
	b=CocPU2nPGP4TQrja1Nvfxgn53L+H2o6svahgn9E8VzYvkNFV2g/pyZndMJVghpmNLc/kti
	huExw8LqAWcrDWlkjjSwI9utcIHK7I20oD91f23s/XGBmGJOSc+S09Lte0BrMMPfvTVywF
	9iJb4L0cDvEd/hSwB0XX7+eT5rnWabI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782891443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs27xci25YTZZGqVi8bFQafrNLGwr7UR7sFsUi1gdtg=;
	b=mR2cN+IqqhxUdelC4O1XUi/51CYUchHhCfaK90OeaHb7YQ7pffmm2nIL8gp8smGcbuPE2Y
	L0dNVh8igBcft8BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1782891443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs27xci25YTZZGqVi8bFQafrNLGwr7UR7sFsUi1gdtg=;
	b=CocPU2nPGP4TQrja1Nvfxgn53L+H2o6svahgn9E8VzYvkNFV2g/pyZndMJVghpmNLc/kti
	huExw8LqAWcrDWlkjjSwI9utcIHK7I20oD91f23s/XGBmGJOSc+S09Lte0BrMMPfvTVywF
	9iJb4L0cDvEd/hSwB0XX7+eT5rnWabI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782891443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs27xci25YTZZGqVi8bFQafrNLGwr7UR7sFsUi1gdtg=;
	b=mR2cN+IqqhxUdelC4O1XUi/51CYUchHhCfaK90OeaHb7YQ7pffmm2nIL8gp8smGcbuPE2Y
	L0dNVh8igBcft8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3F27779AA;
	Wed,  1 Jul 2026 07:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id llwWOrLDRGrCHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 01 Jul 2026 07:37:22 +0000
Date: Wed, 01 Jul 2026 09:37:22 +0200
Message-ID: <87se63upn1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: dengxiang <os_dengxiang82@126.com>
Cc: tiwai@suse.com,
	bo.liu@senarytech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/conexant: Fix microphone mute after power-on
 reboot
In-Reply-To: <20260701065533.72517-1-os_dengxiang82@126.com>
References: <20260701065533.72517-1-os_dengxiang82@126.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: PPNNGPHVQHAZCGSTXMTYMOD7CXQYFVD5
X-Message-ID-Hash: PPNNGPHVQHAZCGSTXMTYMOD7CXQYFVD5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PPNNGPHVQHAZCGSTXMTYMOD7CXQYFVD5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 01 Jul 2026 08:55:33 +0200,
dengxiang wrote:
> 
> Some devices have mute settings in their firmware set by the factory.
> This is to stop popping noise when the devices turn on. But this setting
> makes the microphones unable to record sound properly. This patch
> solves this problem and is compatible with conexant chips.
> 
> Signed-off-by: dengxiang <os_dengxiang82@126.com>

Hmm, this doesn't look like a right solution.

Is it only the problem after the boot?  Or is it an issue after the
runtime PM suspend?  The amp value must be restored by the runtime
resume, and if this doesn't work expected, it's a thing to be
addressed there, not in the PCM hook at all.


thanks,

Takashi

> ---
>  sound/hda/codecs/conexant.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
> index 3d92262763f6..3229f9ef5969 100644
> --- a/sound/hda/codecs/conexant.c
> +++ b/sound/hda/codecs/conexant.c
> @@ -1184,6 +1184,24 @@ static void add_cx5051_fake_mutes(struct hda_codec *codec)
>  	spec->gen.dac_min_mute = true;
>  }
>  
> +static void cxt_fixed_mic_boost(struct hda_codec *codec, hda_nid_t node_id)
> +{
> +	struct conexant_spec *spec = codec->spec;
> +	unsigned int value = 0;
> +
> +	value = snd_hda_codec_read(codec, node_id, 0, AC_VERB_GET_AMP_GAIN_MUTE, 0);
> +	snd_hda_codec_amp_stereo(codec, node_id, HDA_INPUT, 0, HDA_AMP_VOLMASK, value);
> +}
> +
> +static void cxt_capture_hook(struct hda_pcm_stream *hinfo,  struct hda_codec *codec,
> +			       struct snd_pcm_substream *substream, int action)
> +{
> +	struct conexant_spec *spec = codec->spec;
> +	hda_nid_t mux_pin = spec->gen.imux_pins[spec->gen.cur_mux[0]];
> +
> +	cxt_fixed_mic_boost(codec, mux_pin);
> +}
> +
>  static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
>  {
>  	struct conexant_spec *spec;
> @@ -1271,6 +1289,9 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
>  	if (err < 0)
>  		goto error;
>  
> +	if (spec->gen.pcm_capture_hook == NULL)
> +		spec->gen.pcm_capture_hook = cxt_capture_hook;
> +
>  	/* Some laptops with Conexant chips show stalls in S3 resume,
>  	 * which falls into the single-cmd mode.
>  	 * Better to make reset, then.
> -- 
> 2.39.5
> 
