Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD75606A32A
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=DNdPoTRy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TxwieGTB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lf4c6zKs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TxwieGTB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lf4c6zKs
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5DF2601ED;
	Fri, 20 Nov 2026 08:37:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5DF2601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795160244;
	bh=rRV+n8P9k8oR6VMIs6e7LbasMWBkSWA/0ldyqXgHHy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DNdPoTRyK4kr6vJiSZSuLguDxps1Ca6KufLI4sD5/qQTXLMLkwww2g2W2tVQHfxae
	 08iWwZ9Typ9+Jywjbq6P8NZHXmnFc1mmDWJLvvXW1jfGuk+H9FIFxbX9Ss8c38Gspx
	 VAyhGmRJMYNWwEjIB4Uv0PrT1iSIv5mmlHWU0Fuw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF340F805FA; Fri, 20 Nov 2026 08:36:50 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59CC8F80600;
	Fri, 20 Nov 2026 08:36:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC37AF8026A; Fri, 20 Nov 2026 08:36:42 +0100 (CET)
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
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795160202;
	b=LbH8wadYcmBwQMuMypggrgHXLXmetCmxZ6CkJ/D3V5kRPJJne8n5Ju58aa2eaMgCd+F5
	 Y/c67YaFf2uRple2cPSsJDzLDxhinK/ccfCTWRsYxjs7ryePadCMMkugubi4uTWxxP8nc
	 88GTm3KRdrxlxLJH6MroFu/z56ZgcOIoy0pZpfYtPC1qFyC88QUlRxuneakRYEx+GWAlM
	 w6sX7hclUDil8oYdI9X61np42lqEnsOaXKk8FuQqoiJm4TrIwDT7oOGHeYFsxKp8LCbvc
	 PBW5f92InRYyeYL8QO1CpfjD3IncO7CVfLlkxEDNyaGW57xGu7Y86wwjRGQJOJ81Gww==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795160202;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=rRV+n8P9k8oR6VMIs6e7LbasMWBkSWA/0ldyqXgHHy8=;
	b=USylGIPMjyeSaCsjyMHF1i3akOLWVBWaneOr42PJfc46YGSI6CCaZCvUV1kPowIo3L1q
	 hKnQ/7SQLj3FhS6eZCW5WKHNUj8ylhmae6LojuvUhRG9h5EL5yM60U0uMjsEHcC2ucfaW
	 A6T59QKvq8weqGAq52+/252VQKsJ7I4g00C0Uke3uguiKuLtb9M//vT8mX0lVhMR/F5Ud
	 fDc2PpfHntVTqDp0euBffrqh7G7joXVw2zjTP6w3pZNsji6zdJUWAHJU5cHRHvUCQBhW+
	 l9M5faj510bitmyvZ5FJ9L7a8ZFzPHHMMuElgY6l7h5JMr2luZnJUiOPobSNLEFCi1Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=TxwieGTB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=lf4c6zKs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=TxwieGTB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=lf4c6zKs;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 00EFAF800C1
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2026 08:36:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00EFAF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=TxwieGTB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=lf4c6zKs;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=TxwieGTB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=lf4c6zKs
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E855C1FB70;
	Fri, 20 Nov 2026 07:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1795160200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRh1HYATXVNzgWhypno6VuZ+diVja1QSq9VuzmoGwAg=;
	b=TxwieGTBirq+XNOwXc2LTb0QXHU9CeZVO25KA8TC1prUQNhMPrhuH8RjtmyKCAYeywI2J/
	Ilrce+Vlz/NBdxf78DjXORIjW13G2/6zIIi2UMDMjLdsW4kryxWLhu728I8kqDb0F2wGfY
	ugk1lTXr2xlgd3f7bpHDL5fByZziJ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795160200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRh1HYATXVNzgWhypno6VuZ+diVja1QSq9VuzmoGwAg=;
	b=lf4c6zKsTA3X8f/pSkc7KnBCflEcTi7D6+AkLib1qJzrB7wcrnTSQWpPSNxnTsAZ27wFh8
	Y6BsA3Iefki1XFBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TxwieGTB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lf4c6zKs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1795160200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRh1HYATXVNzgWhypno6VuZ+diVja1QSq9VuzmoGwAg=;
	b=TxwieGTBirq+XNOwXc2LTb0QXHU9CeZVO25KA8TC1prUQNhMPrhuH8RjtmyKCAYeywI2J/
	Ilrce+Vlz/NBdxf78DjXORIjW13G2/6zIIi2UMDMjLdsW4kryxWLhu728I8kqDb0F2wGfY
	ugk1lTXr2xlgd3f7bpHDL5fByZziJ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795160200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRh1HYATXVNzgWhypno6VuZ+diVja1QSq9VuzmoGwAg=;
	b=lf4c6zKsTA3X8f/pSkc7KnBCflEcTi7D6+AkLib1qJzrB7wcrnTSQWpPSNxnTsAZ27wFh8
	Y6BsA3Iefki1XFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A42DA1348F;
	Fri, 20 Nov 2026 07:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KTu2HYf4/2pdBQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 20 Nov 2026 07:36:39 +0000
Date: Fri, 20 Nov 2026 08:36:39 +0100
Message-ID: <874idcned4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.4-rc3
In-Reply-To: <1d2dffbb27f822112be2ca68c0bcf7d8@kernel.org>
References: <1d2dffbb27f822112be2ca68c0bcf7d8@kernel.org>
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
X-Rspamd-Queue-Id: E855C1FB70
Message-ID-Hash: MD3REIA3WHLSR2C5FJAJEWNOBEQXRUDO
X-Message-ID-Hash: MD3REIA3WHLSR2C5FJAJEWNOBEQXRUDO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MD3REIA3WHLSR2C5FJAJEWNOBEQXRUDO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Thu, 19 Nov 2026 23:41:25 +0100,
Mark Brown wrote:
> 
> The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:
> 
>   Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-rc3
> 
> for you to fetch changes up to f66297be665c067d2e96da9ce1c5767b587e17b7:
> 
>   ASoC: tas2781: Avoid possible zero-division (2026-11-19 17:34:26 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.4
> 
> Quite a lot of fixes here together with a few quriks for new devices,
> mostly not particularly remarkable.  The Cirrus changes are relatively
> large but reasonably so, there's a bunch of data table updates and a
> couple of new functions needed and they come with clear reasonining.

Pulled now.  Thanks.


Takashi
