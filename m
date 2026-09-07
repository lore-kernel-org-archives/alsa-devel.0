Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8C4C79FA0
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 19:29:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3A47601F0;
	Mon,  7 Sep 2026 21:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3A47601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788809380;
	bh=bxCnbJv2NHU6LpFtUEyIFPJaOYh5eYwEuIE0ScvRX0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=c00ows1Q/r70WtHYCfA1Qg/yYYkTcO2iBsYgX7gQ8VL/Q0JvqwhbGPbZOJfM9+EMk
	 GNKQ/a2kxZ6ISYaZawktWggr/JxQdBC3D10G4WXYIINx8P7v2wjOa2PLZDJEYUujDx
	 OeUaaBQAiO0pQhzQknRIGlkXuywXin0E0P+mH1eo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F17FDF8059F; Mon,  7 Sep 2026 21:29:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6522F805F2;
	Mon,  7 Sep 2026 21:29:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BED50F80571; Mon,  7 Sep 2026 21:28:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788809335;
	b=BLzeF5JBf8nhNatEToUfV7teztwey+IU2xAMPDrJXYU0atXupMexJPZCSSa8BeTS1r7p
	 bspfX9Jae7qk+PtD1GacsEtcQfjF6UuBIL+Kgq4GrLzZjA6EC4mUbRT3pKsP4Qooi1dh1
	 Bg+wYWD2UWImj2hYKIDerTkXD1zSa9ewHigur7+ZRNiKjRRl7UBzl6bRT1oiOtcCvP3t0
	 4RCwuEF3j8II1st2Oslki4esroZSaGL8QMLGZ1T0/rFSfLv30Akd31jn7lrsU+sAmGkWr
	 bTpfRJ59jF+5+IRo5aqHA5MsU+M09q9eFIqsm735jXzyQ9I4dczUmfsFDwNZd8UqsCA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788809335;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=bxCnbJv2NHU6LpFtUEyIFPJaOYh5eYwEuIE0ScvRX0U=;
	b=I1cFpuKEs3NKen9zmYUJrBY6yAIPRobyYklH388kT5ibog452KcZYlKaLt9QxH9pJGIT
	 0aYOxLlmmVd/+GABgSag13BqmqXPQLbU5d1qsu9WEE522QPwqFAU0OgswlzJWFfjbyhCv
	 OcDbOuCXOJpMc1Lt5lPq4oE/qVNmX0PaywdSnngdg3m/aBDG+TN6IMxk/bTHjLZtmFj60
	 WeiStcAwf82jlhqohOFV+VaBltppW6bYuo6zHr87Kvfb65/xWxtob9ukV77qtRoS/U14m
	 ZxSSAixFsMhLvZnSwlXFNf6RoXiZuWISzfuaoyGdw/lLYHF7pXkZGevZB2D6vAV7mtw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=eSbBYzKZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rfm3HIoR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=T0Z73obV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Tgg6uuFt;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B2233F800BD
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 21:28:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2233F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=eSbBYzKZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rfm3HIoR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=T0Z73obV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Tgg6uuFt
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BADA41F770;
	Mon,  7 Sep 2026 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788809329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+Hpde8e2aybkeuNuzWphJMB+4Us4v73JxFalFrc+BY=;
	b=eSbBYzKZBUN96+dw/QJstdPAtTEmgI3WlAVAIdUUCUuHF2m/UnZ/hL6CrbjtWpxPlAzOUY
	gsbmjaLQ3MYjOjoVqNXzNyKXcuqHdMGuT7nC2EkCwt3zbLW4T1Bv4cZfZab28J48qx1qXj
	Lj/iLuXS+T99t90Bc7EaV1BjnWqTsNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788809329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+Hpde8e2aybkeuNuzWphJMB+4Us4v73JxFalFrc+BY=;
	b=rfm3HIoRCOdihVeRvKsQk+s6RhsFPJ4A/G5m3Y65g4SnGJOxpmGlw1sqqV5YUsp4fZTyQ/
	3um50TtyDB1uQpBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788809325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+Hpde8e2aybkeuNuzWphJMB+4Us4v73JxFalFrc+BY=;
	b=T0Z73obVEwcbUUThv4jFRmS6oIlOo67YIOMJ15Vm/vcf/McSngE6bQsNgrCOfKUFRPqvDA
	ko+ScJ2VUogOCznrcQsVJySc9zabYrqRt6L0J4z3Woj22nUAZsbLOUhLU6gWCzjZUyiBeN
	Mw2TBmp/mFBM1VV1ZMmVJnAd3G+KgdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788809325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+Hpde8e2aybkeuNuzWphJMB+4Us4v73JxFalFrc+BY=;
	b=Tgg6uuFto45BmpwZeuVcwTwQUOtmGx5mmWZ8xfEjPZOCD5PA5ekhepfiVmCYCZhOqYSblN
	wGpsPH6eXv/1A0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E70613432;
	Mon,  7 Sep 2026 19:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5+0IEW0Qn2peRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 07 Sep 2026 19:28:45 +0000
Date: Mon, 07 Sep 2026 21:28:44 +0200
Message-ID: <87se3krhcj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ALSA: seq: Fix port lock leak in
 deliver_to_subscribers()
In-Reply-To: 
 <2026-09-05-daily-reply-0028-alsa-seq-port-lock-leak-6-1-ack@kernel.org>
References: <20260904070349.80497-1-tzungbi@kernel.org>
	<2026-09-05-daily-reply-0028-alsa-seq-port-lock-leak-6-1-ack@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
Message-ID-Hash: TBJONLYPUJ2JATUBKDY5N26ZER5EQUQ2
X-Message-ID-Hash: TBJONLYPUJ2JATUBKDY5N26ZER5EQUQ2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TBJONLYPUJ2JATUBKDY5N26ZER5EQUQ2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 06 Sep 2026 15:32:58 +0200,
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
> Jaroslav, Takashi - can either of you Ack this for 6.1.y?

The fix is correct for the stable branches.  Feel free to take my ack

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
