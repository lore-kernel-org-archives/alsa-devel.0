Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F3606A91D
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=BEbSVlAC;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AQim8VLD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+B+Rr1Nb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SShI2Dm8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8xljWlZX
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69FEC601FA;
	Mon,  2 Nov 2026 15:33:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69FEC601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793630023;
	bh=0nn0+0x229EWlhvjTSEUB1qOZ1fAKJblEiQrZIKy3mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BEbSVlACkymIx48ZpiHuQcYV4bqpGznUW4kAljAGrZJYoPd+yy5LTwTmp09NVVd1h
	 1YjLhuEcfLl9fZm8P1JjKtf1MQJlhOUwI8WYzS66SnOy58MEFR5ySwfHcF2yF1U58E
	 CUhnRLh5BK0gCKPWdReJ4+QmnKNTiLsD68/JBmzA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEA64F805FA; Mon,  2 Nov 2026 15:33:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35F13F80600;
	Mon,  2 Nov 2026 15:33:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 291A0F8016E; Mon,  2 Nov 2026 15:33:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793629982;
	b=ih13l5NCaCNBONhCKtjJ2FYpblMlUZYYDpvA3QFFwBE7emaTNd1itRezf9XrXEWP1O2D
	 6Mgv5LcWLsJTfLzUFJn1nJ7R+UEUh53OoR9x23MawnImBSZLvwMaqT+BEhhrGchLxGnLn
	 kij5BLvBISSDGjyA71CURRGl9Qrc+2uk2Ouk7Cfzuyqc37gl5XX03uuks3ENAG+ydbs81
	 sOiTrMCqmc/aR89PL/OYfVBrLlW1kZEwqj/M7jCcL/JWAFKtSugcJyML8xVTi94iXegiK
	 k0YaIFJoct2D+eUy3bjQI/GCazwfiYfYXBYOjYiPutxQcLp3PPDJLNnf8iTKqrc+t3w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793629982;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=0nn0+0x229EWlhvjTSEUB1qOZ1fAKJblEiQrZIKy3mU=;
	b=YFNIjM9Mzk5XGnl6VrZOF32w+hQ66G62SqNhE7v2WLAZPLGAXBzeWGTShj6kPfxlbyaL
	 8+59FfIfSAa9tmzOLjs4Irw1MjNq+ZamQjaeTirLAcmFT1DsmkVTFFKaW1We75i2V/rDw
	 830yQstEhopVpMtWYk3mC6jjOpZiqPgYAUeEB5iCXwMzwpo+vwphRf1W5IX6RVZfVr8bH
	 cBT2JaHYAkcpB+/z/1UJU/wp4EFwuJJrbKBWgt2h2zPVbX7jnC4rlmqG34qD3/a5080m4
	 CYUB737k0uglHi7T5hl9N9IGkmeHI8UDZ+lI0AuGsccepexk7RzBcqKnBYeHK+mkyog==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=AQim8VLD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+B+Rr1Nb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=SShI2Dm8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=8xljWlZX;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BFB75F80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 15:33:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFB75F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=AQim8VLD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+B+Rr1Nb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=SShI2Dm8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=8xljWlZX
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96BB31F38F;
	Sat, 31 Oct 2026 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793465848;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhiIwvADJajh3RbHDwL/JDcA8HU7Bu/kdL+MLxWhn4=;
	b=AQim8VLDAfZ2B0MG15a44DFFH3lTH9uxZ0FEkdCt+KKY9mHHnKz+udEE6ieQiE7ES1xryN
	Dt8yHRz3lyKW/kOvuacPoK7UZBmT3rGAnpuHyZ89aFDRvbOy3QiDTzpH3GNDsPI7ZHxRZ1
	kSzIY9CUiRYehWeKim59z7Sb9zl33tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793465848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhiIwvADJajh3RbHDwL/JDcA8HU7Bu/kdL+MLxWhn4=;
	b=+B+Rr1NbzzLi+IbWn4BrqWkUTRQakoYBuBHt9TY3gbgrT15ST2fyBPBA7djfkeGvNx3iPd
	gWTF0nLUIyC8raAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793465847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhiIwvADJajh3RbHDwL/JDcA8HU7Bu/kdL+MLxWhn4=;
	b=SShI2Dm8GHXidWTZIQ/+2pbnZSiXK/4tgljKcyAQtEAu76jKd12xUjUmIxE8egJKN2r9oh
	os8Z+nwFrJKmEu8DsmVXBkRo88ETIQ1muOclUW9p/IY+mYPtwXa4t6LiCf+CK4/aV52QYi
	scetrf4VO3IYvctRrnqSN7TGdpI6HY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793465847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhiIwvADJajh3RbHDwL/JDcA8HU7Bu/kdL+MLxWhn4=;
	b=8xljWlZXMHnEby8ymRgHWTDKAicRPYtqXs0Bg6ywWfglWBrjWqyTzUGYApBQppbsdkt2xE
	OMImbAmZl+XK2ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28B04132D3;
	Sat, 31 Oct 2026 16:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AWBwO/Yd5mp8ZQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 16:57:27 +0000
