Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BA606FB53
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=lHIGwSCv;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=g+54Jp+p;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6jHwnsE1;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=g+54Jp+p;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6jHwnsE1
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84B2760214;
	Mon,  2 Nov 2026 15:42:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84B2760214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793630532;
	bh=2w2k6g9G1LNitumiMowl9Ywait+1wGicjCMBJRhBlxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lHIGwSCv5Ln3ZfagTeVTVd6QqmS6NpNFb9OaDZzoXhjXNGrz2tmhCxcnoSh6Eh+x1
	 wgCtKM9vBfb+XQ1F2Qa8LPqGoJRar0KuqmCKAw9scYlk4cOCSdJhz65bqyrsml6Xwr
	 dhUq2n7bZyF6enR2jiJWHeg9g9Y2C884WaXwvcXc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 648DFF80615; Mon,  2 Nov 2026 15:41:35 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16629F80619;
	Mon,  2 Nov 2026 15:41:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D3A8F80606; Mon,  2 Nov 2026 15:41:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793630489;
	b=NthJh4EKzCdb4o6TM2msTzek8P9eqKDhDmMP4qZ/+VTcv4y8wVTN/L5zAoqJiqm/5FWC
	 2qL2KkTQmpKFAHhMRgCW/79fgF4t5ESLP4f4OWB7fd2M1VDv+QT5GSU1k3Kw/e4CmOC20
	 trpL9J4NhPoJ93JKr9EZk1h7iDkMWexIec3GQXlo8Vk87TyaTjyhvzzq6Ut9JrNiq3ZSM
	 oxhS0/KUnV9RsixIm81E03KMMvo+S4RhUpbwnLI1SKtsUdrGzXYfGTrA+4g8elNWVjV1n
	 NkgVpWPV4+l4yyKUftDIOCd1caSde4quKxpVewljvSkKBH9zS5gibybS1qO/qCAYzFA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793630489;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=2w2k6g9G1LNitumiMowl9Ywait+1wGicjCMBJRhBlxc=;
	b=G4iu/wzpPcYQPKUGMhZi1O0RZEfB3RqO9KagrfStJtdJTWc/Fx1EB7OoCqJxOBs1ajKo
	 8IDO9RR+BKowFqJfjDP1Ul0LW0B/xn8UKzL42KeKU/Q3uvD5fpJEQsxOS0XdEXnZ0CJB3
	 DOfXNwmdjQA+CBnM1hiOj8bM1dEaqyhZoOLUEZQK4gPXn+ADiGUJB/pmsW0MZ7NHFoy3D
	 G3iAo8ocNk0YxivIFUxH17+YNoKuzCQC4Zp5/aD/wWiu/xfC9/fOABvXt4tFtfloK6qvt
	 2h5XC0YyXT1HeN74zC7CVzkNYhQ2sDqwPf2NHPEPgdrI0TLJR7UzugDFSrsQmgnz6Zg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=g+54Jp+p;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6jHwnsE1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=g+54Jp+p;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6jHwnsE1;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A34E7F805B3
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 15:41:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A34E7F805B3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=g+54Jp+p;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6jHwnsE1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=g+54Jp+p;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=6jHwnsE1
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1F4D22313;
	Sat, 31 Oct 2026 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793461950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6dmbkR3QxM9zdAcjbmxjOGEJkPuuqdvYu3/ZWC3Ngw=;
	b=g+54Jp+pjPz/wKAnN7/EJLhJGHiVE+F0A01LvucVr9FC5kw8U2c8h7cWrBHpIabKRx50fO
	jPzZ7/zGSIWOgFWT/ILfQbDrAF/WIUARR876++l2Pp8QprAl2hygOLVcY7g7th6c7Vd0el
	jR1Hk3Rh6kBhqCqGWa3Y+lgFoP2d7mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793461950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6dmbkR3QxM9zdAcjbmxjOGEJkPuuqdvYu3/ZWC3Ngw=;
	b=6jHwnsE1fVYX6t9qdWDOi9r5Rr07KMJ/sUyA9TjK66kx5Cpdqy7QFWU2TNHOjKZKcxRaKc
	k129az9+k++okeCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=g+54Jp+p;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6jHwnsE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793461950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6dmbkR3QxM9zdAcjbmxjOGEJkPuuqdvYu3/ZWC3Ngw=;
	b=g+54Jp+pjPz/wKAnN7/EJLhJGHiVE+F0A01LvucVr9FC5kw8U2c8h7cWrBHpIabKRx50fO
	jPzZ7/zGSIWOgFWT/ILfQbDrAF/WIUARR876++l2Pp8QprAl2hygOLVcY7g7th6c7Vd0el
	jR1Hk3Rh6kBhqCqGWa3Y+lgFoP2d7mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793461950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6dmbkR3QxM9zdAcjbmxjOGEJkPuuqdvYu3/ZWC3Ngw=;
	b=6jHwnsE1fVYX6t9qdWDOi9r5Rr07KMJ/sUyA9TjK66kx5Cpdqy7QFWU2TNHOjKZKcxRaKc
	k129az9+k++okeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B5D713432;
	Sat, 31 Oct 2026 15:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c881BL4O5mppJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 15:52:30 +0000
