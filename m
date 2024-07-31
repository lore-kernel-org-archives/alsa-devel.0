Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B39CC3DA7F
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Jul 2024 10:41:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 377E42C70;
	Wed, 31 Jul 2024 12:41:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 377E42C70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722422484;
	bh=Ncb9CTSSLlmKgoCRZiTaArzwVM7o0BSNdYG6IQTySMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Gk79auH00MMCyNaAYvY/eNcf3ZVhO0AwB5/NcN1CQsNfZavF55L3P3/YU85nSbffL
	 hMvKu1vVoqnmQ6rJP8NliDD3gd2RHLLqm2VIdRluuNd+6w6+koB+KyTnYNbnkOFUd1
	 wg2I3TZGmvoaub+BBHeGqsdATk609Odwz9c7M1/4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25EECF80580; Wed, 31 Jul 2024 12:41:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B315EF805B5;
	Wed, 31 Jul 2024 12:40:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C93D9F802DB; Wed, 31 Jul 2024 12:30:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5358F80269
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2024 12:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5358F80269
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=lKgP2ubq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=47hLUtRx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=lKgP2ubq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=47hLUtRx
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6A4221CD6;
	Wed, 31 Jul 2024 10:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1722421811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zApTDqqRMnQ88tdecMBReesZBZBFTQO5WdcU+17HzM=;
	b=lKgP2ubq1Qv+W7jxtJwq2uetX5S0ThzTrZQO6BScyvxNPFEFmG//Ba/XqxXvN6mBP8gA5Q
	/O8xAHMOE1GOVfF2rAiAzTzdfvUVZILJF7CFy9DhS0bOTFo9o8VmhqKWzj4vMzXJhCrO4T
	ujqwF+Q3WxxMj4EcODUQAnopjsIIdtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722421811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zApTDqqRMnQ88tdecMBReesZBZBFTQO5WdcU+17HzM=;
	b=47hLUtRxrkijK5iaAKklCEckDnKtvard7qgPjbs1XdUFgblEk2ZnR4iCAT0KEwl8bK6F0c
	qXxfIE49WFi2F4Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1722421811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zApTDqqRMnQ88tdecMBReesZBZBFTQO5WdcU+17HzM=;
	b=lKgP2ubq1Qv+W7jxtJwq2uetX5S0ThzTrZQO6BScyvxNPFEFmG//Ba/XqxXvN6mBP8gA5Q
	/O8xAHMOE1GOVfF2rAiAzTzdfvUVZILJF7CFy9DhS0bOTFo9o8VmhqKWzj4vMzXJhCrO4T
	ujqwF+Q3WxxMj4EcODUQAnopjsIIdtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722421811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zApTDqqRMnQ88tdecMBReesZBZBFTQO5WdcU+17HzM=;
	b=47hLUtRxrkijK5iaAKklCEckDnKtvard7qgPjbs1XdUFgblEk2ZnR4iCAT0KEwl8bK6F0c
	qXxfIE49WFi2F4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6DB13297;
	Wed, 31 Jul 2024 10:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZEKdIDMSqmYHLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 31 Jul 2024 10:30:11 +0000
Date: Wed, 31 Jul 2024 12:30:48 +0200
Message-ID: <87zfpxyht3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ALSA: hda: cs35l41: Stop creating ALSA Controls for
 firmware coefficients
In-Reply-To: <013bdb56-b940-4881-b881-ad12be7321d0@perex.cz>
References: <20240730143748.351651-1-sbinding@opensource.cirrus.com>
	<013bdb56-b940-4881-b881-ad12be7321d0@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: RO3QTYEGOPTFRODXJP5P3EVMWMSMC62K
X-Message-ID-Hash: RO3QTYEGOPTFRODXJP5P3EVMWMSMC62K
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RO3QTYEGOPTFRODXJP5P3EVMWMSMC62K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 30 Jul 2024 16:55:19 +0200,
Jaroslav Kysela wrote:
> 
> On 30. 07. 24 16:37, Stefan Binding wrote:
> > Add a kernel parameter to allow coefficients to be exposed as ALSA controls.
> > 
> > When the CS35L41 loads its firmware, it has a number of controls to
> > affect its behaviour. Currently, these controls are exposed as ALSA
> > Controls by default.
> > 
> > However, nothing in userspace currently uses them, and is unlikely to
> > do so in the future, therefore we don't need to create ASLA controls
> > for them.
> > 
> > These controls can be useful for debug, so we can add a kernel
> > parameter to re-enable them if necessary.
> > 
> > Disabling these controls would prevent userspace from trying to read
> > these controls when the CS35L41 is hibernating, which ordinarily
> > would result in an error message.
> 
> This is probably not a right argument to add this code. The codec
> should be powered up when those controls are accessed or those
> controls should be cached by the driver.
> 
> Although the controls have not been used yet, exposing them in this
> way is not ideal.
> 
> Could you fix the driver (no I/O errors)?

While we should fix the potential errors at hibernation, it's not bad
to hide those controls, IMO.  For the normal use cases, it's nothing
but a cause of troubles, after all.


thanks,

Takashi
