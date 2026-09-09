Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A56C79FB7
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:31:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BB1260291;
	Wed,  9 Sep 2026 15:31:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BB1260291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788960699;
	bh=32cuHm7fqKVjYu0WXu2amRA/5l2JTOsyv2Pu9VoluHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fCkk2OtF3EH2zmxawth1vD6h0TA8usHtxkKFf0kazFft1pwHdba8k3MHpKqaQ97Uj
	 hTDAlWleSdNuwumVpRID2NIwUyVL3CTAVJBUG9LD+cN3zaMJvQUZrsuaTSqLa+knNu
	 bplu2uF+o5jLEsHJ+fecnZChVnLhzMQz86f8JZj4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B893F806BE; Wed,  9 Sep 2026 15:20:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EC9D0F806B3;
	Wed,  9 Sep 2026 15:20:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2792F806A1; Wed,  9 Sep 2026 15:20:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788960039;
	b=Z6iQRPub0159pmmtVbyuWJTr4GkPw+srxkge0qG22LgmHKgAxq/WOzIZYkVyRreBOfmH
	 6pGQOCtGOVUQmbeHUmrCo6pBCQL1fhknDbcnl9WhorLGOZ6+v/fn08wepfEW0EJ0PabcR
	 Jrsv9pZjpDO6eHV3ErsUllgJu+rvIO28LP5fQCdrM1JfxlsAw3WG85iB0wWfRL9eHf/xC
	 4NUHuRG3kFD2RsKN5yf3seanqhnMeRjg6mzyhxTC7yyb1WiKNei1+kksVmk3VIbH+AFPQ
	 l9rsfes3CfhKksyWUh4I2O4nO3zAOdTrr6kkYtOJMBhVZvDN8xmjUhwumNndYv+gOog==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788960039;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=32cuHm7fqKVjYu0WXu2amRA/5l2JTOsyv2Pu9VoluHo=;
	b=OxtZiPUU+5KuUGPOxRck08bf79QPIR/A+Gn9/sab2GxuZRXpD8y/hcSx/3/htP475np3
	 Wvl92H7rRrfNvDoBlr/f6SH+ZgCxkJBxviXTyOb1PEBJvj852EyZ3zjkFJgCDIKkYVlya
	 ryg/eWfXB7DTwWAb4UO3xzYSy/a+32q5DN+pejKj5dxi3cUCafWlAzEfUI+60KYLw2eJN
	 a0ivtZrwghLAWJ2hipt35EiKHVlfl8GnwZ00zbMJlanaXxbY67uWPkftBDyhIfy8JDR2c
	 2foZTT5/p4XZ6jreDG6CU34GudAC5qcNSL3cAF4TX+rB9UhPLjpwPdTSi3pXOsmXbNw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=sGW0tkOb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=cS0YXNEP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=G0zRU+X8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ddhiUNqV;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C8AFFF8069D
	for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2026 15:20:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8AFFF8069D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=sGW0tkOb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=cS0YXNEP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=G0zRU+X8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ddhiUNqV
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCC2D1FB27;
	Wed,  9 Sep 2026 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788960034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8v1hbg+oYTlhSFd7uWMJne8mlXM3pxzuKsCj69+NPMI=;
	b=sGW0tkObOZkCnHQgKaDJfT0pVrcR/SXsRl6L4esOXSDM+BxqNC6nw9f2TAJRzUlQB+UdCK
	RL4S7LgZsTXaPuooE1DOjmF4RlwimwqYe0k1w5iFO6lyQYNptHJaOICfwhpqQcTMqp6Mvv
	5e8Xh4Wv+2fhzR2l53ExJMMDRR6PrHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788960034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8v1hbg+oYTlhSFd7uWMJne8mlXM3pxzuKsCj69+NPMI=;
	b=cS0YXNEPa0UtXSSbeWDAwLbMIk9SX5ntqvwnObAEP/hDEq1mi/eKmHi0Imu5ga15TZKz9F
	/pU1APfGAEa+gZBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G0zRU+X8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ddhiUNqV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788960029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8v1hbg+oYTlhSFd7uWMJne8mlXM3pxzuKsCj69+NPMI=;
	b=G0zRU+X8FOQxPtwxAI9OJC0SitEhGtbkq63fSG0kixdZfx2olkhvn/PwVRUqAnCesOxHTp
	cdZAhyt6UuxUjTOGnR5MeXGQjuKBjppDiMUsncngtvx1KjjjfsYXyTIceIvOjO42hqlM1s
	L29dlIjSwddhcTHZrcU7bbnNg3b/OjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788960029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8v1hbg+oYTlhSFd7uWMJne8mlXM3pxzuKsCj69+NPMI=;
	b=ddhiUNqVyfBat3ROKP0Y3IKcGlUh2Ww76FVREihIt8y5IBU4fpeOO7IzYcmJ/BekGOSM1V
	sMHoZP/1uDuz7HAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C44013185;
	Wed,  9 Sep 2026 13:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8OHfJB1doWrMbQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 09 Sep 2026 13:20:29 +0000
Date: Wed, 09 Sep 2026 15:20:29 +0200
Message-ID: <871pb2o92a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc2
In-Reply-To: <ef950e391b7a5d9d8054cc53d4f88da1@kernel.org>
References: <ef950e391b7a5d9d8054cc53d4f88da1@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: DCC2D1FB27
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: SYXEN2MOYCFVUATRODTTYVV2CAWO2FFK
X-Message-ID-Hash: SYXEN2MOYCFVUATRODTTYVV2CAWO2FFK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SYXEN2MOYCFVUATRODTTYVV2CAWO2FFK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 09 Sep 2026 14:24:52 +0200,
Mark Brown wrote:
> 
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:
> 
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc2
> 
> for you to fetch changes up to 7e125889f1705fc6326679a3db3b4159f7a8c87e:
> 
>   ASoC: amd: acp-da7219-max98357a: don't bind on Raven/Picasso boards (2026-09-08 15:59:06 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.3
> 
> An unusually large batch of fixes here, partly due to me not sending a
> pull request last week and partly due to Linus' fixes for the Ericsson
> systems.  I'm fairly sure he's the only user there so it seemed low risk
> to handle as fixes.  We also have a batch of error handling fixes from
> Cezary and issues with uninitialised stream_config->type from Shuming
> both of which had user error reports attached.  Otherwise everything is
> a fairly normal combination of quirks and device specific fixes.

Pulled now.  Thanks.


Takashi
