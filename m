Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FBACCA46C
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:13:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4028C601FE;
	Fri, 16 Oct 2026 16:13:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4028C601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792160003;
	bh=XkeCI4CQwmAdEBVqiyi23qjHYNXtPLdWdi24kW6C3bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fvf00FkUJCfjCiIFSekjQ5tKX/smH2BAmLtILHy/MQfACbuPNFhxmN8h3OkCz8CR/
	 va89a1SqZoJq03UNlk7wK/BXL3SK14chSHn6qfzYoWKWs2K5wUX/JfWRTAo14Yg+M4
	 4479V8GpH6VHaDOOYaH/a7bcfL52KxbfUd5/wUzc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A3E4F80602; Fri, 16 Oct 2026 16:12:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76A07F805F7;
	Fri, 16 Oct 2026 16:12:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CA69F80423; Fri, 16 Oct 2026 16:12:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792159960;
	b=pPFLkY/IifdBR0qNdW6/CYXqYmG7wZPdu9qpRx1d3xCeebig7iX3C3lQEht4VV82leVH
	 cRnXYVaMwY3aybHSy/4T0Pm4hk0D+oeObuV1xPmKGL+YK2h6+Ki1m5IRxtCBjnDa9vHig
	 iz53Mgk9WmjAhtBOTuF4qBHt7y8nz44acc77p/FUrffUxY9+UMlAGHxkOutmNGK60+Zky
	 H1FezE+Phu1LrjzXmSRbfNTVh7YYzbx05t8sfEnbNPAihDJVRmiyjJPKNPAmNCovcfcZC
	 vMq21RiyLuoN++vla0gt3KMVufmvJsZ0MJ7DxE8p+GsZn1eKykSNoBsk+Gf849Wx59g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792159960;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=XkeCI4CQwmAdEBVqiyi23qjHYNXtPLdWdi24kW6C3bg=;
	b=hZC6Zg6K3TH4zxHRO0aZ8uTCwHD+gZiB0aEeJU9Y6+JI9LeI0ftmk+MaeHrdmIS23VTf
	 AZfvaYGuMyx6NumzI3kaEhytThqmySRUnZElOOTigYM1y+o2Id+Ag00wV2EdBTQSDIEoM
	 SwuiUkkp030vJrA+l76QHKA+JvN/qMRLLscAD9P4xyV/xB4MjC6vgNGIW8hXM1JZl3Bzk
	 OGRacMKkvymB5h6kkB4UXNZh21Tsqo9qoAxr0BVbyn3oc1pWUyEDekUFwI0seYZIsC7Ce
	 Djfzct2beAxKCJ6Yd/MRkuhIGxEfKZ2U0hnjVm1ouw72NAprY63ToopG3s2i28WXCMA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=t8J3ZxTR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+4FprJjE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=t8J3ZxTR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+4FprJjE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1AFB6F80212
	for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2026 16:12:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AFB6F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=t8J3ZxTR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+4FprJjE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=t8J3ZxTR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+4FprJjE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A85B021B9F;
	Fri, 16 Oct 2026 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1792159957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWNiEd+tCU5KWUjQZymH3LyO36LtgZUbDJ2d20bcroo=;
	b=t8J3ZxTRSYB1BXvWClcWbZSTUTJV9lljVPgMh+S5cSQ5pPbx8crd2+8nQQhpUokMyX2tGj
	ir5Xgz+W6qQnCQ2SEtl/ojjVYRuxSFxq1DNnTxMQGQZJB5jHrCPI5j62VwMCxxrkuQxuHS
	HRIYiX/oMqfpzPwRRy7Qd6sr9fdwX3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792159957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWNiEd+tCU5KWUjQZymH3LyO36LtgZUbDJ2d20bcroo=;
	b=+4FprJjES9TZh4NPWRIiOFb+3sKLUZSP5D45y6Ve7EWD/bXnALm1yHD0SZ4qO7UDnVEI6O
	NGgxqe6UTauqd8Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1792159957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWNiEd+tCU5KWUjQZymH3LyO36LtgZUbDJ2d20bcroo=;
	b=t8J3ZxTRSYB1BXvWClcWbZSTUTJV9lljVPgMh+S5cSQ5pPbx8crd2+8nQQhpUokMyX2tGj
	ir5Xgz+W6qQnCQ2SEtl/ojjVYRuxSFxq1DNnTxMQGQZJB5jHrCPI5j62VwMCxxrkuQxuHS
	HRIYiX/oMqfpzPwRRy7Qd6sr9fdwX3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792159957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWNiEd+tCU5KWUjQZymH3LyO36LtgZUbDJ2d20bcroo=;
	b=+4FprJjES9TZh4NPWRIiOFb+3sKLUZSP5D45y6Ve7EWD/bXnALm1yHD0SZ4qO7UDnVEI6O
	NGgxqe6UTauqd8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C9451339F;
	Fri, 16 Oct 2026 14:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L5QoEdUw0mrIDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Oct 2026 14:12:37 +0000
