Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5029C55822
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:27:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5928960207;
	Wed,  5 Aug 2026 12:26:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5928960207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785925616;
	bh=DTIY4a3IIlFkxHcem+4DxqCkM++BTUvp38hZAfsQo4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KdUONswvBxMSMaa4aRXgjqIEE0F2qYW/VJRJQ65GJwJ18p8rFYQyjitdid1Esvhsq
	 iLPChRBfQdIUFFRHTrfBHkvJTDyy7Xg+HjfMpl1f2YJ7VzU5lJQGMhBhj3osQDEBAA
	 IhBsq5KUR8diMhSwg3E1+cEsm3mL3sjtnW+mfySY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2704CF805C2; Wed,  5 Aug 2026 12:26:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4655EF805FC;
	Wed,  5 Aug 2026 12:26:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7BCBF8027B; Wed,  5 Aug 2026 12:26:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785925563;
	b=FuxPa4Oa4rFaIFhw0GJSscCuZChMavCTuTDlTe5GCy8/xgT3xk4nRk0FrE/2kpFubCPf
	 Mmw5e20QN2g45pgOFJjYRU6nhKP2Ftjv2aMNiAbOfJVh8Jag4fditoC57Jf5btOCl2OYI
	 GmeVd3tDF+j+iUtst/VJoqklhdF8wckfKHs0a+dfH569lP2pir8+tK/qPL4r6TUizwaT+
	 SuRjBzaKuxwG20ZHBLUjP66mqG/0cChT0+DFhJPMNL8O5noI3IuFRRsrPFcePrt86DNIc
	 YhtisNylzfb1dSh72JIStHIrk1By/WD8HshWGtLZy4ZH+Zd/mz7cKhn+hmWGsILS9KQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785925563;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=DTIY4a3IIlFkxHcem+4DxqCkM++BTUvp38hZAfsQo4Y=;
	b=reE/NJxfbLBMJOKz7s0jwBDmGhNxUpDLE0JnAxahruoWkellwBiVZL9lFndY0oJ7bcXf
	 GjY3vaF4f4zTtAQQbTnQ6lOURCoQBoUqJeaRuUnLVAAOWkmtGZ6JFtth8ewbhkQe0mFyJ
	 bUjfzhaJIYaOALvEt+cxWo76RncAuLeraQThqEikSPEwaBWRML+75KejxhwyO/qTd7WOT
	 dlzBDOi3/wrimaR/yUzokjEGlVABI8uvhKX1o8NCb7eIGPBXinoa1OIDXJ2g9XEvQ+pYy
	 J/0SxLZYgHSyWMc4v9yg4zXJZpwDaGCW3h0+KJn+5B+DM0IuagOl9LzfuyThNa5kx9g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="wTVL/Xwk";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=yqCalbb5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=yNZ7gyA4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VzgTL51O;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3BC62F800C1
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 12:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BC62F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=wTVL/Xwk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=yqCalbb5;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=yNZ7gyA4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VzgTL51O
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DFD37FD3A;
	Wed,  5 Aug 2026 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785925557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jr2lYpizDEuYuzh+HKhbStp4QDbO2DK7JskvfnGxk5Q=;
	b=wTVL/XwkKWZu2PSlCgI95uJkT+HNBFdWPRzuTHa7Gg7OFce4kynGdTMNmm6QpRyagQuu6n
	Rq80BE5CTbaguY++eoOytzFsb857F/0R4WIp7R1d6ZwGX3u7r+DMx/igRDWmcLfaNMLnso
	gMIf55OZ6DDtn5DprbbS9Nu27FIzMRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785925557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jr2lYpizDEuYuzh+HKhbStp4QDbO2DK7JskvfnGxk5Q=;
	b=yqCalbb5ks6A2rYIfFI9bBspJX9MGyM/qxVATlQaUeoPMC8lfw/M3A4QA08P88VIAUuOC6
	tOAGjz+1rBCniFCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785925553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jr2lYpizDEuYuzh+HKhbStp4QDbO2DK7JskvfnGxk5Q=;
	b=yNZ7gyA4HJqF0Csa702hSCmDtUJ3i8SfZ80y9vx00e3Z31Co0oIbbkQwvadJ9zbGoLJmSB
	0COr+jaTpiMdKRMePLpx4ve2RXRt1VYMBn6JH++9yo1ldfSjayVGLGgz8p847ZmAd5pnCt
	MPHsZ3UOFkuDWOnHw6SBEYSgbxKTuuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785925553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jr2lYpizDEuYuzh+HKhbStp4QDbO2DK7JskvfnGxk5Q=;
	b=VzgTL51OuX/7/wt9spMdUoRspwRCUJUMjjksZDIqJ0aR5FGlmqmaP2vfhlaT+/VFZjKyQX
	p//2Z+kXtg4W0dDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E8CE779B6;
	Wed,  5 Aug 2026 10:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8AApBrEPc2ppbgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Aug 2026 10:25:53 +0000
Date: Wed, 05 Aug 2026 12:25:52 +0200
Message-ID: <87y0ekg8y7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Attila Hudecz <ahudecz@gmail.com>
Cc: alsa-devel@alsa-project.org,
	bo.liu@senarytech.com
