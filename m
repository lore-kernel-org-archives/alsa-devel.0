Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01FEC36000
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:29:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E125602F0;
	Fri, 21 Mar 2025 16:29:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E125602F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742570956;
	bh=RMyWWEohdDzqMcSQPGtDr9wXwBc4GdJGIq1ZEc2uC3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=R4nKoYu1O2YCpR7mJ6+fkI9zopm4BrkQTfYperaIt5oNhnA2MMuhyMujhThWysEyq
	 YPsMxKJ4TX34v7VjcVnO/MsI9ITu/7G574idvs0fXwUpLY5ZYpOsSYPYd5X2xGJSvQ
	 zK3duQza5TeVqIijokThGxqx2SOc2a3qm8qBVbRM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5C4BF805BA; Fri, 21 Mar 2025 16:28:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A069CF805C2;
	Fri, 21 Mar 2025 16:28:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EEBDF8013D; Fri, 21 Mar 2025 16:28:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2E8B7F800BD
	for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2025 16:28:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E8B7F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=oAl2hUEc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gSbKs43t;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=oAl2hUEc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gSbKs43t
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 728C31F847;
	Fri, 21 Mar 2025 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1742570913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hG1Q+spEXnEIds6/6JUHTiLmz2DsbASQWD7CTXrHDQ4=;
	b=oAl2hUEcIRlb9tqvtJaHX3d1MGLE81spyN0tRzu3mNVueuei3ExiGzFhbXQ4OjbkHpQGkC
	RCam6LA3gtltyXZoJRmPrAmDOmJQMKGIU/Cv+qSvgwjQA1PeQtJxGjovFDCSDTHm4V9fV6
	8LaEJKimF6LYF2fXVMCuUbqjDKuVb2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742570913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hG1Q+spEXnEIds6/6JUHTiLmz2DsbASQWD7CTXrHDQ4=;
	b=gSbKs43t/pac94WydGHqoDozbRjblyTmccU4KmWkZHDaf55wwum3v+ZHZj/+dfI6aUsmbD
	67eTGknmNnBYPSDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1742570913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hG1Q+spEXnEIds6/6JUHTiLmz2DsbASQWD7CTXrHDQ4=;
	b=oAl2hUEcIRlb9tqvtJaHX3d1MGLE81spyN0tRzu3mNVueuei3ExiGzFhbXQ4OjbkHpQGkC
	RCam6LA3gtltyXZoJRmPrAmDOmJQMKGIU/Cv+qSvgwjQA1PeQtJxGjovFDCSDTHm4V9fV6
	8LaEJKimF6LYF2fXVMCuUbqjDKuVb2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742570913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hG1Q+spEXnEIds6/6JUHTiLmz2DsbASQWD7CTXrHDQ4=;
	b=gSbKs43t/pac94WydGHqoDozbRjblyTmccU4KmWkZHDaf55wwum3v+ZHZj/+dfI6aUsmbD
	67eTGknmNnBYPSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A018139AA;
	Fri, 21 Mar 2025 15:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +bWHEKGF3WdWFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 21 Mar 2025 15:28:33 +0000
Date: Fri, 21 Mar 2025 16:28:32 +0100
Message-ID: <87r02qtnbz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v6.14-rc7
In-Reply-To: <2e7905783f8f3541e854a13742ff1c22.broonie@kernel.org>
References: <2e7905783f8f3541e854a13742ff1c22.broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: RNSKB46SWZKN2NT4TSERTINWMO245LPN
X-Message-ID-Hash: RNSKB46SWZKN2NT4TSERTINWMO245LPN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RNSKB46SWZKN2NT4TSERTINWMO245LPN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 21 Mar 2025 15:38:39 +0100,
Mark Brown wrote:
> 
> The following changes since commit 658fb7fe8e7f4014ea17a4da0e0c1d9bc319fa35:
> 
>   ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS (2025-03-12 16:12:24 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.14-rc7
> 
> for you to fetch changes up to 45ff65e30deb919604e68faed156ad96ce7474d9:
> 
>   ASoC: ti: j721e-evm: Fix clock configuration for ti,j7200-cpb-audio compatible (2025-03-18 12:27:34 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v6.14
> 
> A couple of small fixes, plus some new device IDs - nothing super urgent
> here.

Pulled now.  But I'll postpone a PR in this week, as we have no urgent
fixes, so likely to be included in 6.15-rc1.


thanks,

Takashi
