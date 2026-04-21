Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EC3F8FA90
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:20:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8FD4601F7;
	Tue, 21 Apr 2026 18:20:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8FD4601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776788428;
	bh=EfjAQQsL27Jojsn1SlZFbwmlWkyQ5b0m56nH4ft7OfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=btAbBK4BFybI+8tsWPFoRcYsrQKOvA9CJSovCvWXepC8kdAESriykW/AlDTiM91oF
	 n80ga6wGlrokhDmma+VcW/rZ9v4V7HMsJEoy1H4huF1ldOqj6dHdiGSGp9lVtIi4Ne
	 qaToGr3SQ1+9C1onxsCwzgDmy47fgDhmM07Fu7k0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3876F805EF; Tue, 21 Apr 2026 18:19:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 87DABF805F1;
	Tue, 21 Apr 2026 18:19:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5544F8055A; Tue, 21 Apr 2026 18:19:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 50F8AF80100
	for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2026 18:19:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50F8AF80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xcg/kDkp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=K04QsIDd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=xcg/kDkp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=K04QsIDd
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF006A7FE;
	Tue, 21 Apr 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776788380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+6oMGYUM3vtv8/UMHCfX99sHQIi0mnicTNP8kP7vTs=;
	b=xcg/kDkpncOJTXmtwVDFK4VtSJFk9gZOsR5aZnnPMK8nT7WvxOfsNJYgrviC9R030UVKQy
	7oS9iLrdLPHIT/ORyq+nVDetaBpKoYAQT+6kFjObSUU3wbVaF84GTcFi0VhPwgCwsAOIPM
	MEwA285uBcibgMqDO4o3mXcNS/aNJQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776788380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+6oMGYUM3vtv8/UMHCfX99sHQIi0mnicTNP8kP7vTs=;
	b=K04QsIDdIuUe//4q5BUGokyblCApHCdNfJfDUERezqUYUwkN7EmssxSqNShG5enX1vDw3F
	9qqF61zhMk99QnDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776788380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+6oMGYUM3vtv8/UMHCfX99sHQIi0mnicTNP8kP7vTs=;
	b=xcg/kDkpncOJTXmtwVDFK4VtSJFk9gZOsR5aZnnPMK8nT7WvxOfsNJYgrviC9R030UVKQy
	7oS9iLrdLPHIT/ORyq+nVDetaBpKoYAQT+6kFjObSUU3wbVaF84GTcFi0VhPwgCwsAOIPM
	MEwA285uBcibgMqDO4o3mXcNS/aNJQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776788380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+6oMGYUM3vtv8/UMHCfX99sHQIi0mnicTNP8kP7vTs=;
	b=K04QsIDdIuUe//4q5BUGokyblCApHCdNfJfDUERezqUYUwkN7EmssxSqNShG5enX1vDw3F
	9qqF61zhMk99QnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5859593AF;
	Tue, 21 Apr 2026 16:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cP4nLpuj52nbNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 21 Apr 2026 16:19:39 +0000
Date: Tue, 21 Apr 2026 18:19:38 +0200
Message-ID: <87v7dk8ew5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Spencer Payton <spayton681@gmail.com>
Cc: alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus
 15-fa2xxx
In-Reply-To: <20260421084918.14685-1-spayton681@gmail.com>
References: <20260421084918.14685-1-spayton681@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: FGGETJ6EN6TBECT5JTUDNW7I6ZARVHYV
X-Message-ID-Hash: FGGETJ6EN6TBECT5JTUDNW7I6ZARVHYV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FGGETJ6EN6TBECT5JTUDNW7I6ZARVHYV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 21 Apr 2026 10:49:18 +0200,
Spencer Payton wrote:
> 
> The mute LED on this laptop uses ALC245 but requires a quirk to work.
> This patch enables the existing ALC245_FIXUP_HP_MUTE_LED_COEFBIT
> quirk for the device.
> 
> Tested my Victus 15-fa2xxx (PCI SSID 103c:8dcd).
> The LED behaviour works as intended.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Spencer Payton <spayton681@gmail.com>

Thanks, applied now.


Takashi
