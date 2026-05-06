Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEE8CD343B
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2026 14:16:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 580DC60220;
	Wed,  6 May 2026 16:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 580DC60220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778076967;
	bh=GYi/8rau8QID9F0RMixFHAHkmPzR4Vq34031HLA9o9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DQ+O6kzv+Y1FmNsRZ0G7CBOQ2GoXdIiWlBAMf0Hrz3YM2WVDVR5U8Tye8fl45WIy7
	 UkNY/qdk6jY6DB6iy0tjg+mEOaDViKZawsYdHNHee1bWM5C+W2vAgIyxQcvF18gVqz
	 8aG4VgSKEqXkNCG1nm/Ow6ac+oC6HuCEiZFxbeyE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98CBAF805F1; Wed,  6 May 2026 16:15:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 47CB4F805E6;
	Wed,  6 May 2026 16:15:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3592DF80217; Wed,  6 May 2026 16:15:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 713F5F8003C
	for <alsa-devel@alsa-project.org>; Wed,  6 May 2026 16:15:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 713F5F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=UpC/1h4Y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=/XEQl1rc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ZuFYKN1x;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X6mXjgUa
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B539E6B5F6;
	Wed,  6 May 2026 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778076923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3hgveFw+6av6mvlhRfcu8ucBtZF9w8+O4HhgmFcUh8=;
	b=UpC/1h4YObwBNhlkgDcimEHfx38YxobG5jt1+/oMQ2jnJz2ZWvHxGdciSDbuZyQuujit1s
	GRLSLv0mNq6Zrm4P53IhyCi6CKzvZJxtmmteLjVMP1nsvztpnqcZe18RlrF029++sD80dv
	RIaBkjYmQ8RHZ9yHbtvors3pSk6nA7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778076923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3hgveFw+6av6mvlhRfcu8ucBtZF9w8+O4HhgmFcUh8=;
	b=/XEQl1rc7hUBLp7MehR/f0ROL3VanMZIGUAQCY0aJfaknCclvGBKbWGT4WsqV+9jRjVE8g
	MGEdVfl24ouO0EDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778076919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3hgveFw+6av6mvlhRfcu8ucBtZF9w8+O4HhgmFcUh8=;
	b=ZuFYKN1xyRpiirZeFeS2FuEY1IgzmL97OO7LpBOhqsjgzrdKI2jemShsUXzl/MC+QvgV9q
	3DyQLDiYgW8s6MRCEfd4BAZF08PLadREg+xiIE85xPSAapXPR94LGpZ/c5r7CkIG97gk9D
	BOgimqagXx/jZ/pNCdCAcFzU68rDZi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778076919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3hgveFw+6av6mvlhRfcu8ucBtZF9w8+O4HhgmFcUh8=;
	b=X6mXjgUaapMWro9cYPRgx5wFIW/7CnhGDdN8ZM03FWjr9BgCvlC8U75p4FbAeM4EPF7tHS
	GX09n5wrauTIDFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F497593A3;
	Wed,  6 May 2026 14:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ahS9IfdM+2kZHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 06 May 2026 14:15:19 +0000
Date: Wed, 06 May 2026 16:15:19 +0200
Message-ID: <87a4ucsjyg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.1-rc2
In-Reply-To: <20260506140552.603EF1AC587E@finisterre.sirena.org.uk>
References: <20260506140552.603EF1AC587E@finisterre.sirena.org.uk>
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: OUZAKVRX55RBR6YBKSLVSJAHSX47JWPT
X-Message-ID-Hash: OUZAKVRX55RBR6YBKSLVSJAHSX47JWPT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OUZAKVRX55RBR6YBKSLVSJAHSX47JWPT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 06 May 2026 16:05:47 +0200,
Mark Brown wrote:
> 
> The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:
> 
>   Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc2
> 
> for you to fetch changes up to 5776bcdf4dccac8edc1160482792b512da5c08b4:
> 
>   ASoC: cs35l56: Fixes for driver cleanup (2026-05-06 21:22:53 +0900)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.1
> 
> Another batch of fixes, plus a couple of quirks (mostly AMD ones, as has
> been the case recently).  All driver changes, including fixes for the
> KUnit tests for the Cirrus drivers that could cause memory corruption.

Pulled now.  Thanks.


Takashi
