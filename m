Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEBDCD8CB2
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:50:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57AA6601F6;
	Wed, 10 Jun 2026 09:49:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57AA6601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781077797;
	bh=YhnipDLGg3txWkfssVNvTnwATli4QFRD9WJtStTrNZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=agxfdd/m+CUjt2gj43i0zZRnKpaWyYV6xKfFvHyvRoT9DyxVKdJX2F1xlV8XBlQvB
	 TBvG68ELBGCpE+nI8ukB39eDpgt7y+p1+ZqQ1ZRQbmsvbeLlibaNQD8l3QAgPkqw6c
	 NIKI60Q136si7iQkLTSzUejt+kWHqCbQ4/OV+G30=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1392F805F9; Wed, 10 Jun 2026 09:49:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A521F805F8;
	Wed, 10 Jun 2026 09:49:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4039FF8058C; Wed, 10 Jun 2026 09:49:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781077741;
	b=D9Q0iwg98h/tLXT9vhf7KxEDnOjwi90Fd3OReVLRzZq4knxswO1srQLirUlViDNSiU4x
	 9Q28fvqyKrNr7l8+jE/3x0FtuAUKvbP0WEtmOYwzbVNmeLFD9xikTa04kJ3Hj00MBPBsB
	 uf2Y0EspOZmD6zf85YP0DZbNw+LRKPIkZ3jSqqvoRuTj+/5X3ENZSKPG5W7FkXEr+Txuy
	 2aAih5NG5Pj/JhfVx+wZLz/mCIRhm8WmxNrCeGcN9Esu4yNml5chauk+ZCtoggQzIZQoB
	 leu/BEVrteRfOYYj2aYm0oVdDRACT9HL0X+/U29EHxe7LPODEXosnG0qc1FmWFKC6eQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781077741;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=YhnipDLGg3txWkfssVNvTnwATli4QFRD9WJtStTrNZc=;
	b=YvGR+pZPBPpDKZ47VSp7EiUSNIbW5GU1lAg8EQqwOZiyd0A0oCKVf2FWQ9LUkKSUkPRv
	 HxuLEMT4y2f87adJO0XVzcgWmdlwkTMQTMH7ga6YCgUZqy8+p1k8ENyy1L1AMwKx2nqsr
	 fffDOCjDebussIfULXJzmzUE1q5nYomhzM1e3mVjx45hCDQBHcjcAg6P79aEFC/rPtDjk
	 ttiL0JZzCP0r2ICMaUD7aNFpexPl16rI74Enc2ulwP5jXVRWxxfiSCdluK5JEkusQAhuU
	 W15gACcy8bFXPFxXQ4FDofWwkcJwJj+w49VnfEgnNLcvVUd4T4LgmtmJQn+55r5fjtA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=pPbEinat;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PoCD93VJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=pPbEinat;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PoCD93VJ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 188F3F8057E
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 09:48:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 188F3F8057E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=pPbEinat;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PoCD93VJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=pPbEinat;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PoCD93VJ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B42067592E;
	Wed, 10 Jun 2026 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781077738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P4qMWAMgpHX0VP63DRLudNmWXCYjd3QviDNx0L0I6aw=;
	b=pPbEinatxlD42gWR5OBhcs8cM+uGLpD3OWdZCVnTBgpFQS5dKBo69/09YU6oHrMLRs+cQk
	Wz11WI4hLXaD650BbitkH9RESZ14aFF9VuuLeQcdExvaclke3kuRKKAsYiOUD0e0xKQfhP
	s2//iTlhngsV8HDNpyeJcOZ/lxAcmjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781077738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P4qMWAMgpHX0VP63DRLudNmWXCYjd3QviDNx0L0I6aw=;
	b=PoCD93VJBG6ZO8/8glUc4iHSanJHTL6ZOAlkVdKi2YUQZ2pwbB6CEKMoxxg8Oe+dDaPnuq
	J609dGQVw/I8H/Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pPbEinat;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PoCD93VJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781077738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P4qMWAMgpHX0VP63DRLudNmWXCYjd3QviDNx0L0I6aw=;
	b=pPbEinatxlD42gWR5OBhcs8cM+uGLpD3OWdZCVnTBgpFQS5dKBo69/09YU6oHrMLRs+cQk
	Wz11WI4hLXaD650BbitkH9RESZ14aFF9VuuLeQcdExvaclke3kuRKKAsYiOUD0e0xKQfhP
	s2//iTlhngsV8HDNpyeJcOZ/lxAcmjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781077738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P4qMWAMgpHX0VP63DRLudNmWXCYjd3QviDNx0L0I6aw=;
	b=PoCD93VJBG6ZO8/8glUc4iHSanJHTL6ZOAlkVdKi2YUQZ2pwbB6CEKMoxxg8Oe+dDaPnuq
	J609dGQVw/I8H/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C215779A7;
	Wed, 10 Jun 2026 07:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nr7uIOoWKWqSVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 10 Jun 2026 07:48:58 +0000
Date: Wed, 10 Jun 2026 09:48:58 +0200
Message-ID: <87o6hi6djp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Frank van de Pol <fvdpol@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] ALSA: usb: Add support for Reloop Jockey 3 DJ
 controllers
In-Reply-To: <20260609221643.3439698-1-fvdpol@gmail.com>
References: <20260609221643.3439698-1-fvdpol@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,sashiko.dev:url,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B42067592E
Message-ID-Hash: NAWZMSWLRFL7IRPHWJCX6N3TTLLGPLWH
X-Message-ID-Hash: NAWZMSWLRFL7IRPHWJCX6N3TTLLGPLWH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NAWZMSWLRFL7IRPHWJCX6N3TTLLGPLWH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 10 Jun 2026 00:16:42 +0200,
Frank van de Pol wrote:
> 
> 
> Hi Takashi, Hello ALSA community,
> 
> After being away from active ALSA development for some 25 years or so, I am 
> happy to submit this patch to introduce a dedicated driver supporting the 
> Jockey 3 series of DJ Controllers made by Reloop (specifically covering the 
> Master Edition and the Remix variants).
> 
> I initially evaluated the feasibility of integrating the required logic to 
> handle the non-standard proprietary Ploytec framing protocol into the standard 
> USB-audio driver via quirks. However, doing so would require introducing 
> numerous hardware-specific exceptions throughout the core layout, adding 
> significant complexity. A clean, isolated driver subdirectory provides much 
> better long-term maintainability without cluttering the existing class-compliant 
> architecture.
> 
> I have successfully validated and stress-tested this driver across three 
> distinct hardware architectures to ensure robustness regarding DMA, timing, 
> and memory alignment:
>  - x86_64 (Standard PC desktop environment)
>  - armhf (32-bit legacy environment on a Raspberry Pi 1B)
>  - arm64 (64-bit modern SoC environment on a Raspberry Pi 4)
> 
> I look forward to your review and feedback, and I am more than happy to 
> make architectural adjustments as required.
> 
> Best regards,
> Frank van de Pol

Hi Frank, nice to hear you again!

Through a quick glance, the driver design looks good and most of the
code are fine, but there can be small details that matter.  Could you
take a look at Sashiko review?
  https://sashiko.dev/#/patchset/20260609221643.3439698-2-fvdpol%40gmail.com

Not all items pointed there are useful, but the playback/capture
stream spinlock should be taken, and the use of the devres-memory for
URB buffer needs the re-consideration, too.

Last but not least, for the resubmission, please send to
linux-sound@vger.kernel.org (and Cc to linux-kernel@vger.kernel.org).
Recently we use alsa-devel ML only for user-space stuff, and the
kernel patches go to vger.


thanks,

Takashi
