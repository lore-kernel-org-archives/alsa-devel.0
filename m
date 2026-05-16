Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FAECD4F3C
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2026 13:44:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64D0A60212;
	Sat, 16 May 2026 15:44:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64D0A60212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778939091;
	bh=/ZbtA2R4Khw7+IPxjvUQ2oltQnsys9vZv2jXccS30/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Hd42Qh5mv2oV5EqBE7+SbZhqQFnwQ/xZ+QQOzXkotevJLg/ccB0RCGpeIS1vkOVnm
	 HFmcAXpqBs2C4fRytfUcYuVOvvwZrOEdb9PghBgmOc0i67C59KDvAv55Kfxq9yEp1P
	 fugAijC+lPvqRNOANbiBrNMSbUGJwA3Pk4mV3dIc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F963F805E8; Sat, 16 May 2026 15:44:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17CFEF805E8;
	Sat, 16 May 2026 15:44:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF9D4F80217; Sat, 16 May 2026 15:44:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8953BF800AE
	for <alsa-devel@alsa-project.org>; Sat, 16 May 2026 15:44:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8953BF800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=e7y98Yw3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=9zYE3uez;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=e7y98Yw3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=9zYE3uez
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77CF061BE4;
	Sat, 16 May 2026 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778939044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84EhMv+sSkfe6JhLH9NwOoKMykifhvRUaDQv/Q2/S74=;
	b=e7y98Yw3HhckDAC3EN7OMOEqc9d+N+cOBLS20pdFif6KvUBOQl5JFNkHqaGzCCNq427ZnT
	XAx8OoyZxqcfJ6qMrkQNXXn4nA7/F5Sb5GPL4YHD/hZ60TuDba32G50pu+Pf0N3rKw3npQ
	c54mCcw9qBQYXEkoUmxv8LMTP01KsUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778939044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84EhMv+sSkfe6JhLH9NwOoKMykifhvRUaDQv/Q2/S74=;
	b=9zYE3uez3zh/9D5S2Te04E3Onkv9J0haqjDjTyatWQ1gY3D3AWYy1K3+QQYh+da/tpq3K+
	bcopqaCU88NFnjAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e7y98Yw3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9zYE3uez
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778939044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84EhMv+sSkfe6JhLH9NwOoKMykifhvRUaDQv/Q2/S74=;
	b=e7y98Yw3HhckDAC3EN7OMOEqc9d+N+cOBLS20pdFif6KvUBOQl5JFNkHqaGzCCNq427ZnT
	XAx8OoyZxqcfJ6qMrkQNXXn4nA7/F5Sb5GPL4YHD/hZ60TuDba32G50pu+Pf0N3rKw3npQ
	c54mCcw9qBQYXEkoUmxv8LMTP01KsUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778939044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84EhMv+sSkfe6JhLH9NwOoKMykifhvRUaDQv/Q2/S74=;
	b=9zYE3uez3zh/9D5S2Te04E3Onkv9J0haqjDjTyatWQ1gY3D3AWYy1K3+QQYh+da/tpq3K+
	bcopqaCU88NFnjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 557ED593A8;
	Sat, 16 May 2026 13:44:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tgRXE6R0CGo6YQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 16 May 2026 13:44:04 +0000
Date: Sat, 16 May 2026 15:44:03 +0200
Message-ID: <87pl2vxye4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sergio Boglione <sboglione@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Add quirk for HP 250 G10
 (103c:8b34)
In-Reply-To: <20260516131651.143109-1-sboglione@gmail.com>
References: <20260516131651.143109-1-sboglione@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 77CF061BE4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Message-ID-Hash: 3XG2PPC3Y4AS7XDVLW53OFIXEDBXWURT
X-Message-ID-Hash: 3XG2PPC3Y4AS7XDVLW53OFIXEDBXWURT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3XG2PPC3Y4AS7XDVLW53OFIXEDBXWURT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 16 May 2026 15:16:50 +0200,
Sergio Boglione wrote:
> 
> HP 250 15.6 inch G10 Notebook PC uses the same ALC236 codec
> as the HP 255 15.6 inch G10 (103c:8b2f) and requires the same
> fixup to enable the internal speaker EAPD and microphone routing.
> 
> Signed-off-by: Sergio Boglione <sboglione@gmail.com>

Thanks, applied now.


Takashi
