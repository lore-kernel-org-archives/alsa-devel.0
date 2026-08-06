Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A1CC56208
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:47:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A15A660235;
	Thu,  6 Aug 2026 11:46:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A15A660235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786009623;
	bh=FFb9xnb2bXsfSp6d3BW7TfV8tEqDZ940SlN8CAICdnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qC15E4K7YECSJrYYV6BO9NbSHgu9y7izs1WTnE5H2WmJRrkwpR9FK5mX4uu3oqiUk
	 DZRsxRp9eBBzKaBgTZkusw/eQ1U8vwLl6gacHTiMaROhLJAcD+JZZtXw0ZVYGbzy85
	 aNSQ8uhkh6xfIJB2c1e9ihKVVFE5CjeR47rjdYmw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C4FCF805F9; Thu,  6 Aug 2026 11:46:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98BDAF805FE;
	Thu,  6 Aug 2026 11:46:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 895CAF8055A; Thu,  6 Aug 2026 11:46:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786009578;
	b=XbUWi5nxXVckrVbb5afhL4knILUwdUirEUtW0gl9/UdbX+pUEm6mIVAXsy87IVi/1ruM
	 GbxZDnmV+aMh2AO4QHTLVRsJyeXWCc8A8DEpu3/dg+60jBAViO4Im6gthmh7REdKqHhQq
	 7XjsJQ8n+tgIITzdfPMBbQyoJatNsp0TKbj0hej8rMEJ2MQ9zP+vSrjLUKS9H0iRNB8Dm
	 4UqGUVZi1B7fXhiMnugoOiSW5JhSl/Tk3LulIdP/v9jVga8UbpBFSPlHlbyt0ljSwU+wL
	 KV3SCJUWgeSyWtTlyIP46CTXuczkH+BB9s4x3+fB4oSdkpbF2XfVBbQZ9h79WUtlt5A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786009578;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=FFb9xnb2bXsfSp6d3BW7TfV8tEqDZ940SlN8CAICdnE=;
	b=nMy0lt21fTHmF0bwlx4VAvo796rtnNLSkdf506NszF+mHbZjI1OLb0LbrKmSXrYUGwdI
	 qEgUC6tUOcz9w6l9JsD0002hPh4zJiJugNNIU51PYZXUU4GJM8i+94oam0f55zQQZCyIx
	 DBzJ8uB0NMrVKmdnQILyhr5eBVsk24wfn6R+/UQyXuJF+FjNDomtQaFGouw7NK84CUh9q
	 ODyXVGRGRnsXLAarAZ6mRSJdjLs0Pi3p/+Kp75nyk2CLzwquK7MTAW0A8eKVFhFULAcJu
	 nfgSK+bmjUTdg9YXUvw/inwBh2YRvkDmIomQKg3MpHclYTN11ppbOBWaUr5zbUpHTcg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=hd8xcnDz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=x4DPizqy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=GtW1sNiD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=nttQBUdh;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81E8DF800B5
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 11:46:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81E8DF800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=hd8xcnDz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=x4DPizqy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=GtW1sNiD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=nttQBUdh
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9001B3E18;
	Thu,  6 Aug 2026 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786009572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMedZm8ilhfGUjnt7tN7TRYRH4QzoXQnT3odAU/ZR3c=;
	b=hd8xcnDzzckvL1nUL3lIakT0nva625Gj/IvUX2FCZSOyI1RnODEP+I9BYblk7KZM+gOsKc
	B/j+dN0IGF3G8cdmRHRUS0NWoiEcivcbkkHRCBXPccWa6ckiJN2bbmV25RkJstIJHeliS2
	OcAIO08ZzQxLKVg/4l+KUX1r1rJczpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786009572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMedZm8ilhfGUjnt7tN7TRYRH4QzoXQnT3odAU/ZR3c=;
	b=x4DPizqycP92r7K8r2880q6mMsQUhoB16j6O8m/fZvxC5tCAnl0624C1fqicnecD01a+6r
	Cf7I36kPU1b9qGCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GtW1sNiD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nttQBUdh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786009568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMedZm8ilhfGUjnt7tN7TRYRH4QzoXQnT3odAU/ZR3c=;
	b=GtW1sNiDyMZ0/IfHkf+C7zvcs9HCKWBbqxko5wFxN/zBB78zEbUWatrBCuy7LY1hXTmC8p
	EHS166q4SqLJ7zQ67OelivVnXSVa9+mTgjJOJet5PO9CXk5fJkNgdvJNcnhL/lmEzwkbfP
	xrZBKA/fAYSCVMbWSnp+MmcSK4xbKUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786009568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMedZm8ilhfGUjnt7tN7TRYRH4QzoXQnT3odAU/ZR3c=;
	b=nttQBUdhHQ7YZwAMc8nmuTQy9tH8wLaEmyXQ6bb8VXueEqZ7/wJxTMlA1AVniUl7pnv1F/
	AiaDIZqbpG6SYLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EFBD779B6;
	Thu,  6 Aug 2026 09:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hlfMFeBXdGrOPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Aug 2026 09:46:08 +0000