Date: Sat, 31 Oct 2026 17:57:26 +0100
Message-ID: <87bj89reo9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: RenPanpan <rppxj178543@163.com>
Cc: alsa-devel@alsa-project.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [DISCUSSION] ALSA: usb-audio: Card naming for composite devices
In-Reply-To: <20261030121740.250336-1-rppxj178543@163.com>
References: <20261030121740.250336-1-rppxj178543@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: L2HK5TQPFQ4FN2ZPVVYTFUWJTYJ6D3YR
X-Message-ID-Hash: L2HK5TQPFQ4FN2ZPVVYTFUWJTYJ6D3YR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L2HK5TQPFQ4FN2ZPVVYTFUWJTYJ6D3YR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Fri, 30 Oct 2026 13:17:39 +0100,
RenPanpan wrote:
> 
> Hello,
> 
> I'd like to discuss an issue with USB audio card naming for composite
> devices and propose a possible improvement.
> 
> Problem
> -------
> 
> For USB composite devices containing both non-audio and UAC audio
> functions, the ALSA card shortname is derived from the device-level
> iProduct string, which describes the entire device rather than the
> audio function.
> 
> For example, the CVT Touch Device (1ff7:0f33) is a composite device
> with HID touch interfaces and UAC audio interfaces. Its iProduct is
> "Touch Device", which is the name for the whole device. The UAC
> OUTPUT_TERMINAL descriptor defines the audio function name as
> "MAXHUB Speaker" via the iTerminal string descriptor (index 14).
> 
> Currently, the ALSA card name shows "Touch Device", which does not
> identify the audio function. The UAC mixer code already reads
> iTerminal for mixer control names (e.g. "MAXHUB Mic" from the
> Microphone INPUT_TERMINAL's iTerminal=17), but the card naming
> function (usb_audio_make_shortname) does not use iTerminal.
> 
> Proposed approach
> -----------------
> 
> When the USB device is composite (i.e. it has non-audio interfaces),
> prefer the Speaker OUTPUT_TERMINAL's iTerminal string as the card
> shortname, instead of the device-level iProduct. If iTerminal is not
> set (zero) or not readable via usb_string(), fall back to iProduct
> (existing behavior).
> 
> Non-composite (dedicated audio) devices are not affected and continue
> to use iProduct.
> 
> The composite device detection checks whether any interface has a
> non-Audio class. The iTerminal reading uses the existing
> snd_usb_find_csint_desc() helper to parse OUTPUT_TERMINAL descriptors
> in the Audio Control interface's extra data. The iTerminal field is
> the last byte of the descriptor, common to both UAC1 (bLength=9) and
> UAC2 (bLength=12).
> 
> As an immediate fix, I have also prepared a quirk entry for 1ff7:0f33
> to override the card shortname to "MAXHUB Speaker" directly.
> 
> Questions for the community
> ----------------------------
> 
> 1. Is this approach reasonable for composite devices, or should it
>    remain a per-device quirk?
> 
> 2. Are there concerns about changing card names for existing composite
>    USB audio devices that have iTerminal set? For example, UCM profile
>    matching or PulseAudio device identification.
> 
> 3. Would it be preferable to also check the IAD's iFunction field
>    before falling back to iTerminal, or is iTerminal sufficient?
> 
> 4. Are there known composite USB audio devices where the iTerminal
>    string might be empty or contain unexpected content?
> 
> I have tested the quirk approach on a MT81C device (Kylin V10-SP1)
> and it works correctly. The iTerminal approach compiles but has not
> been tested on multiple devices yet.
> 
> Any feedback would be appreciated.
> 
> Best regards,
> RenPanpan

I took your first fix patch as it was simple enough.
(It took time just because I was traveling in the last week.)

If it still doesn't suffice, let us know.  Thanks.


Takashi
