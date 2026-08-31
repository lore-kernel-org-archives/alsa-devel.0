Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D25C624A4
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:12:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E9F9601C0;
	Mon, 31 Aug 2026 16:12:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E9F9601C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788185548;
	bh=kZuK65S3qiQN1d6B7wQJIZw/KPbqdkhrrSpFSVpUukw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Qi35xk4KQikEGnfV7W0WRTLAX12Jh37vo0M3BjgyQS/J5SygEYoawqeQg6OWzbUwd
	 6htRNPJFGfNxWEDUYK/TFXBTi9IY2TITOuGxqq9erAxmnaD/usRD60dwxi8SAGUeAj
	 RcqaON9rO13BRk7QPptFwGObkFybkTCtbtVjIuk4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E2FFF805F9; Mon, 31 Aug 2026 16:11:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CA65F8058C;
	Mon, 31 Aug 2026 16:11:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CF61F8051F; Mon, 31 Aug 2026 16:11:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788185502;
	b=aQaQsPptvYXj+S86KO5/RMCNZ1YuEaQFblkWKibx9HkC7r3loCtBiWFYKcKSs6I+a1cj
	 D10coP5GqdarFzrd5jTNE93LK88n5fYaMS4qroG8XL51mKviP0Ly74BDYYg8uD0wMr+AH
	 xah5KRzHuLwGiBS15NwMRfS9/QIa8YaNulUNajygtjfuUR1rleO2TFhgF6weLINX3G9xA
	 BVV/E47HuZDOrFNVRzBj2gsGTzbj/bTKmGGcwhLFIL2KFGYhFKB9T4XmFDpQhvUneboGv
	 wOr2N01AePN3wBtNc6r3KYVIMw6WA0fX6poxp8T7xlXDMY3Wbep0/OUHVGpYIiUqbKQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788185502;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=kZuK65S3qiQN1d6B7wQJIZw/KPbqdkhrrSpFSVpUukw=;
	b=jCaqpAyU66R+Bohh8KbaqB6yIeffFHAO8Y2IcwesGc1zk2H97EgMpqoIwtSNUvDC31vN
	 x0qthQH3CbJgVCESkujcu5YuJq4QNsXIFJ3N1UOTL8sJzySllWybCTq5MOe4XHYk4rGFF
	 RlrO1L2F7xWgGWYrjPtzPjpEdyhFawoEcKaBKJwTDC1q8fwrDPZPCbj2tWLHwV+2YtdD5
	 jOMxY2ExW9OgfiG7oUcZzHiswaxV4cVgHUMdBXZYNRJ0jcvsO6uxpcBht1il6HdfllCut
	 ysGbjEM21RwX5P1humT2eXJ9rZxruzd0n1hXCXn3XvYizwEZTFFqoTOLZgGjz3ImcLg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=KJQ+yRSG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0Q9QZVjp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=TweVIAPz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ETZCPRp5;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D572FF80071
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2026 16:11:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D572FF80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=KJQ+yRSG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0Q9QZVjp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=TweVIAPz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ETZCPRp5
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA95022692;
	Mon, 31 Aug 2026 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788185497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6efP7egJcef8/z70G8RfBRcfOEPgG6p72QXBgc565yg=;
	b=KJQ+yRSG3ffqJ7W1NyotlubEwe9GTUT/A5Lsqf7hxzmFgx+C+JObhtuXRDUX6oBpWv96O7
	xBDfuhzi6qbSdnhYycgfZSiP5CusWTEjsKg5ePlQmctgzlVzfQWexl8yCWHpNpHt67ODAb
	Z1GZfXdDYuXauCCLPTOd6uWox6StaWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788185497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6efP7egJcef8/z70G8RfBRcfOEPgG6p72QXBgc565yg=;
	b=0Q9QZVjpVix7reuvVAJft283KKOgnioAgAh011WqcjsTqsoulTPGZKSJ7f11l6Rut+hs+4
	xZ9/trT7PcDLX+Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TweVIAPz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ETZCPRp5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788185492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6efP7egJcef8/z70G8RfBRcfOEPgG6p72QXBgc565yg=;
	b=TweVIAPz8mn/mxHjIvwMewe68X3r9OJJzkZywBMHwj+B5wLQmCepVgp+Kr3q2EJivWjsp8
	sRjFwZCkGoXWkRbV5YpogJoQyeMV2HMN+4kcx8rbcJ3dF8vytYzUIRSljayVG40J9Mn3en
	pJaOE7LovSZoJDrnk7w/T0M6CQzEoAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788185492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6efP7egJcef8/z70G8RfBRcfOEPgG6p72QXBgc565yg=;
	b=ETZCPRp58c+f7QkZjaCBxo0Tw/d6nKv57/CeMJPIi5t/hLVXSZ57y0KDHEVA+66+tSdgRe
	hVyvV++79En6d2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A00D413685;
	Mon, 31 Aug 2026 14:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xwHSJZSLlWoobQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 31 Aug 2026 14:11:32 +0000
