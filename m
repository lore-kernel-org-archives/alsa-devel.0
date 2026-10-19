Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3A606A32D
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=X9lwUFev;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Lh65nbHl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BgC+HGa7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NIUF4aQN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BU+CC5Aj
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57088601A9;
	Wed, 21 Oct 2026 19:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57088601A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792602433;
	bh=R+78k/G1Ky3gE/+MPAtg817RATsJdDK06ghsQg3e79w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X9lwUFevcGidPJoph6aE/0GX18qTBMpBlOU2BYs4yMzqbVEb/lRm/qJENcGoVVybD
	 fdR+NPTkiZYWaC8hOFfOXQbG18wHucJDk6rgwx46Ndcs25rdOcMfzOkzXF6gHmewtc
	 kpxsA5S9C2UwXxVOS8z2Zzh9hwP+9z7Bm9gzUXEs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58400F805F6; Wed, 21 Oct 2026 19:06:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB16EF80525;
	Wed, 21 Oct 2026 19:06:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11F23F800B6; Wed, 21 Oct 2026 19:06:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC679F80087
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 19:06:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC679F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Lh65nbHl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=BgC+HGa7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=NIUF4aQN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=BU+CC5Aj
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB71E21BDC;
	Mon, 19 Oct 2026 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1792432896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMyX1wCMryLFWIzR6bIg2Xo01mHrn9QZDtx9J0e+gDc=;
	b=Lh65nbHly77wRr0tiATZqHJaR2rIeTOTp5FBYzKgvSleHnyVnGwg4+zpjqOftLxDLk9oeh
	7w1otnsk9cTRMVp5Wmz5kLBaRnEEATE3vhp4EmGcq5KOmQhaIvZK/9EudxLogAIcSSzW57
	6UT2GjEWBQ3jmfSxLzAJP3hgrB4VuK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792432896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMyX1wCMryLFWIzR6bIg2Xo01mHrn9QZDtx9J0e+gDc=;
	b=BgC+HGa7aL3BqLaA8PElAx7chAsAflGygNhgVBka5KVkj1kpgevCt/RCN3zrafWwqCyezG
	ivmhPY+rdMpOPjDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NIUF4aQN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BU+CC5Aj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1792432895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMyX1wCMryLFWIzR6bIg2Xo01mHrn9QZDtx9J0e+gDc=;
	b=NIUF4aQN2VMaJE87nDN6+igBP5r8lABJw8QfAvdrrATrf2YgWz+YhzpLOh6YaH2C7r/6gq
	fH+ZvpasirhgELVisZPwFcxWSZRGxlUqAVFkDMS2dYxFbE1jPmi/rTNhT1H2FX2C+6+s/x
	BYE6EPDbRsQj/KWmjgX3Ljk4rNJ67lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792432895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMyX1wCMryLFWIzR6bIg2Xo01mHrn9QZDtx9J0e+gDc=;
	b=BU+CC5AjloSj9qpltfFuKDN+rN6B6FaW3UsQBfyJz8MF4Jgdyv5GHKr/h1/qSWtQ/uyu7r
	WuYtRTfRDkZVyIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5CDF134B3;
	Mon, 19 Oct 2026 18:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EhzyHv9a1mpTSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Oct 2026 18:01:35 +0000
Date: Mon, 19 Oct 2026 20:01:35 +0200
Message-ID: <87y0btin7k.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC updates for v7.4
In-Reply-To: <20261019171515.805171AC57D0@finisterre.sirena.org.uk>
References: <20261019171515.805171AC57D0@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EB71E21BDC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: NJXRXBHTCIRY4L32PDMVRTLWPN3NHRRQ
X-Message-ID-Hash: NJXRXBHTCIRY4L32PDMVRTLWPN3NHRRQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NJXRXBHTCIRY4L32PDMVRTLWPN3NHRRQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Mon, 19 Oct 2026 19:14:57 +0200,
Mark Brown wrote:
> 
> The following changes since commit 2a31b5378c6db9c4a8d399e5d10d32cd4b732bef:
> 
>   ASoC: amd: yc: disable MSI on resume (2026-10-13 14:32:22 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v7.4
> 
> for you to fetch changes up to 73be2ee656f2722d498504259b9f1fdef8419431:
> 
>   ASoC: codecs: Fix more control definitions that write another control's bits (2026-10-18 13:22:10 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Updates for v7.4
> 
> There's an awful lot of cleanup work in this pull request, lots from Bui
> Duc Phuc, Pengpeng Hou, HyeongJun An and Chancel Liu cleaning up detail
> issues in drivers in addition to Mormoto-san's ongoing framework work.
> This time Morimoto-san's work included enabling auto_selectable_formats
> so there's less manual configuration required for DAI links.
> 
> There's also been a huge amount of upstreaming activity from Qualcomm,
> some pain there but hopefully enough has now landed for things to be
> smoother in future.
> 
>  - Use auto_selectable_formats in most drivers to reduce the amount of
>    manual configuration required for DAI links.
>  - Support for compressed audio on SOF IPC4 systems.
>  - Support for AMD ACP 7.B and 7.F, AmLogic A9 and T7, Airoha AN7581,
>    ESS Technology ES9039Q2M, Intel Cherry Trail with RT5688, Nuvoton
>    NAU83G60, nVidia systems with WM8994, Qualcomm QAIF, Senary I2S, WCD9378
>    and various platforms, Realtek RT766 and RT767, Senary SN624x
> 
> I also mistakenly merged some SPI changes in here then applied more
> patches on top before I noticed (it looks like this was b4's base
> selection logic picking a bad base for some ASoC work), highlights there
> are:
> 
>  - Improvements for spidev_test to cover additional use cases, plus be a
>    bit easier to use.
>  - Push more Tegra210 QSPI handling into interrupt context for
>    performance improvements.
>  - Support for Qualcomm QPIC SNAND v2 and RealTek RTD1625 NOR.
>  - Documentation clarifications.
>  - Fixes for some runtime PM and error handling issues.
>  - Support for R-Car Gen5.
> 
> (this should also be going in via my SPI pull request)

Pulled now.  Thanks.


Takashi
