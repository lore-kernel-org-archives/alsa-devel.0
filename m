Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51643109B475
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:22:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A1C2601F3;
	Tue, 31 Mar 2026 16:22:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A1C2601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774966962;
	bh=K/xpecWapzKDEvEJbg95c+TbC5WJjc/1RGLgQrg0pdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RX3EhrnotoY9cO1El3TOEefO8Rc24v8XlG3vLvyiOOtw6EFOcoAKzOt1LoT5UjJ0W
	 SCTOBsrlKjJ4BIwu/e3XafazF4sRgqIaBZAyaEPTp74aDUey5ELQvOA8njxg3UpMHG
	 omJbod6jeCF3tDpMu2cKAI047/AZ+1rBgejVxqLU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4EFF0F805E1; Tue, 31 Mar 2026 16:22:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CB255F805E5;
	Tue, 31 Mar 2026 16:22:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCE6CF80549; Tue, 31 Mar 2026 16:22:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 74792F804CC
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 16:21:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74792F804CC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=BIbLZANY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=xVI1Q0Pc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=BIbLZANY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=xVI1Q0Pc
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B81C84D27A;
	Tue, 31 Mar 2026 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774966914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8T52YgKF5svVVGrf60J6QzIkopA/0uigCBjh2rdWn3E=;
	b=BIbLZANYISmSZG1Ry++YSqcDeXLVlA+4WZdKlpLrEJ+GV7X+NIfLCVkyzqZleTQDQ1Spqp
	0wn1CRCy3khrucZY9XGH9AGQoLziZhIo3tc52kmosLMWejceGdCbX7Fi1xUeyBBiD3gdz6
	l0cBh14ce6oCv0VQXTKLqTGpUlVyVsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774966914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8T52YgKF5svVVGrf60J6QzIkopA/0uigCBjh2rdWn3E=;
	b=xVI1Q0PcsscvkePJEnCEJ5CT54552tx2a3JZW2JD0bBMG73NEey64tAzkNxPmcDZPVEjoN
	8BbaEG4v0hLFb8BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774966914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8T52YgKF5svVVGrf60J6QzIkopA/0uigCBjh2rdWn3E=;
	b=BIbLZANYISmSZG1Ry++YSqcDeXLVlA+4WZdKlpLrEJ+GV7X+NIfLCVkyzqZleTQDQ1Spqp
	0wn1CRCy3khrucZY9XGH9AGQoLziZhIo3tc52kmosLMWejceGdCbX7Fi1xUeyBBiD3gdz6
	l0cBh14ce6oCv0VQXTKLqTGpUlVyVsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774966914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8T52YgKF5svVVGrf60J6QzIkopA/0uigCBjh2rdWn3E=;
	b=xVI1Q0PcsscvkePJEnCEJ5CT54552tx2a3JZW2JD0bBMG73NEey64tAzkNxPmcDZPVEjoN
	8BbaEG4v0hLFb8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5C634A0A2;
	Tue, 31 Mar 2026 14:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1V/UJ4LYy2mUEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 31 Mar 2026 14:21:54 +0000
Date: Tue, 31 Mar 2026 16:21:50 +0200
Message-ID: <87bjg4rse9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alexander Savenko <alex.sav4387@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IMH9
In-Reply-To: <20260331082929.44890-1-alex.sav4387@gmail.com>
References: <20260331082929.44890-1-alex.sav4387@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: VTCFKB5LXJ4JET4QEQNUUZ247STMQQLB
X-Message-ID-Hash: VTCFKB5LXJ4JET4QEQNUUZ247STMQQLB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VTCFKB5LXJ4JET4QEQNUUZ247STMQQLB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 31 Mar 2026 10:29:28 +0200,
Alexander Savenko wrote:
> 
> The Lenovo Yoga Pro 7 14IMH9 (DMI: 83E2) shares PCI SSID 17aa:3847
> with the Legion 7 16ACHG6, but has a different codec subsystem ID
> (17aa:38cf). The existing SND_PCI_QUIRK for 17aa:3847 applies
> ALC287_FIXUP_LEGION_16ACHG6, which attempts to initialize an external
> I2C amplifier (CLSA0100) that is not present on the Yoga Pro 7 14IMH9.
> 
> As a result, pin 0x17 (bass speakers) is connected to DAC 0x06 which
> has no volume control, making hardware volume adjustment completely
> non-functional. Audio is either silent or at maximum volume regardless
> of the slider position.
> 
> Add a HDA_CODEC_QUIRK entry using the codec subsystem ID (17aa:38cf)
> to correctly identify the Yoga Pro 7 14IMH9 and apply
> ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN, which redirects pin 0x17 to
> DAC 0x02 and restores proper volume control. The existing Legion entry
> is preserved unchanged.
> 
> This follows the same pattern used for 17aa:386e, where Legion Y9000X
> and Yoga Pro 7 14ARP8 share a PCI SSID but are distinguished via
> HDA_CODEC_QUIRK.
> 
> Link: https://github.com/nomad4tech/lenovo-yoga-pro-7-linux
> Tested-by: Alexander Savenko <alex.sav4387@gmail.com>
> Signed-off-by: Alexander Savenko <alex.sav4387@gmail.com>

Applied now.  Thanks.


Takashi
