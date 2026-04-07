Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28BAFEEF29
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 12:29:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D5B0601F6;
	Tue,  7 Apr 2026 14:29:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D5B0601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775564952;
	bh=3+nATR2M0xPl//oQkqwy1364zC1YEpqNFRKXibKNq9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=U52M8hQGpL//wa7gO4weWRf9ooyl9tZ6mQuwf61XTceYNw4MM3chYS8pRKihiYwP4
	 yx1D80MAhl2mHpihVCremiDo28MzH1guHhewhM5sF4byvyHxB+Ee+hwOhnjBqK7Vca
	 o+jGqgitAaLfFLqCDVmLPm8MAcq9vQ6l0W8sbUAQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 916D6F805F5; Tue,  7 Apr 2026 14:28:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2327BF805E8;
	Tue,  7 Apr 2026 14:28:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 895B3F80548; Tue,  7 Apr 2026 14:28:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13DB3F8001F
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 14:28:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13DB3F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=RoSSU2DO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=OVJ898aF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=RoSSU2DO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=OVJ898aF
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ACE95BD4F;
	Tue,  7 Apr 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1775564900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kj9CE0g9qVAC3aWsBDYB4W9VpAcHvTgLMGP0JiHo9g=;
	b=RoSSU2DOqwU50VLvpfKNIfKXtshP8vZBIoL863O68s4VdRwcMd5Zl0jEFO8msYPMlekDDp
	QePVakFqUxv2M/6+KwleSwdL+iVjiHMylf+D5PNWVHMY7ZQGb5UVkpJJ6GGQOR3QkAa7b9
	HB089z/EfX294FxRLtJceCtcNTyfHQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775564900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kj9CE0g9qVAC3aWsBDYB4W9VpAcHvTgLMGP0JiHo9g=;
	b=OVJ898aFMddVU7G2HIfoCPb3t7e4730wMxEDlcNedizEwnXwCr8rH4Kp1ccSWxXtkihRa+
	mHR5yaF4uu5hVSCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RoSSU2DO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OVJ898aF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1775564900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kj9CE0g9qVAC3aWsBDYB4W9VpAcHvTgLMGP0JiHo9g=;
	b=RoSSU2DOqwU50VLvpfKNIfKXtshP8vZBIoL863O68s4VdRwcMd5Zl0jEFO8msYPMlekDDp
	QePVakFqUxv2M/6+KwleSwdL+iVjiHMylf+D5PNWVHMY7ZQGb5UVkpJJ6GGQOR3QkAa7b9
	HB089z/EfX294FxRLtJceCtcNTyfHQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775564900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kj9CE0g9qVAC3aWsBDYB4W9VpAcHvTgLMGP0JiHo9g=;
	b=OVJ898aFMddVU7G2HIfoCPb3t7e4730wMxEDlcNedizEwnXwCr8rH4Kp1ccSWxXtkihRa+
	mHR5yaF4uu5hVSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 059144A0B0;
	Tue,  7 Apr 2026 12:28:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O56wAGT41GnqFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 Apr 2026 12:28:20 +0000
Date: Tue, 07 Apr 2026 14:28:11 +0200
Message-ID: <87qzorlztw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Theodoros Orfanidis <teoulas@gmail.com>
Cc: m.krycki@gmail.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [BUG] ALSA: hda/realtek: SSID 1458:a194 is shared by different
 Gigabyte ALC897 front-panel layouts
In-Reply-To: <20260407120350.42282-1-teoulas@gmail.com>
References: 
 <CAEfRphPU_ABuVFzaHhspxgp2WAqi7kKNGo4yOOt0zeVFPSj8+Q@mail.gmail.com>
	<20260407120350.42282-1-teoulas@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 1ACE95BD4F
Message-ID-Hash: 2LYLJI6CG4ACPQ42QVX7CQ6DAYHSCS2J
X-Message-ID-Hash: 2LYLJI6CG4ACPQ42QVX7CQ6DAYHSCS2J
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2LYLJI6CG4ACPQ42QVX7CQ6DAYHSCS2J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 Apr 2026 14:03:48 +0200,
Theodoros Orfanidis wrote:
> 
> On Mon, 06 Apr 2026, Marcin Krycki wrote:
> > [BUG] ALSA: hda/realtek: SSID 1458:a194 is shared by different
> > Gigabyte ALC897 front-panel layouts
> 
> Same issue here. After a recent kernel update from 6.19.10 to 6.19.11
> (Arch Linux), I realized my mic port had become another headphone out.
> 
> Pin 0x19 (the physical Front Mic jack) is re-tasked as a second
> headphone output, and the microphone input disappears from the
> available sources in the system.
> 
> Prior to this patch (tested on kernel 6.19.10), auto-config correctly
> identified the separate pins:
>   inputs: Rear Mic=0x18, Front Mic=0x19
>   hp_outs=1 (0x1b)
> 
> With this patch applied:
>   inputs: Mic=0x18
>   hp_outs=2 (0x1b, 0x19)
>   Front Mic (0x19) is missing from inputs.
> 
> Manually re-tasking Pin 0x19 back to'Microphone' via hdajackretask
> restores the expected behavior.
> 
> Hardware: Gigabyte B660I AORUS PRO DDR4 (rev. 1.x)
> PCI SSID: 1458:a194
> Codec: Realtek ALC897

OK, I'm going to revert the commit.  The fix patch looks dubious and
needs to be revisited.


thanks,

Takashi
