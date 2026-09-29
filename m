Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DADACA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:11:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C474F601EA;
	Tue, 29 Sep 2026 15:11:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C474F601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790687476;
	bh=ZvTVLjaC6ShH+AJvVo+tS6hpOJ8rm4CxsFWrSEWE5o4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RkWyn3fZGIm4o4CyIOlGwQ8MA/1N4WDmROSTGdUg/vGQVGU574Bm9OdpdyQ05keQG
	 Hwboq1rt/c96/AVQQqc4Tj65iQVzq/9yGJ8BXqkS5H3QGLS/JpsnDXwZriMKOtc0Ma
	 tg7j4IFVw1d8tcYPdG93ZNvT90KjFxDPNynvAAq0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73CD9F805F9; Tue, 29 Sep 2026 15:10:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B929F805F9;
	Tue, 29 Sep 2026 15:10:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4680EF8055C; Tue, 29 Sep 2026 15:10:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790687433;
	b=KjesSolQdUXqh57sP00tJkUaaJ08ePNCn3xjwNox6ys/LYyuQUYNt4MEMQbSr1fBexVO
	 Qs863M0cYo9dnlU0H0yyPWvk8glNMsYlsrIZ+Bb6teUGS2UMwThVE+obwfhKPJw9mWXXE
	 k2qB6pN0fabCD81c8rCeB2ExvF9Ym5jSaOipNNdxOxHkXI8awaj8I9NFJ35mXi8Vnwjqe
	 93thxBGE1AkDQaj1LZk63XBlR6SdDZuOr1uy+4eg7NebCIOD9jubLDgIY7YwO86liE0MP
	 FWImBcMfHSFgEK3YMUg2GtVbjj2j+8xsoBPmaUQyRTjP4s5vu4zPHjYQiwbpUZuRyLw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790687433;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=ZvTVLjaC6ShH+AJvVo+tS6hpOJ8rm4CxsFWrSEWE5o4=;
	b=CrrzjsshzF07GFx+2qX3nQdvK+HqRyHpqfgmcm65TIQNy+3dJnY1TkFsC42Eh1SB4oxK
	 Nbdi71Lef7riWhvq9GHPCHAVeSZprEDk+k/QaLtS0G0zwaIhaIRg8NZmNnRuYkkU5AXSa
	 NOL4HOw7GQbIh0Z5+AM+MjLOJveU3sTKm3dJZaRanhGoYWGGGaArfRh2c5jdYNKWqDi3H
	 7vuWuEjGTamqqqcGzNubbMH3i2HLZm/JjHT2B3/Xi1JOp4Suh1R1i1og7jt0OfrHkRm22
	 suFwrWAzF1VpxGjm+gZdY4YHKssAr/T50YSEcQoDeOPP23ODAJZ7MzbWuQMG9NTIBuw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CZcfjlD9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=3XvHiPYD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=yWsfB835;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZRIHWzyv;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AA4F6F80448
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 15:10:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA4F6F80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CZcfjlD9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=3XvHiPYD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=yWsfB835;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZRIHWzyv
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 890F821C11;
	Tue, 29 Sep 2026 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790687427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tWC+Oy724WqUUyz6Q+GidZeg+BmYf3L3nKkwQ1FQcw=;
	b=CZcfjlD9XDK9kWZkCjnIqDRVVfx7o8oJP2QOT6Ed/4X2nlIr+lYYeLoWH7GJijJ3jluRZd
	4xhehJB96m3cJBEHIr6HduIYSRqC7mw60g7FK3R5YIQ3c2fL8EHua5qW3I1Q0vxqRD9iz1
	E1LbvyBAYnafgsTlMj2QmG7xnAWoBKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790687427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tWC+Oy724WqUUyz6Q+GidZeg+BmYf3L3nKkwQ1FQcw=;
	b=3XvHiPYDMSLu0Q+G5PNqSvRbiY+pFAY3YKDKNnEkAcm0XWwxlHgKckp0hupR8B8dbxQUr3
	hYVQ1JRT2kcdFrCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790687423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tWC+Oy724WqUUyz6Q+GidZeg+BmYf3L3nKkwQ1FQcw=;
	b=yWsfB835D1TmHm1l+nHOOoUPz6hiacBFk2Ln5HVv3ERJNwrD8zF4fGiYbL0sSQgbmHrcH6
	+YdOXvnuXyzFu5dSGp8Qj5TahdeDQqc2i//Toc01OFPtuNmL4G4FIl9B0mliwTyZQHZ7f3
	/xnq7SgEFR0vWjr+4iBo8c/h5pyg9wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790687423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tWC+Oy724WqUUyz6Q+GidZeg+BmYf3L3nKkwQ1FQcw=;
	b=ZRIHWzyvbdvash2nIX/yA7qeA192TeKtYFVPt8EE7vNVH6qGTjPmwVypBUr5OQFNc9sc8/
	SoKCLX2J6p0T4aAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52C45136D1;
	Tue, 29 Sep 2026 13:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CYf9C7+4u2qPCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 13:10:23 +0000
