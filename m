Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29BCC43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:51:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 491FC60235;
	Wed,  1 Jul 2026 10:51:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 491FC60235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782895902;
	bh=Y/cozOHSPQMMSo3WRLwd4rCT9ufJEqgOFGg/hQ9MpIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cuzlKNd5/Y8Z60rTyZKTpOb//Tk4noy8KLopQsugXFjOfhdDxRPy4OhEP7RtpIFuV
	 sw19xgV6zxOME2VI1zj/f2p10bXMc4eFN4ZAVyOOkm/90acwRw+KkOI7RjljqbglmK
	 xohE6xcgo//KjoffKYqQHthsPDs0SyUCSCsZV1po=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65D13F805FB; Wed,  1 Jul 2026 10:51:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C89BAF805F3;
	Wed,  1 Jul 2026 10:51:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E23E1F8051F; Wed,  1 Jul 2026 10:50:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782895858;
	b=ok+LTc8a97SpXf9W6kw/vTjVUQAK5ibghdMzg1zXWY8MP6LvsIvHtjHQKePxZKCjZn4M
	 IKn8xe6JiYlKsamMHThhad54v+f/XUAZ75dRBSQc6mgEc/YXxkhwmH5GcOtJ0XPQcLKK1
	 DKUwUlejHucI/t6g/ryu0xotJOZchmTj4EAVX2OWpgomAIG9wY5CEt2FQZpWWx906udZu
	 y4PIo6KcorsYiRjrEXzMaZNU/5U/bDZGvr9rew8QDCZxhuxslKa6/5Gfb825xnWUysVdC
	 Niu3grjZQmFcsgbdJ9X61kbUl54dEpfv3WqxJSBK54pHd/VI04dj/8xPsoCPAP+FMAA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782895858;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=Y/cozOHSPQMMSo3WRLwd4rCT9ufJEqgOFGg/hQ9MpIY=;
	b=A3BEVMNVOEz7Q1tjblKlUsfJfUKwUo1X21lYVMoeeLz9GV2eA+VSS4kdKNC+rKO6SJX1
	 bQKHYrYIn1svf+ITIg4F5y3ylbNwr2by1eG09rn4wrPOHo1Z3Nq7xjGOfT+Ziw5wz/nOq
	 XO5QVvdazYNPqPjxIPTMu+Gwp4BSl+NDDJjvsAPBNDfmUsYpor2/iySiVXE0SeBPf77HD
	 NocovtfcEXzXv5lHu3aGiBaBV5xmSpEiLs4S0EBMKxGYh33Bq1iooSM17pEtzJbhoc1uz
	 7bzDw64raSQdxgUQpV9w5N3x5hFTIbPe99tHxEuvNKa59nvg7iNbHvmENyfMEnYENtA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gNfBPlta;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=oGA3xDA7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gNfBPlta;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=oGA3xDA7;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5CF83F80152
	for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2026 10:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CF83F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gNfBPlta;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=oGA3xDA7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=gNfBPlta;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=oGA3xDA7
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E15071FB2;
	Wed,  1 Jul 2026 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1782895856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YPd0gL7HTgwaLFo3KJqUZzD8DEDLOZM7IKoXS4xxKs=;
	b=gNfBPltaNe8Dg1MEeQ/r/Z9fjbGh86+jxUhQdRpjqQ2gwvgVe9aGhYJe3rxnU81Vcagm+3
	mhepgq3O7lgF6d/SPHFt6Uudb6SfOooTkf61pSOOoah3nPEBAjr1m0gdLNzvuhWgXl7XC6
	zXd6xSMPgjewS+ivQIfsdFRaPnZSRSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782895856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YPd0gL7HTgwaLFo3KJqUZzD8DEDLOZM7IKoXS4xxKs=;
	b=oGA3xDA7HAzDU5UTLlSrLq9wGtpts1V8f3Q4DkidQUc2mn57g3BGLzVC7dW5Gxx80octmE
	nxrDflCBLSeKfMDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1782895856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YPd0gL7HTgwaLFo3KJqUZzD8DEDLOZM7IKoXS4xxKs=;
	b=gNfBPltaNe8Dg1MEeQ/r/Z9fjbGh86+jxUhQdRpjqQ2gwvgVe9aGhYJe3rxnU81Vcagm+3
	mhepgq3O7lgF6d/SPHFt6Uudb6SfOooTkf61pSOOoah3nPEBAjr1m0gdLNzvuhWgXl7XC6
	zXd6xSMPgjewS+ivQIfsdFRaPnZSRSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782895856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YPd0gL7HTgwaLFo3KJqUZzD8DEDLOZM7IKoXS4xxKs=;
	b=oGA3xDA7HAzDU5UTLlSrLq9wGtpts1V8f3Q4DkidQUc2mn57g3BGLzVC7dW5Gxx80octmE
	nxrDflCBLSeKfMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C59F779AA;
	Wed,  1 Jul 2026 08:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4nPrGPDURGqlagAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 01 Jul 2026 08:50:56 +0000
Date: Wed, 01 Jul 2026 10:50:55 +0200
Message-ID: <87ldbvum8g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: os_dengxiang82  <os_dengxiang82@126.com>
Cc: tiwai@suse.com,
	bo.liu@senarytech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/conexant: Fix microphone mute after power-on
 reboot
