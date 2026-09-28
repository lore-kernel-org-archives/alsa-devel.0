Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A09C9833F
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:56:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91364601EA;
	Mon, 28 Sep 2026 15:56:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91364601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790603782;
	bh=dpjRVqqdpbFBy5bzupRdBusR8ASHtrt5mSY6V3JJi7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VJJ2NjSaNv75RnIeeNSVoyHec3UeWdDDZ5TaAcdz9W67jwxCxR4i0DrHWZEeYPP9I
	 3/b6C+FkbPxjygzMeNpJr9H/Y8o5bNM4khrIC9TqdO/ipPKi+yqrXEKKLZ8pv+YlDa
	 YPX2SmM+FKnrsp5H/CuJwXzoHhlBDrRLaWMY20EE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C8D4F805FB; Mon, 28 Sep 2026 15:55:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF4E6F805FF;
	Mon, 28 Sep 2026 15:55:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA211F80525; Mon, 28 Sep 2026 15:55:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790603741;
	b=jAN/t/eNWXd0xG+uzsu5TTnmD61S8jHVgJ7168VD8eWkWMFCABOkjs4JbBct5tndIi4f
	 EsGWARG0Pv5T6ee9lmnr58cb7rSS/f+9Ovr7Be75lZ2H41nwvivzJa9I4IvVh/2dFw51p
	 rQQbSOImWh1q2CcfhgozKqaqkIs5cMa4jHFk96TKUr4KHmHoxU1MbIWpsiiwFhmEu6v9I
	 H6B/iFBdPYHonnqtU+mcthbHMP/A6a4rIWjsrZvqV3tSBO47ZJYbJZ6iudS5yJQ+CnQpf
	 tCEq8+PeWAfHEYhuChDXkMFndhMyjsF+xeX+d0ChJvS54jSwovMf4+1jPwOc0bGI7/w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790603741;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=dpjRVqqdpbFBy5bzupRdBusR8ASHtrt5mSY6V3JJi7Y=;
	b=X+3FCf0SDbgVARjjv+t5vvt4cmkdVYRtgT8cLUdb7wfgRKqOKl2D7UG+5X/2+ji9D1Ls
	 HN2yJ35diTlAtDdVurfKrLm3MTkCd4FFFp5mfJ4tX8A3/3YiqY8N/DU+6Ylri5xuTLKzd
	 xPkIwh92tdV6w5TBGnch5SgGhH7/5qcYJuHkISXkszEBGggt9sHbA1F/JiwyDZyUbmoEr
	 OVrZ6ESFrE7IgWT2mUpDTuPhPttmeaIPlebRbWNieOdTYQ2dMpUwDtrhzR9HcpX2ak9B3
	 btg66v6sSCqfeq9o3e3IKj37Lrgdo1FYgwWIGjw8cLX4Vf1kZPX//7C7X9mkeaq0kEw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=EMcWdQVX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fbOKYax4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=rYY2TWGq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X6Lq3ZYv;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D00FEF80301
	for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2026 15:55:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D00FEF80301
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=EMcWdQVX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fbOKYax4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=rYY2TWGq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X6Lq3ZYv
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC9D821BD4;
	Mon, 28 Sep 2026 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790603736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aYByQM/SeGkmsxYiU0kL9QzGHYWJSWl0AcN13rheuE=;
	b=EMcWdQVX7XLem2pX7GB/w0KeYM+t166brqsyt2fvnDOQ2cDnKCUg+QkxOpbyPt451AFxVx
	KY94pSzk1NCsPEvVB6oUJZi2D0U+UOqTYAbblguVmyLu3Lb3J+Hjo5JR4iR0aBkzD1ZKY0
	O0YXsCMrcX002yyI6PM6R4BJFdb6f4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790603736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aYByQM/SeGkmsxYiU0kL9QzGHYWJSWl0AcN13rheuE=;
	b=fbOKYax48oZiBV7PwZV84gaFPGNxEoudr8WxHMUz4ccAeKUQBiGwPKEN3BisKI+RdQZAVQ
	0YClzDqqnfnsjPAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790603731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aYByQM/SeGkmsxYiU0kL9QzGHYWJSWl0AcN13rheuE=;
	b=rYY2TWGqakm/Pq5cjD9WLftHmyENetQz0p1gPErGoA/8sOVg4nqF7KgPhud+3ztTd5SlUK
	nu+faRtLv9qyVl+ImPd+W2X5IRsEBoJRIWYQEPtixFMm7FhDOwYa4q2wZ+qzdXZBTNu3aW
	HGapvPnf0CNEOXZIFsd2t6f0EvNzV3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790603731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aYByQM/SeGkmsxYiU0kL9QzGHYWJSWl0AcN13rheuE=;
	b=X6Lq3ZYvYNL79Q/Bt6MRz3hfoidFIuq+K3v04caRM0gAzw4KxOUSyWfFY/NsGbMPlRk/A0
	vpkcNX/0sYmglhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6121133F3;
	Mon, 28 Sep 2026 13:55:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QSO5HNNxumogWQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 13:55:31 +0000
Date: Mon, 28 Sep 2026 15:55:31 +0200
Message-ID: <87o6dh4h0s.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bartosz Brom <bartosz.brom06@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add mute LED quirks for HP Pavilion
 15-eh3174nw and HP Laptop 15-dw1xxx
In-Reply-To: <20260928134335.1875-1-bartosz.brom06@gmail.com>
References: <20260928134335.1875-1-bartosz.brom06@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: J6DFILOHAPARCUJLJULIOZ5NYECJMLHH
X-Message-ID-Hash: J6DFILOHAPARCUJLJULIOZ5NYECJMLHH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J6DFILOHAPARCUJLJULIOZ5NYECJMLHH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 28 Sep 2026 15:43:35 +0200,
Bartosz Brom wrote:
> 
> The HP Pavilion 15-eh3174nw with an ALC287 codec requires the
> ALC287_FIXUP_HP_GPIO_LED fixup for its mute LED to work correctly.
> 
> Add subsystem ID 0x103c:0x8bc7 to the quirk table to apply the
> existing fixup.
> 
> Tested on an HP Pavilion 15-eh3174nw; the mute LED now follows the
> speaker mute state.
> 
> The HP Laptop 15-dw1xxx with an ALC236 codec requires the
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO fixup for its mute LED to work correctly.
> 
> Add subsystem ID 0x103c:0x85f1 to the quirk table to apply the existing fixup.
> 
> Tested on an HP Laptop 15-dw1xxx; the mute LED now follows the speaker
> mute state.
> 
> Signed-off-by: Bartosz Brom <bartosz.brom06@gmail.com>

Applied now.  Thanks.


Takashi
