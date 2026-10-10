Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5445ACA9EBE
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:04:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9C59601F1;
	Sat, 10 Oct 2026 10:04:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9C59601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791619471;
	bh=JH+n6y8uoqaQ0h95wOZjzeIyuo70oJ4txXScbLqKwpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tmYzKkpIzbeM8fkE2YxKZZziReIYVrQGg7SYXBi+OlYHM6+FCezdUVd01j2kA3jMA
	 BGVwBYI+XsDPswYHi+Sd/2CGhQqaGW0AS1t7QwxjOhvahGf9p073V74h2NHUeXG/TG
	 Ova8/tqmBN4Q8clWAuFcGRwPGpyFd97A5d5iFe4Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CFD83F80601; Sat, 10 Oct 2026 10:03:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 56736F805F2;
	Sat, 10 Oct 2026 10:03:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E120F80542; Sat, 10 Oct 2026 10:03:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791619423;
	b=U6y7hRISmqMHXl7v6PRPadMGVCuXcLbXlHzzcRoDSX2jpKXRjc1CtSLb6VJSd/srLr8D
	 ESHHhggAQnihdytjzWZjnK8NcmdK2QG2zaao1sgIybIBQE0XiEmZGI1GAqRaU2fMp4t5U
	 o7UqtwJkcHA74KxjBHRQLZe/RwGQHD790rz/cjHhvixgbCjgDtb+CgnXNemXmamI6eOOI
	 1q+T1jPGKkgAVOaQz9UaoSZJflbHcW5iRSOW+l1HWo7l5V1V8y9tQKXutSyw6tVTSRZc5
	 10XoVACsB6KA8/DhFx43QgUkwRPJkPUsuZ2tqu+vmGOtu+GCfBB9WNtdIvCO9a9m5Pg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791619423;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=JH+n6y8uoqaQ0h95wOZjzeIyuo70oJ4txXScbLqKwpo=;
	b=IC5RBEGbxDyPzYdXhICWmnBJfPaJj+ERlgN/0CQhOT2pKSr/FqKT7oIivYutHyh+lJau
	 gYkzlztBYg9OeQ+cJQMzM6XIdNSfoRaNOf69KXaE3JZQGUgnyR3sXZlASY5fJD+WAgoka
	 qHqbC0sLJ2j0N05ptzrZK8hTDSqz63ld0yZG4NM0W+vVumdaq0HI2slI8uIFcfdup69na
	 NRxStaA37GWMRduQpa7nCDolk5V55oMaJJFys7nYTpAXGYM/PmzOl/okZPUihl728aUIO
	 xpsVCCSsD0NCO7NIny3MaWmcHqxQfaNL6vekGiLZQ9p93rgpzDl0v/3g1CtUYBvU7kg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=uakUok4F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IwktZT1i;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=uakUok4F;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IwktZT1i;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 52FE9F8007E
	for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2026 10:03:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52FE9F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=uakUok4F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IwktZT1i;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=uakUok4F;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IwktZT1i
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22D2D1F388;
	Sat, 10 Oct 2026 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791619421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQjEvOqLuuabg6ypgh05qmuZ8bvBqem5WqYCZ2YRH40=;
	b=uakUok4FVl52W7+TI55PIyJqQII43zO2whjI1y8pvhqFUfUMS25sgyBRWfhYseqeAqEbxx
	y+wRnIGhRQojg3SEQbruo9bX/RvFHE+I/CJReTjE0AVXztWB+yZJfittri0uVDDCVxROsS
	zUFzOyfQbnWfYwctMvZ027VA18Xz5RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791619421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQjEvOqLuuabg6ypgh05qmuZ8bvBqem5WqYCZ2YRH40=;
	b=IwktZT1ibREudtEYXmEwt/mBB0+U6spWLw5rubwsfsTWuNHHH8mJ82GnjrwmQdXlYUyhQp
	SBgFeqiimIyMOfBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791619421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQjEvOqLuuabg6ypgh05qmuZ8bvBqem5WqYCZ2YRH40=;
	b=uakUok4FVl52W7+TI55PIyJqQII43zO2whjI1y8pvhqFUfUMS25sgyBRWfhYseqeAqEbxx
	y+wRnIGhRQojg3SEQbruo9bX/RvFHE+I/CJReTjE0AVXztWB+yZJfittri0uVDDCVxROsS
	zUFzOyfQbnWfYwctMvZ027VA18Xz5RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791619421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQjEvOqLuuabg6ypgh05qmuZ8bvBqem5WqYCZ2YRH40=;
	b=IwktZT1ibREudtEYXmEwt/mBB0+U6spWLw5rubwsfsTWuNHHH8mJ82GnjrwmQdXlYUyhQp
	SBgFeqiimIyMOfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE016133F6;
	Sat, 10 Oct 2026 08:03:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SdEtIFzxyWoJTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 10 Oct 2026 08:03:40 +0000
