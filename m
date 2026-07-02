Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8798DC43458
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:31:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DD4C60228;
	Thu,  2 Jul 2026 09:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DD4C60228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782977505;
	bh=q69LaiHCrojBoEGBTkVRb7G26K4YRG47LKLxeyoryCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ntnd7RrQGyp3REP2cIxs5GwstyLzRyzikWcm49HspqlgWm/2Rv5uy9M2eEZMwxtsn
	 vhhx5ZVWe6WXiW46/QOXFZesZGaBL/teSMxcSIMFudx9GkirtlTBhG9ZQsVkvrvJi5
	 GudsHqjcZXPchE//grr1XfbHJVxh8XcFVqKSk/mY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B0BFF80600; Thu,  2 Jul 2026 09:31:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE7E3F805F8;
	Thu,  2 Jul 2026 09:31:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04B74F805CB; Thu,  2 Jul 2026 09:31:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782977457;
	b=ozhz1LVg6BnQLYio3bx/fXonNgGxUlXlRTRUn1yEaGYhNtr9V6eo0hDDiANWAWGpkMVl
	 zTzo6CrQW0xhw8ZWVYyf8OUFl+MQ0EFgGAF5LuP5NvfbYjvCl6AlIhJ0u1ioSTd5E4G5A
	 ylkAG05xU4uSEIhme2i7Gwj4DXNEG8qmQ/mwkOugZg3Ua4GUKXV1cHPg2B/AJ/swfmlbV
	 DuxHAGblr6Og8q9+LNml+VgNnPZQ+VSCx2+K0qqTyCStUuUEPiJpogvm5NO6u1R+ZgM2V
	 U0AtJo2XL+SjMcap7axvIq7dOODT9Jhg6doEx94X1xyvm7sMUEQrgL9Y+tEQGrxJSLQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782977457;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=q69LaiHCrojBoEGBTkVRb7G26K4YRG47LKLxeyoryCo=;
	b=VzmWI+W3WMifaivw5NYU+wvMNWAbo9BxUESvaWoGZ1X6MLWfEtSEqa+Ngc+WRLFJbTne
	 s3UZPMGOY9V/eQmrqkYhVdEui+p/f7ed3swhm2RPoTTt1mqU7BHvM2Nul/wKbQoI5hrbe
	 j03V0wIhNK/AZZ73/aIeQvtp2r4XtIHQpP4YzojzypfUClLUMluMjxdwxGX/9NNRu/uzw
	 vOU/rC7jluiUjMw5IM9IfZf7sKjLOahXmqF/QyV4gYPCuOSsuHUYpMPsDcaolGe1CfFvm
	 o9+dERHMXQCtrKJsFpQ9w7i9Rwnlf6er7cjAmaR45NXvuys+jxhgeUdWTcsmleloF5w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=2MgEoX+N;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=uRJYUl36;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="G/AKcXJa";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=21ovMkdf;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 28F5CF8012A
	for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2026 09:30:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28F5CF8012A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=2MgEoX+N;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=uRJYUl36;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=G/AKcXJa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=21ovMkdf
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E582C7335E;
	Thu,  2 Jul 2026 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1782977455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EpYbDR00VZeB39O0TdzMdXXaD0LZKTrJIhNd++GVbQ=;
	b=2MgEoX+NAuqt4dwzmJbIWOfJOgIDBpgOJZRlaVd2Lci3ZwiYK0JN6QkIEWOS9swi9hMrVF
	H9jzcDXwmoHjJYtXuJhz0+ETGEOCNWLNS3GS53p1th6rmyDSjQfdYEDDS/XFI9TU6fsJWh
	ih2B5hA9fd/azXT3AYOQytDTHvqqQAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782977455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EpYbDR00VZeB39O0TdzMdXXaD0LZKTrJIhNd++GVbQ=;
	b=uRJYUl36OUw4jEKdpPf4MuVzQp67a/sZ+Z029rwvRhXI4MS7T/r/BoY5KR//fmeoTT6bWr
	PHhPdLIJQYpyeBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1782977454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EpYbDR00VZeB39O0TdzMdXXaD0LZKTrJIhNd++GVbQ=;
	b=G/AKcXJaKMc9qT4co59EIQbv60xt3b2p0LYtKQX4GCDcfhXoQuFyBmjUrSeTNW498Ul8tt
	b0IiFvIxwVNa/ad3omPpJ8Y8T1DZbCyajPpfuA97gk6duZ2Bj64n6tCGmHtLlEGdyT25hH
	SkGItgW5yRSvaybdLbjP1JF5UJUyr1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782977454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EpYbDR00VZeB39O0TdzMdXXaD0LZKTrJIhNd++GVbQ=;
	b=21ovMkdfCKaO+zKEJrW6on7FIJ2jFM9jI3vVkWwHMJt/fnLw+dvS6OE1u2RmxH7Pi/e1r4
	5iLazB3rhZA9kPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2EF9779AA;
	Thu,  2 Jul 2026 07:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VT5jLq4TRmq9AwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 02 Jul 2026 07:30:54 +0000
