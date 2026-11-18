Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58D606A339
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=YeaMDb5/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r5nNzMcF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ahme8KlX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r5nNzMcF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ahme8KlX
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22038601FE;
	Wed, 18 Nov 2026 14:47:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22038601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795009677;
	bh=khH7ZEFx1n8YGgZr4ESjcp8iEX5ATgf0+FwLdTKIQzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YeaMDb5/LCtUpS7EswHh2IQsriMcynbwaDsud3yYxmkq8u7XQ4yKn/VT9AbU43O5Y
	 DSX2Mjcaz9GpSUFXNDNH+MxpP00BPhtI2zcBUUfPca6WXgzhnmwhRe1fbPsO9u75Gt
	 S9NFxBFHTNCwF2IVEPjXXYjmMTeT2wM1cKIB0BbA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5E01F805FB; Wed, 18 Nov 2026 14:47:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11B67F80602;
	Wed, 18 Nov 2026 14:47:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D079F80538; Wed, 18 Nov 2026 14:47:17 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795009632;
	b=AD7LX8illPYIPKu533pbkueHXMtjtTXSp8tu4EvcEhTyHKQOVu2dwlWHCMNl+yn+ceqV
	 9uxU8CYea7Bix0uACNn8s5GcouF6urvAGVCqkqeOpqXcN8z4GWo15MaYdP78qRpT5H+NQ
	 kwsCYVuzmHFZjth80+MRRqPtM5/F6shhRbvRw9TU6Oc0ODcP5VFSxazNF1XInkT7fTuP+
	 sqwkyRZJwFIRcz//i+CuB132w6xuwko2TiUU20lqF1T6eErsCsJ6wsgvN2OlvB0BtYsJi
	 7OWvIViDMJbNmDpEn4gsfSD+uaUx85lsz/3tIFwgSqq2T23loMDU7qq40x7E2u8cc/g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795009632;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=khH7ZEFx1n8YGgZr4ESjcp8iEX5ATgf0+FwLdTKIQzc=;
	b=a8qZ7ChR6/soICKvIMEHuzUS040o21t+QbEvJ2++/1FgVP2B2R9tFUXTBIup2Mo2ZSXs
	 1QFQ6aG58VdvBmOsWagc9ZhhsXvyTGK4VoeclA8gKCIUb1TRh1Ht6SfJ9HIt9jrtTEpzd
	 DG8E97oFTS8BZ7i60fGZ1H9slKjUHEW0JH2O8v3M6Z2Lw4tVA/4YOOj2cwGQzG7yJnceq
	 tvlQ/He0vvdi83p8AYD2ZM00Mb+uSy81Bf4VBcEgHS5Xejh0zful3/aoQHjjIZEYiI5EY
	 sZpmR1gK2NzBuIRyEBkozExlii3tclq9H1zPXINw3eH9lzFnj1+KOr09CMpZvdFSNcg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=r5nNzMcF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ahme8KlX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=r5nNzMcF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ahme8KlX;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91656F80152
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2026 14:47:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91656F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=r5nNzMcF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ahme8KlX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=r5nNzMcF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ahme8KlX
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47813222DD;
	Wed, 18 Nov 2026 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1795009630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P29+0WSfDjivL0QnkfaQfvp/outg1KtB0aHDGFukhnc=;
	b=r5nNzMcFxtfKCzkdsqrQNtjAqYmmIo62cl7Xxr1aOWf4ewQFgO1GaSpRnwrX898O9Ft6+O
	Uv+Pz8x5K8gUa3Bled5PFMEyKLxSmscMCLzU4ehQ9ht6zJHEGQRMiErVawnSg9YRf9t4Px
	QuLmWVNFSUzGCrh+bCPE9rWptC3uveg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795009630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P29+0WSfDjivL0QnkfaQfvp/outg1KtB0aHDGFukhnc=;
	b=ahme8KlXHBzZ6/pvNKoSZbbNxUCEC7EeUhVqyDlkOJgJoQLA7fZVVH4lm164XNuK5TVdNk
	77tpSO4aFLkTVbBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r5nNzMcF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ahme8KlX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1795009630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P29+0WSfDjivL0QnkfaQfvp/outg1KtB0aHDGFukhnc=;
	b=r5nNzMcFxtfKCzkdsqrQNtjAqYmmIo62cl7Xxr1aOWf4ewQFgO1GaSpRnwrX898O9Ft6+O
	Uv+Pz8x5K8gUa3Bled5PFMEyKLxSmscMCLzU4ehQ9ht6zJHEGQRMiErVawnSg9YRf9t4Px
	QuLmWVNFSUzGCrh+bCPE9rWptC3uveg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795009630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P29+0WSfDjivL0QnkfaQfvp/outg1KtB0aHDGFukhnc=;
	b=ahme8KlXHBzZ6/pvNKoSZbbNxUCEC7EeUhVqyDlkOJgJoQLA7fZVVH4lm164XNuK5TVdNk
	77tpSO4aFLkTVbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9D931334C;
	Wed, 18 Nov 2026 13:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VEsWKF2s/WrLEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 18 Nov 2026 13:47:09 +0000
