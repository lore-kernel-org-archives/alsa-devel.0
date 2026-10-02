Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C3ACA5FDD
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:32:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1EA960290;
	Fri,  2 Oct 2026 16:32:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1EA960290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790951559;
	bh=4yfL6ZuTNZa5NX/iTdaOyajQ2+YIltjNFmTy/Ygjfac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lyoy/g/7ysPar5EhsTdq6MHDbzxbKJmE0nzeSrBAN1MxShS/+CZVtlqMHTn7X6DtV
	 +Bzlljzhv5MKQDQgXO5ZMEG4FiFnPekrxoEHvT8gzhx+Xnt7/VPusn3k3nKMptwyGJ
	 yYO6qFQyUqFX3MCx4kDVOnoDqhulH0+Ua4ZMkMmM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54126F805FD; Fri,  2 Oct 2026 16:32:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D059DF80601;
	Fri,  2 Oct 2026 16:32:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 754FBF805BA; Fri,  2 Oct 2026 16:31:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790951513;
	b=ai79oVO9UwEPaOCaciO2/rvtKbnkNe+piOsaE7e9EsJVOqhfqsvbCU9zCg3Yfo+6zSqR
	 5ZesFsw0VY3DpJkEZtBuE1Uw/45+WjsFJUp/E1hPl0t/O+MbcezbKfPARxzHf6vuvAglH
	 33tPo6POTuTrpZzNFe1taNcUjHdMooAMlzTzGTJOoUD93gRbe8e9QK2EpweCiKOuGPY7X
	 kWhnRBWztlB4C++OKJqExX8iLbyYUIXfs+llDFhusdUtmIzEqN2UFwZ+VGsAVuImpmWgu
	 HsKllou0K7BvxZcUvslbJ7kfKfDbzExmVtiiksBgmb65AKdQu7xxDoCY5euPdFwbLdA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790951513;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=4yfL6ZuTNZa5NX/iTdaOyajQ2+YIltjNFmTy/Ygjfac=;
	b=rmdBxERG9JYhmF2h7JAoT+ptf10Zl6m6n1b46VSkZmHTrXn29oRz9yMAi508c/iy/F7d
	 VgE/iRm8Wz9rMe5NYl5jtJdTpyuFpYglGDzxFOh6qwavq+0tcw3B/GwEEacBZNX68KuT1
	 T8HwVW6/rJXqg2DnrjW9lV4+NcjJg7D5V3C5ieaELSVEWz/calDxp4Z01xa8iQgIDd5dd
	 z7Y4Z3JVI/VN0V1lbP0TGAuakBwNX3RdZbCq2g86tvUkwVcgM611GBdQ27f5pUhYFl9O4
	 goxk9jX7v5dXERgmWRk0QPd1Btczzp11WLlsFsCAn44t+phPLriV8iCC+UrkkOIs4bQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Cflr3DeK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=eHMPH2BR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="CtALC/I+";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6Q3Sus+2;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4C8F6F80424
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 16:31:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C8F6F80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Cflr3DeK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=eHMPH2BR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=CtALC/I+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6Q3Sus+2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 017A521EEF;
	Fri,  2 Oct 2026 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790951507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTCIVJ7/j69ZOgjlYrSfK9lJ1Jb4o1WUZlI9LTfcrG8=;
	b=Cflr3DeKzcbDhFfmWlSn0f98yErm1OwC4zOd9cXLdtXfZtSCtFu/Px1NqaeiNcd2JkKdUb
	6Xd7Vyn/NUM5nn6C0CwiW6HVGLdg//ATXjnzq0StkvPwezi4WHM/URErt13NSpN1D5iOjD
	hbKZGDFs9TAaex5mBa1hxfx/lQAJiuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790951507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTCIVJ7/j69ZOgjlYrSfK9lJ1Jb4o1WUZlI9LTfcrG8=;
	b=eHMPH2BRmD4w+gcpwJAR5T1DaUa4PyEIqG5hJ7PMnFwxH+z2rxc6+Y0SmoSv9YLhiMc/Z5
	C7T1fPU2nW42TOAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CtALC/I+";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6Q3Sus+2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790951503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTCIVJ7/j69ZOgjlYrSfK9lJ1Jb4o1WUZlI9LTfcrG8=;
	b=CtALC/I+vrQlO3d87YRNnv4a2ZwMhY1I6UsZYXVQ+UQathTS9mosFLlT6NUZh4Q90TR3Vs
	C2bJALuLaWRBlM9gMNxDufeePsRh4fVEQrg9yhiQ1qZWLCwmONAFB7jbrrzLxxApmal8Yv
	oE9GtmskHJ8QwV7JRXEJQgzoyomLS5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790951503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTCIVJ7/j69ZOgjlYrSfK9lJ1Jb4o1WUZlI9LTfcrG8=;
	b=6Q3Sus+2a3leZrAG7d0Cy1aZS0wDyi6fM1yhn0y2XEEYSwAvVIshhK+Ete3WQmJr+5GE2R
	Bp5oyKFyXAcsXACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2F3D139C9;
	Fri,  2 Oct 2026 14:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 63yyJE7Av2oHQwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Oct 2026 14:31:42 +0000
