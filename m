Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6ACF531C1
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:09:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CF386020D;
	Mon, 13 Apr 2026 20:09:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CF386020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776103752;
	bh=tO7rnijo1SIh2d7Fwapc57aBZjWOBHp/+naAeHF7pnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lxruB2tOy8t+LeiB7rzAR2X5zTkHWFu70eoe6vnVTQ8J9gOMdxG/njLGc+o226BoA
	 OrWBa6yyq7lVBoEfhdcyGu+NNpzbq0W/J9uz2mk8MczPoGxYw/NmJKnFLoHgJc+El6
	 eiqdSJ+IuQxrx/gsbH31Tnr2uIQmyMHo8a4NDuQA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F16FF805F5; Mon, 13 Apr 2026 20:08:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BDEDAF805F2;
	Mon, 13 Apr 2026 20:08:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 769B2F80537; Mon, 13 Apr 2026 20:08:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B9B01F800EE
	for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2026 20:08:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9B01F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=HBtZq+f9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=MABd5NbV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Bw/tfiS/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Kpm7rgAI
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E87395BE60;
	Mon, 13 Apr 2026 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776103709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzb3MnSogp8djxy+2/PL2Oa/2x31XK6dS5mOSAwaeko=;
	b=HBtZq+f9x2gXgBBIfRXOoNh2hcbwK5aY+B2uCzVLrgZ+0cv/plB5OgUq1WZYYokKaE/RuG
	NRoReQ07xL2GdBAQIGLNPakRN9kn+DY9Jmn2dm8Uvb1mSGXhVQLFnaIPYrBniaS+n+NI83
	WaRyMgijzlehmJEPHskPhGQ09ZLmqdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776103709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzb3MnSogp8djxy+2/PL2Oa/2x31XK6dS5mOSAwaeko=;
	b=MABd5NbVt9sT1eWr81Hvf8Bp4/ihG6c+U2YLvx/unT0JTglIgrlzyFQAEWLh8SYCcpUGEp
	C1hJSzcC6WLPL1Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776103708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzb3MnSogp8djxy+2/PL2Oa/2x31XK6dS5mOSAwaeko=;
	b=Bw/tfiS/3WDAlL0atlmWEp6HP6hne2D9GhfGWgvrC+yny0OtrUHSny0EJldhOYkTcHmifM
	LVWG+6jb2rQR1IQOGIIZdendh7bT3veYMq027l27G/z7v6vxEroOkucLxQHbSC6H4kbrT+
	YVSbSdeTW8zZmmNbuWKFRpzUqbaRJQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776103708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzb3MnSogp8djxy+2/PL2Oa/2x31XK6dS5mOSAwaeko=;
	b=Kpm7rgAIMi3PuvxZ0c2S+/bBuw5TEPBi5OzXVOQaodk70py/E3nxvkco8w38yYELxinSf2
	9QiI3j8oVsfzJVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3C0C4AFFD;
	Mon, 13 Apr 2026 18:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2N2aLhwx3WlLVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Apr 2026 18:08:28 +0000
Date: Mon, 13 Apr 2026 20:08:28 +0200
Message-ID: <87eckiu40z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC updates for v7.1
In-Reply-To: <d2e0da35ba2c101c63b915e4bcbc707b@kernel.org>
References: <d2e0da35ba2c101c63b915e4bcbc707b@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: TM72SISZ2TDP7G7BKIT2FAI3YCMYSVXS
X-Message-ID-Hash: TM72SISZ2TDP7G7BKIT2FAI3YCMYSVXS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TM72SISZ2TDP7G7BKIT2FAI3YCMYSVXS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 13 Apr 2026 18:08:06 +0200,
Mark Brown wrote:
> 
> The following changes since commit 6b6f7263d626886a96fce6352f94dfab7a24c339:
> 
>   ASoC: amd: acp: update DMI quirk and add ACP DMIC for Lenovo platforms (2026-04-08 17:04:47 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v7.1
> 
> for you to fetch changes up to 115e7d764dad66a10e150bd4b3ba3bbb95b04d85:
> 
>   ASoC: dt-bindings: rockchip: convert rk3399-gru-sound to DT Schema (2026-04-12 17:24:42 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Updates for v7.1
> 
> There's one new core feature here but mostly this has been a fairly
> quiet release, we've got a few new drivers and one core feature that's
> likely to be relatively rarely used but the bulk of the work this time
> around has been on quality.
> 
>  - Support for bus keepers, this will be used by the Apple device
>    support.
>  - Enhancements to the SDCA support, incuding retaskable jacks.
>  - Unwinding of the pcm_new()/pcm_free() cleanups from Morimoto-san.
>  - Test improvements for the Cirrus Logic drivers.
>  - Large sets of fixes for the NXP, nVidia and Qualcomm drivers.
>  - Support for AMD RPL DMICs, Cirrus Logic CS42L43 and CS47L47, nVidia
>    machines with CPCAP and WM8962.

Thanks, pulled.


Takashi
