Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD0ACD4F54
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2026 12:03:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4272C60274;
	Thu, 28 May 2026 14:03:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4272C60274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779969809;
	bh=kLXdfIu3TDXvhgdmIMOlcTwukAOIVFTN+jy1SXAecZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fpXu8v5Dxo5D7nt1tHLzJpyuNfeb92yiTxtYGRJJ5r6q+CU8dG5EnvJNi+7Ck88aj
	 xDSPf5VUpZJqs/E8bgM1YdumQqBrUJ5D3CFEM7te0+Xm7k4eLuWSvfdDtspxTiAO+q
	 DFBWOJV4SNxdrOSHxZZMToSP0WXvTRAd/AtgjIz8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89355F805F6; Thu, 28 May 2026 14:02:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F1F1F805C8;
	Thu, 28 May 2026 14:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C62C3F8026A; Thu, 28 May 2026 14:02:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2FF5EF80132
	for <alsa-devel@alsa-project.org>; Thu, 28 May 2026 14:02:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FF5EF80132
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=qtcAg6YE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=0gMeqoDh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=IMVNXIRo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IUU4TxLa
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 70DD06A8E1;
	Thu, 28 May 2026 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779969765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IWXAOyH83XZYhGf4hPtS9ap06We8NE01Pzy5wY+UUo=;
	b=qtcAg6YEBFLyTbtXCZbf1kghLYodQl6NL9qpjRjagFcBMM6QALU9dP94YI4Ph1Mv5+03e2
	/sm2CU3sZ4R4djflmkjL9Yy3wlwonNB/DesSmGCTa/qVqKILBAUZ9tKUxKfQ+Fca4gsE3V
	lpg2fyt1M0QZ9pGjFrencpPY2+JsVsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779969765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IWXAOyH83XZYhGf4hPtS9ap06We8NE01Pzy5wY+UUo=;
	b=0gMeqoDhmRd27WNj80fYSx1iiuWpQQP1kygmYKwiZv7CrVdZfKyDO0E5c4u351S3kaj+dT
	7fR9uihmit4YS2Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779969764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IWXAOyH83XZYhGf4hPtS9ap06We8NE01Pzy5wY+UUo=;
	b=IMVNXIRobJflV6VDXxDbEXiphZfnikfQsrO0eYOsMSCApiU8wjXM5GR1LwyuMRv9iJNBxK
	0h6T1UzPfNtsld8fniuIhmeeBElnd3Pqw4a/Jh4acBG60bv/nx1uK9gM4FP70iI9Lsv/D1
	WGkcn+OAN9GCgWQR1n0Qp/Xrgzvvvfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779969764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IWXAOyH83XZYhGf4hPtS9ap06We8NE01Pzy5wY+UUo=;
	b=IUU4TxLawvB6n9j0VXFmZuP/PBnR61XaB8h4rvMrE4214zthu7ZSb9bfYZNBgwf0OeoCWW
	xNH2AHeQIQSTVaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CCB45AD93;
	Thu, 28 May 2026 12:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KIFrEeQuGGpXZQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 28 May 2026 12:02:44 +0000
Date: Thu, 28 May 2026 14:02:43 +0200
Message-ID: <87se7bu4gs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.1-rc5
In-Reply-To: <69088c924b372c57eeb1e4e49a2c09ba@kernel.org>
References: <69088c924b372c57eeb1e4e49a2c09ba@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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
Message-ID-Hash: BF4N32HJOXBXW6IMNEEA7BDE74DGRYDO
X-Message-ID-Hash: BF4N32HJOXBXW6IMNEEA7BDE74DGRYDO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BF4N32HJOXBXW6IMNEEA7BDE74DGRYDO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 28 May 2026 13:44:09 +0200,
Mark Brown wrote:
> 
> The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:
> 
>   Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc5
> 
> for you to fetch changes up to f63ad68e18d774a5d15cd7e405ead63f6b322679:
> 
>   ASoC: codecs: simple-mux: Fix enum control bounds check (2026-05-27 13:43:20 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.1
> 
> This round of fixes is mostly Sirini's Qualcomm cleanups that have been
> in review for a while, we also have a couple of small fixes from Cássio.

Pulled now.  Thanks.


Takashi
