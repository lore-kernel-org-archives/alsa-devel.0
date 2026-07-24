Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37061C531F9
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:11:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10DC260200;
	Fri, 24 Jul 2026 11:11:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10DC260200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784884292;
	bh=SnoaoNBdaaLMkTXD3nqQqd9hmZoPoHIyqwrQJo4XM2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ny0IrcX70FSXrHOrNIn1MZYjsjvNRiwzD0NQfa2ie11hdpYL3Nl1SXPnYONmkatDj
	 6RugA7p8AumeoQecp/cLFPBIL+wNzzTI68zJ13kPgK3dlWeZYL2e9T17ab8EH6vgtr
	 5w3Y4H5S/Piqb/R7uUaPO/nWo9T0tIjWOc0gU5W0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11842F805FB; Fri, 24 Jul 2026 11:10:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 752A2F805F8;
	Fri, 24 Jul 2026 11:10:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7995F805BF; Fri, 24 Jul 2026 11:10:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784884246;
	b=C0oWIBHzcojG046KvUuKNcawxxfEC/ESa7nkrgc9j22oBipOjpfQlvl1uLX83ww4w1z6
	 A/Gih19dZ8nBNB3gU/JDqBfASed8JR0EylLmgzu98N4zu8iawn6mfJVpFflxl3A/OeqMq
	 w3HyhX9oCHa2yzJbzfCCLIY+60dZOHd58FzV17ecfMjiyVfj9CpFSXMUG4FbZrwmBC2RF
	 ZXLOJT9rGBrcIA34bP6GP6h/abQkAk1pPwrlXh9tkkxiGPbbtDMttH7/T10dohNsNqCRa
	 MmSbUq+UyBYApGtgoObieUHmlFwpBckgeHCU3Sf/mquFyf3LiCPN0APEG79Wti1INGg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784884246;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=SnoaoNBdaaLMkTXD3nqQqd9hmZoPoHIyqwrQJo4XM2A=;
	b=DV2mFeEyTMbbScPz50mL3LDeq8466SCBbOdMK8SS6lQkUeH3+kKiu0i76pBGJvI7hXHv
	 dY88YoBdwQTwbXnOUcjeCPlq8vERFu4xq2s4XJkZFt9v9xj2dE/ytpmhaTe8VuXGVqfoR
	 3gCqauTxrzbq2O+cEQQ+ZuYWLb4+yZzoPaiJgtC5xirzFOWbAt3O+Eqie48IMWxsqoU47
	 qDjvl1PE/y9a3QAJxZjeYpTXeyFbHs8nfQj9pMrUrICuAK0Hu0uMprn6r1tC5h/6dlhN/
	 /GKbNBDW2LP6vA/hOxsolkrZtX8RYNEqiFIub8oWtlyj4ExoyF7TMssbdztbIwlccIg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ifzIBGw8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=WSu6+829;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ifzIBGw8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=WSu6+829;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 54EC5F800AC
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2026 11:10:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54EC5F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ifzIBGw8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=WSu6+829;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ifzIBGw8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=WSu6+829
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 085FC7B68D;
	Fri, 24 Jul 2026 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784884244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBf4Gsu2q/t3BGIbMC2XUMh4mL7NMAlksrWTttgdG7g=;
	b=ifzIBGw8KAe3GIhlI+Nya8mDep9Ww5C7sYtBSKAM/hLO4GACJW8anjSNnjKi/aZusON+tS
	6v8UEb9k+qYkkw//Hr4zfhlKjDO0WZwSHn/DfGz7fohtXI+v6XRwK8QtShyEWLbk7Oli5M
	HzVwuu0e+yf8hal+A+suJBjWWYVX49Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784884244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBf4Gsu2q/t3BGIbMC2XUMh4mL7NMAlksrWTttgdG7g=;
	b=WSu6+829BeGq880PW98s7xIBOO7DIIgWs8mQTzm+UxNSJQwSBTfbxr3qL6eA6C8UtqSEa2
	x+27MscbSS+GqFCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784884244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBf4Gsu2q/t3BGIbMC2XUMh4mL7NMAlksrWTttgdG7g=;
	b=ifzIBGw8KAe3GIhlI+Nya8mDep9Ww5C7sYtBSKAM/hLO4GACJW8anjSNnjKi/aZusON+tS
	6v8UEb9k+qYkkw//Hr4zfhlKjDO0WZwSHn/DfGz7fohtXI+v6XRwK8QtShyEWLbk7Oli5M
	HzVwuu0e+yf8hal+A+suJBjWWYVX49Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784884244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBf4Gsu2q/t3BGIbMC2XUMh4mL7NMAlksrWTttgdG7g=;
	b=WSu6+829BeGq880PW98s7xIBOO7DIIgWs8mQTzm+UxNSJQwSBTfbxr3qL6eA6C8UtqSEa2
	x+27MscbSS+GqFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D39FB779BA;
	Fri, 24 Jul 2026 09:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A7tkMhMsY2qxJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 24 Jul 2026 09:10:43 +0000
Date: Fri, 24 Jul 2026 11:10:43 +0200
Message-ID: <8733x8eorw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Markus Lindner <lindner.markus@outlook.at>
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add dB map quirk for Razer Barracuda X
 2.4
In-Reply-To: 
 <AS8P195MB2142F4EFF83980BD02BA6566E1C12@AS8P195MB2142.EURP195.PROD.OUTLOOK.COM>
References: 
 <AS8P195MB2142F4EFF83980BD02BA6566E1C12@AS8P195MB2142.EURP195.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[outlook.at];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.at];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: CVCKRZY7OWKU3WGVQ3SAOXVLLDQ357QW
X-Message-ID-Hash: CVCKRZY7OWKU3WGVQ3SAOXVLLDQ357QW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CVCKRZY7OWKU3WGVQ3SAOXVLLDQ357QW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 22 Jul 2026 03:09:18 +0200,
Markus Lindner wrote:
> 
> The Razer Barracuda X 2.4 GHz USB headset dongle (0x1532:0x0552)
> reports a minimum volume register value of cval->min = -16800.
> 
> In UAC 1/256 dB units, -16800 corresponds to -65.625 dB. However,
> stock ALSA misinterprets this raw integer as 1/100 dB units
> (-168.00 dB), causing user-space audio servers (PipeWire /
> PulseAudio) to map their volume curves against an incorrectly wide
> range.
> 
> Add an explicit usbmix_dB_map entry overriding Unit 2 to -6562
> (-65.62 dB) to accurately report the physical hardware
> attenuation bounds.
> 
> Signed-off-by: Markus Lindner <lindner.markus@outlook.at>

Applied now.

But at the next time, please submit to linux-sound@vger.kernel.org
instead of alsa-devel ML.  alsa-devel ML is only for user-space stuff
for now.


thanks,

Takashi
