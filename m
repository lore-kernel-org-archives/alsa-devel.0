Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9882606A324
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Em7RXFls;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cRZDc6Ts;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=x1sirfJ8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cRZDc6Ts;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=x1sirfJ8
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7F77601C7;
	Mon,  2 Nov 2026 14:47:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7F77601C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793627241;
	bh=V4neWq/41TfH91kuuWRNlE89W41qyCu0jCPkn8edvt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Em7RXFlsIkaaxfjFqZddBicaRnSVkY/6GoBVFAjmD3mVU4g2BmDMLYxBKGjbgi82I
	 +queP+x/xCnsMfCD05XdmXbV43Ffn2D9uKcLJUvJ3oIk6iATC5DRzUaTDl4tdSCLWw
	 Nkv7i9tI2Seh/c0CFdCeI/QT4XflvP8C2F18slgI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4FBD1F8061F; Mon,  2 Nov 2026 14:46:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2870FF8061F;
	Mon,  2 Nov 2026 14:46:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4FD38F80609; Mon,  2 Nov 2026 14:46:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6530DF805FC
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 14:46:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6530DF805FC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=cRZDc6Ts;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=x1sirfJ8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=cRZDc6Ts;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=x1sirfJ8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F229F222F1;
	Sat, 31 Oct 2026 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793463007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUClp3uABXUcUkd+nCAS6mdH9mEhxznUhHt/NIHf0/4=;
	b=cRZDc6Tsoj5cOM5EZhWb2IH5JaE3d/ipIsAeVYWWLrOpZiyDowWnLSUtOqKoJKsuV2KZg/
	msrHPFJLyov++kYRYV8HVL50Z5DhOWKrFe+6782L5ts69IGQyy9X11lfllGU7yrsb6kiqd
	atNU+EtzcEI0pUwbBBv8AnZ/qfRu6G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793463007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUClp3uABXUcUkd+nCAS6mdH9mEhxznUhHt/NIHf0/4=;
	b=x1sirfJ85qmSrAuhSBdrHc04iIDDLIFXwKewFVG+IX8Q6oq2j9pfBjKMqDNf13QKJwb5IK
	/bnXtzX8SDBN5TBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cRZDc6Ts;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x1sirfJ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793463007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUClp3uABXUcUkd+nCAS6mdH9mEhxznUhHt/NIHf0/4=;
	b=cRZDc6Tsoj5cOM5EZhWb2IH5JaE3d/ipIsAeVYWWLrOpZiyDowWnLSUtOqKoJKsuV2KZg/
	msrHPFJLyov++kYRYV8HVL50Z5DhOWKrFe+6782L5ts69IGQyy9X11lfllGU7yrsb6kiqd
	atNU+EtzcEI0pUwbBBv8AnZ/qfRu6G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793463007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUClp3uABXUcUkd+nCAS6mdH9mEhxznUhHt/NIHf0/4=;
	b=x1sirfJ85qmSrAuhSBdrHc04iIDDLIFXwKewFVG+IX8Q6oq2j9pfBjKMqDNf13QKJwb5IK
	/bnXtzX8SDBN5TBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C910132D3;
	Sat, 31 Oct 2026 16:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZGQ2DN4S5mrxNgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 16:10:06 +0000
Date: Sat, 31 Oct 2026 17:10:05 +0100
Message-ID: <87pkwprgv6.wl-tiwai@suse.de>
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
Subject: Re: [PATCH] ALSA: pcm: Don't WARN on NULL dma_area in the default
 mmap fault handler
In-Reply-To: <20261030112502.22227-1-Dmitry.Chumachenko@cyberprotect.ru>
References: <20261030112502.22227-1-Dmitry.Chumachenko@cyberprotect.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: F229F222F1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,cyberprotect.ru:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,linuxfoundation.org,kernel.org,gmx.de,gmail.com,doyensec.com,alsa-project.org,vger.kernel.org,linuxtesting.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Message-ID-Hash: FPADWHLLOTX675ALQBP4DFLRX3D5FDQA
X-Message-ID-Hash: FPADWHLLOTX675ALQBP4DFLRX3D5FDQA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FPADWHLLOTX675ALQBP4DFLRX3D5FDQA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Fri, 30 Oct 2026 12:25:02 +0100,
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
> snd_pcm_mmap_data_fault() guards the default RAM-buffer path with
> WARN_ON_ONCE(!runtime->dma_area). As commit d2913a07d903 notes, a driver
> may allow mmap before dma_area is set up, so this state is reachable from
> user space: mmap the PCM data region and fault it while the buffer is not
> allocated. The WARN then fires on a user-triggerable path and panics a
> kernel with panic_on_warn.
> 
> Drop the WARN; the NULL check and VM_FAULT_SIGBUS return stay, which is
> the correct silent handling.
> 
> Fixes: d2913a07d903 ("ALSA: pcm: Add sanity NULL check for the default mmap fault handler")
> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>

The WARN_ON() was put there because it shouldn't happen, and dropping
WARN_ON() is likely an incorrect "solution".

Could you rather investigate how this is triggered (under which
condition with which driver)?  That should be addressed instead of
just silencing it.


thanks,

Takashi
