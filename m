Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5981CD4F2C
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:05:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 936FD60202;
	Fri, 12 Jun 2026 11:05:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 936FD60202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781255151;
	bh=yy3xqO5tlMVhHO0R/tvhiIS2/ijl6UJVhc3Gi2vLQ9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=j2EuJtoa5u28zxGhJ5YMNHtF4dYuffENxfjgTSM2m0ANqP1aKMP2oAyMQFeZIWST7
	 fXV/wYl1fMrmTffYo7fdArxzpfH08h0aXAt+GwM1VG4PufRe1XHxDnS5ZXDmuPJhft
	 tFDPkQE4qkekELof5XwTejParXItweIMy0FgTcT8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BAA43F805FD; Fri, 12 Jun 2026 11:05:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 31456F805EF;
	Fri, 12 Jun 2026 11:05:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF1E7F80579; Fri, 12 Jun 2026 11:05:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781255103;
	b=LAZInI50XLsYPT6r9qgjosput6Q35w0zBk9WTo08aIj5PUOP+mckpBLJgRxVdmR4dOKH
	 n0tu5C8xZ8eQDybY2vWQlVaMMsTZnt9T9Jn8BnAH1NxQ4y2zQ6rFoMKWBa6AHWFWbF8xw
	 k7p/1f7hIuEIP0Q1yfzn77zBBkdk04mHg4I03Uz0ImFfLKXCjnDycPEL22QxG2J/S69eJ
	 VVEHD2QiLrPe7In23KpbS9Uf79XmcYX83jX6Yf2vqEnhj9fATA9tA6U2ruW4febLjlzN+
	 w5XxJkznP5fjIhrjUm+awkUvr549hqCRds9uTi2XSkphIzGSMttRZaC+iGwEmTH26Pw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781255103;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=yy3xqO5tlMVhHO0R/tvhiIS2/ijl6UJVhc3Gi2vLQ9s=;
	b=Wtsxmu9lVw7sHp72lEE1ii5mjvgi6PwBKzeYAEVFXiL3hVSp/Y2UbXCYM5sCypIXaRr0
	 owLLgtFDBY1RZZiYkUmAfCxW+Qe21ns9hik6KPBefnOQeR9o28Jmtq6Yq2LXiAjiJ+JO3
	 yNKLP9U8EVwPVxOVokhUWKqPIXQDwf9YcW0Uaq/xzLUPm7dKNmk1mbgM0J4+BdyUSXxg8
	 mI8wmw06ZdTp9pzAh27/Bvo1xMXrzz1AhuAdvVGSq73dfO3brlqiHF7LvXCG1w+DbwU5C
	 vmupTQBFl6rUQDbolNwRskuV6FTxnM5FNeQPgxFdGrMwOfoDKYWfpiNc64hap5h+B/A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=IcCacYHz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tZbG6v2K;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=IcCacYHz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tZbG6v2K;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8E9D1F801F5
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2026 11:05:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E9D1F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=IcCacYHz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tZbG6v2K;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=IcCacYHz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tZbG6v2K
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BBAB75E9D;
	Fri, 12 Jun 2026 09:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781255101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSBEmiimj3D5yii9pl1IMafFEhvrh94gfTW58psUsbA=;
	b=IcCacYHz7/QPm6/xEZHfNvOi2v2nmAWf2End6CrtsZ+4CGlPmqw1m4rXYU662nh2d6XX+5
	Fl2v+3hdX7b4yi4MZQhM4PAeCeGgiRMoGHLhitSJ8FpYr+qCs75nI9CSXazqIUGBh8ExDJ
	LMeHgPk1z+OyBZHOgPV6Z50Wn1N/KC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781255101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSBEmiimj3D5yii9pl1IMafFEhvrh94gfTW58psUsbA=;
	b=tZbG6v2KFcLWjLHaLAm4raq6kTw7n/Se3RKRYdYmKWfoe9LM1RaCWJ/oD50R+SZYOIu99w
	TMF0uF50Gu55esBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781255101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSBEmiimj3D5yii9pl1IMafFEhvrh94gfTW58psUsbA=;
	b=IcCacYHz7/QPm6/xEZHfNvOi2v2nmAWf2End6CrtsZ+4CGlPmqw1m4rXYU662nh2d6XX+5
	Fl2v+3hdX7b4yi4MZQhM4PAeCeGgiRMoGHLhitSJ8FpYr+qCs75nI9CSXazqIUGBh8ExDJ
	LMeHgPk1z+OyBZHOgPV6Z50Wn1N/KC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781255101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSBEmiimj3D5yii9pl1IMafFEhvrh94gfTW58psUsbA=;
	b=tZbG6v2KFcLWjLHaLAm4raq6kTw7n/Se3RKRYdYmKWfoe9LM1RaCWJ/oD50R+SZYOIu99w
	TMF0uF50Gu55esBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20818779A7;
	Fri, 12 Jun 2026 09:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uVhtBb3LK2o5aQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Jun 2026 09:05:01 +0000
Date: Fri, 12 Jun 2026 11:05:00 +0200
Message-ID: <87o6hgi0xv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cameron Graham <cam.graham@gmail.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/hdmi: Add HP EliteDesk 800 G5 Mini to
 force_connect_list
In-Reply-To: 
 <CAG-YL0gTPreYFE7FEDzgJ5qfDEPpC2J8FZouw_nfPLM3fTGDXg@mail.gmail.com>
References: 
 <CAG-YL0gTPreYFE7FEDzgJ5qfDEPpC2J8FZouw_nfPLM3fTGDXg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: VHNGV2NPWPHQCD7NFGXHKO7XIGEKKPYP
X-Message-ID-Hash: VHNGV2NPWPHQCD7NFGXHKO7XIGEKKPYP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VHNGV2NPWPHQCD7NFGXHKO7XIGEKKPYP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 12 Jun 2026 05:38:42 +0200,
Cameron Graham wrote:
> 
> 
>   The HP EliteDesk 800 G5 Mini (PCI subsystem 103c:8595) uses
>   Cannon Lake PCH cAVS HDA with DisplayPort audio pins 0x05 and
>   0x06 set to AC_JACK_PORT_NONE (N/A) in BIOS defaults, causing
>   hdmi_add_pin() to skip them and the DP audio device to not
>   appear in ALSA.
> 
>   Add the board to the existing force_connect_list alongside the
>   similar HP EliteDesk 800 G4 entries.
> 
>   Signed-off-by: Cam Graham <cam.graham@gmail.com>
>   ---
>    sound/hda/codecs/hdmi/hdmi.c | 1 +
>    1 file changed, 1 insertion(+)
> 
>   diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
>   index ...
>   --- a/sound/hda/codecs/hdmi/hdmi.c
>   +++ b/sound/hda/codecs/hdmi/hdmi.c
>   @@ -1551,6 +1551,7 @@ static const struct snd_pci_quirk force_connect_list[]
> = {
>         SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
>         SND_PCI_QUIRK(0x103c, 0x845a, "HP EliteDesk 800 G4 DM 65W", 1),
>   +     SND_PCI_QUIRK(0x103c, 0x8595, "HP EliteDesk 800 G5 Mini", 1),
>         SND_PCI_QUIRK(0x103c, 0x83f3, "HP ProDesk 400", 1),

The patch isn't properly formatted for an e-mail submission (two
spaces are added in all lines).  Also, use linux-sound@vger.kernel.org
for the kernel patch instead of alsa-devel ML.

Please resubmit the correct patch to linux-sound ML.


thanks,

Takashi

