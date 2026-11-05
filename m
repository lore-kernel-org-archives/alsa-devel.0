Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E34606D806
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=aaOhw0iB;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gGxO0SHx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HKTQbMwv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gGxO0SHx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HKTQbMwv
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A94D46014C;
	Thu,  5 Nov 2026 17:02:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A94D46014C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793894545;
	bh=2Zvxb/A5eHTWzuzdfdLCAju0BStvKd/4ddIMpBfj7uA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aaOhw0iBoXkjtkPklnKf5jiFxMAEIagw3nzYFpJNkzeFzQ0E6txxgD9foWx1q81ga
	 gk2aNRslxaZvNze1so1kcOkngqZ1Byn/BUMjfF0fbvHRpnKKqnkKEsAqVRJDPOaXmN
	 h7XOKoPGeszmaFGao2NcZfZptbq63+QufnBpc1+w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91364F805FF; Thu,  5 Nov 2026 17:01:51 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CDDDF805F5;
	Thu,  5 Nov 2026 17:01:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 259AEF804FF; Thu,  5 Nov 2026 17:01:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793894505;
	b=jxtbTvkQejQMJ5MckG/7YAQZ21iEhm2S+WdKqKJH+3us+ehjqfhInLPWu7Lwb7mCietu
	 MP3a90l47a8DwGgN3H3BbEW5vgfCSPYOUAVl7bDSFW8kspItHa3VQxm/ntA7BWNM1lu/h
	 3UeSA1p2j5mJdS41wiKWm+T9rMiW80tGsBJS8Jdh1ADUWqOrt7DFjSmPQJLiTyWFgzJWg
	 zy8qCg7RbCxjUZ9/8EU3psLZVstAfMgY5lkFiFlpvT3MzKYIsvI+AyiJTioUvwMUuCd2p
	 JCm4KUJzA9gbS38jbsz6qiXCFTZA5nCDe28UQaIgfAdG1HAtfBXaXvBmGhLuTWuaF/g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793894505;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=2Zvxb/A5eHTWzuzdfdLCAju0BStvKd/4ddIMpBfj7uA=;
	b=J4AiQvaR0UEYAGefkp/NVDfcs/fSNNeffDa6zqLqiQS9j+FwNPq38M+pCpPKOCY99laK
	 Lg5lRjtFugGxA18aepC1pYvfda8JPWw6mQjIUoXbx62kM1ZEGVSb92QG03ObaVpQbabgG
	 cSqdPuG3SiWJ3iXp6XTR4lXgowDO1is0jwgRzNA7tr7FKx4QPQumtjPWpmf0Pd/Dp3dPs
	 TZT+FCHvOuyQFdTLavKdSY3GqfAIfr1rUmKIVeUHM4ZsiUNMTbbY1ajFIel73FHqI0YX6
	 ExAvfNfM2zASeC3vv289llvQmUBrLCZUZuF6rZzAtGFicwGSAl0hHV/f/wNhgjzjrXw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gGxO0SHx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HKTQbMwv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gGxO0SHx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HKTQbMwv;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 17C0BF802DB
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 17:01:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17C0BF802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gGxO0SHx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HKTQbMwv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=gGxO0SHx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HKTQbMwv
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74CF81F749;
	Thu,  5 Nov 2026 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793894497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCAXsQYTn+ro7wQ3X5+sSRZ5vAY/PJ6i1XVSyLlK874=;
	b=gGxO0SHxJ1lggBgMepmGGMhM37Zk6ZbGTZjUGvYd+f5ND44PnkydwOpHOH2EhbF9IV+ZS5
	Ij1G5YHY8D4iat7e5sSDU1af8bacUr1Supq8MGxYYc+IgY0ayPux1lfzBWEGkMH1PF8KaG
	Uh+ltF6pcVN89+fAV1jtyIp7+FdYAlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793894497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCAXsQYTn+ro7wQ3X5+sSRZ5vAY/PJ6i1XVSyLlK874=;
	b=HKTQbMwvEsex35AwmI7QAHHEdbUROjIJdJ3mSKzJ5J1LCujAdlx+JFwYI3lWWLAybS0Bjw
	wzk6bqu6/5F6WEBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gGxO0SHx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HKTQbMwv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793894497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCAXsQYTn+ro7wQ3X5+sSRZ5vAY/PJ6i1XVSyLlK874=;
	b=gGxO0SHxJ1lggBgMepmGGMhM37Zk6ZbGTZjUGvYd+f5ND44PnkydwOpHOH2EhbF9IV+ZS5
	Ij1G5YHY8D4iat7e5sSDU1af8bacUr1Supq8MGxYYc+IgY0ayPux1lfzBWEGkMH1PF8KaG
	Uh+ltF6pcVN89+fAV1jtyIp7+FdYAlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793894497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCAXsQYTn+ro7wQ3X5+sSRZ5vAY/PJ6i1XVSyLlK874=;
	b=HKTQbMwvEsex35AwmI7QAHHEdbUROjIJdJ3mSKzJ5J1LCujAdlx+JFwYI3lWWLAybS0Bjw
	wzk6bqu6/5F6WEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 354B7134F4;
	Thu,  5 Nov 2026 16:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yv/wA2Go7Gq9CgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Nov 2026 16:01:37 +0000
Date: Thu, 05 Nov 2026 17:01:36 +0100
Message-ID: <87v76bqnbz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.4-rc1
In-Reply-To: <e5aded615cb3e714bfe90050876a9f98@kernel.org>
References: <e5aded615cb3e714bfe90050876a9f98@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 74CF81F749
Message-ID-Hash: YBBO6BVCMZWVKNEII26PCQ57YBDFYFNR
X-Message-ID-Hash: YBBO6BVCMZWVKNEII26PCQ57YBDFYFNR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YBBO6BVCMZWVKNEII26PCQ57YBDFYFNR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Thu, 05 Nov 2026 16:52:47 +0100,
Mark Brown wrote:
> 
> The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:
> 
>   Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-rc1
> 
> for you to fetch changes up to cf09d02dc0c49593fdd9e0ec2f17251cba39a94e:
> 
>   ASoC: amd: yc: drop duplicated DMI quirk entries (2026-11-05 00:25:11 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.4
> 
> More fixes that have come in since -rc1, a lot of this is quirks but
> there's some bug fixes as well.  The bug fixes should mostly be those
> that seem to be affecting actual users rather than just being pure
> static analysis work.  I also took some fixes for missing Kconfig
> dependencies which won't have any runtime impact.

Pulled now.  Thanks.


Takashi
