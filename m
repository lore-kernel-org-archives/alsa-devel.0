Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182F606A334
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=fnoE0Q3V;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CLe7A21F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+oW/bxjd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CLe7A21F;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+oW/bxjd
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C268660202;
	Fri, 13 Nov 2026 08:52:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C268660202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794556337;
	bh=/J4ES4/HqYuO2ijfbFEnzS1kSxM6pH2tGr9s0sD/0zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fnoE0Q3VeZhUCcLrpa7VqswTKYAdDiwpBIChBq4ifPbfi1n3FYbG1fKbJTHLXi0E1
	 AwZ43mkyFcgw4rXTAqvDTEzg1DRGpqfCZ9+kyQL/fMmSvsNzaiK3xZgWB4oDznQOnB
	 7CBZkMei5KxqTTKcyLWha/VesYw+D5I1oRwXi4Nk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 136ECF805F7; Fri, 13 Nov 2026 08:51:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 64577F805EF;
	Fri, 13 Nov 2026 08:51:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4C84F80552; Fri, 13 Nov 2026 08:51:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794556294;
	b=jPUT7YJYgB2/Jqnc5Nv3zCrvdKPLQXJSywE0fRDpmCc+UCVRc7NTENjdh/CS/xYtUVeZ
	 BprigZNUc6s/jn6Sb05K13kTY69xstDOn79BOWwqyjfT9+brmkFjPzg156GILPVXO/oVr
	 f3FJZ6dMKFrU5odcUD+7UAz9IDXJsXVRjyizc6eVqI/36tH0nZP52KAOehlw7KI6DVkgM
	 UUBhy7gpCYqmcyvypDH0O0CXLUU7YTo1wMANCUbs72t+W/6j0JoJDlGjOHsFIahPhwPgN
	 UFIDmKuOCC0ImSWntuQplDX3/zG+vo1lV4bComUQuK8fVqM+0s+vC/Co6ufOp4Y+ofw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794556294;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=/J4ES4/HqYuO2ijfbFEnzS1kSxM6pH2tGr9s0sD/0zw=;
	b=LPO6tCuSeAn2yxEFXSH1SBlITYiB76iDPZNTXPyfHpwPoFDEChwcsjuEcnlThNqu0RVv
	 Y70L5VTMxn/wxEOApI+62uUdIZovJApcz708Y7dGgA5Dhm/4OSuI2JXBmUwFy3FfKEcyi
	 xLgTKQZohlqHYk0jwozuDxaz91Gl9rbh0ah3Q7Y+9ZtzrBe5BOlfl/0R/M7c1rb1sg6Zw
	 NWN9gyJ0K1yZk9Z0jqHJHCuQJ8nOvpI2Hdy1cHgBxq/AfUu60m6WGJN1sbBwBRWdzZ/eb
	 vh3NOn/L8EO1rLOyMt0QEtYeyushwPB9aU7hz1x1A2zeN/DRjBK9JTQoX3cwmdY5K6A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CLe7A21F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="+oW/bxjd";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CLe7A21F;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="+oW/bxjd";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BE68FF80095
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2026 08:51:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE68FF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CLe7A21F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+oW/bxjd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=CLe7A21F;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+oW/bxjd
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A53C220B7;
	Fri, 13 Nov 2026 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1794556292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTrNb72e3UZ/aCsehypATNb6lFPLqpvLaCvAfBKmJ7g=;
	b=CLe7A21FklmaTQsR1j+vcCAj0GlS1WUzTCxfoLvDce3hdcbvPdkkRrhOfpFjKF6AniAlu6
	2ul5vkQmnTYEkh5RSP1JTMMkOPyv1Ktw5c45XMv9tTpr0FeZyNHLOF4Q0Zf2fR0RyS2vmy
	F8azlY3GYeC0kgyi+kMXZZaHBrivEEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794556292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTrNb72e3UZ/aCsehypATNb6lFPLqpvLaCvAfBKmJ7g=;
	b=+oW/bxjd1i1yNtiebDNFQsmYoVs0JrJFofGERQqUnoJjbm3qbrcAFJgrkOiI1OGy90inTd
	KnjpWXesV/o40gDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1794556292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTrNb72e3UZ/aCsehypATNb6lFPLqpvLaCvAfBKmJ7g=;
	b=CLe7A21FklmaTQsR1j+vcCAj0GlS1WUzTCxfoLvDce3hdcbvPdkkRrhOfpFjKF6AniAlu6
	2ul5vkQmnTYEkh5RSP1JTMMkOPyv1Ktw5c45XMv9tTpr0FeZyNHLOF4Q0Zf2fR0RyS2vmy
	F8azlY3GYeC0kgyi+kMXZZaHBrivEEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794556292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTrNb72e3UZ/aCsehypATNb6lFPLqpvLaCvAfBKmJ7g=;
	b=+oW/bxjd1i1yNtiebDNFQsmYoVs0JrJFofGERQqUnoJjbm3qbrcAFJgrkOiI1OGy90inTd
	KnjpWXesV/o40gDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E1651344A;
	Fri, 13 Nov 2026 07:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GdekD4TB9mr8WgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 13 Nov 2026 07:51:32 +0000
Date: Fri, 13 Nov 2026 08:51:31 +0100
Message-ID: <87cxs9qid8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.4-rc2
In-Reply-To: <da3d9a0821be2c6200c0af618dda6256@kernel.org>
References: <da3d9a0821be2c6200c0af618dda6256@kernel.org>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: DKJVQPTGSZT3A7TZIV37IXPN44WGJEGQ
X-Message-ID-Hash: DKJVQPTGSZT3A7TZIV37IXPN44WGJEGQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DKJVQPTGSZT3A7TZIV37IXPN44WGJEGQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Thu, 12 Nov 2026 19:55:28 +0100,
Mark Brown wrote:
> 
> The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:
> 
>   Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-rc2
> 
> for you to fetch changes up to 58d51fa6ff1d21e79c3c340bfb3155dfa3025ca3:
> 
>   ASoC: max98090: keep the MIC boost across mic input power-up (2026-11-11 18:05:03 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.4
> 
> Another week, another pile of driver specific fixes and quirks.  We do
> have one major fix which addresses a bug introduced by confusion with
> the counted_by interfaces that was causing major disruption for a number
> of platforms.

Pulled now.  Thanks.


Takashi