Date: Wed, 18 Nov 2026 14:47:09 +0100
Message-ID: <87h5hew8te.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,
	Mehul Rao <mehulrao@gmail.com>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	Norbert Szetei
	<norbert@doyensec.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH v2] ALSA: pcm_oss: reject buffer reconfiguration while the
 stream is mmapped
In-Reply-To: <20261118131945.27592-1-Dmitry.Chumachenko@cyberprotect.ru>
References: <20261118131945.27592-1-Dmitry.Chumachenko@cyberprotect.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,linuxfoundation.org,kernel.org,gmx.de,gmail.com,doyensec.com,alsa-project.org,vger.kernel.org,linuxtesting.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyberprotect.ru:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 47813222DD
Message-ID-Hash: RKNQXUZZZJCRL3635GPM36B6FPELJLGC
X-Message-ID-Hash: RKNQXUZZZJCRL3635GPM36B6FPELJLGC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RKNQXUZZZJCRL3635GPM36B6FPELJLGC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Wed, 18 Nov 2026 14:19:45 +0100,
Dmitriy Chumachenko wrote:
> 
> During fuzz testing, the following issue was discovered.                   
>                                                                            
> WARNING: CPU: 2 PID: 1734 at sound/core/pcm_native.c:3835                  
> snd_pcm_mmap_data_fault+0x47f/0x530 sound/core/pcm_native.c:3835           
>                                                                            
> Modules linked in:                                                         
> CPU: 2 PID: 1734 Comm: syz.1.352 Not tainted 6.1.187-syzkaller-00593-g063a81552262 #0
> RIP: 0010:snd_pcm_mmap_data_fault+0x47f/0x530 sound/core/pcm_native.c:3835 
>                                                                            
> Call Trace:                                                                
>  <TASK>                                                                    
>  __do_fault+0x10d/0x480 mm/memory.c:4280                                   
>  do_cow_fault mm/memory.c:4661 [inline]                                    
>  do_fault+0xa7a/0x1100 mm/memory.c:4762                                    
>  handle_pte_fault mm/memory.c:5031 [inline]                                
>  __handle_mm_fault+0xdf3/0x2e40 mm/memory.c:5173                           
>  handle_mm_fault+0x2da/0xa60 mm/memory.c:5294                              
>  do_user_addr_fault+0x4aa/0x1050 arch/x86/mm/fault.c:1338                  
>  handle_page_fault arch/x86/mm/fault.c:1429 [inline]                       
>  exc_page_fault+0x98/0x1b0 arch/x86/mm/fault.c:1482                        
>  asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:608
> 
> snd_pcm_oss_change_params() frees and reallocates the substream buffer,
> and several OSS entry points reach it while the data area may already be
> mmapped: snd_pcm_oss_mmap() and the SNDCTL_DSP_GETOSPACE/GETISPACE ioctls
> (snd_pcm_oss_get_space()).
> 
> For OSS streams snd_pcm_hw_params() skips the mmap_count guard
> (!is_oss_stream), so the buffer is torn down under a live mapping. If the
> reallocation then fails, the substream is left with runtime->dma_area ==
> NULL, and the next page fault on the stale mapping reaches
> snd_pcm_mmap_data_fault() with no buffer, hitting the WARN_ON_ONCE().
> 
> Reject the reconfiguration in snd_pcm_oss_change_params_locked() when the
> stream is already mmapped; this covers all callers (read/write already
> bail out earlier on a non-zero mmap_count). The core WARN_ON_ONCE() is
> left in place.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>

Well, if we want to restrict the hw_params with mmap completely, it's
easier just drop the exception for OSS in the PCM core, instead:

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -778,7 +778,7 @@ static int hw_params_state_check(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_SETUP:
 	case SNDRV_PCM_STATE_PREPARED:
-		if (check_mmap && !is_oss_stream(substream) &&
+		if (check_mmap &&
 		    atomic_read(&substream->mmap_count))
 			return -EBADFD;
 		return 0;

But, there must be some reason for this explicitly allowance for OSS
(maybe some apps like the old game need it), and the above (and your)
change would break it.
So, if we really want to guarantee the compatibility for old existing
applications, we need some other ways to check the buffer reallocation
instead (e.g. disallow the buffer byte size change).  Though, I'm not
sure whether it's worth...


thanks,

Takashi