Date: Thu, 06 Aug 2026 11:46:07 +0200
Message-ID: <87pkzveg4g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: sbinding@opensource.cirrus.com
Cc: Gemayel Lira <gemayellira@gmail.com>,
    alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS
 UX3405CA
In-Reply-To: 
 <CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>
References: 
 <CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9001B3E18
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: P7J35MQDYAK3JMXCU3XIQMYU3X3LZQBD
X-Message-ID-Hash: P7J35MQDYAK3JMXCU3XIQMYU3X3LZQBD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P7J35MQDYAK3JMXCU3XIQMYU3X3LZQBD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 02 Aug 2026 01:00:22 +0200,
Gemayel Lira wrote:
> 
> 
> The ASUS Zenbook 14 UX3405CA (SSID 1043:1A63) has internal CS35L41
> amplifiers, but was using the missing_speaker_id_gpio2 fallback entry.
> This caused the right speaker channel to bind with VSPK voltage switch
> disabled
> (VSPK: 0), leading to a volume drop ~1 second after starting playback due to
> power imbalance protection.
> 
> Add an explicit entry for 10431A63 in cs35l41_config_table with internal boost
> type, 4500mA peak current, and switch its model mapping to generic_dsd_config.
> This resolves the volume drop issue and enables proper internal boost for both
> channels.
> 
> Pull Request on SOF Project: https://github.com/thesofproject/linux/pull/5866
> 
> Signed-off-by: Gemayel Lira <gemayellira@gmail.com>
> 
> From 10431A6300000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Gemayel Lira <gemayellira@gmail.com>
> Date: Sat, 1 Aug 2026 19:15:00 -0300
> Subject: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS UX3405CA
> 
> The ASUS Zenbook 14 UX3405CA (SSID 1043:1A63) has internal CS35L41
> amplifiers, but was using the `missing_speaker_id_gpio2` fallback entry.
> This caused the right speaker channel to bind with VSPK voltage switch disabled
> (VSPK: 0), leading to a volume drop ~1 second after starting playback due to
> power imbalance protection.
> 
> Add an explicit entry for 10431A63 in cs35l41_config_table with internal boost
> type, 4500mA peak current, and switch its model mapping to `generic_dsd_config`.
> This resolves the volume drop issue and enables proper internal boost for both channels.
> 
> Signed-off-by: Gemayel Lira <gemayellira@gmail.com>

Stefan, is this also covered in your side?
Or shall we just take this?


BTW, Gemayel, at the next time, please submit to
linux-sound@vger.kernel.org.  It's the place for kernel patches, while
alsa-devel ML is mostly for only user-space stuff.


thanks,

Takashi


> ---
>  sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> index 416d7bf..1cf12f8 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> @@ -104,6 +104,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>  	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
>  	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
> +	{ "10431A63", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, -1, 2, -1, 1000, 4500, 24 },
>  	{ "10431A83", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "10431B93", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
>  	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> @@ -530,7 +531,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "104317F3", generic_dsd_config },
>  	{ "CSC3551", "10431863", generic_dsd_config },
>  	{ "CSC3551", "104318D3", generic_dsd_config },
> -	{ "CSC3551", "10431A63", missing_speaker_id_gpio2 },
> +	{ "CSC3551", "10431A63", generic_dsd_config },
>  	{ "CSC3551", "10431A83", generic_dsd_config },
>  	{ "CSC3551", "10431B93", generic_dsd_config },
>  	{ "CSC3551", "10431C9F", generic_dsd_config },
> -- 
> 2.43.0