Date: Sat, 10 Oct 2026 10:03:40 +0200
Message-ID: <87mrsmj82r.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alex James <igotmysoul@gmail.com>
Cc: alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix internal mic capture on ASUS ROG
 Flow Z13 GZ302EA
In-Reply-To: 
 <CA+YQcmcUKi98dKYRWjg8MR6hQoxoOEvXAuSDLgUUVK-L=ge7JA@mail.gmail.com>
References: 
 <CA+YQcmcUKi98dKYRWjg8MR6hQoxoOEvXAuSDLgUUVK-L=ge7JA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: PYB4PFITSX5XN6PNM4LVOL362SJ6B5VA
X-Message-ID-Hash: PYB4PFITSX5XN6PNM4LVOL362SJ6B5VA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PYB4PFITSX5XN6PNM4LVOL362SJ6B5VA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 09 Oct 2026 23:19:39 +0200,
Alex James wrote:
> 
> The ASUS ROG Flow Z13 GZ302EA (Realtek ALC294, SSID 1043:1fb3) exposes
> two fixed internal mic pins, 0x12 (0x90a60140) and 0x13 (0x90a60130), as
> capture sources "Internal Mic" and "Internal Mic 1". The input mux
> defaults to 0x12, but on this model 0x12 is defective: its right channel
> rails to -32768 and the left channel carries heavy noise, so out of the
> box the internal microphone records loud noise/hum.
> Pin 0x13 captures clean audio on both channels (at lower level). The
> mic array is not reachable through the AMD ACP70/PDM path either: forcing
> it on via ACPI _WOV=1 creates the dmic-codec device but all samples rail
> at -32768, so HDA is the only usable capture path.
> The existing quirk for this SSID only initializes the two CS35L41 I2C
> smart amps (speakers). Disable the broken 0x12 pin via pincfg so that
> 0x13 becomes the sole "Internal Mic" capture source, and keep the CS35L41
> initialization by chaining it in a new fixup.
> Measured on a GZ302EA (arecord, 48 kHz S16LE, identical gain):
>   pin 0x12: L 47% clipped samples, R 15% clipped (railed noise)
>   pin 0x13: <0.3% clipped, hum components below -65 dBFS
> The fix was validated on the target hardware without building a kernel
> by applying the same pincfg override (0x12 -> 0x40000000) through a
> boot-time HDA patch firmware (snd-hda-intel patch=). With the override
> the codec parser drops pin 0x12 entirely: the card comes up with a single
> "Internal Mic" (0x13), the Capture Source mux control disappears (single
> input is hardwired), and capture is clean and stable across boot,
> suspend/resume, and PipeWire/WirePlumber route re-applies. Note that a
> runtime hda-verb override alone is not sufficient because the bus driver
> builds its pin cache at codec registration.
> Also observed on this SSID while testing: repeated
> "ALC294: Invalid fixup type 2016568172" messages in dmesg during probe
> with the current quirk; likely unrelated but worth a look.
> Link: https://github.com/CachyOS/linux-cachyos/issues/880
> Tested-by: aic0d3r <funforfreeapps@gmail.com>
> Signed-off-by: aic0d3r <funforfreeapps@gmail.com>

The blank lines and the white spaces seem broken, possibly due to your
mailer, so the patch can't be applied correctly.  Also, the
Signed-off-by tag has to be a real name (or a known identity) as it's
a legal requirement.  Yet better would be to align From tag with
Signed-off-by, too.

Could you resubmit with proper blank lines and keeping the tabs/spaces
as well as Signed-off-by/From tag corrections?


thanks,

Takashi
