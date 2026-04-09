Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ABAEA3C22
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:08:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B484F601FA;
	Thu,  9 Apr 2026 12:08:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B484F601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775729323;
	bh=6ZHQKqYKi/wXcxzVrBobWd+rZCDifND2lZw1AlIQpMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NFQQtAvqP7dyEqY4jV99Oa/02DLgkiKC0pSpDN27k3mXRXYzw9e8QutR4nz9ppJCS
	 tl17MAhnpmaZFDdX5vO6LCD6Y7N8HJkJ6NbbfqX2LSa7oV9JgQSwSPBx+59A9FbKQT
	 nQ1V3q84hujR/QdlsF/XFngDVf4SL2zolbZVB+0o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89B16F805ED; Thu,  9 Apr 2026 12:08:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1308FF805E7;
	Thu,  9 Apr 2026 12:08:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0D8DF8052D; Thu,  9 Apr 2026 12:08:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 53DBDF8027B
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 12:08:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53DBDF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Y+VH1cyK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gOk0hdBP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Y+VH1cyK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gOk0hdBP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AC345BD1E;
	Thu,  9 Apr 2026 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1775729281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGEPckBhe8z+TG5+glglG6YLudtRQ+eIHU6EXwccg3k=;
	b=Y+VH1cyKSYSwWBAvirz0MCc6qeMjgwcST8Y+6m82TV6iQQhycAw/xhA3JFC7mOqgLCIiYz
	B0Tk+kQm1vt5HRsZLMd4hgykEKA36mVN9Ln2l73yx3QBFe/923tOZ6lRXCuzy67NwYqckb
	xCPO/0WSlmD3aHN9tk9p7un0NLzjD+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775729281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGEPckBhe8z+TG5+glglG6YLudtRQ+eIHU6EXwccg3k=;
	b=gOk0hdBPe8mRISZFn89w6TqXYJd+gUIvU3aFfBRvD4PBGYqZe/hHKW5O84mtpDXJg02U+G
	sL9LS546r5eTBBCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1775729281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGEPckBhe8z+TG5+glglG6YLudtRQ+eIHU6EXwccg3k=;
	b=Y+VH1cyKSYSwWBAvirz0MCc6qeMjgwcST8Y+6m82TV6iQQhycAw/xhA3JFC7mOqgLCIiYz
	B0Tk+kQm1vt5HRsZLMd4hgykEKA36mVN9Ln2l73yx3QBFe/923tOZ6lRXCuzy67NwYqckb
	xCPO/0WSlmD3aHN9tk9p7un0NLzjD+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775729281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGEPckBhe8z+TG5+glglG6YLudtRQ+eIHU6EXwccg3k=;
	b=gOk0hdBPe8mRISZFn89w6TqXYJd+gUIvU3aFfBRvD4PBGYqZe/hHKW5O84mtpDXJg02U+G
	sL9LS546r5eTBBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B5A24A0B3;
	Thu,  9 Apr 2026 10:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8jDsFIF612lBeQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 09 Apr 2026 10:08:01 +0000
Date: Thu, 09 Apr 2026 12:08:01 +0200
Message-ID: <874ilkjvjy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joseph Ferrero <joeferrero14@gmail.com>
Cc: alsa-devel@alsa-project.org,
	shumingf@realtek.com
Subject: Re: [REGRESSION] ALSA: hda/realtek: Gigabyte quirk misconfigures
 front combo jack mic pin as HP out on ALC897
In-Reply-To: 
 <CAGid3wpdk1NK0mij2f4bwWOchdJE81ipyifx5yxxOB0W=Bm3_g@mail.gmail.com>
References: 
 <CAGid3wpdk1NK0mij2f4bwWOchdJE81ipyifx5yxxOB0W=Bm3_g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: GNH5RBEP7BKIO5KV7TU7V53M4IEI4CD2
X-Message-ID-Hash: GNH5RBEP7BKIO5KV7TU7V53M4IEI4CD2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GNH5RBEP7BKIO5KV7TU7V53M4IEI4CD2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 Apr 2026 18:19:16 +0200,
Joseph Ferrero wrote:
> 
> Hi,
> 
> After upgrading from kernel 6.19.10 to 6.19.11, the front panel combo jack
> on my Gigabyte Z890M GAMING X no longer provides microphone input. The
> headphone output on the same jack still works. Reverting to 6.19.10
> restores mic functionality.
> 
> I suspect the following commit introduced in 6.19.11:
> 
>   ALSA: hda/realtek: Add quirk for Gigabyte Technology to fix headphone
> 
> Hardware:
>   Board: Gigabyte Z890M GAMING X
>   Codec: Realtek ALC897 (card 1, /proc/asound/card1/codec#0)
>   Subsystem Id: 0x1458a194
>   Controller: Intel 800 Series ACE (HDA Intel PCH)
> 
> Workaround:
>   Downgrade to linux 6.19.10.

The revert of the change above is already in the next planned PR for
7.0.


thanks,

Takashi
