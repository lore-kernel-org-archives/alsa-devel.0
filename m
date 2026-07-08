Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5E2C43602
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:45:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8757B60222;
	Wed,  8 Jul 2026 12:44:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8757B60222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783507507;
	bh=W12NetVsRx54VRkW1vkqTM88zeDmN0SSmzoWKJPPxjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iHcr8/4sAgZQNvuOCozpf/OLwPB2heOunWqWFw63YiddnkBtW8Avchu3cFOEGRKKE
	 /m4MK9inQ4vVWH5ORch0Ajn4yPF4e8LsaB4IfWUH5eJsOg077y4hEEIWdPYNpclIcA
	 nwgvfAhCH4VVxDHwxliWDgjPmPSq625Y8nv7Sfss=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2C94F805FE; Wed,  8 Jul 2026 12:44:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 21D82F805EF;
	Wed,  8 Jul 2026 12:44:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7AE79F8055B; Wed,  8 Jul 2026 12:44:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783507463;
	b=RMM/fbool9ghjJCpJZh7CZGWcXtQIPzq9eI45vRiUE2bat12nPKOfVKZRz5dRTDApElr
	 8nMLEyxoxiovO7I8Cl5MOCXsR471kA8L4IMDx/asVA7zzUkkiQ8zkYZr3Foujm76EvyQH
	 31uO0WhP2PqfzpXebjijFvDEwnFnEUn2YFsxH/NutPV7OD3kdZRSH6DTz6kAk7bWWD3gB
	 Pe0kdoUN+nwOEWRyLO6xggo8xR5ddumwy7JpIFv4YK2wAnIE2t9cX0Wb+S/j2lyM0Ihp0
	 cI1FQduLdS9s5cV/GRz7Bn15PWmc+Bz4SM6GggHTN/3VCfW9dRaHvkXWiQFMXOAQpoA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783507463;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=W12NetVsRx54VRkW1vkqTM88zeDmN0SSmzoWKJPPxjg=;
	b=hOu/c7vCOa0+Y3IrpbxgszdGAikHWAlwQLwJmX5sud29M81mRTt51pvyLfGtykOKFPp9
	 5MsiXlij6pPl/Fb7nhy/BhD7xDMBZUgwlULkdvsvc5YMZ5BHZq0jchOCDfLJ1WYqsbO5J
	 2hzi8/ZbeuTHFsHac2acSqC1eXbRhRprJCgg34mhvk/IZEazpjjgcX+hNNncta8NCxAR5
	 cPDuFAsOhhwty1aG+sDPDUSJ0A6CUorqv3m+eFJjq7zIZYXQyX8cuHudOrHr0Iy0SlYkY
	 u/ytc9GJ1V0QwNbDPp8NT8t4qgA9WBiQjnqgJGA8uNTf7Ki2ZcKOC8Dx/3NfSqkeEkQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="CVe/ve0U";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CY4M5N+m;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=0TFt+6Bx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=y6KiO9Ze;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 35E40F80224
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 12:44:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35E40F80224
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CVe/ve0U;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CY4M5N+m;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=0TFt+6Bx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=y6KiO9Ze
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1DE175826;
	Wed,  8 Jul 2026 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783507461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWAQx527YH/zk9IqP/fQd49Wwtgd5tP/Ti+p3Ps2LJU=;
	b=CVe/ve0U/6pvZO1CPcVnd8LP9StaEdAF7wJkqnHRw/2lEqZnNEEARZcRHxc5+VYkbjUn6T
	rSlzV1/WoePF6NqsYuTlPQk6XsUJ30xX1NFwAWZvxsvjz1MQga+HipKo0DmHYI2VpPmoDj
	Rn0Y4uc+oohgpOHKzlOsGdxLLNqCdws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783507461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWAQx527YH/zk9IqP/fQd49Wwtgd5tP/Ti+p3Ps2LJU=;
	b=CY4M5N+mvPHn7NnZQQOfXKnAj40yRA8Erd2A074ovyMdmW2klsr0HFxZtlpxm0kKDUksdD
	EIxcsSvxrSIngKDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0TFt+6Bx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y6KiO9Ze
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783507459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWAQx527YH/zk9IqP/fQd49Wwtgd5tP/Ti+p3Ps2LJU=;
	b=0TFt+6BxsN1vDfvUp8iC6Zz21XSYPJQGGxOOQqIwjCwTdAvaHZExh6IDwYTl4ojGcKCz3F
	dteFDwKkTe4AJ1hNTwSRL3SKsbhmUWFkQ6v0TUx+hZk8caqrylLKQjQQb96Pk49hQ72sTb
	/scnKeJxsuxqZjpEIqMzms2keqG1FQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783507459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWAQx527YH/zk9IqP/fQd49Wwtgd5tP/Ti+p3Ps2LJU=;
	b=y6KiO9ZeiDfta/cKK9Qm25zVt1kynjhtvTg5ODLnIqHPBOOTFspE4w0n4ytLaW2Qn8krxv
	Afq6LP5qtmpKjlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8F05779AE;
	Wed,  8 Jul 2026 10:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rBaxMwMqTmpqIQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 Jul 2026 10:44:19 +0000
Date: Wed, 08 Jul 2026 12:44:19 +0200
Message-ID: <8733xt69rw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rohit Sinha <rohitsinha12043@gmail.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek - Add quirk for HP Victus 15-fa0xxx (MB
 8A50)
In-Reply-To: <20260706211834.384022-1-rohitsinha12043@gmail.com>
References: <20260706211834.384022-1-rohitsinha12043@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F1DE175826
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: XTA3HDZ5IIHNL2WMU3PQ5ULN6IGBORT5
X-Message-ID-Hash: XTA3HDZ5IIHNL2WMU3PQ5ULN6IGBORT5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XTA3HDZ5IIHNL2WMU3PQ5ULN6IGBORT5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 06 Jul 2026 23:18:34 +0200,
Rohit Sinha wrote:
> 
> The mute LED on HP Victus 15-fa0xxx (board ID 8A50) uses ALC245 but
> requires a quirk to work. This patch enables the existing
> ALC245_FIXUP_HP_MUTE_LED_COEFBIT quirk for the device.
> 
> Tested on my HP Victus 15-fa0xxx. The LED behaviour works as intended.
> 
> Signed-off-by: Rohit Sinha <rohitsinha12043@gmail.com>

Applied now.

But at the next time, please submit to linux-sound@vger.kernel.org for
kernel patches, instead.  alsa-devel ML is only for user-space stuff.


thanks,

Takashi
