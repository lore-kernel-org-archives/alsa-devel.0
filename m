Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96885C4450F
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:17:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0610A601F3;
	Fri, 17 Jul 2026 08:17:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0610A601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784269038;
	bh=G9dQnTtE6B2elZOhdyNlV+3TIWahYCiVKVknRe3uSxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=imIbVU1KdlJAoVQDRIJJcGhvMzUuWSvU7J3LOXvp/ax6DGvKQHpsWSTn9zKsqiRvB
	 3KSrUHiGqFKGIzgm5ykpEDu6lX5+RSyL7Ci8IgDAfDcK8GmDUC4Y0rL2++B24Re4l1
	 ZtATTB6n91gh6lJIRnXiLozaxXnnQY4EC1bheNsE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC53CF805F7; Fri, 17 Jul 2026 08:16:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73425F80601;
	Fri, 17 Jul 2026 08:16:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E144FF80526; Fri, 17 Jul 2026 08:16:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784268995;
	b=peHrgZ74CGncH9LHKlkRcY4I1F1gU/cCJ1YRk8FYQQLoBPCOtWUimQ1nmpMGUk8ZgOAP
	 IF1vjfBWQWGZjpHgIZzYzj5GuZMGbhNwKCG/0hfQq8186ULl5EIEJ9YYqd/pXFFsA9Cca
	 SRYUA5GhadQgCCCvZIIaDcXvuYVoohS+A2Cd2vnzzzPPQe4y0E/kLqctOsRwxyPix63HD
	 iL1ah9h0NeIzpe3b6dtwDgLGG9oNB5zE6OLHttfjb/pKLjlZ5AUWXfK6Xu8Opm71w8uZ7
	 6duCQNKMJzBxRxVY/5rKA7yvgaBB4DBRPje0mG6wPSl0SBOgpJNSZW0bqlmKM/Hyrvg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784268995;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=G9dQnTtE6B2elZOhdyNlV+3TIWahYCiVKVknRe3uSxE=;
	b=XAA+CjYPJIDp97sNzAQpQe4ofYgbUtPaunSQjKAJSRm0sNM/cMJ6ZQCPvBjW7V8yAE3g
	 28a/3+/ANr8iShh6K6WB6HGrsWL6xawdx1ZPGz2oDB9WRz03tCDBvPgFfo+91GNu9UWuQ
	 6vpOvxYlmA+ULh0zAZ6twZ38vMOlEJvXx5W67e81fFdF+WeRjAFXQ6tLJMvj1GmLDSyDd
	 pDy10uA8L7KGRnW/IO6xach76I409QFsMkUZtujxEojTS+eIOa37L29+qhpY3/wkH/i8D
	 3XiGbd/uB1jrXfbrImxZWM2err7sW8U5FSqn+Y2TMeV/UxFaqRAw3BTTML68KYSE8Iw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Bk+j3hdf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=4PPkRrq8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=OXn+Q6iZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rbl6GlU7;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 31556F801F7
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 08:16:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31556F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Bk+j3hdf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=4PPkRrq8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=OXn+Q6iZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=rbl6GlU7
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE33678D50;
	Fri, 17 Jul 2026 06:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784268993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkhYMVoDfzP/uEe9wacNczRJmfyg0WwLPfhhbgc/xc8=;
	b=Bk+j3hdfWMAuTsBxJ/g+WrKxViwlAmy7rGl4hwfzvftbWdWK/60qRzUxcS9HCq3g422tuB
	xD12XPCQ10OsOq8KqTiT65jVmrpQ/M8KWWzW0XxOKM2iUzIDUI2vAMc4srNTkfddgEVaHs
	iI+ozqsM73degFe4yTpQ37yK1O8z8qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784268993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkhYMVoDfzP/uEe9wacNczRJmfyg0WwLPfhhbgc/xc8=;
	b=4PPkRrq8w0X1ZT7UoXe35QglkSy8iGLcFw/BjNm/LYuR10LB+ddOZzO7ptY6sd3xiUnf4w
	rngvuWX2j/Z7IpAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OXn+Q6iZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rbl6GlU7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784268991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkhYMVoDfzP/uEe9wacNczRJmfyg0WwLPfhhbgc/xc8=;
	b=OXn+Q6iZvzCqKDxG6iHjnzgH8BbIYbfWOZJBw0we2G1dAoTeYzBpdklqptkvBBVOb3c6Dw
	3ItZdnJ6oTUioZF3WPNCoPeoLaGPK2wSAT0wPJE3p5eWokv8RXxcb+7MKPXHHIRz9E3AGe
	TY7z6yLAUoCXfvuWXPerSTxpQmu0Hk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784268991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkhYMVoDfzP/uEe9wacNczRJmfyg0WwLPfhhbgc/xc8=;
	b=rbl6GlU7Y2+79Z6F4z/WDhOyttzLSOqnNfedqsG5Ak/hsU4bBMbox4fNYdUs0mFHhS1YiL
	EX0xI1acKibxTYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88C58779AA;
	Fri, 17 Jul 2026 06:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p27uH7/IWWo0PwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 Jul 2026 06:16:31 +0000
Date: Fri, 17 Jul 2026 08:16:31 +0200
Message-ID: <87qzl2ta2o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-rc3
In-Reply-To: <e11aad798859896a3f0388f99de32bc0@kernel.org>
References: <e11aad798859896a3f0388f99de32bc0@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE33678D50
Message-ID-Hash: 7NWEJO74P6IQRXL2KZJUAHGDFYR6SUNP
X-Message-ID-Hash: 7NWEJO74P6IQRXL2KZJUAHGDFYR6SUNP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7NWEJO74P6IQRXL2KZJUAHGDFYR6SUNP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 16 Jul 2026 18:41:39 +0200,
Mark Brown wrote:
> 
> The following changes since commit 3238c634725afbb2a137fdda762208510828f71d:
> 
>   ASoC: tas2562: fix deprecated 'shut-down' GPIO always cleared after lookup (2026-07-09 00:33:20 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc3
> 
> for you to fetch changes up to efd80de2de9d06ddf0eee55ca11b04e39bfc7cd8:
> 
>   ASoC: Intel: sof_sdw: Add quirks for new Dell laptops (2026-07-16 17:18:08 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.2
> 
> A fairly standard collection of device specific fixes and quirks,
> nothing particularly remarkable.

Pulled now.  Thanks.


Takashi
