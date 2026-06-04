Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285ABCD6E6D
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:22:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 350B160262;
	Thu,  4 Jun 2026 17:22:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 350B160262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780586567;
	bh=RQ4hLi+TacwxV/QmZJsmjymeL8+5AS/LfUeWBJE+4ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jybb/DQ+0WFFAh6AAoqDvdPI0SemAj49G7WGW0w1J6/vn58IpeuQoux4Kokg7zc9k
	 ONccREdkd3C/RFbFvrlzNEy6P1sZf/3XPSX7DHuOVruLSggo05Uh0w7/hx/YvlfbEz
	 49dbwE+1KVHQ03XFiO+/IRnsHXT+bzpsopcgQ11Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90661F805FD; Thu,  4 Jun 2026 17:22:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 25929F805F7;
	Thu,  4 Jun 2026 17:22:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8ABFFF804CC; Thu,  4 Jun 2026 17:22:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780586522;
	b=RcgWbWDM8ddpFJWKdHc5KFg3DuxY1PO9xlUw6ReazjF4IyxdJSOS4gu5P02ItIJeN6/f
	 l8kvyrZfnGREfV3qw2ysuLc5OTmf6BIEr5hVhhAJxgfh6mIqIo0z5PDkxEF3eR83UW2bI
	 07ayHIQBUX3BpXUdjtbWxZs+ZRpl6UAMKuP4JZytuKz7bM52lgSqeapEbCICAs7t+ywrp
	 iQ7PI7lEm7kB3PsLAZxXYgGygXBShbqvgNxPSTvUvcnaJE/4Y8yjDu8icPcXX4P/5/hLT
	 QDiNCtFhbtmHCdQhEELm7M+HHRiUe2EByP6qHSsE4+7v0xQrvrH5QgLeEyv+VirNZxQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780586522;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=RQ4hLi+TacwxV/QmZJsmjymeL8+5AS/LfUeWBJE+4ws=;
	b=DKMVOZw1btkGuYyTvcliL8wbYiVKIpGS0qiv/T5b7zbCccPK3hChhgzVHaDZzWXOY6ox
	 pf2wTyu1OjuKM6zS9ANyd06iQNP4jl04iUjAu/Gsc4w9Nb1JPxIgKhL/GbQO6cjX7gErP
	 IfFyOrw0p3UrBWNqrEMrDtBuGfzon7I0+RGLlHdUeelUnIdr7Bnd2kf8sa8Z1+osai8Xy
	 UHg5B+2LmwHu+bSSaoch2ePDNLT5t6U9ZFg++co5ovT2DmHluGtmzQ/9onvY13b2AO9Tu
	 dkHV1JZzA8AEhPaLMFemR2y0VrEBvZzL8wm/La51/X4ctEO42AGm2Z1ZHtjxgRmMywA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ZR3zhJeR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Ao6tIgX1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ZR3zhJeR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Ao6tIgX1;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 362B1F8047D
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 17:22:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 362B1F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ZR3zhJeR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Ao6tIgX1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ZR3zhJeR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Ao6tIgX1
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64D45683EF;
	Thu,  4 Jun 2026 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780586520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTsAb+TsYO8EqTBfY4MK8zKt2wQxn4kAjBXQbZFYrl0=;
	b=ZR3zhJeR1A95McPBTS2ydpJeoLS4MhgS0Zy+er9yngaxDIl+L4de6XDT4ec4GIjfb6BE7x
	HmdVcJQL3fu0cY0pnUAGCCJvMn5XE3Xoo1Cf7jbwnkUENaiiUpF4QPBO1egeynK0sOF5nq
	YK6fPyaNICQsFJG64Q5dUsTTWACreuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780586520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTsAb+TsYO8EqTBfY4MK8zKt2wQxn4kAjBXQbZFYrl0=;
	b=Ao6tIgX14txm56ebbqv7x6r1j0U0FzsYx20fRBWU+jo6MzABmmMLzjnHxhgxNkeDAzbBXR
	glsP0/hj43ldNSDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780586520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTsAb+TsYO8EqTBfY4MK8zKt2wQxn4kAjBXQbZFYrl0=;
	b=ZR3zhJeR1A95McPBTS2ydpJeoLS4MhgS0Zy+er9yngaxDIl+L4de6XDT4ec4GIjfb6BE7x
	HmdVcJQL3fu0cY0pnUAGCCJvMn5XE3Xoo1Cf7jbwnkUENaiiUpF4QPBO1egeynK0sOF5nq
	YK6fPyaNICQsFJG64Q5dUsTTWACreuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780586520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTsAb+TsYO8EqTBfY4MK8zKt2wQxn4kAjBXQbZFYrl0=;
	b=Ao6tIgX14txm56ebbqv7x6r1j0U0FzsYx20fRBWU+jo6MzABmmMLzjnHxhgxNkeDAzbBXR
	glsP0/hj43ldNSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40ABF779A8;
	Thu,  4 Jun 2026 15:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nj+jDhiYIWoeIwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Jun 2026 15:22:00 +0000
Date: Thu, 04 Jun 2026 17:21:59 +0200
Message-ID: <87y0guuy94.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.1-rc6
In-Reply-To: <b99a86ce19505d0016af56bcfe4ad81f@kernel.org>
References: <b99a86ce19505d0016af56bcfe4ad81f@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
Message-ID-Hash: U7SL2J54QETC7CKZWHHDZNEQO2VT3N63
X-Message-ID-Hash: U7SL2J54QETC7CKZWHHDZNEQO2VT3N63
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U7SL2J54QETC7CKZWHHDZNEQO2VT3N63/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 04 Jun 2026 16:59:17 +0200,
Mark Brown wrote:
> 
> The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:
> 
>   Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc6
> 
> for you to fetch changes up to d2dcd85f9e09fe3566d4cdcd357856a42ac73f93:
> 
>   ASoC: amd: acp70: add standalone RT721 SoundWire machine (2026-06-04 11:35:06 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.1
> 
> There's only one actual fix here, for the TDM configuration on the
> Freescale SAI controller, everytihng else is DMI quirks for AMD systems.
> One of those is relatively large as it adds a bunch of different structs
> but it's all data.

Pulled now.  Thanks.


Takashi