Date: Tue, 29 Sep 2026 15:10:14 +0200
Message-ID: <87fqys19vt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: dchristensen8 <dchristensen8@proton.me>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/ca0132: Add Sound BlasterX AE-5 external RGB
 LED strip support
In-Reply-To: 
 <eFYfxKMV2ei__fURd-elssegCIVmOuRDne6lj9PMaM2bEgnYkz7Tzf6JLrgEaPZtvrUC_wHnmnwaUZAOdg0uh24nt73FQqi6T65qvJebHJA=@proton.me>
References: 
 <eFYfxKMV2ei__fURd-elssegCIVmOuRDne6lj9PMaM2bEgnYkz7Tzf6JLrgEaPZtvrUC_wHnmnwaUZAOdg0uh24nt73FQqi6T65qvJebHJA=@proton.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.966];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: 3KJDMNZX3R3ML4VMVG4ULRPNXS5MHWOQ
X-Message-ID-Hash: 3KJDMNZX3R3ML4VMVG4ULRPNXS5MHWOQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3KJDMNZX3R3ML4VMVG4ULRPNXS5MHWOQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 28 Sep 2026 19:26:05 +0200,
dchristensen8 wrote:
> 
>     Hi Takashi, Jaroslav,                                                                                             
>                                                                                                                       
>     Please find attached a patch adding support for the external addressable RGB LED strip header on the Creative Sound BlasterX AE-5 and AE-5 Plus.                                           
>                                                                                                                       
>     The patch is attached as a .patch file.                                                                                  
>   
>     The Sound BlasterX AE-5 and AE-5 Plus expose a 3-pin 5V addressable RGB header driven directly by the CA0113 PCIe-to-HD-Audio bridge. Rather than using the CA0132 DSP or MMIO GPIO, the CA0113 contains an autonomous HDA link sniffer that snoops a designated HDA DMA playback stream, extracts the 24-bit GRB color payload, and serializes it as 800 kHz single-wire NRZ pulses to the strip (WS2812B protocol).
>   
>     Expose the strip through a sysfs interface on the codec device:
>     ae5_strip_leds: read current colors write a comma-deparated #RRGGBB or R,G,B list (a single color replicates across all active LEDs) 
> 
> ae5_strip_num_leds: get or set the active LED count (1..100)
>   
>     Writes allocate an idle HDA playback stream, format a 32 KB DMA buffer populated with repeating WS2812 frames (5-word zero preamble, 4 audio words per LED, and reset gap), configure the CA0113 BAR2 serializers and stream-tag pin mux, and pulse the stream long enough for the reset latch to fire. Access is serialized with a per-spec mutex, and the attributes are only registered on QUIRK_AE5 devices.
>   
>     Document the new sysfs attributes in documentation/ABI/testing.
>   
>     Signed-off-by: Devin Christensen <dchristensen8@proton.me>
>     Testing & Subsystem Context:
>      - Verified on physical Sound BlasterX AE-5 hardware.
>      - Tested continuous 60 FPS streaming and dynamic strip resizing (10 -> 7 -> 10 LEDs)
>        via the OpenRGB effects engine (MR: https://gitlab.com/CalcProgrammer1/OpenRGB/-/merge_requests/3658).         
>      - Verified concurrent audio playback and LED updates without dropped samples or xruns.
>      - Built clean against tiwai/sound for-next (commit 72107104d4f5).
>      - Passes scripts/checkpatch.pl with 0 errors and 0 checks.

Thanks for the patch.

It's an interesting stuff (rather surprising that they (ab)use
HD-audio for such an interface :)

Through a quick glance, most of the code looks OK.

So the question is rather the interface -- is the sysfs the best
choice for this kind of display controls?  The implementation can be
refactored at any time, but the interface must be set solid, so that's
the most important question to be clarified.