Subject: Re: [BUG] hda/conexant: SN6140 (0x14f11f87) loses widget state
 across suspend =?ISO-2022-JP?B?GyRCIT0bKEI=?= silent capture + dead
 speaker, no resume callback
In-Reply-To: 
 <CAKuZFt+_TMWoBmG5uKhTfGQYkDwuubHmritEntvcAYkE1OJQmw@mail.gmail.com>
References: 
 <CAKuZFtLvRRNZnJ23xNBWwDcEsY8Wnz0eR2N6x12qtgiBWDp7iQ@mail.gmail.com>
	<CAKuZFt+_TMWoBmG5uKhTfGQYkDwuubHmritEntvcAYkE1OJQmw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Spamd-Result: default: False [-3.24 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.14)[-0.711];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: OQQSCCKXE7QJO47QKUN7TK6OOZLE7UO3
X-Message-ID-Hash: OQQSCCKXE7QJO47QKUN7TK6OOZLE7UO3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OQQSCCKXE7QJO47QKUN7TK6OOZLE7UO3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 05 Aug 2026 11:29:35 +0200,
Attila Hudecz wrote:
> 
> 
> Follow-up with three weeks of monitoring data (a watchdog samples the ALSA
> PCM state every 5s and snapshots context on each failure), plus a specific
> question for Bo Liu about the codec's internal power behaviour.
> 
> == New findings since the original report ==
> 
> 1. The failures are NOT limited to suspend/resume. Of ~30 logged events,
> roughly half occurred with no suspend at all ― typically on the first
> capture after 1-3 h of capture-idle, and occasionally mid-stream (hw_ptr
> advancing, then frozen). A resume-only fix therefore would not cover all
> cases.
> 
> 2. In the failed state the widgets read "Power: setting=D3, actual=D3" ―
> i.e. the codec's power-state register itself holds D3 as the *set* value ―
> while on the software side nobody requested it:
> - snd_hda_intel power_save=0 power_save_controller=N (verified live),
> - kernel log completely silent at the moment of failure,
> - PCI device and codec stay in D0 / runtime-active,
> - userspace (PipeWire/WirePlumber) ruled out.
> Codec re-init via /sys/.../reconfig always restores the silent variant;
> the spurious-response/single_cmd variant needs a controller reset (reboot).
> 
> 3. Event frequency wanders (0-6/day) and has worsened over the three weeks,
> independent of kernel (6.17.0-122035 → 6.17.0-124040), PipeWire and other
> userspace changes ― so a platform/firmware factor may be involved. An
> EC/BIOS update recommended by the vendor (TUXEDO) is pending on our side;
> I will report its effect on the thread.
> 
> == Question for Bo Liu ==
> 
> Does the SN61xx family implement an internal / autonomous power-down (or
> power-state controller) that is meant to be configured or disabled through
> vendor init verbs? The observed behaviour ― widgets ending up with
> setting=D3 with no driver activity, recoverable only by re-running codec
> init ― looks like un-configured codec-internal power logic rather than
> driver-initiated PM.
> 
> Your SN6186 work adds senary_init_verb() and an init-verb/fixup framework.
> Does the SN6140 need an equivalent vendor init-verb table, and could you
> share the appropriate verbs/coefficients? (conexant.c already writes one
> vendor coefficient for this family ― the 0x320/0x010 micbias comparator
> setting on nid 0x1c ― so I assume more such coefs exist.)
> 
> == Candidate patch, and offer to test ==
> 
> I drafted a minimal resume callback for conexant.c mirroring the pending
> senarytech one (below). It builds and loads fine on 6.17, but per finding
> (1) it cannot address the no-suspend cases, so I have reverted it pending
> your guidance on the init-verb question. I have a ready build/test pipeline
> for this machine and can turn any test patch around within a day.
> 
> --- a/sound/hda/codecs/conexant.c
> +++ b/sound/hda/codecs/conexant.c
> @@ -1269,6 +1269,21 @@
> return err;
> }
> 
> +/*
> + * The generic HDA resume path restores the register cache but does not
> re-run
> + * the codec's init sequence, so vendor-specific hardware state (widget
> power,
> + * converter/pin setup) can be lost after S3 resume, leaving capture and the
> + * internal speaker silent with the codec stuck in D3. Mirror the senarytech
> + * fix: on resume, re-sync the register cache, re-run init, and resync jacks.
> + */
> +static int cx_resume(struct hda_codec *codec)
> +{
> + regcache_sync(codec->core.regmap);
> + cx_init(codec);
> + snd_hda_jack_report_sync(codec);
> + return 0;
> +}
> +
> static const struct hda_codec_ops cx_codec_ops = {
> .probe = cx_probe,
> .remove = cx_remove,
> @@ -1277,6 +1292,7 @@
> .init = cx_init,
> .unsol_event = snd_hda_jack_unsol_event,
> .suspend = cx_suspend,
> + .resume = cx_resume,
> .check_power_status = snd_hda_gen_check_power_status,
> .stream_pm = snd_hda_gen_stream_pm,
> };

This patch shouldn't improve things, I suppose.  Basically it's as
same as the behavior without NULL resume callback; see
hda_codec_runtime_resume() in sound/hda/common/codec.c.


Takashi
