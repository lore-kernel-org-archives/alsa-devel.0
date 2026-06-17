Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F280ECD98EE
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:05:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19614601F1;
	Wed, 17 Jun 2026 11:05:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19614601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781687154;
	bh=hauPKJFFK3i8NsTy/V3icSrBdRiV4SrhARUBT8/7oww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=k0i8KM9gaxPq9ZI9Fgw8FlhbYV/0YlGXFq4TVc0shf8kyNg40pTV+l5cuqWMfNRwH
	 LyA0Mp1FU49ea04aTmgcHqz16C5S5ZmkhQRuVvF9Ig8HHkFv6kjehpq46+BnvAC93H
	 5XSJzmTGmvCW2Bt/ROzuY5P95ahASbWzqL4HFl8w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D591F805C3; Wed, 17 Jun 2026 11:05:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F9A5F80589;
	Wed, 17 Jun 2026 11:05:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76286F8055A; Wed, 17 Jun 2026 11:05:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781687110;
	b=p/yYd1RtXCWAjfLQOOksySro9EsD0OBTDjThsZPuWfPDhUxsSgZ1R4xXTcNwh0/pzxLD
	 yPLCjmEFiU6VQvVJItLkCB/hmLE9Wc5EMGn5HGshN5TOrRDeaVGa76D1S9PjQJO5ZTkNc
	 m2DhRK0QPCqDAteJ/utg/I9gRsJBigvL/WuHwLmEf2TWGp9LQmcHP+AmAA7rGGmY6Cva7
	 nVpzwkYneOsfHhxlqNxC3KMoIUNGW0YBmj0stVkfruo+woSU9315Qjtb2Nc7DLe5dTMUs
	 4cSOnMPV5LXAnQd0+X3JETNXZHcAOwZ9TV3N/pHvJOA8OZB8l5lsKzlHxSLVS2yShLA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781687110;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=hauPKJFFK3i8NsTy/V3icSrBdRiV4SrhARUBT8/7oww=;
	b=gNbiC3RrpSedku0g3bheSQf5U8XCkaldhvrIpqMrPLhxLvG4MEFx4MgA6y0lrGAFpZl3
	 OPAVoHdPiaLKfHB/H88iAjwBuu+Tizqr4FhBw2G4ZzBdURWrhtoNsOdVn9DMdu980ki4Y
	 sHggUCPzSI4KOJ0+RyTHYWbPr2xOuqExNuV3rSaqsFSW2T2Wia52jsTXx60LyxV0P3T21
	 4CdJ5hZ8S7G0JCl/BHwaNk8Z7ml86n5z1pDYaY+5KHVUygpgQvet9+aAXPotvo4HWiuJ3
	 aATmGE1gNmVmln1EZnwake+crdbubrwKLPj2tQAHZ0qruB52tDYiROgjZ5J4RozihBQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="n9jr0l/K";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZNNB0Ijt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="n9jr0l/K";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZNNB0Ijt;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C7391F80495
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2026 11:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7391F80495
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=n9jr0l/K;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZNNB0Ijt;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=n9jr0l/K;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZNNB0Ijt
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AAA5758CA;
	Wed, 17 Jun 2026 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781687108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoojYLiw+UHdeWhS2DXosMq8RZh/tIxMny3iP5gShU0=;
	b=n9jr0l/KqlmPFyUMamlN5ELnYOvpVmkMpqThDtq/6HAJrXyEQOBjID6IPiNYZ+3G+3Rx8d
	NIMfoXzcD7jZX0cqQuarWoCxJYS80xod1YHhZl1H/Ysoo00ofIn/kT1VXCi6CFXqV6wlPv
	Wmo9lFjLm4lBAbE/j7fh423FZ6y9hcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781687108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoojYLiw+UHdeWhS2DXosMq8RZh/tIxMny3iP5gShU0=;
	b=ZNNB0IjtnyIyFlu1ZWGrY35rQobGeJX065m9brq0fWUWNJNsin0FTu+QpJhjAjgvR5fYbY
	6HuEMbY6kgn4+kBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="n9jr0l/K";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZNNB0Ijt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781687108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoojYLiw+UHdeWhS2DXosMq8RZh/tIxMny3iP5gShU0=;
	b=n9jr0l/KqlmPFyUMamlN5ELnYOvpVmkMpqThDtq/6HAJrXyEQOBjID6IPiNYZ+3G+3Rx8d
	NIMfoXzcD7jZX0cqQuarWoCxJYS80xod1YHhZl1H/Ysoo00ofIn/kT1VXCi6CFXqV6wlPv
	Wmo9lFjLm4lBAbE/j7fh423FZ6y9hcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781687108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoojYLiw+UHdeWhS2DXosMq8RZh/tIxMny3iP5gShU0=;
	b=ZNNB0IjtnyIyFlu1ZWGrY35rQobGeJX065m9brq0fWUWNJNsin0FTu+QpJhjAjgvR5fYbY
	6HuEMbY6kgn4+kBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B37A779A8;
	Wed, 17 Jun 2026 09:05:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LfjREERjMmrQUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Jun 2026 09:05:08 +0000
Date: Wed, 17 Jun 2026 11:05:07 +0200
Message-ID: <87qzm5pmf0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Galen Hassen <rwekyes@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/conexant: Add pin config quirk for Lenovo
 IdeaPad Slim 5 16AKP10
In-Reply-To: <20260616173257.37373-1-rwekyes@gmail.com>
References: <87se6mrah4.wl-tiwai@suse.de>
	<20260616173257.37373-1-rwekyes@gmail.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7AAA5758CA
Message-ID-Hash: VIY4PLMHVAFAPPWPNJK6PZJN6AOKUMJR
X-Message-ID-Hash: VIY4PLMHVAFAPPWPNJK6PZJN6AOKUMJR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VIY4PLMHVAFAPPWPNJK6PZJN6AOKUMJR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 16 Jun 2026 19:32:57 +0200,
Galen Hassen wrote:
> 
> The Lenovo IdeaPad Slim 5 16AKP10 (PCI SSID 17aa:38b6) uses the
> Conexant SN6140 codec. The internal microphone is on pin 0x1a but
> the BIOS configures it with pin default 0x95a60120, which includes
> a jack detection bit that causes the kernel to treat it as an
> unplugged external mic rather than a fixed internal mic.
> 
> Add a pin config quirk that overrides pin 0x1a to 0x95a60130,
> setting the connectivity bits to indicate a fixed/always-connected
> device. This allows the internal microphone to be correctly
> identified and used.
> 
> Signed-off-by: Galen Hassen <rwekyes@gmail.com>

Applied now.  Thanks.


Takashi
