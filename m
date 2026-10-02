Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1008ECA5FD4
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:25:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC2266028B;
	Fri,  2 Oct 2026 14:25:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC2266028B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790943935;
	bh=B0NG11sYT8qZ/HJph0/POXvfXYNAiewpCaAd+w4ZA7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pPpKdH3uEObGHWq3dwOgJdJlfQV9nBAM/iRMOwmOKcVGC87Qzyh3rqx/WsmR4/JEj
	 IU+U7Le6KSP3kOxfpAN3q5ht4CeWMdHomZ9WX6oxv2gs6odwhkxoJVZcamIIz5g7xS
	 l2xbAJlhAnl20BLiyCqOpG135bd0tMXrI04wW0KI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6CB5F805EF; Fri,  2 Oct 2026 14:25:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F60BF80604;
	Fri,  2 Oct 2026 14:25:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55CCCF805BA; Fri,  2 Oct 2026 14:24:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790943895;
	b=TnpA1172mM0EPqc1Rv72XkWaL0/uwIN2QWCrjL93hgppq0h/SLiFHaGnj3WNE/KYfciR
	 O9c+zm5spA648ORsO7m6nDs1bA1DkDQatfluGpptHxiQtViHDYxbP8bKVyEsRtegn7pta
	 dMQy3pGHPZfcQtg5uBQTvRvm2A0BDnzwZIr5VEoidgjxVdTfmJL2+9lh/Ds2GPd4jk4Qd
	 QAYd8sVgrdC6bGAh4GtAFsCL98B+XUegavTR0zxcCfGfZgXHKxerOKs0WW41eGd/hSqnq
	 5gYSWPdFFvuLnJSwyS/5ZH90LmHPdmN2uEDyUbC4rCKSL3GYfzeP/BMftwitxfN81fA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790943895;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=B0NG11sYT8qZ/HJph0/POXvfXYNAiewpCaAd+w4ZA7k=;
	b=XMHKh1cjjJa8yhpRXGXjqTfw1YG3yVhiyt/23/9gEe8byaXCrRD3jOI+ZHrNBftznfzQ
	 c5c7NdOCM20UQU6XerZH6Ni9QDai5/1CzYCcim04jSaxxxWsxBW3qLsgyG8yJ0A+HZLFl
	 t6cDKF+4uyS0t+4gC7Eju/tco7mPsRVI0PmVyt7TG5UOmlMhqP9d23Y0Qp6qyT60MTvuH
	 CmAS5W9ZN4Y7sfPmdQcrZtq7s12XK8F+H62Kixq4acvW44WYx5DmkSuTStQo0WNt20+3G
	 6wl6okzptwUHT0/1d18Ubl7GmC+DjCPClzlsoHnWcb6Toq63szWNDSo+PumA/P9BI4A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=o8bgGmyy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=9dDHIROo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=QkObJqM3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=F+Du8vcR;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 915FDF80424
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 14:24:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 915FDF80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=o8bgGmyy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=9dDHIROo;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=QkObJqM3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=F+Du8vcR
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B51C01FE3A;
	Fri,  2 Oct 2026 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790943889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZODSKMv5b5U6bVzupZFZsEAgoJZwSG9bwV78123WnmQ=;
	b=o8bgGmyyEnfd0p2ItmM8c8C71TMFpyQ2SSrDls3tjZbi250UL/gGLoTA9G1quwBmsWA0W8
	F7Sws1bzPD+lhT+kWFoBxCNWyutfD5C52IOVQaQrdztY3BqsYC6qRh/a54MKEm+Ucuh0uQ
	LddYYSW3kIvMUZAJ5sVPmI+lh754vWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790943889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZODSKMv5b5U6bVzupZFZsEAgoJZwSG9bwV78123WnmQ=;
	b=9dDHIROoPdmIrP+fDQHYDgjoFEpFJnHxwco6WGLNITirS07YPEUfgNC2IUfpfQ8BMI9VIS
	uBUYS7CaU/vowTBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QkObJqM3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F+Du8vcR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790943885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZODSKMv5b5U6bVzupZFZsEAgoJZwSG9bwV78123WnmQ=;
	b=QkObJqM3o2VTqtbSDxSjCmQCsIpXsQgcJ3x8p5A4msrgYEzR0gSJofk+OJUaeqUIvO1zue
	Jyn/9L0YMRysqWE7cCGXuTiK/f9xgO00ajWTDUYCfCmoUw5MKxyAyLrqGLdfWB4aalYVhl
	C3acHJ3/on4hkx6jUDy63uQi3REpSI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790943885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZODSKMv5b5U6bVzupZFZsEAgoJZwSG9bwV78123WnmQ=;
	b=F+Du8vcRoHk4R3X1hrSix2lHv5sTxLlxx2xyyHfzUcaQSTo6QxSszlEsxlRgPdt/HqnTsj
	8pEGcV2yEo+o0kAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5000D13C73;
	Fri,  2 Oct 2026 12:24:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bZeQCY2iv2oOOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Oct 2026 12:24:45 +0000
Date: Fri, 02 Oct 2026 14:24:44 +0200
Message-ID: <871pa81e9f.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc5
In-Reply-To: <874if41eee.wl-tiwai@suse.de>
References: <20261002115438.DD6341AC57CB@finisterre.sirena.org.uk>
	<877bk01fii.wl-tiwai@suse.de>
	<68deab21-b10e-47d5-b0f3-f533c995a87e@sirena.org.uk>
	<874if41eee.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B51C01FE3A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: 5S6OYFRIGLV7WLV7EQ23FRNZC3M7JUI7
X-Message-ID-Hash: 5S6OYFRIGLV7WLV7EQ23FRNZC3M7JUI7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5S6OYFRIGLV7WLV7EQ23FRNZC3M7JUI7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 02 Oct 2026 14:21:45 +0200,
Takashi Iwai wrote:
> 
> On Fri, 02 Oct 2026 14:05:02 +0200,
> Mark Brown wrote:
> > 
> > On Fri, Oct 02, 2026 at 01:57:41PM +0200, Takashi Iwai wrote:
> > > Mark Brown wrote:
> > 
> > > > ASoC: Fixes for v7.4
> > > 
> > > This is meant for a PR for 7.3-rc6?  Or really for 7.4?
> > 
> > v7.3, sorry - I thinkoed when I was typing stuff and fixed up the tag
> > name but not the subject.
> 
> OK, I corrected it at merging :)  Pulled now.

Hmm, wait, those changes look really too much for 7.3-rc.
It contains lots of Morimoto-san's refactoring changes, for example.
So they look really rather for 7.4.


Takashi
