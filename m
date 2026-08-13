Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D330BC5CFEB
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:36:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A299460202;
	Thu, 13 Aug 2026 16:36:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A299460202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786631770;
	bh=Ypo2/dLzzXsHjDcz9+fXpGjuNXOywvAxBq4MKB4liv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MyxEcl+Sb9suTE73/xpOsj4TfvBWUELz9YPOT6uYhptZXJdEipr3OniTw5cMTKPsJ
	 rH2cvLSoGvtFswG6R6NTxbVkVycXRrCmshLxKoWAWbhG7Q76EJun/lIAb6czAbMZ0G
	 VLecpJ0f9JacWC6FSEOls/OzhB0QwwzaFPcxDDQw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80E48F805FB; Thu, 13 Aug 2026 16:35:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28154F80600;
	Thu, 13 Aug 2026 16:35:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65935F80553; Thu, 13 Aug 2026 16:35:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786631728;
	b=MsXKJS67UO/VIphVIEiZhRIFtrWtovri+mVZIOzrhKP3fWNMuPdB6RxvlLJQsu/xvFaG
	 WHFDZfnv0hNwbZIVoPqY2hTmmk5Y1TBgVjDvc6Gwrb8AGa63Ip6SBEOjQwo0lrsL5FIzU
	 fmlIrxwoX3bm9kExo6vjRjzR1zr+Z4Fdbq09t1rlCbt0kg11LBhtssjva/d70M6xjIAOO
	 ri+87g6s+NEHiqzbZzvSIQ1Lomj3MvTjdBZpK27SU1BxVkGKT1Pj14558OycnZ3y4i6D5
	 +A72Lxa6F0spImP76b+ZE4aSkx4grzlYyU4KRR3s3Z3eBH5yL35g9U2lTAkSG++eBhg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786631728;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=Ypo2/dLzzXsHjDcz9+fXpGjuNXOywvAxBq4MKB4liv0=;
	b=gcO/wCa8KixRvi+X/wY3N06dIdn0IkAZbeJr03n+V9/MhqyhA6VqwCmY2Dvl9PKExFpM
	 rjzWZ7KqJwPGpyH1ZIGyLzmNUhXMcZId3SfvLVOsI3ZZhsFdJyuu+xVNvIPEE3aMZgxof
	 iIjcjlWEWK+QF1VfEqBpayIxUXY3zE4GxgwK8GAbVHedIKQ75zNN1KwlwQMXyE+Afl5ck
	 6G/90iQL5v73SWvTWL487delR9WeCVFbpNmSSOUUMCG7RXMOAVAEZ/VrFuyjVfShEdFEj
	 BBBKiJASi1eb9YSxiF1BNXi5Uvs79hj7UQ60JxxfV4YVIK+IL0mTTP94Y+x4uzFhRfw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=fFjc9FNP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zEtMhMks;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=shIFDITu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=MTXq7YX2;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C93AAF80027
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2026 16:35:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C93AAF80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=fFjc9FNP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zEtMhMks;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=shIFDITu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=MTXq7YX2
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99E553E9E;
	Thu, 13 Aug 2026 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786631722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWu/dWef1OuXSDDyi7cWIti5FAb3GEsFodPyL0XiCeI=;
	b=fFjc9FNP57aC2Z5vZ6O9P71nl1TCC3ZhTwx/l/Py0Uzq1ZX8FlvNI4WsBJe6lZIKP9fzFy
	3/13I5LyYZKQGBGw4vathurbgSZfoRGkxOfzEvfwJy40HL602iRMUVu113LzyrrRTqyxZg
	AoKLEAejpFG3t/QDJ8LtcFlUcslfwlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786631722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWu/dWef1OuXSDDyi7cWIti5FAb3GEsFodPyL0XiCeI=;
	b=zEtMhMksx3+87mcygZ6tWrnSfSra++Oz8fyKMx94IEN4kT5MI+yPqsrM9xMxlWo7YCO2YH
	DcTL8lg7KnicG5BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786631718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWu/dWef1OuXSDDyi7cWIti5FAb3GEsFodPyL0XiCeI=;
	b=shIFDITuXHQ2hVgnjX/Kof2w7NVEXCsA1Pgmv2dkdnbVRdHrpjHFc+/Pd1ZpSGiFFBjpqw
	F10Y2XaFBkvHa/IhpRmo/bJYBZP7POjNebUiyIsz9mqD51nH8JtdrtAs9MsBj8UCFEjbtH
	rC7dHWFosFr9xFsQ7qwNzHzQkomwGVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786631718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWu/dWef1OuXSDDyi7cWIti5FAb3GEsFodPyL0XiCeI=;
	b=MTXq7YX2VCtCg3W7J87WKwk5QQhq37tHajxG+ZOlaX3i00W7Z8qVcoY8s366VfYHg7QIGh
	lrXJzG31usxTaeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CF2B77E7C;
	Thu, 13 Aug 2026 14:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uQJVGSbWfWqgSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Aug 2026 14:35:18 +0000
Date: Thu, 13 Aug 2026 16:35:18 +0200
Message-ID: <87cxvmxf4p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-rc7
In-Reply-To: <317e8543ff401f09ccc2e93c8cd70e71@kernel.org>
References: <317e8543ff401f09ccc2e93c8cd70e71@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: QW6T6T2QCQ5HHGCIGHQO2W4YFI2UYI23
X-Message-ID-Hash: QW6T6T2QCQ5HHGCIGHQO2W4YFI2UYI23
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QW6T6T2QCQ5HHGCIGHQO2W4YFI2UYI23/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 13 Aug 2026 14:16:39 +0200,
Mark Brown wrote:
> 
> The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:
> 
>   Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc7
> 
> for you to fetch changes up to 079e27f52b929b554b90514b081ea40b3d632a25:
> 
>   ASoC: Intel: NVL: Add entry for HDMI-In capture support to non-I2S codec boards. (2026-08-11 17:14:15 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.2
> 
> This set of fixes is bulked out quite a bit by the inclusion of a lot of
> quirks for various x86 platforms, though there are a few driver specific
> fixes in here too.  Nothing here is terribly critical, we should be fine
> waiting for the merge window if it's too much.

Pulled now.  Thanks.


Takashi
