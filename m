Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B72C43458
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:27:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E228F60240;
	Thu,  9 Jul 2026 11:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E228F60240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783589278;
	bh=FvbemxWRmP7EYMfSReLFC9/iZDFK83/AxX0fB0UQRYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z/E587uxqSeAeGxzX/aCgZ20eAybf7HcfT8V3wkDOoPl4gsj5TBW0Ld5O+LevHibm
	 cwHZPPyreX1uZWA8NY1yzdvwM0hKbjOzkK9/6jsmYS/cvdalTRBCoFwpV+CABC00MW
	 I7XWrwsp67weTAMGb+5/CZGR+/HM0w3z/V8eEikg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCF70F805EE; Thu,  9 Jul 2026 11:27:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37E08F805F9;
	Thu,  9 Jul 2026 11:27:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B0C6F80495; Thu,  9 Jul 2026 11:27:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783589236;
	b=D4Lz2aeI2z9cWyo745gr75dDfj80DuL6GHRTxg4e/NyFa/RQrg8zLYApROpX9Yd7sRFI
	 atKAlj70APRpkAUETHAXGqPUDMMxntrJoG4B0sfJz37PG1HzAvOdYMqvPa/PoawRG/44J
	 wqRgo2th06UaMvFAeFaOUOwIknaPhyv4zzKowvQOU7y5qhxepIRdhLOCpRR5fdvzjv1FR
	 L2HlHJTroixSBwdks0b4Fa00r4f15eMkp1Yv/JQ9Z8FFINR1w2RvBpmef4AKUdng6bQMS
	 8fpxDfavla7zMTKZJmZezN5PaI0KcN2Jf/2jH05pDVFL0d49HLL0i3Vm0VKXi+0CraQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783589236;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=FvbemxWRmP7EYMfSReLFC9/iZDFK83/AxX0fB0UQRYI=;
	b=ir9cyQaWZFQRJ91ICi+7D2Fy2o7HSj9z/5vYS+9k7pf2Zx3vJiOJE/ngdG1bMfgpMS8n
	 ElyvE6087zqpIAntMoWN0Lr1sEA4YgpcqFxqErepA5H6BF7RMYAmzxDOScBvHPaYevC5U
	 Rokqg65ZXqST22oQ/M82cGskLuc8YDGXHhMFzYc1rA5kyWvAE0NF9+XQ9xgIw1Ri6dZWp
	 MEWM4o7C6mxoY/yT8gM6Mfe6x+98DJNbJbPmRI/d/8NSQYm2OZFiHadcsy4uXmlZiF6eV
	 Wl/mSoB902m3ac1d8zCstWu9lD8kEAyr++JNt54enurwx7dc4XQ9dSZYsRY1WIl3ZOg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="sWYJi7b/";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="t+/t7N+k";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=bDbJ2tJB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="/WjDWds0";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 15760F80124
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 11:27:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15760F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=sWYJi7b/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=t+/t7N+k;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=bDbJ2tJB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=/WjDWds0
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 235B8760BC;
	Thu,  9 Jul 2026 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783589233;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNc6oLVE01PDd5eJpVLwEiUEjSItoPk31pzgMZF5Omo=;
	b=sWYJi7b/7GLGt7Xwb3yf2wU2b8xIp82CfIkbudx2YDLzXCe9Qd8xmt5Rj45cb+14to115c
	R2T1PRwa7nqSOTuZ7h00Tm/8wJD4c7HwZzeYKrCBECbxVdPNrrVdYsV1cqUus/A5EczBzx
	o7LyC9EKQZQfDYIfM0eeuXLevs91E4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783589233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNc6oLVE01PDd5eJpVLwEiUEjSItoPk31pzgMZF5Omo=;
	b=t+/t7N+klm/rfVhvr7HrZUX/FF2aQ3PsO/WAFxSbddzoMyMNbNRZozGq/y/hVbEZ644FnC
	FDmoFMww9bVMM7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783589232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNc6oLVE01PDd5eJpVLwEiUEjSItoPk31pzgMZF5Omo=;
	b=bDbJ2tJBHa7U0GFsIfoMOIS6aMOBVtXBg1zVappDw2fqOjXxgvCVq6j9aOLxr2BR1/lPzu
	kC6YYPhjxO3SQlZgL4G5dNxLRA+CC/rdE7aTb6KZz1mSa81UHHnNqpnYbleQrSjGo+gul9
	3ByM0RplHCFV8lMXiz7JF6eLzqvMJPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783589232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNc6oLVE01PDd5eJpVLwEiUEjSItoPk31pzgMZF5Omo=;
	b=/WjDWds0VKNKcA3BzAh1qQa3rCTtrmaJ+BQ3KezNyROJ+U36lt7uF/WSQg1qs+N0vNosDR
	+2Pg/iO0rT/FapDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED3CD779AA;
	Thu,  9 Jul 2026 09:27:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TgWLOG9pT2ovPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 09 Jul 2026 09:27:11 +0000
