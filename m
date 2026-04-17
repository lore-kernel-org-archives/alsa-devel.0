Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAA7F8E4B8
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:47:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE189601D3;
	Fri, 17 Apr 2026 09:47:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE189601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776412076;
	bh=ejz4D2MBX0RfM6LWerhLANqbEp6oTfj4bnnLoLAiSps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lYSkPWORr8jB5N78HVxiqjXGJycdMLz8xGwXFWzdQpzTkVoJhVbUEjEya+5OhgqW3
	 0GN2TvleJgqXTOgoYZKcFnQ5BcRcNS4uLnvuF0E+YHqsXWVtoeN3C/R97WjM9C36BD
	 xGvARrI4jgHFqNSggmAgiaVtN2WU0vhLUvVDqXmw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A55CEF805F2; Fri, 17 Apr 2026 09:47:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 261AAF805F2;
	Fri, 17 Apr 2026 09:47:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6982F80528; Fri, 17 Apr 2026 09:47:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98728F8016D
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2026 09:47:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98728F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=FBCRL/Kg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=iqoIhFgj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=FBCRL/Kg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=iqoIhFgj
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 776246A991;
	Fri, 17 Apr 2026 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776412025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFxx5oLwBgSxrkFfMA46Ljy+DqasIL63sVcf7J/iv4k=;
	b=FBCRL/KguwnuEnrGFqWJq5PJOJwoz5Si7jKfxpGvokgg5e5l00iuewv/m0zymW4A+5C/bK
	yG5WDM/TlqvsV3+UO7sfN/pRQq97pN0WlcB+XILMKivSRHTH6SNN4n/qJifmVajusfNYPc
	JbFfanUlDj8j1EKqs5LmB4x8eLn2gIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776412025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFxx5oLwBgSxrkFfMA46Ljy+DqasIL63sVcf7J/iv4k=;
	b=iqoIhFgjnaJPM8WQCXE4F/2mD/tXf89ADdhq1MC9x8mvUlrEyJuOwQZGcOQx3eCymSDS0b
	yO+v6benXykvJjAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="FBCRL/Kg";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iqoIhFgj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776412025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFxx5oLwBgSxrkFfMA46Ljy+DqasIL63sVcf7J/iv4k=;
	b=FBCRL/KguwnuEnrGFqWJq5PJOJwoz5Si7jKfxpGvokgg5e5l00iuewv/m0zymW4A+5C/bK
	yG5WDM/TlqvsV3+UO7sfN/pRQq97pN0WlcB+XILMKivSRHTH6SNN4n/qJifmVajusfNYPc
	JbFfanUlDj8j1EKqs5LmB4x8eLn2gIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776412025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFxx5oLwBgSxrkFfMA46Ljy+DqasIL63sVcf7J/iv4k=;
	b=iqoIhFgjnaJPM8WQCXE4F/2mD/tXf89ADdhq1MC9x8mvUlrEyJuOwQZGcOQx3eCymSDS0b
	yO+v6benXykvJjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 564EB593AE;
	Fri, 17 Apr 2026 07:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fPahE3nl4WkQFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 Apr 2026 07:47:05 +0000
Date: Fri, 17 Apr 2026 09:47:04 +0200
Message-ID: <87o6jido5j.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Juan Pablo Fuentealba Bizama <jpfuentealbabizama@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: usb-audio: Add quirk for SmartlinkTechnology M01
In-Reply-To: <20260416191149.12088-1-jpfuentealbabizama@gmail.com>
References: <20260416191149.12088-1-jpfuentealbabizama@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 776246A991
Message-ID-Hash: B7EO34FNAYX4WU4HI6VGR44SDWALTWHD
X-Message-ID-Hash: B7EO34FNAYX4WU4HI6VGR44SDWALTWHD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B7EO34FNAYX4WU4HI6VGR44SDWALTWHD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 16 Apr 2026 21:11:49 +0200,
Juan Pablo Fuentealba Bizama wrote:
> 
> Add quirk entry for SmartlinkTechnology M01 USB microphone to enable the standard mixer interface.
> 
> Signed-off-by: Juan Pablo Fuentealba Bizama <jpfuentealbabizama@gmail.com>

Thanks, applied now.


Takashi