About the code:

>  /*
> - * Setup default parameters for the Sound BlasterX AE-5 DSP.
> + * Sound BlasterX AE-5 External WS2812B RGB LED Strip Transport
>   */
> +static void ae5_strip_encode_24(u32 u, u32 *words)
> +{
> +	/* Bit-for-bit exact encoding matching CtxHda.sys FUN_00042944:
> +	 * 24-bit pixel -> 4 x 32-bit audio words (6 bits per word).
> +	 * Hardware audio serializer transmits MSB first (bits 31 down to 0).
> +	 * For word i (i8 = 23, 17, 11, 5), bit_idx 0..5 (MSB to LSB within the word)
> +	 * is placed at n = 29 - bit_idx * 4 (bits 29, 25, 21, 17, 13, 9):
> +	 *   out |= (bit << n) | ((bit | 2) << (n + 1))
> +	 * Bit 0 -> 0b010 (375ns high, 1042ns low)
> +	 * Bit 1 -> 0b111 (1083ns high, 333ns low)
> +	 */
> +	int i8 = 23;
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		u32 out = 0;
> +		int bit_idx;
> +
> +		for (bit_idx = 0; bit_idx < 6; bit_idx++) {
> +			int bit = (u >> (i8 - bit_idx)) & 1;
> +			int n = 29 - bit_idx * 4;
> +
> +			out |= (u32)(bit << n) | ((u32)(bit | 2) << (n + 1));
> +		}
> +		words[i] = out;
> +		i8 -= 6;
> +	}

I guess some BIT() macro or such could help in a bit cleaner form.


> +static struct hdac_stream *ae5_strip_find_stream(struct hda_codec *codec)
> +{
> +	struct ca0132_spec *spec = codec->spec;
> +	struct hdac_bus *bus = &codec->bus->core;
> +	struct hdac_stream *s, *dsp = NULL, *first = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bus->reg_lock, flags);
> +	list_for_each_entry(s, &bus->stream_list, list) {
> +		if (s->direction != SNDRV_PCM_STREAM_PLAYBACK)
> +			continue;
> +		if (s->running || s->locked)
> +			continue;
> +		if (!first)
> +			first = s;
> +		/* The DSP DMA consumes the DSP-loader stream (tag in dsp_stream_id). */
> +		if (spec->dsp_stream_id && s->stream_tag == spec->dsp_stream_id)
> +			dsp = s;
> +	}
> +	spin_unlock_irqrestore(&bus->reg_lock, flags);

Try to use guard() instead of manual lock/unlock.


> +/*
> + * Caller must hold spec->ae5_strip_mutex.
> + */

You can put a lockdep assert to assure that in the actual code, too.

