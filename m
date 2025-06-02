Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BA5C5AD49
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jun 2025 14:46:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 049A3601E1;
	Mon,  2 Jun 2025 16:46:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 049A3601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748875610;
	bh=085F+VfQC6Aofahj6fpw4RhR2qAs0x5z1++xCfD+hCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E1kk+1Z4rcCcfdIvej5syBJRUnrdYvQON01aEntwlQ4JWs4nivJlEKtkshqNrFjum
	 rdsmEVSbXKmfoK6tpSkw01WoRGLZgziFmc6rOSIVEYBc8iJhwzprx87/obK3IPSxe+
	 kmLRE1Xhxi48GpMQ0EmQ04/Mqf6Byu9LH7yiPMnc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F973F805BB; Mon,  2 Jun 2025 16:46:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DCF2F805C2;
	Mon,  2 Jun 2025 16:46:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25235F80533; Mon,  2 Jun 2025 16:46:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4E2AFF8016E
	for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2025 16:46:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E2AFF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=q86IU2cF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PfdE9/2j;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=q86IU2cF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PfdE9/2j
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 219A91F443;
	Mon,  2 Jun 2025 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1748875568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS+wawCNtEIHtbvRiU6OJlp/x7y3T5bmdB1kCqnxeuw=;
	b=q86IU2cFvgXx7AJkNGJPCcRiESbRHpYdPkT9wHoxLim6ACQIHRaYqWi/WfWEq8omisZTnz
	uSAJ39EPidtEGClOVbCyzn5IJVU/ULZ4++8T1B1FWixgt2QbW6ze1dPdNiAsepiFbfIdJc
	XNuOXX/gmiv9Dcf3eyqVPCMrQZ5INlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748875568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS+wawCNtEIHtbvRiU6OJlp/x7y3T5bmdB1kCqnxeuw=;
	b=PfdE9/2jPcwx7USxbx2pgBBEK20pARTEDNRqCWkyMLh6n7rh4Ua/0sbD0uP4JDND1ECSD2
	D9deOYsgwphs0/DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1748875568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS+wawCNtEIHtbvRiU6OJlp/x7y3T5bmdB1kCqnxeuw=;
	b=q86IU2cFvgXx7AJkNGJPCcRiESbRHpYdPkT9wHoxLim6ACQIHRaYqWi/WfWEq8omisZTnz
	uSAJ39EPidtEGClOVbCyzn5IJVU/ULZ4++8T1B1FWixgt2QbW6ze1dPdNiAsepiFbfIdJc
	XNuOXX/gmiv9Dcf3eyqVPCMrQZ5INlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748875568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS+wawCNtEIHtbvRiU6OJlp/x7y3T5bmdB1kCqnxeuw=;
	b=PfdE9/2jPcwx7USxbx2pgBBEK20pARTEDNRqCWkyMLh6n7rh4Ua/0sbD0uP4JDND1ECSD2
	D9deOYsgwphs0/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD8AF13AE0;
	Mon,  2 Jun 2025 14:46:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kh+dMC+5PWikXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Jun 2025 14:46:07 +0000
Date: Mon, 02 Jun 2025 16:46:07 +0200
Message-ID: <87v7pexkuo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<Sunil-kumar.Dommati@amd.com>,
	<alexander.deucher@amd.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda: Add new pci id for AMD GPU display HD audio
 controller
In-Reply-To: <20250529053838.2350071-1-Vijendar.Mukunda@amd.com>
References: <20250529053838.2350071-1-Vijendar.Mukunda@amd.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: S3VMV7EGEDCETBGOAPNB75S3NTYMB4UF
X-Message-ID-Hash: S3VMV7EGEDCETBGOAPNB75S3NTYMB4UF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S3VMV7EGEDCETBGOAPNB75S3NTYMB4UF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 29 May 2025 07:38:13 +0200,
Vijendar Mukunda wrote:
> 
> Add new pci id for AMD GPU display HD audio controller(device id- 0xab40).
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Applied now.  Thanks.


Takashi
