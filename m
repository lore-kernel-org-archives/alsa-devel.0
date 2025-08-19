Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D331CA0EE9
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Aug 2025 06:28:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71782601FA;
	Tue, 19 Aug 2025 08:28:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71782601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1755584912;
	bh=cV05Eq02/nG0Q9sYIvBcAE8pEoJxtUZkAvLw/4uwtuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sOOvWYlQiTwkkl1/kUDLWe9CCaYdCH7/LkK7Vb6xV4frQG/56nL3Aa5Eqz2Sqbatm
	 1eXGrTRRkTeXiRnxcUTZ5RY/fBFquXfGYpRnj6XMgdw6vGPW/oJyP1IPpTN2fKCoqe
	 6oWpWdosS13cW35xJaP70hFrq0JX0KRoqRxWFtKY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40278F805D2; Tue, 19 Aug 2025 08:27:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 96BD3F805C0;
	Tue, 19 Aug 2025 08:27:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E8F3F80217; Tue, 19 Aug 2025 08:27:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CB709F80171
	for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2025 08:27:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB709F80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=K9xACBtj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=7K7cdYtb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=K9xACBtj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=7K7cdYtb
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC93F1F749;
	Tue, 19 Aug 2025 06:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1755584850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6wMoqLgpNEKyx4tj2YTrdP3c6dN+MPsSq2WOcNX60I=;
	b=K9xACBtj1SWXExQjv5fpd0t9XVYrxQhuM7V9otcZ6bVWZ+HItJAt5VaaamFcm9gJ6BjPz8
	ko2fJykGNyXLqPrZMcWLcQWLm9GcKu5S/o+Z2IiZlN0cl2+OxjNS5NUHYNObYdtrSxVakD
	OuCh4FjEGww6bX+EXUTtCHh+D0f7bsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755584850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6wMoqLgpNEKyx4tj2YTrdP3c6dN+MPsSq2WOcNX60I=;
	b=7K7cdYtbjCCodYjma7o0dQ4PvOSA0Ph9HC2lIBrQ5rGmj0wTZuZ3dFnoS+obM1r3DQmCsZ
	xUnFCsKc4795jaBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1755584850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6wMoqLgpNEKyx4tj2YTrdP3c6dN+MPsSq2WOcNX60I=;
	b=K9xACBtj1SWXExQjv5fpd0t9XVYrxQhuM7V9otcZ6bVWZ+HItJAt5VaaamFcm9gJ6BjPz8
	ko2fJykGNyXLqPrZMcWLcQWLm9GcKu5S/o+Z2IiZlN0cl2+OxjNS5NUHYNObYdtrSxVakD
	OuCh4FjEGww6bX+EXUTtCHh+D0f7bsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755584850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6wMoqLgpNEKyx4tj2YTrdP3c6dN+MPsSq2WOcNX60I=;
	b=7K7cdYtbjCCodYjma7o0dQ4PvOSA0Ph9HC2lIBrQ5rGmj0wTZuZ3dFnoS+obM1r3DQmCsZ
	xUnFCsKc4795jaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C229139B3;
	Tue, 19 Aug 2025 06:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYsZIVIZpGjCEAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 19 Aug 2025 06:27:30 +0000
Date: Tue, 19 Aug 2025 08:27:30 +0200
Message-ID: <87qzx7vnal.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: Bug 220109 - Audio disappears on HP 15-fc000 after warm boot
 again
In-Reply-To: <5317ca723c82447a938414fcca85cbf5@realtek.com>
References: <5317ca723c82447a938414fcca85cbf5@realtek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: MHSKGCIFSHUPEYUEGLVDAMKGOOKEFJ7X
X-Message-ID-Hash: MHSKGCIFSHUPEYUEGLVDAMKGOOKEFJ7X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MHSKGCIFSHUPEYUEGLVDAMKGOOKEFJ7X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 19 Aug 2025 08:19:45 +0200,
Kailang wrote:
> 
> Hi Takashi,
> 
> Attach patch will solve issue.
> 
> BR,
> Kailang

Thanks, applied now (with a slight reformat of patch description
texts).


Takashi
