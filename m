Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FECC3271F
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jul 2024 07:55:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 820ADE8E;
	Fri,  5 Jul 2024 09:54:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 820ADE8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720166104;
	bh=hMp6l/Q0tRWtdQWtgPn3R1thSAAk2BO6+7UT5Y5JZBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ncjuBUQvs0KAb1+VPUrIDBmgkF6334v/IoV4EWW2aBYDh47I+1tSyqVCYDXG99mtT
	 H573h1BWmPZ8De1oqeVC2rBGSR9bgEhheReWY/xBLZCt3cqd20BeAZKkka8C2IiAT3
	 W1EjKF7koIs3UaNOOHs8nAyWbzdRidHpZHFlm0cA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AABBF805BB; Fri,  5 Jul 2024 09:54:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81533F80272;
	Fri,  5 Jul 2024 09:54:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F41AF8025E; Fri,  5 Jul 2024 09:50:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B8F4F800FE
	for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2024 09:49:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B8F4F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=UAfa4qeX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+rqJUXXV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=UAfa4qeX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+rqJUXXV
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15523211FB;
	Fri,  5 Jul 2024 07:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1720165794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKeueWiOxTkRl2AaL2goX5dJcMu5nfUjrLiXntdXAaI=;
	b=UAfa4qeX4LNHIyzRJ2tiGjSw7ayTq2OAt7X35H/bjjF5nXhKGWXRqh2rDP95OMmmhF/oKe
	KFuW1cNX14bAkGX2PogaMr2r2Cjv4+/iaFhY/dR0OSgE4TID38DJzfFndIIYEFerJztlKF
	WFN/XNc6KPrBZBeeYo6Kcn8hi9/lMWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720165794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKeueWiOxTkRl2AaL2goX5dJcMu5nfUjrLiXntdXAaI=;
	b=+rqJUXXVcXYfHoZi0ExwCJLN39sP7R/Ok/+xjLnnTRpfH049Kowkl0A//jOHk+NaCK47oM
	ql0+npw/xE1053AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1720165794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKeueWiOxTkRl2AaL2goX5dJcMu5nfUjrLiXntdXAaI=;
	b=UAfa4qeX4LNHIyzRJ2tiGjSw7ayTq2OAt7X35H/bjjF5nXhKGWXRqh2rDP95OMmmhF/oKe
	KFuW1cNX14bAkGX2PogaMr2r2Cjv4+/iaFhY/dR0OSgE4TID38DJzfFndIIYEFerJztlKF
	WFN/XNc6KPrBZBeeYo6Kcn8hi9/lMWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720165794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKeueWiOxTkRl2AaL2goX5dJcMu5nfUjrLiXntdXAaI=;
	b=+rqJUXXVcXYfHoZi0ExwCJLN39sP7R/Ok/+xjLnnTRpfH049Kowkl0A//jOHk+NaCK47oM
	ql0+npw/xE1053AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D271C1396E;
	Fri,  5 Jul 2024 07:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U4CWMaGlh2YSLwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 05 Jul 2024 07:49:53 +0000
Date: Fri, 05 Jul 2024 09:50:23 +0200
Message-ID: <87zfqwgtvk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dmitry Savin <envelsavinds@gmail.com>
Cc: tiwai@suse.com,
	rf@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	david.rhodes@cirrus.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] Fix swapped l/r audio channels for Lenovo ThinBook 13x
 Gen4
In-Reply-To: <20240704211402.87776-1-envelsavinds@gmail.com>
References: <20240704211402.87776-1-envelsavinds@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: I4SHD7CI2DHO7KKLCTZJ3LAVWAMVMGWG
X-Message-ID-Hash: I4SHD7CI2DHO7KKLCTZJ3LAVWAMVMGWG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I4SHD7CI2DHO7KKLCTZJ3LAVWAMVMGWG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 04 Jul 2024 23:14:01 +0200,
Dmitry Savin wrote:
> 
> Fixes audio channel assignment in configuration table for ThinkBook 13x Gen4.
> 
> Signed-off-by: Dmitry Savin <envelsavinds@gmail.com>
> Reviewed-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks, applied now.


Takashi
