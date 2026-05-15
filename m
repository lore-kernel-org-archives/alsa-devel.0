Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA5CCD343F
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 12:56:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DF0D601EB;
	Fri, 15 May 2026 14:55:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DF0D601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778849762;
	bh=jr841fFO7Rl84q/39MPhnatZExKbfPaiIEgefnhTO5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=f6eaPJbhVs02M7q3WH0/yvqFpS+EFe18kZHDu3in/thfzz4ATWCGsBe+BW29PJdYk
	 YKpTe+kQbt2s6vHlTRczbNhzPAU1qYFqGVDPbQ2Z/LnIrjZKGo23zDf+Zg3PCaDomH
	 4gXxD5fv7+qZOw9o7ET+jzdnqOqI8iGu1gdhoL5M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C120F805ED; Fri, 15 May 2026 14:55:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FDBAF805EA;
	Fri, 15 May 2026 14:55:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3260F80557; Fri, 15 May 2026 14:55:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5641BF800BD
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2026 14:55:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5641BF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gXHm9udT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Ql+Nrce5;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=I/Hs4aur;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gbZ2vMWv
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69FCD63136;
	Fri, 15 May 2026 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778849714;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOh34rapuSm8hb4WUj6Q4YlI+891WbtK1vwjkswkEos=;
	b=gXHm9udTUZEGoxtlIV7/y5RS+VhZz3SF+dys0AEW1lkHvfsZrtIP+uNdK3Sb+66zMQ39nS
	lKdwUev81YmLua4FCnPqDmxgrPrAujEHLgrBDCtEggSzb7iycnT10CgFvkUiJGB70Fy9MB
	wQbTMfPX4x5pxqJwYd8qYGcwDXKjEvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778849714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOh34rapuSm8hb4WUj6Q4YlI+891WbtK1vwjkswkEos=;
	b=Ql+Nrce5CMc2McHFuYaabi0+h1yWHBl8htpBkJatNvP/Ba0ivD2gWugvRet3I1c7kvwwNh
	cRr2+C3iRinSaAAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="I/Hs4aur";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gbZ2vMWv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778849713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOh34rapuSm8hb4WUj6Q4YlI+891WbtK1vwjkswkEos=;
	b=I/Hs4aurV4I65NRq1pA2KRJ8UICy5Ogzi4PUeGs8xIoEVF7NZhVrw7xu0cuMOhfPaLAT5b
	B7LoQpksQFuHIzNGYodPbRJj84IFfdPwIsRpRchCmHwmgcDewZgV123+CB03DuUJzM96af
	OmO2+UvOBNSVR2wcGeHrj19X5ZJ6s9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778849713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOh34rapuSm8hb4WUj6Q4YlI+891WbtK1vwjkswkEos=;
	b=gbZ2vMWvji/1cJ4RFvxDMAB/iEMgkuYj9mwVZmWMaVWx4Yds7MDJHSbxX0Nvpuytpc+DjO
	1fzauOhr8/s3umAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35FD1593A9;
	Fri, 15 May 2026 12:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6rFmC7EXB2rASAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 12:55:13 +0000
Date: Fri, 15 May 2026 14:55:12 +0200
Message-ID: <87se7ssuhb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Eric Naim <dnaim@cachyos.org>
Cc: Rob Blake <rob@losource.net>,
	alsa-devel@alsa-project.org,
	kailang@realtek.com,
	baojun.xu@ti.com
Subject: Re: equest to upstream: ALC287_FIXUP_TXNW2781_I2C quirk for ASUS
 Strix Gxx5 family (CachyOS commit 20313d76)
