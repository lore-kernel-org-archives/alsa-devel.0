Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648ECCD8C9D
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:31:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8346601E6;
	Thu, 11 Jun 2026 21:30:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8346601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781206264;
	bh=rtX0gmLPZ7sCVMzzJ01HnzleW5RvHym/BZphO6JOhwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ClhQYf0HxnWRq53XO0ycZze955jxbsrAYXQacKA5Jt2vjgs4GMt9wneT49ErZ+sbK
	 XRKxXWWXE5qBB/CFdHeSTan9lDYxdGrJ9NyD88Pkv/DCbxe8QjpNHIviTuZFjppMq3
	 SrB9wfYe6ktT2/97Wp1xz/+XWVMRcmuWs7Tl9Hcw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A58E4F805F3; Thu, 11 Jun 2026 21:30:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 466A6F805F9;
	Thu, 11 Jun 2026 21:30:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10DEDF805B1; Thu, 11 Jun 2026 21:30:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781206220;
	b=LdIjvTURE2ece9y5yv+zue7Y7DkrazkDFCjJ6fPkKzEN2qvF2Xq5Ie2jLbyw/ro5Wpu0
	 8FTELvaYk/Uz14E6tSqdh2FAdruJLz81pT08NjaDz/IP94+WV4Ze3Di5O6nAQ8whrxUI3
	 qWR4LCbJ4lHpmqas3GUZsb9sFZZrTYNXxtiXlcUsnI6uTBdyteJl/yFSbWuSVbEPGPAJ+
	 u7W5NHQvUmQTlf1f8G2czRS+MwN4N8rXTrve2vIL9NYhODwa8SeS1yxdi2MmelFy9eO/7
	 yOUsyuMFNpvVredOHz7SEKx0nEV53OVk7kmMmdsUw+jKl+6I1/UbDWFxnZgMX0UsAlw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781206220;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=rtX0gmLPZ7sCVMzzJ01HnzleW5RvHym/BZphO6JOhwI=;
	b=ipmwYONj9uIJ+kM+C8K1x5oU1i6pGeyYzTxkrS4bV5iug6DA194If0TtsEaq9xBqakyY
	 Bqjsykud9nJNH8OPgWaLuOfARx9hfRr3bcPDqZufwZhceMbLFGtAZCsIlf4an656mU6k/
	 aWxE/rkDNgVBeZEDD0OrlLRZNm3BH//BCf68qTvA+814YngvlL995OIuByLS5mRbHFI1s
	 Evm3OqzthFiCll4iIUCUd3hfl6GQsF3IuQ2axi9bBGJ/vQG3wc4lvj5mF83WXf4aIa+5r
	 NcN6xw970EwdqwkZ4etVMtK5mU3HvW0MhY9tAImfqMF6gYQSc+8L6QYGMhZINe3GXPg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="vk85/4+u";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Xz+VSlWN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="vk85/4+u";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Xz+VSlWN;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C3014F8024C
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2026 21:30:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3014F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=vk85/4+u;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Xz+VSlWN;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=vk85/4+u;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Xz+VSlWN
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1D1E75D16;
	Thu, 11 Jun 2026 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781206218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bl1yDiK1JT6DJd7r6EVwRS1jbhf0qp/IiIN1NGcs0hE=;
	b=vk85/4+uVbvjwblsaO2oQV8NnV6k3VA3KHVU0ossQqoA3NB2Iori6anSkXs9xeTcUw5rAc
	3IjT/IdKZa8Lxy39t3TUtof6/qQqhKDA8BIAerNqMHe8eWdoo76bRhPzMHqGnxaNN01QGM
	ITWX7J2tKKKe45NltHiOFct9Le0nd1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781206218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bl1yDiK1JT6DJd7r6EVwRS1jbhf0qp/IiIN1NGcs0hE=;
	b=Xz+VSlWNaaAcgxbTBRdZ3uxtX1vHlsHw+wcYTRbF5jHsfYxsJiGR/Zx4bEIqXt+eXprxi5
	wOJGzRpgsLp5WRBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vk85/4+u";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xz+VSlWN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781206218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bl1yDiK1JT6DJd7r6EVwRS1jbhf0qp/IiIN1NGcs0hE=;
	b=vk85/4+uVbvjwblsaO2oQV8NnV6k3VA3KHVU0ossQqoA3NB2Iori6anSkXs9xeTcUw5rAc
	3IjT/IdKZa8Lxy39t3TUtof6/qQqhKDA8BIAerNqMHe8eWdoo76bRhPzMHqGnxaNN01QGM
	ITWX7J2tKKKe45NltHiOFct9Le0nd1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781206218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bl1yDiK1JT6DJd7r6EVwRS1jbhf0qp/IiIN1NGcs0hE=;
	b=Xz+VSlWNaaAcgxbTBRdZ3uxtX1vHlsHw+wcYTRbF5jHsfYxsJiGR/Zx4bEIqXt+eXprxi5
	wOJGzRpgsLp5WRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 770CA779A7;
	Thu, 11 Jun 2026 19:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FnFyG8oMK2qpcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 11 Jun 2026 19:30:18 +0000
Date: Thu, 11 Jun 2026 21:30:17 +0200
Message-ID: <8733yskh86.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.1-rc7
In-Reply-To: <20260611181119.2822E1AC56C9@finisterre.sirena.org.uk>
References: <20260611181119.2822E1AC56C9@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A1D1E75D16
Message-ID-Hash: DIKG5KZ5S6WHJ4NAT7YPHRY3F2CCYCIS
X-Message-ID-Hash: DIKG5KZ5S6WHJ4NAT7YPHRY3F2CCYCIS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DIKG5KZ5S6WHJ4NAT7YPHRY3F2CCYCIS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 11 Jun 2026 20:11:12 +0200,
Mark Brown wrote:
> 
> The following changes since commit d2dcd85f9e09fe3566d4cdcd357856a42ac73f93:
> 
>   ASoC: amd: acp70: add standalone RT721 SoundWire machine (2026-06-04 11:35:06 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc7
> 
> for you to fetch changes up to e4c60a1d4b6ccc66aefb3789cd908d4f9482eefd:
> 
>   ASoC: SDCA: fix NULL pointer dereference in sdca_dev_unregister_functions (2026-06-11 15:55:23 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.1
> 
> A few more fixes for this release, some smaller driver specific ones
> plus a final quirk.

Pulled now.  Thanks.


Takashi
