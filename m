Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208D5CD4F46
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 06:56:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72995601F8;
	Fri, 15 May 2026 08:56:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72995601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778828182;
	bh=V8/7dcG4YKKRtQY1emSNwarj3tvseTNdxJgaYPuQ3Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dFSOIjHwEJGEMPfFxdrVfLO5PM4sCksxhJjBJfPOK0t1jGFKUETbsj/ovh06DzZRC
	 7lhlI6pVokALErPe7eBnE/gnx1HS/cg3Jsk+oSiLBHnRyV0aqPhsrRpuvCHa7sx1Jy
	 n0LaSWGadlF11KtQQv1/D6WxEsyhKqjRLOAYzgNY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8E26F805EC; Fri, 15 May 2026 08:55:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59499F805F2;
	Fri, 15 May 2026 08:55:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35019F80557; Fri, 15 May 2026 08:55:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 90241F800C1
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2026 08:55:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90241F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Sm/1uNxI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=8qbqkFa7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Sm/1uNxI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=8qbqkFa7
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 271D76B2A1;
	Fri, 15 May 2026 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778828136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYmIenVMH+yqhwyJrvCMit6NPjZhq1+okGy0dyLLbq8=;
	b=Sm/1uNxIAsqVUyDdMFamc9QC8Yh1QWK2zk5r+VkudT+R+x19Xc/uEEKULOluFp7NCicYRi
	GH20Ziy3knVcOTvRlaBWWyX5g3iNIYZ3HAD2FI59FY0lqyOOpiC+ZPb0IEiXfvOXKpJpni
	SvpAdvOrGB/Zm87o0zk/FNhw/+awaWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778828136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYmIenVMH+yqhwyJrvCMit6NPjZhq1+okGy0dyLLbq8=;
	b=8qbqkFa7H+0HWrnjM7qWmIHDW20DOL0/DKl5jSy4cD3qc2abh64dTJxqls1BNPwBDDzkyU
	SugFaiyP+7UbaMBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Sm/1uNxI";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8qbqkFa7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778828136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYmIenVMH+yqhwyJrvCMit6NPjZhq1+okGy0dyLLbq8=;
	b=Sm/1uNxIAsqVUyDdMFamc9QC8Yh1QWK2zk5r+VkudT+R+x19Xc/uEEKULOluFp7NCicYRi
	GH20Ziy3knVcOTvRlaBWWyX5g3iNIYZ3HAD2FI59FY0lqyOOpiC+ZPb0IEiXfvOXKpJpni
	SvpAdvOrGB/Zm87o0zk/FNhw/+awaWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778828136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYmIenVMH+yqhwyJrvCMit6NPjZhq1+okGy0dyLLbq8=;
	b=8qbqkFa7H+0HWrnjM7qWmIHDW20DOL0/DKl5jSy4cD3qc2abh64dTJxqls1BNPwBDDzkyU
	SugFaiyP+7UbaMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1AAB593A9;
	Fri, 15 May 2026 06:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HxGMNWfDBmrrUgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 06:55:35 +0000
Date: Fri, 15 May 2026 08:55:35 +0200
Message-ID: <878q9lupp4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Wood <simon@mungewell.org>
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: M-Audio C600 disable Output Gain Knob
In-Reply-To: <20260511212458.44142-1-simon@mungewell.org>
References: <20260511212458.44142-1-simon@mungewell.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mungewell.org:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,mungewell.org:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 271D76B2A1
Message-ID-Hash: W3YRPOZBXDU2M2FHECFCJTLRLTI4BZ4S
X-Message-ID-Hash: W3YRPOZBXDU2M2FHECFCJTLRLTI4BZ4S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W3YRPOZBXDU2M2FHECFCJTLRLTI4BZ4S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 11 May 2026 23:24:58 +0200,
Simon Wood wrote:
> 
> The C400/C600 interfaces have a large output gain knob which attenuates
> the outputs as stereo pairs (1/2, 3/4 and 5/6). The Windows driver/app
> provides a control to disable this knob/behaviour on any/all outputs,
> forcing maximum gain on each.
> 
> The 'disable behaviour' is desirable if any outputs are being used for
> aux/effects sends, or if interface is being used as a live/matrix mixer.
> 
> This patch adds a control to select which output pairs are affected by
> the Output Gain Knob. Default behaviour is to select all outputs.
> 
> Tested on the C600, likely also works for the C400.
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

Applied to for-next branch.  Thanks.


Takashi
