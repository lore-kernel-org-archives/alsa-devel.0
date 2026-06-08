Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D9CD8C8E
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:29:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45844601CF;
	Mon,  8 Jun 2026 09:29:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45844601CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780903762;
	bh=kZkPsQ3UDOZP14zCEzYcTgHFwVRsi8n0SADExrWtkuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rsXQNDR3oOMmY/hOyXN6GoLogg1uygk+4BTUb47pbIGDDBxbDkUzt+faj98CQmgO9
	 jV/0fHrMGgvR7WOzgUQc+hrojX9C7wdOHP5iGHfbD6f+r9sEA+7NCCDSz32jrbL6ey
	 ngwa8E7+YPu04eLc+hiofZUndzKkuv78UgyMWIMs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF5BEF805FD; Mon,  8 Jun 2026 09:28:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CF713F805FF;
	Mon,  8 Jun 2026 09:28:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13695F80423; Mon,  8 Jun 2026 09:28:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780903716;
	b=CObeKDDvY89+a/G4CCaNO4WiBLNT5kKUua4wgPWIZFec9fnrQqPK7gmd10tXPvU9BGtA
	 o/N4SxvVUhj99KZ6w76RDGG6PLmI0xG/0ikkE0bgxq0l6lC7j8MKN+vAEKBC3Y/hRzM6K
	 ZcJxrST21YjouOqi1GHepW3wGxZ5NN05cd+rhJBH36dBxaB/pUGtuL/WBc0YGBfYUE7zZ
	 V/9BQR6rW5qydLEBOaHoisbCDD/JtJuei0VvJkZkqtF1YG2PAVCt43Q/LnR+DiuqgnKkL
	 Mm99uE858Gx5+oCwH9U7RotuT2K1f9bcOSnV36mPykZdPLM7mNknr4wjyuvbbQkzbeg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780903716;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=kZkPsQ3UDOZP14zCEzYcTgHFwVRsi8n0SADExrWtkuY=;
	b=UCd0g3Z+84smo1C44HOg8TJeVACyqS3NAzlfDILsG5Na8u8mi5b/MLZ2oFSvgSrqGWxD
	 AVFJfdKZbhViKkYbonC20ArybIalX6VKtdELWwaXu9Py6Q1YVkm1ediiV1dG9XaibBEga
	 iTRGav1T1s24YVVNXVwpqzjOCL3ezacirygfd1pfgg3NEfQzDiqPlz0lYA5sD08loqg7Z
	 frCeAR7D3wSlLc0hUioWHAAZtjKa4EzVViHZJTKeXeKU9MKBFtus3jjSkoua9FNL2PHui
	 EQ1tuX7vuoW4+pdhqePfAWOxOPfulua8aeJ0eoh8m/MQ6YhMDjqNVDTj35J9n05iwdA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=GAtLIibJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=e2zVfkZQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=GAtLIibJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=e2zVfkZQ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 92001F80124
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 09:28:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92001F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=GAtLIibJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=e2zVfkZQ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=GAtLIibJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=e2zVfkZQ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A42D46B6B7;
	Mon,  8 Jun 2026 07:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780903714;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pa/AQvL6mhrN55GAYFFwd+7pO/saurSsJ7NB3rmD/Ik=;
	b=GAtLIibJ5zO0dcgdpC/CLFjmDQZv/PuARktVZEZBTLj7Vnqx7kDnhSs99db3NH1gRNg70Y
	FlHYzBa252CouxIXvXFFvRyHWoCezDav1ERlBnlWd1eQSMXIHKuyKM8opqSxBzs3p0UVxx
	IhKGv+FwKGG12rinsJO26BTEVsfAO3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780903714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pa/AQvL6mhrN55GAYFFwd+7pO/saurSsJ7NB3rmD/Ik=;
	b=e2zVfkZQz96JbRS/vECywnxPJWTDgzS4v+K9xFZ+fCohZswHXOM01MmW4RU0J2cIwffhEl
	tGAgwffi3vUGchCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780903714;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pa/AQvL6mhrN55GAYFFwd+7pO/saurSsJ7NB3rmD/Ik=;
	b=GAtLIibJ5zO0dcgdpC/CLFjmDQZv/PuARktVZEZBTLj7Vnqx7kDnhSs99db3NH1gRNg70Y
	FlHYzBa252CouxIXvXFFvRyHWoCezDav1ERlBnlWd1eQSMXIHKuyKM8opqSxBzs3p0UVxx
	IhKGv+FwKGG12rinsJO26BTEVsfAO3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780903714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pa/AQvL6mhrN55GAYFFwd+7pO/saurSsJ7NB3rmD/Ik=;
	b=e2zVfkZQz96JbRS/vECywnxPJWTDgzS4v+K9xFZ+fCohZswHXOM01MmW4RU0J2cIwffhEl
	tGAgwffi3vUGchCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73F39779A9;
	Mon,  8 Jun 2026 07:28:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I3n8GiJvJmq6dgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 08 Jun 2026 07:28:34 +0000
