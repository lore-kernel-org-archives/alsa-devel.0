Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C5DCA5FE6
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2026 18:27:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AF30602AF;
	Sun,  4 Oct 2026 20:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AF30602AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791138459;
	bh=2DHXQiLJXcGGqNSvh6uQ+cRd5aeBs+pi0Gk8QzSTLrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ff7S2dfV4nrCazMbsD4hABW8gnsi2Rmijhn8/7IoI31sZlQxT3VDFjMxpN57WBTYC
	 JNbMf5D1RO23fctbDYDMYgf9txOi9vOiwvegKAnWc0gmR2HUCiUAfN7rwtCPzE7gbq
	 iNK2yt4hrnXoLpfOZ2qTt6IZUiln7EbvdSZE77ig=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EFDBFF80602; Sun,  4 Oct 2026 20:27:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3925F805F6;
	Sun,  4 Oct 2026 20:27:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30D64F8026D; Sun,  4 Oct 2026 20:26:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791138415;
	b=k3fAtOjyHzhfKp5OmJ1qZIbPUA7eNePQWtN2Ibk8s3f3ma5gIzkY7L1hrluGm4cDOTx8
	 oshDKo9rg/dOKan/ywsTcc3tHfm7gLlpgwclhC5kYjb0s9KE3u9ItFeY26mvhNJmual78
	 n1ikPSXcPsQ1BeuKQ/f6ELAksPlPHJ39sOlT8C5sEo7/kBwYYYwIohZg+sgyg8lAjMMI/
	 68Hds5bYdEDZIOoY8DeYTjr6e9z9OVjKw6xdv5EDRpKh++b8jNsRvlo8wNiN0jJN/GIS9
	 JTljgjQZbiSL91KUinlGQfRVKDuTMSeMqulcQKOP/wC3yKB8b+lbD5GsK71tSTO92VA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791138415;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=2DHXQiLJXcGGqNSvh6uQ+cRd5aeBs+pi0Gk8QzSTLrQ=;
	b=j4ehW0PJjCuYyBQ3oY83e9o9bFjgb2I0gNWDqK8N3UNOmF2IxA+oCBZyWsCONDrbJCe8
	 pU+38XpW1klijfe+eE7luXX7PdiztLxWt/bmHGyo59rgT2doMLLn/1F+nqJG9H41TJO08
	 gSmImPiKN7PMxV5CMG2ZiD4wpg0QN7WJuPdeypuWx1gUHcvVfLoyMEEir4iopLbQmPyGc
	 /U6uOJcI0BK+0iK6iQyqTo5+BWGHOz25jdKYCsF8Zrq52fY+y3BB+WCcQuohUA1FxAO7q
	 B9vcVaj37WdDWDGDLcnS1U6UC4mysagiPIGPvmT6gLzBjdLOb742sMHWxGKq5L5mDPw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=dHwMoiPG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=9VW+eop5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Qy15Z41g;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=b4W329D9;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08FB1F800BD
	for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2026 20:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08FB1F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=dHwMoiPG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=9VW+eop5;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Qy15Z41g;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=b4W329D9
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3B051F444;
	Sun,  4 Oct 2026 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791138409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLYCHzmlz45Xw1JnmVwiqhPvihBPAf82xirGZLhLols=;
	b=dHwMoiPGKsEzzgrhmAjj+DFfLlzMT38bmizDao/kMGqV1onFrQSnL52tXe1/gkZ0Gk1lX0
	sxLslPhCGnN7N7xUScouG/YN1aAdNrEberZHbSU0MQDUmcTDfvON8ixOYQ7hfRazKC2N06
	/CYXMZAJDhrxOoIAdKlPFKhgmSU4aBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791138409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLYCHzmlz45Xw1JnmVwiqhPvihBPAf82xirGZLhLols=;
	b=9VW+eop5olmhjQZKSBBJyKyfIPoLfhiZIcM9U7xk0kFteHNp4e1lfYRwbJO2z4k2oE9mM8
	EtfBQ6KDUHJos8Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qy15Z41g;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b4W329D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791138405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLYCHzmlz45Xw1JnmVwiqhPvihBPAf82xirGZLhLols=;
	b=Qy15Z41g9Wgo2fbKyJke8Rr344gXbwuYpNmwcZfOBl5lq6Z6UhdkFCSxVtUu3W/MuijMaW
	k3gXOHLeLth85ah1yHjGS7LHjqoa1JRs1TxqgkgteibvylwUSwULMEq78WnM93pTy9kqCB
	iNLMTYbzsVsz2Y8XlIqX86iCOoqPuf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791138405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLYCHzmlz45Xw1JnmVwiqhPvihBPAf82xirGZLhLols=;
	b=b4W329D9tSP0WuXusponliTHkqOiNb5Y7/eeYl6iT/+cL3vNZrfJqeUoC8NVmefnsPaWq2
	Ya9mBiSawHVwcgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65F56133CF;
	Sun,  4 Oct 2026 18:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HOn8DmSawmpPUwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 04 Oct 2026 18:26:44 +0000
Date: Sun, 04 Oct 2026 20:26:40 +0200
Message-ID: <87cxtpiaov.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: dchristensen8 <dchristensen8@proton.me>
Cc: "tiwai@suse.com" <tiwai@suse.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/ca0132: Add Sound BlasterX AE-5 external RGB
 LED strip support
In-Reply-To: 
 <qOF5tUXvi5MWOfDFTuE8fU0Wiqk3eTZMHhdWpsxR-JFuTXCwEeayR_yxgYmAQ6SIHogQmMkvtM8otTM9z1Wi4KIujjj6LtQPORGuegUuRmM=@proton.me>
References: 
 <I690osvh2wujN3P04R4abtKFqOqtIiC-qin2ZEFs9q8kKU7-qfIg2cya4BuHS7Vg83Wkon6BCJGtVIxeJVfRZ8nG07laTUlv-fJjELMgp1Y=@proton.me>
	<87ik3kyy0h.wl-tiwai@suse.de>
	<qOF5tUXvi5MWOfDFTuE8fU0Wiqk3eTZMHhdWpsxR-JFuTXCwEeayR_yxgYmAQ6SIHogQmMkvtM8otTM9z1Wi4KIujjj6LtQPORGuegUuRmM=@proton.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F3B051F444
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: N2YGRYPX7IETZF6KGWY7GTIXI6ZNSVHS
X-Message-ID-Hash: N2YGRYPX7IETZF6KGWY7GTIXI6ZNSVHS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N2YGRYPX7IETZF6KGWY7GTIXI6ZNSVHS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 03 Oct 2026 03:41:51 +0200,
dchristensen8 wrote:
> 
> Hi Takashi,
> 
> Thanks for the review! I moved the dma-mapping.h include into the main header block, added the s->opened check to ae5_strip_find_stream(), wrapped all the strip code in IS_ENABLED(CONFIG_SND_HDA_DSP_LOADER) with a no-op stub when it's disabled, and updated the put callbacks to return 1 when the values actually change.

This looks like a patch on top of the previous one?
Please submit a complete single patch.  Also, can you try to submit
without an attachment, at best, with git-am?  If it's difficult, it's
fine with an attachment as a fallback, though.

> One other thing: I was talking with the maintainer of openrgb and he suggested a patch to make zone0 led's work via the same mechanism (this card has onboard led's at zone0 and external led's at zone1). Should I add that to this patch or submit a separate patch after this one is completed?

Let's make a separate path.  The current one looks already enough, and
if any, we can change incrementally.


thanks,

Takashi