> +static int ae5_strip_send_frame(struct hda_codec *codec, const u32 *grb_colors, int num_leds)
> +{
> +	struct ca0132_spec *spec = codec->spec;
> +	struct snd_dma_buffer dmab;
> +	struct hdac_stream *hstr = NULL;
> +	unsigned int format, stream_tag;
> +	u32 enc_words[4];
> +	u32 *dst;
> +	int total_words = 0x8000 / sizeof(u32); /* 8192 words (32KB) */

It should be defined as a constant instead?

> +	int word_idx = 0;
> +	int frame_words;
> +	int led, w;
> +	int retries = 20; /* ~100ms max */
> +	u8 orig_sd_ctl = 0;
> +
> +	if (!spec || !spec->mem_base)
> +		return -ENODEV;
> +	if (num_leds <= 0 || num_leds > AE5_STRIP_MAX_LEDS)
> +		return -EINVAL;
> +
> +	snd_hda_power_up(codec);
> +
> +	/*
> +	 * 44.1kHz, 24-bit, 2-channel format (0x4031) matches Windows CtxHda
> +	 * HDAUDIO_STREAM_FORMAT.
> +	 */
> +	format = snd_hdac_stream_format(2, 24, 44100);
> +
> +	for (;;) {
> +		hstr = ae5_strip_find_stream(codec);
> +		if (!hstr) {
> +			if (--retries <= 0) {
> +				codec_warn(codec, "AE5 strip: no free azx stream after retries\n");
> +				snd_hda_power_down(codec);
> +				return -EBUSY;
> +			}
> +			usleep_range(5000, 10000);
> +			continue;
> +		}
> +
> +		stream_tag = snd_hdac_dsp_prepare(hstr, format, 0x8000, &dmab);
> +		if ((int)stream_tag > 0)
> +			break;
> +
> +		/* Prepare failed (e.g. -EBUSY due to race with playback starting); retry */
> +		if (--retries <= 0) {
> +			codec_warn(codec, "AE5 strip: snd_hdac_dsp_prepare failed %d\n",
> +				   (int)stream_tag);
> +			snd_hda_power_down(codec);
> +			return (int)stream_tag;
> +		}
> +		usleep_range(5000, 10000);
> +	}
> +
> +	/* Prevent interrupt storms during free-running LED stream, saving original control bits */
> +	if (hstr->sd_addr) {
> +		orig_sd_ctl = readb(hstr->sd_addr);
> +		writeb(orig_sd_ctl & ~0x1c, hstr->sd_addr); /* Clear IOCE, FEIE, DEIE */
> +	}
> +
> +	/* 1. Populate the 32KB DMA buffer with repeating WS2812 frames + reset gaps */
> +	memset(dmab.area, 0, 0x8000);
> +	dst = (u32 *)dmab.area;
> +
> +	/* Words per frame: 5 words zero preamble + num_leds * 4 words + 83 words reset gap */
> +	frame_words = 5 + (num_leds * 4) + 83;
> +
> +	while (word_idx + frame_words <= total_words) {
> +		/* 5-word zero preamble per Windows CtxHda FUN_00042944 */
> +		for (w = 0; w < 5; w++) {
> +			*dst++ = 0;
> +			word_idx++;
> +		}
> +		/* LEDs */
> +		for (led = 0; led < num_leds; led++) {
> +			ae5_strip_encode_24(grb_colors[led], enc_words);
> +			for (w = 0; w < 4; w++) {
> +				*dst++ = enc_words[w];
> +				word_idx++;
> +			}
> +		}
> +		/* 83 words (> 1.8 ms) zero reset gap (WS2812 requires > 50 us low) */
> +		for (w = 0; w < 83; w++) {

Here, too.  Let's avoid magic numbers.

> +			*dst++ = 0;
> +			word_idx++;
> +		}
> +	}
> +	while (word_idx < total_words) {
> +		*dst++ = 0;
> +		word_idx++;
> +	}
> +	/* Ensure DMA buffer writes are committed before triggering the HDA stream */
> +	wmb();
> +
> +	/* 2. Configure CA0113 BAR2 hardware registers */
> +	/* Power up clocks (CtxHdb 0x141b7 / 0x14210) */
> +	writel(readl(spec->mem_base + 0xc04) | 0x7, spec->mem_base + 0xc04);
> +
> +	/* Base serializer initialization (CtxHdb 0x14ba4) */
> +	writel(readl(spec->mem_base + 0x400) | 1, spec->mem_base + 0x400);
> +	writel(readl(spec->mem_base + 0x42c) & ~1, spec->mem_base + 0x42c);
> +	writel(readl(spec->mem_base + 0x46c) & ~1, spec->mem_base + 0x46c);
> +	writel(readl(spec->mem_base + 0x4ac) & ~1, spec->mem_base + 0x4ac);
> +	writel(readl(spec->mem_base + 0x4ec) & ~1, spec->mem_base + 0x4ec);
> +	writel(0, spec->mem_base + 0x43c);
> +	writel(0, spec->mem_base + 0x47c);
> +	writel(0, spec->mem_base + 0x4bc);
> +	writel(0, spec->mem_base + 0x4fc);
> +	writel(readl(spec->mem_base + 0x408) | 1, spec->mem_base + 0x408);
> +	writel(readl(spec->mem_base + 0x40c) | 1, spec->mem_base + 0x40c);
> +	writel((readl(spec->mem_base + 0x410) & ~0xb) | 0x14, spec->mem_base + 0x410);
> +
> +	/* Configure serializers 0..3 clocking (CtxHdb 0x14a6c) */
> +	writel(readl(spec->mem_base + 0x43c) | 0x33, spec->mem_base + 0x43c);
> +	writel(readl(spec->mem_base + 0x47c) | 0x33, spec->mem_base + 0x47c);
> +	writel(readl(spec->mem_base + 0x4bc) | 0x33, spec->mem_base + 0x4bc);
> +	writel(readl(spec->mem_base + 0x4fc) | 0x33, spec->mem_base + 0x4fc);

Some helpers or macros look deserving.

I stop at this point, as we'd need to define the interface at first.


thanks,

Takashi