Date: Mon, 08 Jun 2026 09:28:34 +0200
Message-ID: <87se6xqyn1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-2022-JP?B?GyRCPH4bKEJPY2Vhbg==?= <zhouoceanhy@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
In-Reply-To: 
 <CACYx1Sq87CJfYa6w-dFuDZigzDA73OEX9am2FhKS2P6OOxw97g@mail.gmail.com>
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
	<87y0h2r3g6.wl-tiwai@suse.de>
	<CACYx1SrnTfg6GKK2S1Vb13f9OWOq1x=VUDA=AFWs1CALsC_B2g@mail.gmail.com>
	<8733z7pv5e.wl-tiwai@suse.de>
	<CACYx1SobX420vGovUv-1WROW-Kh-sPvaFBj0vNfgQnVnDyOeZg@mail.gmail.com>
	<87fr32wwpv.wl-tiwai@suse.de>
	<CACYx1SqT5sL7MpsjnB16dPwhjyvhzjL3M0E6-ka0Rn-cSgqiqA@mail.gmail.com>
	<875x3usg00.wl-tiwai@suse.de>
	<CACYx1SqBnPiGkoRYQoBTPiR1nhVS3ha2i+ADGKfMSpSfaiC04A@mail.gmail.com>
	<CACYx1Sq87CJfYa6w-dFuDZigzDA73OEX9am2FhKS2P6OOxw97g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[ocean-sudo];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: ZVGPQ4SLSKO6COH7AQYW6F2JP2TDVGXD
X-Message-ID-Hash: ZVGPQ4SLSKO6COH7AQYW6F2JP2TDVGXD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZVGPQ4SLSKO6COH7AQYW6F2JP2TDVGXD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 07 Jun 2026 19:40:13 +0200,
周Ocean wrote:
> 
> Hi Takashi,
> 
> A quick follow-up to my previous email! I have a correction to make.
> 
> First, I must apologize for a bit of confusion regarding the "loud
> electrical hum" I mentioned. I realized that during my earlier
> troubleshooting, I had accidentally cranked the Internal Mic Boost to
> a massive +48dB in alsamixer to see if I could force any signal to
> appear. After lowering the boost to a normal level, the stock driver's
> behavior is exactly as I originally described: mostly silent but only
> captures faint acoustic tapping on the chassis, with no actual voice.
> 
> More importantly, following your guidance, I managed to find the
> perfect and elegant fix for this issue!
> 
> Instead of using my previous brute-force hack (locking the ADC to
> 0x1e), I wrote a proper HDA pin override quirk for this machine (PCI
> Subsystem ID: 0x2014:8004). The quirk simply sets the pin default for
> the phantom Rear Mic (Node 0x1b) to 0x40000000 ([N/A] None).
> 
> Once Node 0x1b is disabled, ALSA's auto-parser magically handles the rest:
> 
> Without a headset plugged in, the system automatically defaults the
> capture to 0x1e (Internal Mic), completely eliminating the noise and
> allowing normal voice capture.
> 
> When I plug a headset into the front panel, the system dynamically
> switches the input to 0x1a (Front Headset Mic), and it works
> perfectly!
> 
> As for the rear speaker not auto-muting, I discovered that Auto-Mute
> Mode was simply set to Disabled in my ALSA mixer. After enabling it,
> the rear speaker correctly auto-mutes when the headset is plugged in.
> 
> Just as you pointed out in your earlier email, hard-wiring the
> connection wasn't the right approach. It seems that correcting the pin
> default to hide the phantom node (0x1b) allows the parser to wire the
> expected routes naturally. Could you let me know if using
> HDA_FIXUP_PINS for this is the correct implementation route? If this
> approach aligns with the proper topology handling, I would be very
> happy to prepare and submit a v2 patch.

Yes, disabling the pin config with that fixup makes sense.

There are a few more things you can test, though:

- Does the jack detection work for the rear jack?
  There are two pins assigned, NID 0x1b and 0x1c for input and output.

- Does the output from the rear work as-is?

- If the output works, try to change the pin control of the output of
  the rear jack (NID 0x1c), e.g. via hda-verb.  As default it's 0x40,
  and set to 0x00.  Does it change anything on the input from that
  jack?


Takashi