Date: Fri, 16 Oct 2026 16:12:36 +0200
Message-ID: <87bj8t3faj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Viktor Menshin <ripeeerr@gmail.com>
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix hiss/crackle on Lenovo Xiaoxin 14
 GT (17aa:3912)
In-Reply-To: <20261015132157.57198-1-ripeeerr@gmail.com>
References: <20261015132157.57198-1-ripeeerr@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
Message-ID-Hash: XTLSTSKQS57U6CRPAFWQYZB4LOMILNVQ
X-Message-ID-Hash: XTLSTSKQS57U6CRPAFWQYZB4LOMILNVQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XTLSTSKQS57U6CRPAFWQYZB4LOMILNVQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 15 Oct 2026 15:21:57 +0200,
Viktor Menshin wrote:
> 
> Commit 3a3e810e9108 ("ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin
> 14 GT") added a quirk mapping SSID 17aa:3912 to
> ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN, chosen by analogy with
> neighboring SSIDs (0x390d, 0x3911, 0x391a) without being verified on
> hardware, as noted in that commit's own message.
> 
> I have since tested it on the actual hardware (Lenovo Xiaoxin Pro 14
> ASP10, same 17aa:3912 SSID) and confirmed it does not fix the reported
> issue. ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN only repoints pin 0x17
> and the preferred DAC pairs for the bass speaker; it does not touch
> the codec's vendor processing coefficients. The actual symptom -
> constant electrical hiss/crackle on both the headphone jack and the
> internal speakers, independent of volume - is unrelated to pin/DAC
> routing and is also present on stock Windows before the Realtek
> driver is installed, which points at those coefficients being left
> at their power-on default.
> 
> To find the correct values, I passed the physical HD Audio controller
> through to a Windows 10 VM (VFIO, with QEMU patched to log CORB verb
> traffic) and captured the coefficient writes the vendor Realtek driver
> performs at init. Replaying a single one of them on Linux via hda-verb
> reproducibly eliminates the headphone jack noise:
> 
>     hda-verb /dev/snd/hwC#D0 0x20 SET_COEF_INDEX 0x36
>     hda-verb /dev/snd/hwC#D0 0x20 SET_PROC_COEF  0x77d7
> 
> This has held up across reboots and kernel updates for several weeks
> (applied via a small systemd oneshot unit while testing).
> 
> Add a dedicated fixup that performs this coefficient write and chains
> it with the existing ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN (which may
> still be relevant for the bass speaker pin wiring on this board), and
> point the 17aa:3912 quirk entry at it instead.
> 
> Honesty note: this fixes the headphone jack. The internal speakers
> still have noise under certain conditions (notably worse on AC power)
> that I have not been able to isolate via coefficient-table replay;
> that part remains open. Sending what is verified to work rather than
> holding this back.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221203
> Fixes: 3a3e810e9108 ("ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin 14 GT")
> Signed-off-by: Viktor Menshin <ripeeerr@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi
