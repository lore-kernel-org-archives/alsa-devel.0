Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A20DC43458
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:39:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2B66601CE;
	Fri, 10 Jul 2026 16:39:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2B66601CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783694394;
	bh=wr55SriesO4d9TqEzhMpVPGVhDtbpjZQchIcnRrUh+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lUaMWE0fYC8TWnBsGeCYYrV1ffjXpAszX2V1HEm2Ef/PkqnNBZ4dPQSnh51tPfOWE
	 zuAxWJC+5JQQ5EV3Vk/M0fULsW4i0kq/93tb/I5FratRYYXoFHCf+RoFBPVINPqbbL
	 NHcN0a0MhHu3UIwY2Ty7UscBFqJ967GcJ8bfnM1M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2012AF805FF; Fri, 10 Jul 2026 16:39:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D8CE3F805F6;
	Fri, 10 Jul 2026 16:39:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E448BF8057E; Fri, 10 Jul 2026 16:39:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783694354;
	b=CaqGKVzpRyfpdDD+cL3/0zHpc1rM114YzZYvw5SL7NQYKZ/iJZZzHT39IUVwasbE1bf7
	 /2WoPwamPxsIbsPtuQGBJJ4Y8nmtTs83NSt4Eyntpyy2rwwwMhIXIrsl/8QYs3o9JEWXe
	 bEA4WHPMBJOVPGh9q5XThrES5fqIhTMcEfvQDVbBf6VFirhvzQum9AhpFVv2uSFt8FVPi
	 m6YSZQwAx5YZQB+NN4bFRiD9OG6/aeS86Sig4NABIUHokCsP31ONET1TtOVzAGwfAMa2O
	 jlopwoOi4T63c46xdz7uImRz3Dwv4Gk7fA7DU0cb2R4QQD/bKk0smvWvHxtBGQ2cx7A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783694354;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=wr55SriesO4d9TqEzhMpVPGVhDtbpjZQchIcnRrUh+M=;
	b=E+ne4gLKaiBDJNtcBL+abWXvJ/b0mIxx67/ui/3EPuThCE2D0ucPSge/GasFTqA2ndHL
	 bnjYd4Guq99wqUO4BCtpVNfZz05wjN0wUvEa9ZoFCXVtj9ql6fZeKWmaYubK0PsuzzhfN
	 WD8LCk6/K1v4C+WHnNhoga4or2XWbiTf4i1OvxUo06eUIxz22xxo/in2EqNWWXz//bfMY
	 pujoVNQkENSubqAq6cBZqIzdUp1s2tqiKRz1vgH6UnMUBemXoK10s6D3i556UhuWEKjVb
	 sLJIheHGg0+LhkSDDAH1G74h6gB/Xmt0h2rCBI02AcDzyaBdvO+MavdSskBkMhcV9qw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=qhdXFfPy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fNvcgzoL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=UtR9Wezh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=7rjIweI+;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 06CF6F800D0
	for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2026 16:39:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06CF6F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=qhdXFfPy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=fNvcgzoL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=UtR9Wezh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=7rjIweI+
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EDC47532F;
	Fri, 10 Jul 2026 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783694352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WywX2A2/JKBAjKx09bRnb0JwecBq18t/kTQMF7+Al5U=;
	b=qhdXFfPyyrqhkei3q4Jncdygpapmuzv+c19BSdl8KeEjkRRBPbGde07NSM/YcIckxTrWDX
	Tj63nDZhKOisrDOcm8f4PifDBzFPU/VjVrhfJrhl2rau2Cx/pWgjzdLFIypluvrenSnOl3
	ERXvdBRxh2Vo/YJS5S9J6/nmp9ZJ0rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783694352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WywX2A2/JKBAjKx09bRnb0JwecBq18t/kTQMF7+Al5U=;
	b=fNvcgzoLUACn2QFPe8Bxys0vAGRgxg2sVts/8NE3pSO6CtYvkZrH3CbqVKHh2BcVtWOXEB
	3TsqapbcozEWOBCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783694351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WywX2A2/JKBAjKx09bRnb0JwecBq18t/kTQMF7+Al5U=;
	b=UtR9WezhQiKCzrhuTANCLcYFiPIc01J1uaZoGxf/d7EZzudFYU8O+dg5UQ93aGiaO6MO4b
	fCx/FHjjynxfFKfB83yZg1PvJL6eysmv/BcPWDONouV0RS1cX3nmx/ENGlrXQRXUHGf8v3
	2zFoO75LBRmnKdMQRXt8TULLNWkGXpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783694351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WywX2A2/JKBAjKx09bRnb0JwecBq18t/kTQMF7+Al5U=;
	b=7rjIweI+KVhicW4wkrudB+Hs82axSsr9hBaAY1DXM6icP1ZcstHO7LzRbQ05Ab5yRhsFy2
	9Jfen2iCO4N+n6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD7E7779BD;
	Fri, 10 Jul 2026 14:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +3XdNA4EUWqNUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 10 Jul 2026 14:39:10 +0000
Date: Fri, 10 Jul 2026 16:39:10 +0200
Message-ID: <87o6ge29kh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-rc2
In-Reply-To: <19b1f3ea7e0f08ad827d02c50075f69d@kernel.org>
References: <19b1f3ea7e0f08ad827d02c50075f69d@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: UOU375PZABGZKU7CDA54SJGDT4LP5I6A
X-Message-ID-Hash: UOU375PZABGZKU7CDA54SJGDT4LP5I6A
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UOU375PZABGZKU7CDA54SJGDT4LP5I6A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 10 Jul 2026 12:45:07 +0200,
Mark Brown wrote:
> 
> The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:
> 
>   Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc2
> 
> for you to fetch changes up to 3238c634725afbb2a137fdda762208510828f71d:
> 
>   ASoC: tas2562: fix deprecated 'shut-down' GPIO always cleared after lookup (2026-07-09 00:33:20 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.2
> 
> A fairly standard set of device specific fixes and quriks for new
> devices, nothing too remarkable here.

Pulled now.  Thanks.


Takashi
