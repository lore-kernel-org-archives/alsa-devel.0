Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1B7CD342C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:30:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 884F260209;
	Mon,  4 May 2026 13:30:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 884F260209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894215;
	bh=+5ZSkjLpwF/N5g6fgp5cVdsPuMc6kvrQ/D++IAi4AJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=om3SNGTyFvpHPE6e8ihJ3oxLFXKPpbBfeqIhQJ4et8wvTpQPotiHxMICNpOHfl5Or
	 wI72OAo3p6DjO6Qomrmj4LT44eTl3ljzX347JCWiMEHrXet3CA5EF3lRWCGQCJZWMT
	 uNAGsV4NIAc28XlumQxFeffxe0x0vkUj1b1o+SN8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC68AF805E7; Mon,  4 May 2026 13:29:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EABFF805F1;
	Mon,  4 May 2026 13:29:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69517F8021D; Mon,  4 May 2026 13:29:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A48C8F800C1
	for <alsa-devel@alsa-project.org>; Mon,  4 May 2026 13:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A48C8F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=2M/Lfe/T;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0GyTb1M1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=2M/Lfe/T;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0GyTb1M1
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C43276B0EA;
	Mon,  4 May 2026 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1777894167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUj4I81ajz+AeL3gGD9TAC67O4nkgwF89j8Ou879sYM=;
	b=2M/Lfe/TB/zrMq8YaZarf8MySzSRaL2fRBGSSS0DwlxU0mDnWCKDsHNbvFUnbjKw2lTNHJ
	jvSrv798zqEBNt9pPwssjfsy3UoShPdtSaqpKDpYokCQxQ133TOGZeI47iiBGogHrP/8iE
	BDvKQEMB3ylBhI9rkGLKsMFhGCj3O28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777894167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUj4I81ajz+AeL3gGD9TAC67O4nkgwF89j8Ou879sYM=;
	b=0GyTb1M1sNQFxA5yJyY3Xaiq86mlXWKyiBZ6R1LUmIqqIgyiGC6kfHAtGlg0LLubs0CrxU
	O7G3j7Z9GE8WUBCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="2M/Lfe/T";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0GyTb1M1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1777894167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUj4I81ajz+AeL3gGD9TAC67O4nkgwF89j8Ou879sYM=;
	b=2M/Lfe/TB/zrMq8YaZarf8MySzSRaL2fRBGSSS0DwlxU0mDnWCKDsHNbvFUnbjKw2lTNHJ
	jvSrv798zqEBNt9pPwssjfsy3UoShPdtSaqpKDpYokCQxQ133TOGZeI47iiBGogHrP/8iE
	BDvKQEMB3ylBhI9rkGLKsMFhGCj3O28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777894167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUj4I81ajz+AeL3gGD9TAC67O4nkgwF89j8Ou879sYM=;
	b=0GyTb1M1sNQFxA5yJyY3Xaiq86mlXWKyiBZ6R1LUmIqqIgyiGC6kfHAtGlg0LLubs0CrxU
	O7G3j7Z9GE8WUBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CBB3593A3;
	Mon,  4 May 2026 11:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bB74JBeD+GnCHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 May 2026 11:29:27 +0000
Date: Mon, 04 May 2026 13:29:27 +0200
Message-ID: <87tssnxvjc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Anton Swart <anton.swart.jhb@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add quirk flags for AlphaTheta EUPHONIA
In-Reply-To: <20260503211517.14332-1-anton.swart.jhb@gmail.com>
References: <20260503211517.14332-1-anton.swart.jhb@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: C43276B0EA
Message-ID-Hash: P5ZDY7L4FLV7L5HY6JQ3JIT2GIIHEI47
X-Message-ID-Hash: P5ZDY7L4FLV7L5HY6JQ3JIT2GIIHEI47
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P5ZDY7L4FLV7L5HY6JQ3JIT2GIIHEI47/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 03 May 2026 23:15:17 +0200,
Anton Swart wrote:
> 
> The AlphaTheta EUPHONIA (VID 0x2b73, PID 0x0047) is a USB Audio
> Class 2 DJ mixer that requires implicit feedback for full-duplex
> operation. The capture endpoint (0x83 IN, interface 2) acts as the
> implicit feedback source for the playback endpoint (0x03 OUT,
> interface 1), and the device firmware does not send isochronous
> data on the capture endpoint unless the host is simultaneously
> sending data on the playback endpoint, i.e. playback must be
> started first.
> 
> Without QUIRK_FLAG_PLAYBACK_FIRST the kernel waits for capture URBs
> before submitting playback URBs, creating a deadlock: the device
> waits for playback data and the host waits for capture data.
> Without QUIRK_FLAG_GENERIC_IMPLICIT_FB the kernel does not detect
> the implicit feedback relationship between the two interfaces.
> 
> The same flag combination is already used for the Behringer UMC202HD,
> UMC204HD and UMC404HD (0x1397:0x0507/0x0508/0x0509), which exhibit
> the identical implicit-feedback topology.
> 
> Tested on Raspberry Pi 5 with kernel 6.12.75; continuous full-duplex
> streaming at 96 kHz / 24-bit, zero XRUNs.
> 
> Signed-off-by: Anton Swart <anton.swart.jhb@gmail.com>

Applied now.  Thanks.


Takashi