In-Reply-To: <4932c551.6ece.19f1cdd10ba.Coremail.os_dengxiang82@126.com>
References: <20260701065533.72517-1-os_dengxiang82@126.com>
	<87se63upn1.wl-tiwai@suse.de>
	<235d28fc.65dd.19f1cc1a68d.Coremail.os_dengxiang82@126.com>
	<87o6grun6p.wl-tiwai@suse.de>
	<4932c551.6ece.19f1cdd10ba.Coremail.os_dengxiang82@126.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: JBSCOTCN5WOGAHIQRCPXW4ZM5UOHYTRX
X-Message-ID-Hash: JBSCOTCN5WOGAHIQRCPXW4ZM5UOHYTRX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JBSCOTCN5WOGAHIQRCPXW4ZM5UOHYTRX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 01 Jul 2026 10:47:57 +0200,
os_dengxiang82 wrote:
> 
> 
> I have already tried calling regcache_mark_dirty() and snd_hda_regmap_sync()
> inside the resume callback, and I¢ve also attempted this during the bootup
> phase. But the issue is still present.

Then you need to investigate why this doesn't suffice, instead of an
ad hoc workaround :)  We can take a workaround fix, too, but only when
it's the only appropriate solution.


thanks,

Takashi

> At 2026-07-01 16:30:22, "Takashi Iwai" <tiwai@suse.de> wrote:
> >On Wed, 01 Jul 2026 10:18:00 +0200,
> >os_dengxiang82 wrote:
> >> 
> >> 
> >> Hi Takashi,
> >> 
> >>   This failure occurs during bootup as well as after runtime resume. Does
> >> runtime resume here refer to the resume handler, like .resume = cx_resume? or
> >> something else? Looking forward to your reply.
> >
> >It's hda_codec_runtime_resume().  We have no Conexant-specific resume
> >callback, hence the standard procedure is applied, i.e.
> >regcache_mark_dirty() and snd_hda_regmap_sync() make the codec verbs
> >resumed that have been touched.  So, you'd need to check whether the
> >needed amp has been already accessed via regmap, and check whether the
> >value gets restored properly in the procedure above.
> >
> >
> >Takashi
> >
> >> 
> >> xiang
> >> 
> >> At 2026-07-01 15:37:22, "Takashi Iwai" <tiwai@suse.de> wrote:
> >> >On Wed, 01 Jul 2026 08:55:33 +0200,
> >> >dengxiang wrote:
> >> >> 
> >> >> Some devices have mute settings in their firmware set by the factory.
> >> >> This is to stop popping noise when the devices turn on. But this setting
> >> >> makes the microphones unable to record sound properly. This patch
> >> >> solves this problem and is compatible with conexant chips.
> >> >> 
> >> >> Signed-off-by: dengxiang <os_dengxiang82@126.com>
> >> >
> >> >Hmm, this doesn't look like a right solution.
> >> >
> >> >Is it only the problem after the boot?  Or is it an issue after the
> >> >runtime PM suspend?  The amp value must be restored by the runtime
> >> >resume, and if this doesn't work expected, it's a thing to be
> >> >addressed there, not in the PCM hook at all.
> >> >
> >> >
> >> >thanks,
> >> >
> >> >Takashi
> >> >
> >> >> ---
> >> >>  sound/hda/codecs/conexant.c | 21 +++++++++++++++++++++
> >> >>  1 file changed, 21 insertions(+)
> >> >> 
> >> >> diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
> >> >> index 3d92262763f6..3229f9ef5969 100644
> >> >> --- a/sound/hda/codecs/conexant.c
> >> >> +++ b/sound/hda/codecs/conexant.c
> >> >> @@ -1184,6 +1184,24 @@ static void add_cx5051_fake_mutes(struct hda_codec *codec)
> >> >>                    spec->gen.dac_min_mute = true;
> >> >>  }
> >> >>  
> >> >> +static void cxt_fixed_mic_boost(struct hda_codec *codec, hda_nid_t node_id)
> >> >> +{
> >> >> +                  struct conexant_spec *spec = codec->spec;
> >> >> +                  unsigned int value = 0;
> >> >> +
> >> >> +                  value = snd_hda_codec_read(codec, node_id, 0, AC_VERB_GET_AMP_GAIN_MUTE, 0);
> >> >> +                  snd_hda_codec_amp_stereo(codec, node_id, HDA_INPUT, 0, HDA_AMP_VOLMASK, value);
> >> >> +}
> >> >> +
> >> >> +static void cxt_capture_hook(struct hda_pcm_stream *hinfo,  struct hda_codec *codec,
> >> >> +                                                                     struct snd_pcm_substream *substream, int action)
> >> >> +{
> >> >> +                  struct conexant_spec *spec = codec->spec;
> >> >> +                  hda_nid_t mux_pin = spec->gen.imux_pins[spec->gen.cur_mux[0]];
> >> >> +
> >> >> +                  cxt_fixed_mic_boost(codec, mux_pin);
> >> >> +}
> >> >> +
> >> >>  static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
> >> >>  {
> >> >>                    struct conexant_spec *spec;
> >> >> @@ -1271,6 +1289,9 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
> >> >>                    if (err < 0)
> >> >>                                          goto error;
> >> >>  
> >> >> +                  if (spec->gen.pcm_capture_hook == NULL)
> >> >> +                                        spec->gen.pcm_capture_hook = cxt_capture_hook;
> >> >> +
> >> >>                    /* Some laptops with Conexant chips show stalls in S3 resume,
> >> >>                     * which falls into the single-cmd mode.
> >> >>                     * Better to make reset, then.
> >> >> -- 
> >> >> 2.39.5
> >> >>
> >>
> 