Date: Fri, 02 Oct 2026 16:31:42 +0200
Message-ID: <87ik3kyy0h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: dchristensen8 <dchristensen8@proton.me>
Cc: "tiwai@suse.com" <tiwai@suse.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/ca0132: Add Sound BlasterX AE-5 external RGB
 LED strip support
In-Reply-To: 
 <I690osvh2wujN3P04R4abtKFqOqtIiC-qin2ZEFs9q8kKU7-qfIg2cya4BuHS7Vg83Wkon6BCJGtVIxeJVfRZ8nG07laTUlv-fJjELMgp1Y=@proton.me>
References: 
 <I690osvh2wujN3P04R4abtKFqOqtIiC-qin2ZEFs9q8kKU7-qfIg2cya4BuHS7Vg83Wkon6BCJGtVIxeJVfRZ8nG07laTUlv-fJjELMgp1Y=@proton.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 017A521EEF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: PWVHQ7BJHHCHG4OOREP4JNOGD3JO3W5H
X-Message-ID-Hash: PWVHQ7BJHHCHG4OOREP4JNOGD3JO3W5H
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PWVHQ7BJHHCHG4OOREP4JNOGD3JO3W5H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 02 Oct 2026 03:41:50 +0200,
dchristensen8 wrote:
> 
> 
> Takashi,
> 
> Thank you for your assistance on this! I updated it to use CLASS
> (snd_hda_power_pm, pm)(codec) for the power management call, which cleaned up
> all the manual power-down error exits nicely.
> 
> Attached is the proper v2 patch for upstreaming.

Now reviewing further in details, and some issues found:

> --- a/sound/hda/codecs/ca0132.c
> +++ b/sound/hda/codecs/ca0132.c
> @@ -35,6 +35,8 @@
>  #include <sound/tlv.h>
>  #endif
>  
> +#include <linux/dma-mapping.h>

Let's move this into the block with other header file inclusions.
Not needed to be alone here.


> +static struct hdac_stream *ae5_strip_find_stream(struct hda_codec *codec)
> +{
> +	struct ca0132_spec *spec = codec->spec;
> +	struct hdac_bus *bus = &codec->bus->core;
> +	struct hdac_stream *s, *dsp = NULL, *first = NULL;
> +
> +	guard(spinlock_irqsave)(&bus->reg_lock);
> +	list_for_each_entry(s, &bus->stream_list, list) {
> +		if (s->direction != SNDRV_PCM_STREAM_PLAYBACK)
> +			continue;
> +		if (s->running || s->locked)
> +			continue;

It should also check s->opened, too.

> +	for (;;) {
> +		hstr = ae5_strip_find_stream(codec);
> +		if (!hstr) {
> +			if (--retries <= 0) {
> +				codec_warn(codec, "AE5 strip: no free azx stream after retries\n");
> +				return -EBUSY;
> +			}
> +			usleep_range(5000, 10000);
> +			continue;
> +		}
> +
> +		stream_tag = snd_hdac_dsp_prepare(hstr, format, AE5_STRIP_DMA_SIZE, &dmab);

The function needs CONFIG_SND_HDA_DSP_LOADER, and it's not always
selected.  Although the compile would works, it makes no sense to keep
the code without the support code.


> +static int ae5_strip_ctl_put(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct ca0132_spec *spec = codec->spec;
> +	u32 colors[AE5_STRIP_MAX_LEDS];
> +	int i, num_leds;
> +
> +	guard(mutex)(&spec->ae5_strip_mutex);
> +	num_leds = spec->ae5_strip_cur_num_leds;
> +	for (i = 0; i < num_leds; i++) {
> +		u8 r = ucontrol->value.bytes.data[i * 3 + 0];
> +		u8 g = ucontrol->value.bytes.data[i * 3 + 1];
> +		u8 b = ucontrol->value.bytes.data[i * 3 + 2];
> +
> +		colors[i] = ((u32)g << 16) | ((u32)r << 8) | (u32)b;
> +	}
> +	memcpy(spec->ae5_strip_cur_colors, colors, sizeof(u32) * num_leds);
> +	ae5_strip_send_frame(codec, colors, num_leds);
> +	return 0;

In general, the put callback should return 1 if the values are
modified.


thanks,

Takashi
