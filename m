Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B23C79F99
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 19:30:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFE7960200;
	Mon,  7 Sep 2026 21:29:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFE7960200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788809399;
	bh=KpGqBl13nn4DPR5k/TSPm1PxekCvu8cNp3XWXyscq0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=piRQWrLtXr583F0ARe6gjVVxIOf8HZK9y+FpvOiAf0R4IMQG7le3YOMyUzU9usRiO
	 2PePpKYaOhASM6igeQGH91HkuTH1EHJSK9Du4uRcaytF3prrmo1X4ysBXO+OwlADMv
	 HFKYTAN+J/GcTiOYvzhs4iMQV+bvHogyvDu6D3ss=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81E4FF80610; Mon,  7 Sep 2026 21:29:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1399FF80611;
	Mon,  7 Sep 2026 21:29:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB2CFF80589; Mon,  7 Sep 2026 21:29:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788809366;
	b=ljBEwctf5RLC1mDagRpzelWqrlmb72XCpKoqInjvWrof7uPIbOlENYh+Tlx/0z0Chu1i
	 MBvvrT7XUMIJ4vW/uGZ7s5x4JTXR3JqkE3Hn8mF97iKko8FvZCGz8dOdsLY91TT/POH1l
	 W+i9qFTn2Xr9afKa42ZiUQ+nSFMWvCYe8I2aBglfISp7lYoIPIYM+Ssbi+3QqWrLec4CC
	 G+Hd2rWXbNwy+roFeNV8vq2pBDRrYjbggjsQgpotgdBNRT1Jqgfqac9MKGikH28OmOGOW
	 eNIQ3574u5oxHnU7B/GBaEBwjTS2zloLx8e5jEx40DYDFKesLVOIddv3hzq7bItIjfg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788809366;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=KpGqBl13nn4DPR5k/TSPm1PxekCvu8cNp3XWXyscq0c=;
	b=qkdJ9A1Y6GIPEh6UN+9RtN4TL4a/QjJIB9gSW4oRkTudX9dQuqeqtlWhvz2E3/0X+Bgg
	 UvyfYRoJxRPOKRT7ZHkoQCRRFbBW9ToZpHSHBKvpyCpayY3Ea//k4AONN/5PcMn+UiOTf
	 tZJO/gA1TDULi7070es6cWJKnV5mxZQLfVXFUuO9A3wxj5CzXYDLAsMCgeZqozsQ6VBoI
	 oPAMiCUWeyYPapDL5JIPA0sPLiCBehqHrdobLEdoAYsqIXQCkv0xpZmRgoVo8+wH6Hy99
	 DuPLsvQaEi2ewXCFvROHjWrA3h7aNl7k5wTFO94IgHjTDqDtpV2Wj391/HZs15QdpyA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Vy6UY5Ao;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IWnD2QkB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="ZA8/+/ej";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=v4CwVYGM;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1B07F80088
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 21:29:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1B07F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Vy6UY5Ao;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IWnD2QkB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ZA8/+/ej;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=v4CwVYGM
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 445661F456;
	Mon,  7 Sep 2026 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788809360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyRykY7n9TjE6RWlEb4cJkZfh+EywU6P8QqTsSWIsO8=;
	b=Vy6UY5AoOOzZsx7t+qaW21PSObblxxopNLxajS9waGPEa3EwkDOjdQ2jLhbzTRqI5KkVTx
	9QUyWLgiaFleW50ZjdycaX77D3PoYvlV4hL2eO+KfaeszdZweZ9Joa+bwXpCZOaxH1ryE9
	OkFlLnJ1n4x+5iuMSgba1qstFpVYvcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788809360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyRykY7n9TjE6RWlEb4cJkZfh+EywU6P8QqTsSWIsO8=;
	b=IWnD2QkBy/MQLex7J3UlrrxXPckNvK3Ql/4DPdsmUYRw95GIV+qBxUktlxzqNFPzTVHhbv
	fFi6dzTZo/WZxaBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ZA8/+/ej";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v4CwVYGM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788809356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyRykY7n9TjE6RWlEb4cJkZfh+EywU6P8QqTsSWIsO8=;
	b=ZA8/+/ejaI87CyNIbATD2llGlLOwbwtFd03c1IFbY2+IVqN09MHhBu/vlucnjfujM5/bHA
	YQWo4X/WkLVqq5ald0YIOo+9m60g/802pzdWta+dgGb2U9vmC6MC2XtOzC387lWDqq9e62
	Jl42If9xirQ0a5XgAbudTvL8vh9sApA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788809356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyRykY7n9TjE6RWlEb4cJkZfh+EywU6P8QqTsSWIsO8=;
	b=v4CwVYGMIUteKJQb13/Bxx+71UhejwUIIJ4KvDDWXSW5fA21IIQQZE71UGFrUrI/7nYBSe
	B5GdTUaVRwBHwbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA8413432;
	Mon,  7 Sep 2026 19:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bT+dOIsQn2pwRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 07 Sep 2026 19:29:15 +0000
Date: Mon, 07 Sep 2026 21:29:15 +0200
Message-ID: <87qzj4rhbo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ALSA: seq: Fix port lock leak in
 deliver_to_subscribers()
In-Reply-To: 
 <2026-09-05-daily-reply-0029-alsa-seq-port-lock-leak-5-15-ack@kernel.org>
References: <20260904070409.80648-1-tzungbi@kernel.org>
	<2026-09-05-daily-reply-0029-alsa-seq-port-lock-leak-5-15-ack@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 445661F456
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: BOKPNAKTINBL5AZVG4C7QTA6YPN7TUG4
X-Message-ID-Hash: BOKPNAKTINBL5AZVG4C7QTA6YPN7TUG4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BOKPNAKTINBL5AZVG4C7QTA6YPN7TUG4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 06 Sep 2026 15:32:59 +0200,
Sasha Levin wrote:
> 
> > Commit 46397622a3fa ("ALSA: seq: Add UMP support") mistakenly removed
> > the `snd_seq_port_unlock(src_port)` call in deliver_to_subscribers().
> > As a result, every time an event is delivered to a subscriber, the
> > source port's `use_lock` atomic counter is increased but never
> 
> The fix itself looks right - restores exactly the unlock that
> 46397622a3fa dropped, nothing else touched. But there's no mainline
> commit backing it (the actual upstream fix would be 177ccf811df4, which
> is a MIDI 2.0 feature commit and not stable material on its own), so
> this is a stable-only fix and needs a subsystem Ack before it can go in.
> 
> Jaroslav, Takashi - can either of you Ack this for 5.15.y?

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
