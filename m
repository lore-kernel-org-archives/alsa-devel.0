Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0795FFF60CE
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:37:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E541160197;
	Tue, 31 Mar 2026 08:37:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E541160197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774939048;
	bh=kJ3Bk6M2MTNQgL1/ZGB8PoT58cFcVJQUR5MirL31AQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Rl+z/f+wezdI7GcZEA0+xtDHL1bzPUONAuLiKrmDRUChACnitNwzvN9N2p7Gj6IgE
	 ymglzQ+1Pgg3ndhGBlJjXapBIfyKgIHKFZk5n+bqtEi2owZtN2SJZQjZNHOyeYjvnV
	 ZP+wkRypnx3UNKYLOv/iAg32h/iwnXJjmbaW/XPw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5236AF805B3; Tue, 31 Mar 2026 08:36:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D90EF805E7;
	Tue, 31 Mar 2026 08:36:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A4BAF80549; Tue, 31 Mar 2026 08:36:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A3611F804CC
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 08:36:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3611F804CC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=dTBJfDJZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gpbmHWIz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=dTBJfDJZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gpbmHWIz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8382C4D541;
	Tue, 31 Mar 2026 06:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774938989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2woUnOnzHe2oo5TWd+W+6ys8rxmRo3CGNSJi1h73a6o=;
	b=dTBJfDJZ15L+FeLm7QHXmJ0wjz3V1S5QPJt9lxjYN904KBW4I1W9g6tv5JRYn9mMIzTIbU
	NtDHDKarVEv1fmlU79W+OaRroaa70t4r8L6Tj4/kEtSd68FW/8kksOvqZa/1KWxPK8YWA5
	M79CrDushBOywiyk/xC9BcrLs3MGbb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774938989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2woUnOnzHe2oo5TWd+W+6ys8rxmRo3CGNSJi1h73a6o=;
	b=gpbmHWIzpddcDxanFd+HA9y6kn61DS4P6o8FtwutrWsbNKzvFc8kpbL4KwQjlmIvsIiQRr
	2kArs1D9yPed5zBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774938989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2woUnOnzHe2oo5TWd+W+6ys8rxmRo3CGNSJi1h73a6o=;
	b=dTBJfDJZ15L+FeLm7QHXmJ0wjz3V1S5QPJt9lxjYN904KBW4I1W9g6tv5JRYn9mMIzTIbU
	NtDHDKarVEv1fmlU79W+OaRroaa70t4r8L6Tj4/kEtSd68FW/8kksOvqZa/1KWxPK8YWA5
	M79CrDushBOywiyk/xC9BcrLs3MGbb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774938989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2woUnOnzHe2oo5TWd+W+6ys8rxmRo3CGNSJi1h73a6o=;
	b=gpbmHWIzpddcDxanFd+HA9y6kn61DS4P6o8FtwutrWsbNKzvFc8kpbL4KwQjlmIvsIiQRr
	2kArs1D9yPed5zBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BD384A0A2;
	Tue, 31 Mar 2026 06:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DuJJDW1ry2k1IwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 31 Mar 2026 06:36:29 +0000
Date: Tue, 31 Mar 2026 08:36:28 +0200
Message-ID: <878qb8tsib.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Linux-ALSA <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	arun@asymptotic.io,
	wim.taymans@gmail.com
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
In-Reply-To: <dadef18b-1c2e-4c0d-8ae8-2e4b8ad75d04@linux.intel.com>
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
	<87se9htms4.wl-tiwai@suse.de>
	<67b9f48b-1cc7-4dac-8f6a-c0cba6a84b36@linux.intel.com>
	<87ikadtgpe.wl-tiwai@suse.de>
	<dadef18b-1c2e-4c0d-8ae8-2e4b8ad75d04@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,kernel.org,linux.intel.com,alsa-project.org,vger.kernel.org,asymptotic.io,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: 7O73HEOYHMF33COCVUN6MSBQHELKCDVU
X-Message-ID-Hash: 7O73HEOYHMF33COCVUN6MSBQHELKCDVU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7O73HEOYHMF33COCVUN6MSBQHELKCDVU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 31 Mar 2026 08:00:56 +0200,
Péter Ujfalusi wrote:
> 
> 
> 
> On 30/03/2026 19:39, Takashi Iwai wrote:
> > OK, then I'd say that the existing fifo_size doesn't fit fully for
> > this kind of stuff.  e.g.
> 
> We came to the same conclusion with Jaroslav, and the plan is to
> introduce two new parameter in hw_params:
> init_chunk and step_chunk, both in frames.
> init_chunk - is the size of the hw_ptr jump right when the start happens
> step_chunk - is the runtime jump size which happens every step_chunk time.
> 
> for example:
> init_chunk = 100ms
> step_chunk = 1ms
> hw_ptr moves 100ms on start (pointing to 101ms), after 1ms of time the
> hw_ptr will move 1ms ahead to 102ms, in another 1ms it again moves 1ms
> to 103ms...
> 
> init_chunk = 100ms
> step_chunk = 96ms
> hw_ptr moves 100ms on start (pointing to 101ms), after 96ms of time the
> hw_ptr will move 96ms ahead to 197ms, in another 96ms it again moves 1ms
> to 293ms...

In the second example, where does 1ms offset comes from?
  hw_ptr moves 100ms on start (pointing to 101ms)

I thought that this 1ms is the step_chunk size in the first example...

> Note, the first is theoretical, with SOF 1ms step is used only with
> 'small' DSP side buffer:
> 
> init_chunk = 4ms
> step_chunk = 1ms
> hw_ptr moves 4ms on start (pointing to 5ms), after 1ms of time the
> hw_ptr will move 1ms ahead to 6ms, in another 1ms it again moves 1ms to
> 7ms...

So, init_chunk is the size to be filled up at the start, something
similar like sw_params.start_threshold, but it's rather a hardware
requirement.

And step_chunk is essentially the hw_ptr granularity?

> I'm not sure if we want these to be snd_pcm_uframes_t types in
> snd_pcm_hw_params or should be u32 simplify the shrinking of reserved..
> 
> -       unsigned char reserved[48];
> +       snd_pcm_uframes_t init_chunk;	/* in frames */
> +       snd_pcm_uframes_t step_chunk;	/* in frames */
> +       unsigned char reserved[48 - 2 * sizeof(snd_pcm_uframes_t)];
> 
> with u32 we can simply change the reserved size to 40, which is anyways
> going to be the case for the snd_pcm_hw_params32{}

In my idea, it may be configurable, hence it belongs to interval, so
it's two in ires[9] for the reserved intervals.

> > if a device allows a different queue size, it should be configurable
> > via hw_params.
> 
> I'm not sure if I follow this statement. the fifo_size is a driver to
> user space information, driver fills it and user space ignores it ;) - I
> cannot find any evidence of it's use.

If a chip has a similar constraint but the init and step sizes are
adjustable, they should be configurable via hw_params procedure --
that's my point.

> The init_chunk, step_chunk would be similar, the driver sets it and user
> space would use it.
> 
> In SOF this will be dynamic and it will depend on the period size:
> https://github.com/thesofproject/linux/pull/5673/commits/18f3ba5e42212d77019d79ec09b7057a7703d361

Well, so even in your case, the driver can implement the hw_constraint
for coupling those numbers, too.  Then application may choose the
init_chunk or step_chunk, which restricts the period size
automatically.  If application doesn't choose those, the hw_params
engine will choose depending on the period size, and application can
see the values after hw_params call.


thanks,

Takashi