Date: Mon, 31 Aug 2026 16:11:32 +0200
Message-ID: <87h5kafkh7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Isma=EFl?= Bahloul <i.bahloul01@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] RME Babyface Pro FS driver (proprietary mode)
In-Reply-To: <20260829100333.32933-1-i.bahloul01@gmail.com>
References: <20260829100333.32933-1-i.bahloul01@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EA95022692
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
Message-ID-Hash: AURTS2AQLNE3QV6CEHBSK4YWYCR4IWUL
X-Message-ID-Hash: AURTS2AQLNE3QV6CEHBSK4YWYCR4IWUL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AURTS2AQLNE3QV6CEHBSK4YWYCR4IWUL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 29 Aug 2026 12:03:32 +0200,
Ismaïl Bahloul wrote:
> 
> Hi,
> 
> I'm sending this as an RFC for a driver I've been working on for the
> RME Babyface Pro FS in its proprietary USB mode (VID 0x2a39, PID
> 0x3fc0). In that mode the PCM stream runs on interrupt endpoints
> (interface 5, ep 0x01 OUT / 0x82 IN) instead of the class-compliant
> isochronous path, so it can't be handled as a quirk on top of
> snd-usb-audio. It needs a standalone driver, and I modeled it on
> snd-usb-caiaq, which is the existing in-tree precedent for
> interrupt-based USB audio streaming. The driver is hardware-validated
> on a real unit and the code is checkpatch, sparse and W=1 clean.
> 
> The vendor protocol (control requests, register map, front-panel
> readback) was reverse-engineered from Windows USB captures and
> verified bit by bit on hardware. The capture analysis, the calibrated
> laws, and a userspace reference implementation live in the sibling
> TuxMix repo (https://github.com/ismail-bahloul/TuxMix). This driver is
> the kernel side of that effort.
> 
> What's included:
> 
>  - Interrupt-URB PCM streaming, full-duplex, 2-12 channels, S24_LE,
>    9 sample rates from 32 to 192 kHz across 3 USB bandwidth classes.
>  - ALSA mixer: 6 output masters and mutes, the 6x14 crosspoint routing
>    matrix, 4 mic/instrument preamp gains with phantom power and PAD,
>    pitch/varispeed, loopback, and a few device-specific toggles
>    (AN 1>2, input link, MS processor, DIM, width, FX send).
>  - Front-panel emulation. The unit has no onboard DSP for its own
>    panel, so the host mirrors TotalMix's role: it translates physical
>    wheel/button events into mixer writes and exposes the decoded panel
>    state as read-only ALSA controls.
>  - A hardware 3-band plus low-cut parametric EQ for the 4 analog-input
>    strips, computed in fixed-point (no FPU use) and uploaded as
>    coefficient blocks.
>  - Mixer-state persistence across interface re-probes and system
>    suspend/resume, because the firmware has no state readback of its
>    own.
> 
> Validation: a full-duplex sweep across the whole rate x period matrix
> with a signal-integrity tap, start/stop stress (30 cycles), mixer-state
> restore across an interface unbind/rebind, and a mid-stream disconnect.
> All of that runs through the automated regression suite kept in the
> driver's development tree.
> 
> Known limitations, stated up front:
> 
>  - USB autosuspend is not supported yet. I disable it explicitly
>    (usb_disable_autosuspend at probe, balanced at disconnect) rather
>    than ship something untested. The front-panel poll and keepalive
>    work items run continuously, and nothing pairs usb_autopm_get/put
>    around the stream, so an autosuspend request could race a live
>    stream. S3 suspend/resume works and is tested. Full autosuspend
>    (pausing the panel/keepalive work plus autopm pairing) is a
>    follow-up.
>  - A few protocol items aren't fully pinned down, but they don't affect
>    the shipped controls; the relevant paths are hardware-verified. They
>    are documented as open in PROTOCOL.md: the preamp readback index
>    semantics (0x003F vs 0x0000), a width strip-ownership edge case, and
>    the exact high-frequency warping of the EQ coefficient computation
>    versus TotalMix's curve.
>  - The latency profile is selected at load time via the frames_per_urb
>    and nurbs module params. Default is 256 frames/URB, matching
>    TotalMix's 256-sample buffer; frames_per_urb=16 nurbs=16 gives a
>    0.33 ms monitoring-grade floor. Changing profile currently means a
>    module reload. A runtime reconfiguration (like RME's own Fireface
>    USB Settings panel) is a post-merge follow-up.
> 
> This is an RFC. I'm mainly after feedback on the interrupt-URB PCM
> design, the control naming and topology, the two-file split, and
> whether a subdirectory (sound/usb/babyfacepro/) is the right layout.
> I sent it as a single patch (4651 lines, 7 files) because that's how a
> wholesale new-driver addition is usually submitted, but I can split it
> into a series if that's preferred.

Splitting would be better in general for this level of the code size,
yes.  It'll make easier to review.

About the basic code design: do we have to handle the volume
conversions in the driver?  Doing such in the kernel driver is usually
avoided as much as possible.

The use of interrupt EPs should be fine, as long as it actually works.
The implementation with work might need more consideration, though.

BTW, is the code generated / assisted via LLM?  Or is it purely
written by you alone?  If LLM is used for coding, please add a proper
Assisted-by tag.


thanks,

Takashi
