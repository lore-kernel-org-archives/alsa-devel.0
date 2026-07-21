Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE811C4451C
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:55:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 826EE601E9;
	Tue, 21 Jul 2026 09:55:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 826EE601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784620531;
	bh=WQ1HSbXk3hnK9zfDFfQ6TOWMU9nYdcBfHxBIl35AjX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=r1JdFgA/QYdR2eWXH756erM6yOuQl+DvqhnyBZGbKjsWS9UA6RvleIpETsIqKY+3n
	 dQjVDC8r1zRReUhkhZJmLH5JWkGu6Svh1qbI+1OqNqzGuGCA6I/AArrmlVf8r/CnEJ
	 5VwFN7L5VouEKnGaOA4vSERy/9y8RL7ppGP1w7sM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53FC1F80601; Tue, 21 Jul 2026 09:54:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 941DBF80423;
	Tue, 21 Jul 2026 09:54:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90D7CF8053D; Tue, 21 Jul 2026 09:54:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784620493;
	b=AysoGa78RlYbv/pSOJyGUlGv/Ltj6Tq1Yd92gE7WymOHklQSOIqzXKJRw16gFcm6SFIM
	 SasApuzIXb/TVQAi/7YRitZ5gyRi83Lzu8M5WVyV9TcwMPB8FlxjLkHSiN00u7viMTIyP
	 y9lOPS5g6W6bgjwd7Fn9o6OXTOQo9GZLL8etJY9eVmQ6NGq0YrOCdAxUwdqY1TbC3gm0p
	 afY8hDhHOrmD1CAufUpBdmyIhegs8vVbEk6RNSxPddAI9VsXNcwCvok6h6auOc/0jsoY7
	 hiyA9kAkQI2li9zqID+2DYHJJK3SGcADGo5yziVSPCN0vyDOGiNEtKDS7WxT6lcsBZQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784620493;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=WQ1HSbXk3hnK9zfDFfQ6TOWMU9nYdcBfHxBIl35AjX0=;
	b=Kz+5KJInDs32tmNuRE5D15Juwhr8YQY/Mp1SOE32hvF63XFSjn6GEmMeSUYex2HWoPqC
	 uCLkc9+cLq1k7SRsx32rqNvNGWVlruIu1c0PbPI42eQFQKx408aKdfXRjgY1qNpE6blTw
	 3RuDSVvrP6zdmwfT9m9wSa6blGdu7aibzKTc9nEKbi4KJcb24f36vvZhpL3/FADIWginx
	 nlE2m5b+KNY04lT7GUwnEfA6P1KCFhjAnA3Ten6DMKM4LA4lo4NlHLcm9rdar1QUPg4Xc
	 yBHwU38e2rkTN3qRFDcwIOtnGoJUiZAij46vyHK4g+LOS8XniMjxWGLyETASoRnrgFg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=zxu82QXb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TU5I8JhM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=zxu82QXb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TU5I8JhM;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EEC4DF804D6
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2026 09:54:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEC4DF804D6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=zxu82QXb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TU5I8JhM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=zxu82QXb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TU5I8JhM
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 225D57A483;
	Tue, 21 Jul 2026 07:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784620491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1ebN0J6hAHE1fD0yc9pVknfeXeYE053eu7vo4cSUxc=;
	b=zxu82QXbGOOj+K0tB32ldoXUNk2wjMsI29dRX9i2jZACWytoKgaI2AQEZsu7NgY/lchnBb
	3YIUIS0SvyUdr8rzK0EhhhEk1ZdDnyzdE8UAnhwvMLUxUEIVbFpqO0Z/8568VjRzOLgOOl
	704h5O1Gz6MzWlxwg6KVD1Jz7gt83ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784620491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1ebN0J6hAHE1fD0yc9pVknfeXeYE053eu7vo4cSUxc=;
	b=TU5I8JhMzvBEssUWwwxgiAq1xD26ivPSCoBae2NNbDpByCxXXYBTpzwmVVWrgnP5qh64rt
	yaCe8zBioCy56hDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zxu82QXb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TU5I8JhM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784620491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1ebN0J6hAHE1fD0yc9pVknfeXeYE053eu7vo4cSUxc=;
	b=zxu82QXbGOOj+K0tB32ldoXUNk2wjMsI29dRX9i2jZACWytoKgaI2AQEZsu7NgY/lchnBb
	3YIUIS0SvyUdr8rzK0EhhhEk1ZdDnyzdE8UAnhwvMLUxUEIVbFpqO0Z/8568VjRzOLgOOl
	704h5O1Gz6MzWlxwg6KVD1Jz7gt83ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784620491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1ebN0J6hAHE1fD0yc9pVknfeXeYE053eu7vo4cSUxc=;
	b=TU5I8JhMzvBEssUWwwxgiAq1xD26ivPSCoBae2NNbDpByCxXXYBTpzwmVVWrgnP5qh64rt
	yaCe8zBioCy56hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA615779AA;
	Tue, 21 Jul 2026 07:54:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4ZEdM8olX2ouOQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 21 Jul 2026 07:54:50 +0000
Date: Tue, 21 Jul 2026 09:54:50 +0200
Message-ID: <87ik68pyk5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: ALSA: hda/realtek - Add quirk for Dell Pro QC1255
In-Reply-To: <e13d08e96ac449b6994d56dfe6ce3f5c@realtek.com>
References: <e13d08e96ac449b6994d56dfe6ce3f5c@realtek.com>
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 225D57A483
Message-ID-Hash: YYK7NHGMP2QPDKVTW5ME7DQRCL4YQVZY
X-Message-ID-Hash: YYK7NHGMP2QPDKVTW5ME7DQRCL4YQVZY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YYK7NHGMP2QPDKVTW5ME7DQRCL4YQVZY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 21 Jul 2026 09:46:50 +0200,
Kailang wrote:
> 
> Hi Takashi,
> 
> Vendor want to add more SSID.
> They forgot to list all the supported SSIDs.

Thanks, applied now (with the correction to Fixes tag).


Takashi
