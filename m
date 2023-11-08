Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6DEC4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Nov 2023 12:40:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE8A0844;
	Wed,  8 Nov 2023 13:39:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE8A0844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699447248;
	bh=HYLBtaP4bsKUIGKNt2595IGi4v7RE6IV73g0i3oEkmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OoLgjAlS6tXPb6sPRykWiFewew/rIymTbmRKFtU4H6aMhBAtIAhYCZZMYgbVRI+fP
	 HieuQOKAaz+O/5sqHF59WOdFEPqBjim515GfLotpww2joXpt1JLtnM5vC4y6estWy8
	 hpLlVlDhtx/84ClBOfsTN67DqY4TCMjCQT5EKcKM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6014F80549; Wed,  8 Nov 2023 13:39:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DF2EF8016D;
	Wed,  8 Nov 2023 13:39:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87F60F8016D; Wed,  8 Nov 2023 13:39:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 53F33F80100
	for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2023 13:39:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53F33F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=lkHkclyr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hRjTcE9k
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0DB51F8AA;
	Wed,  8 Nov 2023 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1699447162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caTSVkX7DWg9efIwdAHVnURh+gmnfRTacrd+wM1pTjM=;
	b=lkHkclyrTqcppb3bmNISYV/4HMRWVr0q6mrsiyi5RaP8v5AA3TA2OMaUSzWbqZvKNy2lNj
	Shj2UBQXu+r4wpRMdJWatUECk2AgqcnKDRAAaNaeaizjjIrrxR3mbxgZ9UQ2hkLwbn1t+h
	Vaq40fzotu6sH+5ip7rG17cLW+AJe/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699447162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caTSVkX7DWg9efIwdAHVnURh+gmnfRTacrd+wM1pTjM=;
	b=hRjTcE9kr7PNoeMS8E73MPUljlowzU67kn0PfSKxs6ytAHOvmKZ6ReM9+zkOcLfdMPsM/j
	t0dOSm2+u2yp7RBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97329133F5;
	Wed,  8 Nov 2023 12:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zQZoJHqBS2W4MAAAMHmgww
	(envelope-from <tiwai@suse.de>); Wed, 08 Nov 2023 12:39:22 +0000
Date: Wed, 08 Nov 2023 13:39:22 +0100
Message-ID: <87edh0ctc5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?EUC-KR?B?sK29xcf8?= <s47.kang@samsung.com>
Cc: <kuninori.morimoto.gx@renesas.com>,
	<alsa-devel@alsa-project.org>,
	<lgirdwood@gmail.com>,
	<pierre-louis.bossart@linux.intel.com>,
	<broonie@kernel.org>,
	<cpgs@samsung.com>,
	<pilsun.jang@samsung.com>,
	<seungbin.lee@samsung.com>,
	<donghee.moon@samsung.com>
Subject: Re: [PATCH] ALSA: core: Replace mutex_lock with mutex_trylock
In-Reply-To: <1891546521.01699446601660.JavaMail.epsvc@epcpadp3>
References: 
 <CGME20231107081810epcas2p27a897426580fce6f0884cffb256b2aaf@epcas2p2.samsung.com>
	<664457955.21699345385931.JavaMail.epsvc@epcpadp4>
	<87y1f9r705.wl-tiwai@suse.de>
	<1891546521.01699446601660.JavaMail.epsvc@epcpadp3>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2RZFDHSG4RDRXNR56W3JR5LK34QB4JZR
X-Message-ID-Hash: 2RZFDHSG4RDRXNR56W3JR5LK34QB4JZR
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2RZFDHSG4RDRXNR56W3JR5LK34QB4JZR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 08 Nov 2023 13:14:15 +0100,
°­½ÅÇü wrote:
> 
> > Thanks for the patch.  But this change may break the current working
> > behavior; e.g. when two proc reads are running concurrently, one would
> > be aborted unexpectedly.
> > 
> > IIUC, the problem is the call of proc_remove(), and this call itself
> > can be outside the global mutex.
> > 
> > Could you check whether the patch below works instead?  (Note that
> > it's only compile-tested.)  It makes the proc_remove() called at
> > first, then clearing the internal entries.  The function was renamed
> > accordingly for avoiding confusion, too.
> > 
> > 
> > Takashi
> 
> You are right. My patch is just for avoiding the deadlock. 
> It may lead to other problem instead the deadlock(e.g. USB sound card
> registration failure)
> Your patch works well without any problems.
> But I can't confirm that the problem is solved or not.
> because the issue has occurred only once until now.
> (Test method: USB insertion / removal during a call)

Maybe you can reproduce it more easily by adding some delay
(e.g. ssleep(2)) before mutex_lock() in snd_info_entry_open().
Then it's easier to cause a race.


Takashi