In-Reply-To: <66390566-61ce-4d9f-9f7f-b5a66c8468ab@cachyos.org>
References: <59fd4aa4-76b9-4984-8db9-a60e55ec6e80@losource.net>
	<7650fdea-6b8a-4116-9560-ac6b2f6c54b1@cachyos.org>
	<87o6iht559.wl-tiwai@suse.de>
	<7e8c59c5-8459-4c74-9d32-d3b3b66210fc@cachyos.org>
	<66390566-61ce-4d9f-9f7f-b5a66c8468ab@cachyos.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,cachyos.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 69FCD63136
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Message-ID-Hash: XCIFQMSJJWW2EC3NSYOMM65DN6FNUUAB
X-Message-ID-Hash: XCIFQMSJJWW2EC3NSYOMM65DN6FNUUAB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XCIFQMSJJWW2EC3NSYOMM65DN6FNUUAB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 15 May 2026 14:52:00 +0200,
Eric Naim wrote:
> 
> On 5/15/26 8:40 PM, Eric Naim wrote:
> > On 5/15/26 5:04 PM, Takashi Iwai wrote:
> >> On Wed, 13 May 2026 11:24:00 +0200,
> >> Eric Naim wrote:
> >>>
> >>> On 5/12/26 9:50 PM, Rob Blake wrote:
> >>>> Hi all,
> >>>>
> >>>> I'm writing to ask whether the small fixup-table change below can be picked up
> >>>> for mainline. It's already in CachyOS's downstream tree since 2026-03-06 and
> >>>> is reported to restore speaker audio on an
> >>>> entire family of recent ASUS ROG Strix laptops, including mine.
> >>>>
> >>>> The relevant commit is by Eric Naim <dnaim@cachyos.org>:
> >>>>
> >>>>   CachyOS commit 20313d767be2e5abdb88295b7c724634e1937a4f
> >>>>   "ALSA: hda/realtek: Use ALC287_FIXUP_TXNW2781_I2C for ASUS Strix Gxx5"
> >>>> https://github.com/CachyOS/linux/commit/20313d767be2e5abdb88295b7c724634e1937a4f
> >>>>
> >>>> The change is a six-line edit to sound/hda/codecs/realtek/alc269.c: the
> >>>> affected SSIDs are currently mapped to ALC287_FIXUP_TAS2781_I2C but actually
> >>>> need ALC287_FIXUP_TXNW2781_I2C. The wrong quirk leaves the I²C interrupt
> >>>> config inconsistent with the ACPI TXNW2781 entry, so serial-multi-instantiate
> >>>> fails to resolve IRQ index 0 for each of the three amp channels, and only the
> >>>> first channel binds.
> >>>>
> >>>> SSIDs affected (per Eric's patch):
> >>>>   0x1043 0x3ee0  ASUS Strix G815_JHR_JMR_JPR
> >>>>   0x1043 0x3ef0  ASUS Strix G635LR_LW_LX
> >>>>   0x1043 0x3f00  ASUS Strix G815LH_LM_LP
> >>>>   0x1043 0x3f10  ASUS Strix G835LR_LW_LX
> >>>>   0x1043 0x3f20  ASUS Strix G615LR_LW   <-- my machine
> >>>>   0x1043 0x3f30  ASUS Strix G815LR_LW
> >>>>
> >>>> On my G615LW (SSID 1043:3f20) running kernel 6.19.14-101.fc44, the
> >>>> broken state matches Eric's commit log exactly:
> >>>>
> >>>>   Serial bus multi instantiate pseudo device driver TXNW2781:00: error -ENXIO:
> >>>> IRQ index 0 not found
> >>>>   Serial bus multi instantiate pseudo device driver TXNW2781:00: error -ENXIO:
> >>>> IRQ index 0 not found
> >>>>   Serial bus multi instantiate pseudo device driver TXNW2781:00: error -ENXIO:
> >>>> IRQ index 0 not found
> >>>>   Serial bus multi instantiate pseudo device driver TXNW2781:00: Instantiated
> >>>> 3 I2C devices.
> >>>>
> >>>> with .0 binding to tas2781-hda and .1/.2 staying at driver=NONE.
> >>>> Speakers are silent. Headphones work (they're on a separate codec pin and
> >>>> don't involve TAS2781).
> >>>>
> >>>> I've ruled out asusd as the cause — I rebooted with asusd masked and the
> >>>> failure is identical, so this is purely codec-quirk-table business.
> >>>>
> >>>> Original upstream report:
> >>>> https://lore.kernel.org/
> >>>> CACB9z7kjs8rhLstEc8fV29BCTb5dd881JwGozoKdO5cwCb=YwQ@mail.gmail.com
> >>>>
> >>>> CachyOS issue with discussion:
> >>>>   https://github.com/CachyOS/linux-cachyos/issues/752
> >>>>
> >>>> I'm not a kernel developer and don't feel qualified to submit Eric's patch on
> >>>> his behalf. Could one of you (or Eric, if you're on this list) take a look and
> >>>> consider sending it for inclusion? It's a self-contained six-line change that
> >>>> fixes audio for a sizeable family of shipping laptops, and the patch is
> >>>> already authored and signed-off.
> >>>>
> >>>> Happy to test patches against my G615LW.
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Rob
> >>>>
> >>>
> >>> Hi Rob,
> >>>
> >>> I've sent this patch 2 months ago [1]. I never got a reply from Baojun so I
> >>> myself am unsure as to how to proceed, cc'ing them here to hopefully get a reply.
> >>>
> >>> [1] https://lore.kernel.org/linux-sound/20260315160939.191265-1-dnaim@cachyos.org/
> >>
> >> Indeed.  If no further followup appears, I'm going to pick up Eric's
> >> v2 patch in the next week.
> >>
> >>
> > 
> > Glad to hear that! I haven't sent any v2, but I will do so in the next few
> > days. I assume here the v2 will only cover the 2 confirmed misbehaving devices
> > instead of the full 6 in the first iteration, yes?
> 
> As luck would have it, I just got a report from another distro maintainer that
> PID 0x3f30 also needs the fix, in addition to the confirmed 0x3f20 and 0x3ef0.
> 
> This makes me think that the original patch should be kept as-is. Thoughts?

Whatever you prefer.  Just send the latest versions to be picked up.


thanks,

Takashi