Date: Thu, 02 Jul 2026 09:30:54 +0200
Message-ID: <87cxx5alw1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Omer Cohen <nevergfx1@gmail.com>
Cc: broonie@kernel.org,
	alsa-devel@alsa-project.org,
	security@kernel.org
Subject: Re: [PATCH 0/6] ALSA: sound/core: fix multiple data races and bugs
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: JOOQWLCZ7BXJBH5WK3BU2OA5CIIWZGEJ
X-Message-ID-Hash: JOOQWLCZ7BXJBH5WK3BU2OA5CIIWZGEJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JOOQWLCZ7BXJBH5WK3BU2OA5CIIWZGEJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 26 Jun 2026 15:47:03 +0200,
Omer Cohen wrote:
> 
> To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Cc: security@kernel.org
> 
> Hi Takashi, Mark,
> 
> This is my first patch series to the Linux kernel.  I am CCing the
> security team as recommended by the docs for initial reports.
> 
> This series fixes 6 bugs found via code review and KCSAN dynamic
> analysis in the ALSA sound/core subsystem.  All patches are against
> current HEAD (4edcdefd4083).
> 
> Patch 1 is confirmed with KCSAN.  The remaining patches address bugs
> found during analysis of the same code paths.
> 
> This work was AI-assisted.  Per the kernel documentation on reporting
> security bugs, it is sent to the public mailing list.  All
> reproducers have been tested on arm64 QEMU.

Maybe my previous mail didn't reach you properly, so I ask here again
(with keeping Cc at this time):
could you resubmit to linux-sound@vger.kernel.org ML, Cc to
linux-kernel@vger.kernel.org, instead?  Since some time ago,
alsa-devel ML is only for user-space stuff, and the kernel patches
should go to linux-sound ML.

Also, please double-check that the issue is still reproducible with
the latest Linus tree beforehand, too.


thanks,

Takashi

> 
> Summary:
> 
>   [1/6] ALSA: compress: remove illegal state mutation in poll()
>     snd_compr_poll() writes runtime->state = SETUP when it sees
>     DRAINING.  This races with snd_compress_wait_for_drain() which
>     reads runtime->state concurrently.  KCSAN confirms:
> 
>       BUG: KCSAN: data-race in snd_compr_poll / snd_compress_wait_for_drain
> 
>       write to 0xffff0000c75c8200 of 4 bytes by task 282 on cpu 3:
>        snd_compr_poll+0x29c/0x2c8
>        do_sys_poll+0x2b0/0x628
> 
>       read to 0xffff0000c75c8200 of 4 bytes by task 279 on cpu 1:
>        snd_compress_wait_for_drain+0xa4/0x270
>        snd_compr_ioctl+0x1ba0/0x1bc8
> 
>       value changed: 0x00000005 -> 0x00000001
> 
>     poll() is a query operation and must not mutate state.  The
>     DRAINING->SETUP transition is already handled by drivers via
>     snd_compr_drain_notify().
> 
>   [2/6] ALSA: compress: fix buffer leak on set_params driver failure
>     If ops->set_params() fails after buffer allocation, the buffer
>     leaks on retry because runtime->buffer was already overwritten.
> 
>   [3/6] ALSA: timer: fix lockless tu->tread read in read()
>     snd_timer_user_read() reads tu->tread without ioctl_lock to
>     determine entry size, then re-reads it under lock for the copy
>     format.  A concurrent TREAD ioctl can change the format between
>     reads, causing a size/format mismatch.
> 
>   [4/6] ALSA: timer: copy queue entries under lock before copy_to_user
>     After dequeuing under qlock, read() drops the lock and calls
>     copy_to_user() directly from the queue slot.  Timer callbacks
>     can overwrite that slot via queue wraparound during the copy.
>     Same bug class as CVE-2017-1000380.
> 
>   [5/6] ALSA: pcm: use locked state read in snd_pcm_drop()
>     snd_pcm_drop() reads runtime->state without the stream lock.
>     Commit 7bc02ab446d3 fixed this pattern in read/write paths
>     but missed drop().
> 
>   [6/6] ALSA: rawmidi: propagate resize_runtime_buffer() error
>     snd_rawmidi_input_params() ignores the return value from
>     resize_runtime_buffer() and unconditionally returns 0.
> 
> KCSAN reproducer for patch 1:
> 
>   The race is triggered by concurrent poll() and DRAIN ioctl on a
>   compress offload stream.  A minimal reproducer uses four threads:
> 
>     Thread 1: DRAIN ioctl loop
>     Thread 2: PARTIAL_DRAIN ioctl loop
>     Thread 3: STOP ioctl loop (random delay)
>     Thread 4: poll() loop
> 
>   The main thread repeatedly sets up and starts the stream.  With
>   CONFIG_KCSAN=y and CONFIG_KCSAN_STRICT=y, the race is flagged
>   within ~2000 iterations.
> 
>   Any compress offload driver (hardware or virtual) exposes the
>   race since the bug is in the framework, not driver code.
> 
>   Tested on arm64 QEMU, kernel 7.1.0-rc7+ (4edcdefd4083).
> 
> Thanks,
> Omer
