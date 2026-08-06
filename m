Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C964AC56208
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:49:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3EE96023A;
	Thu,  6 Aug 2026 11:49:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3EE96023A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786009758;
	bh=1pGX56+sYlNPgx3Pkk5ShNWOac8rMgntgYGbnC0FIEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EGC/GxMCDXSkRFYbQC9a4fNXdkOPzkZ+wcCURvdoguWm05tOExZUcKaLQ+8DplvVm
	 lP4U9SVDXqbPttnK2TogeIQ++efzFelbls5aXHQA2bk0srdi1k2GKcUrA/rO0iL23W
	 OUO3n0RWcOlmZYjgziHpp4h+UnLbQWNK9/N5AFV8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9DB8DF80600; Thu,  6 Aug 2026 11:48:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24885F805F3;
	Thu,  6 Aug 2026 11:48:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EA02F8055A; Thu,  6 Aug 2026 11:48:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786009714;
	b=SFfVwRJDIdD0vHSzromq5fFMiGNEOCfuGWrqmSir15agTxnjc/xVWyZK3EaI2IRnTduQ
	 4eAV1SHrLK5UQDAeMUkxZpLgil4uNMNxRpEMLzB3ZTEh6y3yHKLertT8GlkMY3M0Fi4W8
	 xVUL3Mk63StDRAmRFIsKi1v1yJ9Ipqv27NqkiUzSnM3vBIfSzNoqSqDhocv/S7C1zQmp4
	 xwXMuwGIJGM3Invh5e1QzNSD+enuqE2yfnn01+ecSreXWPnSkodLIBuL1Fdd4+a5rUYSc
	 sWUqtoB7ceLW2U/rGN6zCvthTymYUZmWbh5v9L4TPvr1PV/0wFmbZxi9QrkABSvPAGw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786009714;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=1pGX56+sYlNPgx3Pkk5ShNWOac8rMgntgYGbnC0FIEY=;
	b=C0wX5sIwS+TLel8eCM8vbDb6oG9ILX7+KkHn6X8bDco3C0EuX9rapq/mjBN9uKvVL26u
	 VAYqOnzFl0PVUU+/APRkybShMkSLH+Oyeck+qVrOOauPuF/Gq7wGnytadxI+ra1W/nYxb
	 S4ZgW1wuDz6OFOKe5BO6bdIsWDM6hMaemFIbWN5nB0RCGnIRhK7yD+wwRaPC0iRsFNdp1
	 0FyT6v7FjWuzein3s+h8GNLA/Q+tIWpXTxC2D3TEBypB0Iy4k4rPC0ynoQgW1JN6wyy7t
	 B6irC/wN22WXOGEEqQ8UGeD1qBLN0on1vR7TAmcgMo9En/hznhMJJPywnOH5Lu4KGqQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="pDAXu1/a";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=lhKrasLg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=m580Vlsa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=AZqaB5OP;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EEF2EF800B5
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 11:48:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEF2EF800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=pDAXu1/a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=lhKrasLg;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=m580Vlsa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=AZqaB5OP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 188393E0A;
	Thu,  6 Aug 2026 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786009708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU5XJnaayDumPDVpK3Ie3UPd5NJNSKlqkG/TLuMVt7A=;
	b=pDAXu1/aeu/6f/NrqZNu/TD7rM4feYFH4Af2NBC5d+tqXKbcBwPtAE1NoHDG9uTHnMTwiX
	gAdwP4e0KGh12/oLO5uw+BgyFK0fDXjmI1ZyPULvE3Ei8YGXoG91ZnNP0YfeQMGmcz4gUp
	7bbbtyAehMmNRj+iQq/kAoQGoiEh3TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786009708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU5XJnaayDumPDVpK3Ie3UPd5NJNSKlqkG/TLuMVt7A=;
	b=lhKrasLgD3zAHefI7HsUDNlYbLefaXfg/jqhN7MUGI77gJ1yRD4oh4Xvcc5cY6XfFLACEo
	OSXILY2tEnIJBDAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786009704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU5XJnaayDumPDVpK3Ie3UPd5NJNSKlqkG/TLuMVt7A=;
	b=m580VlsaHyZeVVbvFiQX+iWJ6nz+fmTbuCDepAWl0bqKJAKnQKGdaEchp0TZsBvTFD/1hT
	skGeZIolhTiDQGDGZeKmr0KTw2aqJBYPPpqnbUVwrjT6QVE+LFKATQzXOmsSG9DjdzXoYB
	tZxGYOZuTq+UpA4rIXJv7jr47jgXzzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786009704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU5XJnaayDumPDVpK3Ie3UPd5NJNSKlqkG/TLuMVt7A=;
	b=AZqaB5OPxexCNyMMfH+FndfRC87XPQNwG6QDvP/+eBhh7eIRyO1vnBvRlO/eit81QQaCot
	lcrEPsbJ2JwWrUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EED2B779C0;
	Thu,  6 Aug 2026 09:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1lnDOGdYdGp5PgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Aug 2026 09:48:23 +0000
Date: Thu, 06 Aug 2026 11:48:23 +0200
Message-ID: <87mruzeg0o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Carl Quist <equalizerjr@gmail.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable mute LED on HP Laptop 15-dy0xxx
In-Reply-To: 
 <CAOtcGaxXndKxTK5MVSEcmF-LUy+V51K7fhE=qvLA+VvW5ZyCNA@mail.gmail.com>
References: 
 <CAOtcGaxXndKxTK5MVSEcmF-LUy+V51K7fhE=qvLA+VvW5ZyCNA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.944];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: SVICFHCP3W5ZCOIIOILOHJGAWRHYCVHA
X-Message-ID-Hash: SVICFHCP3W5ZCOIIOILOHJGAWRHYCVHA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SVICFHCP3W5ZCOIIOILOHJGAWRHYCVHA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 06 Aug 2026 01:57:27 +0200,
Carl Quist wrote:
> 
> 
> The mute LED on the HP Laptop 15-dy0xxx (PCI SSID 103c:864f, Realtek
> ALC236) does not work, because the machine has no entry in the quirk
> table. No fixup is applied, so no mute LED classdev is registered and
> nothing ever drives the LED.
> 
> The LED is controlled by COEF index 0x07, bit 0. This was verified on
> the hardware with hda-verb: setting the bit lights the mute LED and
> clearing it turns the LED off.
> 
>   hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x07
>   hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x1     # LED on
>   hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x200   # LED off
> 
> That is exactly what ALC236_FIXUP_HP_MUTE_LED_COEFBIT2 configures, and
> the closely related HP Laptop 15-dw0xxx (103c:85f0) already uses it.
> Bit 9 (0x200) is set by default on this board and is preserved by the
> fixup's read-modify-write.
> 
> Tested on an HP Laptop 15-dy0xxx (SKU 7FU54UA#ABA, board 864F,
> BIOS F.40).
> 
> Signed-off-by: Carl Quist <equalizerjr@gmail.com>

Applied now.  But at the next time, please submit to
linux-sound@vger.kernel.org, instead.  It's the place for kernel
patches.


thanks,

Takashi
