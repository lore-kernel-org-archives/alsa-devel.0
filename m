Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD7BCD343F
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 07:09:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8430860204;
	Fri, 15 May 2026 09:09:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8430860204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778828982;
	bh=86ejFq3rb9bRbylZXChI7VBwk4nDY5IeLVwBUg+x87A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o/tnfzVKZiUOB1CfJUUo/k0xAOaf9N/75L4+H/igXk6zNLbuAO60dgDyQtz3SNqTG
	 swpomEx7Tp1+4Cagr7tRmCfYsqpyZlRbXl3rUmXqBEvkWPLFIjEOBjXS8NsiZRq6aI
	 5vrbEO65+rVaT0KTj58Gqv/lg8/1zfCOjF0Q2Xys=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E783F805F1; Fri, 15 May 2026 09:09:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD694F805E2;
	Fri, 15 May 2026 09:09:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDDCFF80557; Fri, 15 May 2026 09:09:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BDD9DF800C1
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2026 09:08:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDD9DF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=XSbyoXho;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ow/aKMKl;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=bw0zTaQw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vKq6LRjY
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B817A6AF0C;
	Fri, 15 May 2026 07:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778828937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiHXj/41w3NeF6xoYKIc+0rusShmBu2JMTnP67EJVAM=;
	b=XSbyoXhoTD2zqvyno7XbSRNy5dGMoEsrEcVqxEiI9mHw1dZFWDlWclipuAkTDiCYHq4ug6
	8bMjulMmTfr4n3Vlci/ZpBOhmQtwKBjo9AN1gbLG3clcAh86z6rfbPUUNWqISGnVpN/Ms7
	9nqGiPl98KZSudUZFpayFjmKQXIXEZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778828937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiHXj/41w3NeF6xoYKIc+0rusShmBu2JMTnP67EJVAM=;
	b=ow/aKMKlv9+2fp/MeV4nKppFKc+WelwY4yx6MlVTPDZ7fA+eGYICMXHivAwj756yyG+Okw
	ODeRs74X9+rCuBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778828936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiHXj/41w3NeF6xoYKIc+0rusShmBu2JMTnP67EJVAM=;
	b=bw0zTaQwtyCTyGMkqI5ZHJo+xj2muo/YioTXbLqPW8tZZq+UwWIyGTpnuVH22LO1adHGLb
	FbWC5i1x90y4h+MOQcrGxmODzMpTK24ZdANgqYkQD3pGuExYhJyBkxqnSzeJJf7sSv1iek
	3lZtQN6ncPcWYJtTIAI4dhcIU7ze3SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778828936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiHXj/41w3NeF6xoYKIc+0rusShmBu2JMTnP67EJVAM=;
	b=vKq6LRjYj359aJBWCCX4Y+FTmEodd2NsSavfhTUkEzpWoyxLA0Pjjk5mEI8Olzfcy2A5RP
	Tn42bYH2+JVfnxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82A35593A9;
	Fri, 15 May 2026 07:08:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id doyJHojGBmoLYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 07:08:56 +0000
Date: Fri, 15 May 2026 09:08:56 +0200
Message-ID: <871pfdup2v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Markus Kramer <linux@markus-kramer.de>
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book5 360
 headphone
In-Reply-To: <20260513222818.14351-1-linux@markus-kramer.de>
References: <20260513222818.14351-1-linux@markus-kramer.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[markus-kramer.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: X6U3GS4JQVIQYJEQPZSZIYLNCWXUA7C2
X-Message-ID-Hash: X6U3GS4JQVIQYJEQPZSZIYLNCWXUA7C2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X6U3GS4JQVIQYJEQPZSZIYLNCWXUA7C2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 14 May 2026 00:28:18 +0200,
Markus Kramer wrote:
> 
> The Samsung Galaxy Book5 360 (NP750QHA, PCI subsystem ID 0x144d:0xc902)
> has severe audio distortion on the 3.5mm headphone jack. Applying
> ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET corrects the output path
> configuration, consistent with fixes already applied to other Samsung
> Galaxy Book models using the same ALC256 codec.
> 
> Cc: stable@vger.kernel.org
> Link: https://github.com/thesofproject/linux/issues/5648
> Signed-off-by: Markus Kramer <linux@markus-kramer.de>

Applied now.  Thanks.


Takashi