Date: Sat, 31 Oct 2026 16:52:29 +0100
Message-ID: <8733tlsw8y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Guobing Yin <yinguobing@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Huawei WRT-WX9 (ALC256,
 19e5:320d)
In-Reply-To: 
 <CA+2LKoO7He4DciWnx7qcwndwpZNxA4R1FMTpXGSTVK_k9J6Svg@mail.gmail.com>
References: 
 <CA+2LKoO7He4DciWnx7qcwndwpZNxA4R1FMTpXGSTVK_k9J6Svg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: A1F4D22313
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: 3AEBI5Y7B5EXOYRIAVO4Z6FCF247MCVD
X-Message-ID-Hash: 3AEBI5Y7B5EXOYRIAVO4Z6FCF247MCVD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3AEBI5Y7B5EXOYRIAVO4Z6FCF247MCVD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Thu, 29 Oct 2026 09:13:31 +0100,
Guobing Yin wrote:
> 
> Hi,
> 
> this is a one-line quirk addition for a Huawei MateBook WRT-WX9 whose
> Realtek ALC256 codec reports subsystem ID 19e5:320d.  The patch is
> attached.
> 
> Problem: headphone insertion is never detected.  The "Headphone Jack"
> control stays off, PipeWire keeps the speaker route selected, and audio
> comes out of the internal speakers and the headphones at the same time.
> Unplugging the headphones leaves the speakers working, so only insertion
> detection is broken.
> 
> Cause: the existing quirk for this machine family is registered for
> 19e5:320f only, so this variant receives no fixup at all.  Applying
> ALC269_FIXUP_HEADSET_MODE makes jack detection work.
> 
> Evidence from the affected machine (kernel 7.0.0-38-generic):
> 
>   lspci -nn:
>     00:1f.3 Audio device [0403]: Intel Corporation Cannon Point-LP
>     High Definition Audio Controller [8086:9dc8] (rev 30)
> 
>   codec:  Realtek ALC256, vendor 0x10ec0256, subsystem 0x19e5320d
>   DMI:    HUAWEI WRT-WX9 / WRT-WX9-PCB, BIOS 1.39
> 
>   Without the fixup:
>     $ amixer -c0 cget numid=12 | tail -1
>       : values=off            # headphones are plugged in
>     $ hda-verb /dev/snd/hwC0D0 0x21 0x0f09 0x0
>       value = 0x0             # pin sense never reports presence
>     PipeWire: analog-output-headphones -> "not available"
> 
>   Booting with snd-hda-intel.model=headset-mode (the same
>   ALC269_FIXUP_HEADSET_MODE fixup):
>     $ amixer -c0 cget numid=12 | tail -1
>       : values=on
>     $ hda-verb /dev/snd/hwC0D0 0x21 0x0f09 0x0
>       value = 0x80000000
>     PipeWire: analog-output-headphones -> "available"; the speaker is
>     muted automatically on insertion and unplugging restores speaker
>     output.
> 
>   HDMI audio profiles and the internal microphone keep working with the
>   fixup applied.
> 
> The attached patch just maps 19e5:320d to that fixup.
> 
> I am not subscribed to the list, please keep me in Cc.
> 
> Thanks,
> yinguobing <yinguobing@gmail.com>
> From: yinguobing <yinguobing@gmail.com>
> Date: Thu, 29 Oct 2026 16:08:00 +0800
> Subject: [PATCH] ALSA: hda/realtek: Add quirk for Huawei WRT-WX9 (ALC256, 19e5:320d)
> 
> On the Huawei MateBook WRT-WX9 whose ALC256 codec reports subsystem ID
> 19e5:320d, headphone jack presence detection never works: the
> "Headphone Jack" control stays off, PipeWire keeps the speaker route
> active, and audio plays from the internal speakers and the headphones at
> the same time.  Unplugging the headphones leaves the speakers working, so
> only insertion detection is broken.
> 
> The existing quirk for this machine family is registered for 19e5:320f
> only, so this variant receives no fixup at all.  ALC256 on this board
> needs ALC269_FIXUP_HEADSET_MODE; without it the codec's jack detection is
> never enabled and GET_PIN_SENSE on the headphone pin (0x21) always reads 0.
> 
> Verified on the affected machine by booting with
> snd-hda-intel.model=headset-mode, which applies the same fixup: the
> "Headphone Jack" control then reports "on" when a plug is inserted,
> GET_PIN_SENSE on pin 0x21 returns 0x80000000, the "Headphones" port
> becomes available in PipeWire, and the speaker is muted automatically on
> insertion.  HDMI audio profiles and the internal microphone keep working.
> 
> Add a SND_PCI_QUIRK entry for 19e5:320d using ALC269_FIXUP_HEADSET_MODE.
> 
> Signed-off-by: yinguobing <yinguobing@gmail.com>

Applied now.  Thanks.


Takashi