Date: Thu, 09 Jul 2026 11:27:11 +0200
Message-ID: <871pdc4iog.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Miguel =?ISO-8859-1?Q?M=E1rio_N=E1poli?= <miguelmnapoli@yahoo.com.br>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [BUG] snd-usb-audio: incorrect PCM volume scaling on Edifier R19U
 USB speaker (0001:0201)
In-Reply-To: <916698070.3732567.1783292866624@mail.yahoo.com>
References: <916698070.3732567.1783292866624.ref@mail.yahoo.com>
	<916698070.3732567.1783292866624@mail.yahoo.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[yahoo.com.br];
	FREEMAIL_ENVRCPT(0.00)[yahoo.com.br];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mvsilicon.inc:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: 2RMUIR5Y54H6GFOC56PUNAHL4MO6ZU22
X-Message-ID-Hash: 2RMUIR5Y54H6GFOC56PUNAHL4MO6ZU22
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2RMUIR5Y54H6GFOC56PUNAHL4MO6ZU22/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 06 Jul 2026 01:07:46 +0200,
Miguel Mário Nápoli wrote:
> 
> 
> Hello,
> 
> I'd like to report an issue with USB audio volume scaling on a cheap
> USB-powered speaker set, in case it's useful for a mixer quirk fix.
> 
> Device: Edifier R19U USB speakers (MVSILICON.INC. controller chip)
> lsusb: Bus 001 Device 010: ID 0001:0201 Fry's Electronics EDIFIER R19U
>   (Note: idVendor 0001 is an unofficial/reused ID ("Fry's Electronics"
>   placeholder), so it may be shared by unrelated devices from other
>   vendors -- please take that into account if considering a quirk
>   based on VID/PID matching alone.)
> 
> System: Zorin OS 18 (Ubuntu-based), fresh install (< 1 week old)
> Kernel: 6.17.0-35-generic
> PipeWire: 1.0.5
> 
> Problem description:
> On connection, the kernel logs a warning about an unusually large
> volume range for this device's PCM control:
> 
>   usb 1-2: New USB device found, idVendor=0001, idProduct=0201, bcdDevice=0.10
>   usb 1-2: Product: EDIFIER R19U
>   usb 1-2: Manufacturer: MVSILICON.INC.
>   usb 1-2: Warning! Unlikely big volume range (=999), cval->res is probably
> wrong.
>   usb 1-2: [9] FU [PCM Playback Volume] ch = 2, val = 0/999/1
> 
> As a result, userspace volume controls (tested via PipeWire/WirePlumber
> and GNOME Sound Settings) display a normal-looking volume percentage
> (e.g. 69%), while the actual underlying ALSA mixer value stays at 0,
> producing no audible output at all -- with no mute indicator anywhere
> in the UI.
> 
> Confirmed via amixer while PipeWire reported ~69%:
> 
>   Simple mixer control 'PCM',0
>     Capabilities: pvolume pswitch pswitch-joined
>     Playback channels: Front Left - Front Right
>     Limits: Playback 0 - 999
>     Front Left: Playback 0 [0%] [0.00dB] [on]
>     Front Right: Playback 0 [0%] [0.00dB] [on]
> 
> Manually forcing the raw ALSA control resolves it immediately:
> 
>   amixer -c <card> sset PCM 999
> 
> After this, audio plays correctly and the volume responds normally to
> further adjustments, confirming the hardware/DAC path itself is fine --
> this looks like a resolution/step (cval->res) miscalculation for this
> device's 0-999 range, similar to past quirk fixes for other USB audio
> chips with non-standard volume ranges (e.g. the Logitech c270 webcam
> fix in sound/usb/mixer.c, volume_control_quirks()).
> 
> This was not an issue on a previous Ubuntu installation with an older
> kernel/PipeWire stack on the same hardware, suggesting this may be a
> regression in how a newer kernel or PipeWire handles this specific
> range, or simply a device that was never covered by an existing quirk.
> 
> Current workaround in use (userspace, not a real fix):
> A udev rule triggers `amixer -c <card> sset PCM 999` whenever the
> device is connected (matched by idVendor=0001/idProduct=0201), forcing
> the ALSA control to maximum so PipeWire's own volume slider can then
> attenuate correctly from there.
> 
> Happy to test a patch or provide more logs/output if needed.

Have you tried to apply the existing quirk?  Judging from the number
999, it might be a linear volume, and you can apply the linear volume
quirk.  See Documentation/sound/alsa-configuration.rst, the section
for snd-usb-audio quirk_flags.


thanks,

Takashi
