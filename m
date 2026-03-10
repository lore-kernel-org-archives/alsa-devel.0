Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD545FCC9DE
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2026 08:33:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC7E5601E9;
	Tue, 10 Mar 2026 09:33:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC7E5601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773131620;
	bh=f81pAW2zwR7oqdLTPQ1x+sHJC6GOTfGX015wQYP9eGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mjMNW1ELLnUBzsRz6uBEJes/vVbieOKQymAfdX2DutWlyfh7sTAo0tXRba1O+9It+
	 Z6PzTIyQvX8rd8TFLHPuKs7kc+Nwi+mWesrTdV3snTywyQOUIJu5U4z5I5EokgqyMi
	 EFK+Rf+vPJBjf9qyt4/Y1Dvy9jbKaePSa+iKgIow=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D03DF805EE; Tue, 10 Mar 2026 09:33:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7499AF805ED;
	Tue, 10 Mar 2026 09:33:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29DE5F8053B; Tue, 10 Mar 2026 09:32:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CE910F802DB
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2026 09:32:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE910F802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=R0+J5Ynu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0DhkaTMx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=R0+J5Ynu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0DhkaTMx
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08B6E5BCCF;
	Tue, 10 Mar 2026 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1773131573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9PaSRDL+LoeYJygYCrzTcK+RLyPyVus0n/koED/N0E=;
	b=R0+J5YnuMJEpg/yctD68wV/63o8VV41q1D1l5XMR4E6yb/GQE8A8chIfrSFj/M+NlKLo4n
	g6SA2lt3HJz8HIMNO4pMxVLwdE70jcPypzdcvWWwMwx5uiyOXaoY5nWMJf/xi5nKPs7ngo
	AuwG0vQaQbS6Ygg2HZIxvoBwPbUVwDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773131573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9PaSRDL+LoeYJygYCrzTcK+RLyPyVus0n/koED/N0E=;
	b=0DhkaTMxOLw1ICQiP0PTpi2x8eDSc3xq5e03ZwNVwhZe+xOkL4zV3KWcelyaYZlHdNYFfM
	z8fwnAtthsKTKSAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1773131573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9PaSRDL+LoeYJygYCrzTcK+RLyPyVus0n/koED/N0E=;
	b=R0+J5YnuMJEpg/yctD68wV/63o8VV41q1D1l5XMR4E6yb/GQE8A8chIfrSFj/M+NlKLo4n
	g6SA2lt3HJz8HIMNO4pMxVLwdE70jcPypzdcvWWwMwx5uiyOXaoY5nWMJf/xi5nKPs7ngo
	AuwG0vQaQbS6Ygg2HZIxvoBwPbUVwDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773131573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9PaSRDL+LoeYJygYCrzTcK+RLyPyVus0n/koED/N0E=;
	b=0DhkaTMxOLw1ICQiP0PTpi2x8eDSc3xq5e03ZwNVwhZe+xOkL4zV3KWcelyaYZlHdNYFfM
	z8fwnAtthsKTKSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF6D33F371;
	Tue, 10 Mar 2026 08:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WiVOMTTXr2kIGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Mar 2026 08:32:52 +0000
Date: Tue, 10 Mar 2026 09:32:52 +0100
Message-ID: <871phsrsnf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Bethmont <jeremy.bethmont@gmail.com>
Cc: Kailang Yang <kailang@realtek.com>,
	alsa-devel@alsa-project.org,
	regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC287)
 after commit d2e01e0c5e94
In-Reply-To: 
 <CAC88DfvjQvZvdvGdZ00woMymE2tUWk=2Dbqi3EzuzSHxGjEnzw@mail.gmail.com>
References: 
 <CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com>
	<87a4wgrxil.wl-tiwai@suse.de>
	<CAC88DfvjQvZvdvGdZ00woMymE2tUWk=2Dbqi3EzuzSHxGjEnzw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
Message-ID-Hash: SGQF2OTZ5Z5KHUJUFR4Z56WSLSDS6T5I
X-Message-ID-Hash: SGQF2OTZ5Z5KHUJUFR4Z56WSLSDS6T5I
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SGQF2OTZ5Z5KHUJUFR4Z56WSLSDS6T5I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 10 Mar 2026 09:24:38 +0100,
Jérémy Bethmont wrote:
> 
> Hi Takashi,
> 
> Thank you for looking into this so quickly.
> 
> As requested, I have attached the output of `alsa-info.sh --no-upload`
> from my machine.
> 
> Please let me know if you have a proposed patch you would like me to
> test. I am happy to build it and verify if it resolves the popping on
> my hardware.

I guess dropping the alc_process_coef_fw(codec, en_coefs) call at
closing would fix your problem while keeping the one at open.
But I'm not sure about any side-effect by that.
Kailang, could you check this?

BTW, when you disable runtime PM, does the pop noise still appears?


thanks,

Takashi

> 
> Best regards,
> Jeremy
> 
> On Tue, 10 Mar 2026 at 13:47, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Tue, 10 Mar 2026 01:01:11 +0100,
> > Jérémy Bethmont wrote:
> > >
> > > Hi Takashi, Kailang,
> > >
> > > I am reporting an audio regression introduced in kernel 6.18.13 on the
> > > Lenovo ThinkPad X1 Carbon Gen 12 (Meteor Lake, Realtek ALC287 codec,
> > > SSID: 0x17aa231e).
> > >
> > > Since this update, the laptop emits a short, noticeable hardware
> > > pop/blip from the speakers exactly when an audio stream closes and the
> > > PCM state suspends. It happens consistently a few seconds after
> > > playback finishes (e.g., after a system notification or terminal
> > > bell).
> > >
> > > I have tracked the regression down to the following commit:
> > > d2e01e0c5e947da0b5005ca89efa82baeb232adc ("ALSA: hda/realtek - fixed
> > > speaker no sound")
> > >
> > > #regzbot introduced: d2e01e0c5e947da0b5005ca89efa82baeb232adc
> > >
> > > Root cause analysis:
> > > The commit modifies the `alc287_alc1318_playback_pcm_hook` function,
> > > adding raw COEF writes to disable/enable AMP silence detection on
> > > HDA_GEN_PCM_ACT_OPEN and HDA_GEN_PCM_ACT_CLOSE.
> > >
> > > Because `alc287_alc1318_playback_pcm_hook` is a shared hook used by
> > > multiple Lenovo ALC287/ALC1318 devices, these unconditional
> > > `WRITE_COEF` instructions are being sent to hardware that does not
> > > need the silence detection fix. On the X1 Carbon Gen 12, executing
> > > `alc_process_coef_fw(codec, en_coefs)` upon stream close triggers an
> > > immediate electrical pop. Monitoring with `pw-mon` confirms the
> > > hardware pop coincides perfectly with the monitor_FR / monitor_FL
> > > ports going idle/suspended.
> > >
> > > Proposed solution:
> > > Could we revert this commit, or alternatively, wrap these specific
> > > silence-detection COEF writes in a targeted `ALC287_FIXUP` quirk
> > > matched via SSID/DMI, rather than executing them globally in the
> > > shared playback hook?
> >
> > Could you give alsa-info.sh output?  Run the script with --no-upload
> > option and attach the output.
> >
> > I guess the bug might not be specific to your device but happening in
> > general with all matching ones.  As a workaround for such a pop noise,
> > we often need to reorder verbs or put some delay between verbs.
> >
> >
> > Takashi
> 
> 
> 
> -- 
> Jérémy Bethmont
> 
