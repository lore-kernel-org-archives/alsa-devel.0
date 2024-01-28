Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D82C47258
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jan 2024 12:12:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 723FD850;
	Sun, 28 Jan 2024 13:12:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 723FD850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706443931;
	bh=FQzq2NAotC6wUwaYUkpZ6HIbEUogOXl600xzI6zhA3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ULzgH7bkXQtxAVa20o5WUQUMit38FmaY7QHA6rVCt1adhpEipu5PnFh1B9Keno3yn
	 sCOX/tincXmpTSv99QVkuUYWTlPbjKBqfRtsaZ2LoFPeI6Lkxo+ydA1dZTj0PrIa9U
	 ywTmD4NvDiK9DYW/ZYfyKee287kqV1Dxu6SZF+d8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64298F8055C; Sun, 28 Jan 2024 13:11:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C57D3F80580;
	Sun, 28 Jan 2024 13:11:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7304DF80310; Sun, 28 Jan 2024 13:11:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A9D93F80149
	for <alsa-devel@alsa-project.org>; Sun, 28 Jan 2024 13:11:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9D93F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=l9KTQ5bc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hWrkoH6q;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=l9KTQ5bc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hWrkoH6q
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7FC51F785;
	Sun, 28 Jan 2024 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1706443888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEjlU+HfxYw6/YuHRrKma248cZlFW5ARPvm9WCT7WDk=;
	b=l9KTQ5bcyVy6bLVoIHOJK4BScfdG6DXFVv2ZcSFDteRwjEA/5bJl0S4d1Ve8WSzILFaJBE
	azxW2cFOyF/Uhw1ZJb/8BB8Pwlca0rFtrvdVGjd2kTnjRtQX5EfZNLmb+tTT5HF3IrIty2
	cj358sPztKLfqsM3I7FrtgiDh94r72Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706443888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEjlU+HfxYw6/YuHRrKma248cZlFW5ARPvm9WCT7WDk=;
	b=hWrkoH6qQg2VeOEV2IIT2RHQ/UTAU2k1X6sgqo7D/6WmDKi2+fOHLYC1kfXiA9DrXcX73e
	CyjGnV3UCXEwivCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1706443888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEjlU+HfxYw6/YuHRrKma248cZlFW5ARPvm9WCT7WDk=;
	b=l9KTQ5bcyVy6bLVoIHOJK4BScfdG6DXFVv2ZcSFDteRwjEA/5bJl0S4d1Ve8WSzILFaJBE
	azxW2cFOyF/Uhw1ZJb/8BB8Pwlca0rFtrvdVGjd2kTnjRtQX5EfZNLmb+tTT5HF3IrIty2
	cj358sPztKLfqsM3I7FrtgiDh94r72Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706443888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEjlU+HfxYw6/YuHRrKma248cZlFW5ARPvm9WCT7WDk=;
	b=hWrkoH6qQg2VeOEV2IIT2RHQ/UTAU2k1X6sgqo7D/6WmDKi2+fOHLYC1kfXiA9DrXcX73e
	CyjGnV3UCXEwivCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87B8312FF7;
	Sun, 28 Jan 2024 12:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hKyWH3BEtmU2CgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 28 Jan 2024 12:11:28 +0000
Date: Sun, 28 Jan 2024 13:11:28 +0100
Message-ID: <87zfwpmzdb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/4] Support HP Models without _DSD
In-Reply-To: <20240126164005.367021-1-sbinding@opensource.cirrus.com>
References: <20240126164005.367021-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.71)[98.72%]
Message-ID-Hash: DXWSA7E45HOVP3SXMO5GR2ISTX4YZWJU
X-Message-ID-Hash: DXWSA7E45HOVP3SXMO5GR2ISTX4YZWJU
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DXWSA7E45HOVP3SXMO5GR2ISTX4YZWJU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 26 Jan 2024 17:40:01 +0100,
Stefan Binding wrote:
> 
> Add Quirks and driver properties for Dell models.
> Driver properties are required since these models do not have _DSD.
> Some models require special handing for Speaker ID and cannot use
> the configuration table to add properties.
> Also fix an issue for Channel Index property, when set through the
> configuration table, to use the same method as when loading _DSD
> properties. This is needed for laptops with 4 amps where the
> channels do not alternate.
> 
> Changes from v1:
> - Rebase on latest for-next
> 
> Stefan Binding (4):
>   ALSA: hda: cs35l41: Set Channel Index correctly when system is missing
>     _DSD
>   ALSA: hda: cs35l41: Support additional HP Envy Models
>   ALSA: hda: cs35l41: Support HP models without _DSD using dual Speaker
>     ID
>   ALSA: hda/realtek: Add quirks for various HP ENVY models

Applied all four patches now.


thanks,

Takashi
