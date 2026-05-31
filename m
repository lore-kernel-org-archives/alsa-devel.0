Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29E3CD6E52
	for <alsa-devel@archiver.kernel.org>; Sun, 31 May 2026 13:27:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D8F660222;
	Sun, 31 May 2026 15:27:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D8F660222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780234042;
	bh=kFC5azpUlgVp5WcMaZ28WZur13Ng/tKlVHqnMLJNn40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V0lgey8jvhBykSJ+UOQ9yPv6LJEw/swf67BezNyg/rO2CfhlmUwtYwK6g2Z2hjs1J
	 /ftDh+GgJ3fwsZCWFFnngcULPkxTUIPxxZvuZ64SOHXr5j9eGyTxkzeVaeNhYfZL5l
	 EiOKj5chxcl9+bNXbZMRos92GdW/MX1c4NIB9oLc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3675F805E9; Sun, 31 May 2026 15:26:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CA78F805ED;
	Sun, 31 May 2026 15:26:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 680C4F805B0; Sun, 31 May 2026 15:26:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BF71DF80075
	for <alsa-devel@alsa-project.org>; Sun, 31 May 2026 15:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF71DF80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=jVqIDTLP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HQMvqNwd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=jVqIDTLP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HQMvqNwd
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07CFA6B9A9;
	Sun, 31 May 2026 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780233998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWCMDa0OYzZuqpOPZ7xjhHXIkf4VDW/Pxey+oqX8Dnk=;
	b=jVqIDTLP+qsH7gnybVq7ga6M6A8mCYiHlonzDE0hbC64TLJ24YKVO9oN/Q1mD3B0rEEVc3
	2awS+gHK6RZYvkTDFJLG8Hm38HpgnIgXY1sGHZ5NESGY5otJitZtEiIa/MJ36CemP//cEF
	yqNRFZhMrLGuQbEG9Percvx9dY69/L8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780233998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWCMDa0OYzZuqpOPZ7xjhHXIkf4VDW/Pxey+oqX8Dnk=;
	b=HQMvqNwdz/Zmg5GnSaBxyiBl3Kehr/Ga4xRZdPVy2XiiUdbHTUHdlWgwpmySObricHlNRj
	HMYP5I1PaPlQ14Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780233998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWCMDa0OYzZuqpOPZ7xjhHXIkf4VDW/Pxey+oqX8Dnk=;
	b=jVqIDTLP+qsH7gnybVq7ga6M6A8mCYiHlonzDE0hbC64TLJ24YKVO9oN/Q1mD3B0rEEVc3
	2awS+gHK6RZYvkTDFJLG8Hm38HpgnIgXY1sGHZ5NESGY5otJitZtEiIa/MJ36CemP//cEF
	yqNRFZhMrLGuQbEG9Percvx9dY69/L8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780233998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWCMDa0OYzZuqpOPZ7xjhHXIkf4VDW/Pxey+oqX8Dnk=;
	b=HQMvqNwdz/Zmg5GnSaBxyiBl3Kehr/Ga4xRZdPVy2XiiUdbHTUHdlWgwpmySObricHlNRj
	HMYP5I1PaPlQ14Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3FAC779A7;
	Sun, 31 May 2026 13:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zGGQMg03HGqlWwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 31 May 2026 13:26:37 +0000
Date: Sun, 31 May 2026 15:26:37 +0200
Message-ID: <8733z7pv5e.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-2022-JP?B?GyRCPH4bKEJPY2Vhbg==?= <zhouoceanhy@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
In-Reply-To: 
 <CACYx1SrnTfg6GKK2S1Vb13f9OWOq1x=VUDA=AFWs1CALsC_B2g@mail.gmail.com>
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
	<87y0h2r3g6.wl-tiwai@suse.de>
	<CACYx1SrnTfg6GKK2S1Vb13f9OWOq1x=VUDA=AFWs1CALsC_B2g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[ocean-sudo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: ZXZGGHA27NIWKRNGZPDG4SV2PM37HAUZ
X-Message-ID-Hash: ZXZGGHA27NIWKRNGZPDG4SV2PM37HAUZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZXZGGHA27NIWKRNGZPDG4SV2PM37HAUZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 31 May 2026 04:52:03 +0200,
周Ocean wrote:
> 
> 
> Hi Takashi,
> 
> Thanks for your quick reply and professional guidance!
> 
> Here is the original topology of Conexant CX20632 (SSID 2014:8004) on FEVM
> FA880 PRO:
> 
> - Node 0x14 [Audio Input] (Analog Capture)
>   Connection: 4
>      0x1a 0x1b 0x1d 0x1e*   (Note: 0x1e is selected by default)
> 
> - Node 0x1e [Pin Complex] (Internal Mic)
>   Pin Default 0x95a60120: [Fixed] Mic at Int Top
>   Connection: None (It's a digital/fixed mic pin)
> 
> - Node 0x1a [Pin Complex] (Front Mic): Pin Default 0x02a1103e
> - Node 0x1b [Pin Complex] (Rear Mic): Pin Default 0x01a13030
> 
> Regarding the kernel crash, I encountered a kernel Oops in try_assign_dacs()
> during the auto-config stage on the newer 7.0.10-cachyos kernel. I suspect it
> might be triggered when loading my out-of-tree custom DKMS module, or due to
> changes in how try_assign_dacs() interacts with this specific topology on the
> new kernel. (Fortunately, the system works perfectly fine on the 6.18-lts
> kernel with my custom module).
> 
> In the older kernel (like 6.18), the auto-parser didn't crash but would
> incorrectly route Node 0x14 away from Node 0x1e after probing, disabling the
> internal microphone. That was why my previous patch forced index 0x03 on Node
> 0x14 in HDA_FIXUP_ACT_INIT.
> 
> Since you mentioned correcting the routes before parsing, should we override
> the connection list of Node 0x14 to restrict it during
> HDA_FIXUP_ACT_PRE_PROBE, or override the pin default configuration via
> HDA_FIXUP_PINS to fix this properly? 
> 
> I would really appreciate your advice on how we should construct the fixup
> gracefully!

For better understanding your system, could you give alsa-info.sh
outputs (at best both with and without your patch)?  Run the script
with --no-upload option and attach the outputs.


thanks,

