Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB69F99344
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:54:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E636760205;
	Thu, 23 Apr 2026 10:53:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E636760205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776934443;
	bh=ccpROn8pEIJFjukym+vufN1xB/U6CJzEbR04MpUzWtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uiPu798QjjOkxnWUVfvIRS4Lx7ULmGA3kjZ7KsXTsKrxB3SDwUlTMFRDdwTJkrcsK
	 xg506PE7BdjBsCnsVJH54RprOrQFaY38LWtVcB6vFhonT5PsyN6EMPLS2cpx0UXVgQ
	 py3t8ujiMIypQ73Ruz3Z3gqpnYFdbk1yxg3OmfQQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2450F805F6; Thu, 23 Apr 2026 10:53:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 39EFAF805EA;
	Thu, 23 Apr 2026 10:53:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 809B5F80526; Thu, 23 Apr 2026 10:53:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E56ECF80162
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2026 10:53:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E56ECF80162
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Q5S65j9O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=s+7buWEk;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=G+6DP26n;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=z4tCMGa0
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA9516A82E;
	Thu, 23 Apr 2026 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776934393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IufGVrR7N6OOFeQLWb5J82GpxJOOA/GkIgthZ7UilJg=;
	b=Q5S65j9OWAc2F2bCv4ksb6sRti1dc5uie5IxnTQDqOu3ROmARb5pRsiJ0CkpKedrNtTuxp
	9yn89wynREADa/S7QY0PAtDXIPzoBZt0rSHXXHctKUj/B4H/j3VfsZ2bNuJhq6D9RWPLBB
	ORtMz/kKZxFHI+dDGjI/uSfJW6slNKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776934393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IufGVrR7N6OOFeQLWb5J82GpxJOOA/GkIgthZ7UilJg=;
	b=s+7buWEkwgHBUI0A4ZBSWYMGPai2D5E+8M1fqcktymGUgW02c9CTF98eHnj3C82DV6fueo
	PyVVVlsScKBPmUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776934391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IufGVrR7N6OOFeQLWb5J82GpxJOOA/GkIgthZ7UilJg=;
	b=G+6DP26n1pcHWQgZVhfg8UFHw79YfryJFymRxP793iyyzx6SfAofaSbqCpDh6NUhZywqx/
	RnlclwzOaaK/mK9L0TYox3KKTfp224x7MRUDaXDo3CDJhMJPJVLmn5Un1Ir5CzGAbI9jgZ
	IA7Kvkr/z/SkVsP/xBnpSquxbXK7A8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776934391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IufGVrR7N6OOFeQLWb5J82GpxJOOA/GkIgthZ7UilJg=;
	b=z4tCMGa02Vra/d713fhq1MCr/e4a+VDI3Oki/NRoW3bp/g5fkMJcWvF4lGMoN3OqeElmac
	pFdHaGCvqX1traAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 888FF593A3;
	Thu, 23 Apr 2026 08:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2WAeIPfd6WlJCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 23 Apr 2026 08:53:11 +0000
Date: Thu, 23 Apr 2026 10:53:11 +0200
Message-ID: <874il23vns.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.1-merge-window
In-Reply-To: <101ba0b3f4dd2e7213d3ef9dbb8a2140@kernel.org>
References: <101ba0b3f4dd2e7213d3ef9dbb8a2140@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
Message-ID-Hash: IJNSZ6TPQHHWUHMTK5PGAGFATHO2W34U
X-Message-ID-Hash: IJNSZ6TPQHHWUHMTK5PGAGFATHO2W34U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IJNSZ6TPQHHWUHMTK5PGAGFATHO2W34U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 22 Apr 2026 23:02:58 +0200,
Mark Brown wrote:
> 
> The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:
> 
>   Linux 7.0 (2026-04-12 13:48:06 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-merge-window
> 
> for you to fetch changes up to 24fcdc81dd7e1560e57eff75b618e5b00054b714:
> 
>   ASoC: dt-bindings: ti,tas2781: Add TAS5832 support (2026-04-22 21:15:55 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.1
> 
> A fairly small collection of fixes, device IDs and quirks that came in
> during the merge window, the most remarkable of which is one for SDCA
> boolean firmware flags which is remarkable mainly because it is
> partially in regmap.

Pull now.  Thanks.


Takashi
