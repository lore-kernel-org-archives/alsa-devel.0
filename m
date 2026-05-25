Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C855ACD5BBF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 07:45:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0861A60218;
	Mon, 25 May 2026 09:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0861A60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779695145;
	bh=OKFhFiWUPttNZ/hpn8HTcj75G6qa5/cUWPI0mhEvbNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=knxxnVZeA0uRPuGLa5ESLC9Xogz5Ds6S7wx3KGrn4Vdc54IqKPfPCImuH1pIurNXV
	 l0V4IKJDvTWXfbV4y65VBAjDzT/ljbfs0+euMPQi9wQOt0y7khdoUeFoPsXjvTs547
	 vq35aUDqHVW4YCyP63GwP9VXHkk4T2GPBQZ8ghC0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63CFDF805F6; Mon, 25 May 2026 09:45:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF0AAF800B6;
	Mon, 25 May 2026 09:45:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD838F80588; Mon, 25 May 2026 09:45:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 910EEF8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 09:45:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 910EEF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=jNl4s4O7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=UMRoQTNt;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=jNl4s4O7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=UMRoQTNt
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EB0E6C50F;
	Mon, 25 May 2026 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779693701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gF3Bv0s8CIvcKl4ZslYm90Eb8ChVK/ny0grorrH7hI=;
	b=jNl4s4O7kaqlAatPIF5eQmAOmmASTwRDWJZXZziINv5Zr08yrUAROQKjkn9JCBlQeXebHT
	6Mls4YQWFL53yig7wOEaHvG1BT1t9KkItUiW9Hh6jfCmZwatx4L+mlxvliWsNBt0pPS5Q+
	W3o/csH46XeQFR7k7th5BdTIXDitTS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779693701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gF3Bv0s8CIvcKl4ZslYm90Eb8ChVK/ny0grorrH7hI=;
	b=UMRoQTNt4WAfe1hmGTjoAZEqp+KWTtsiKnjja+aNundJ50eJ3Wng61J6D8sBQszD5ctbC8
	V6goKDJhFSvgBYAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779693701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gF3Bv0s8CIvcKl4ZslYm90Eb8ChVK/ny0grorrH7hI=;
	b=jNl4s4O7kaqlAatPIF5eQmAOmmASTwRDWJZXZziINv5Zr08yrUAROQKjkn9JCBlQeXebHT
	6Mls4YQWFL53yig7wOEaHvG1BT1t9KkItUiW9Hh6jfCmZwatx4L+mlxvliWsNBt0pPS5Q+
	W3o/csH46XeQFR7k7th5BdTIXDitTS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779693701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gF3Bv0s8CIvcKl4ZslYm90Eb8ChVK/ny0grorrH7hI=;
	b=UMRoQTNt4WAfe1hmGTjoAZEqp+KWTtsiKnjja+aNundJ50eJ3Wng61J6D8sBQszD5ctbC8
	V6goKDJhFSvgBYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8052859B04;
	Mon, 25 May 2026 07:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8AAOHoX4E2p7EQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 25 May 2026 07:21:41 +0000
Date: Mon, 25 May 2026 09:21:41 +0200
Message-ID: <87fr3ggdiy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kris Kater <kris@kater.nu>
Cc: Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add HDA_CODEC_QUIRK for Lenovo Yoga
 Slim 7 14AGP11
In-Reply-To: <20260522060902.9423-1-kris@kater.nu>
References: <20260522060902.9423-1-kris@kater.nu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	internal_greylist_whitelist(0.00)[10.150.64.97];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: DCFMHMGUJGQGEP3KRVPXNGZHHQ3PHLF5
X-Message-ID-Hash: DCFMHMGUJGQGEP3KRVPXNGZHHQ3PHLF5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DCFMHMGUJGQGEP3KRVPXNGZHHQ3PHLF5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 22 May 2026 08:09:02 +0200,
Kris Kater wrote:
> 
> The BIOS on the Lenovo Yoga Slim 7 14AGP11 (AMD Ryzen AI / Kraken
> Point chassis; board LNVNB161216, product 83QS) programs the PCI
> subsystem ID of the HDA function as 17aa:0000. As a result no entry
> in alc269_fixup_tbl[] matches via SND_PCI_QUIRK, the fixup falls back
> to the generic auto-routing path, and the bass speaker pin is left
> mis-routed. Laptop speakers sound noticeably thin.
> 
> The codec's own internal subsystem ID register reports 0x17aa394c
> correctly, so an HDA_CODEC_QUIRK entry (which matches on the codec
> SSID rather than on the PCI SSID) binds the chassis to the existing
> ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN fixup. This mirrors the same
> workaround already in place for the closely-related Yoga 7 2-in-1
> 14AKP10 and 16AKP10 entries earlier in the table.
> 
> With this change the kernel log goes from
> 
>   ALC287: picked fixup  for PCI SSID 17aa:0000
> 
> to
> 
>   ALC287: picked fixup alc287-yoga9-bass-spk-pin
> 
> and speaker routing matches what the firmware intended. Verified by
> the reporter against the equivalent modprobe override
> (model=,alc287-yoga9-bass-spk-pin).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221438
> Signed-off-by: Kris Kater <kris@kater.nu>

Applied now.  Thanks.


Takashi
