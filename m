Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7512E9381D
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:36:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB0D260196;
	Mon, 13 Apr 2026 07:36:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB0D260196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776058613;
	bh=PG6gTqjJT52DFL2uQ58VBaOsZYoiBBQc6oI1TpnqKKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uAZgEgIqBPq4NVY4+QYAaEUDEaGgWLEjtTVFS/+IxQi+qn6D82bgHZ7hvgePbFoRS
	 yBD6Z3nxHVkjepoOrhjAkwC2JoTzHnEf8aleVHRnOPJD3gjYjPxHGkZpCivAoo4NAd
	 BaeeeYTX54Ynw2IzRh104Azvuzi5Z079TCBCy5mQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A205F805F1; Mon, 13 Apr 2026 07:36:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F043AF805F2;
	Mon, 13 Apr 2026 07:36:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88B21F80537; Mon, 13 Apr 2026 07:36:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5129F8011B
	for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2026 07:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5129F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=GpgIDdc8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5V7erp9q;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=GpgIDdc8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5V7erp9q
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E281E6A893;
	Mon, 13 Apr 2026 05:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776058561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLlxGWJhADFrjXWMZE+OK06QmzS6M8GjDms4YMDxDLo=;
	b=GpgIDdc8Y7xEGm19ZTYxMVKqHLHY1clkCpfY7Nw/SEfvTQ8rEcBZ/LVGXZ32KWzHwgvJkP
	ytVqa0N06QLwN+xv21QmPbZ3OS0TiHyRSRBumi4hnaMYcGk3yfdewwmgb9u4ze6JLumCyx
	HzNnqKCAqJasghJe3jpHO7h1ti4Cdpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776058561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLlxGWJhADFrjXWMZE+OK06QmzS6M8GjDms4YMDxDLo=;
	b=5V7erp9qWH39JGXE4IYXyevhx0rVaKAMZP3Pf45ZKHzboZviHChvaIjS9I68CGtxqbYFCG
	8AOIuvbiJ+/vsVBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1776058561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLlxGWJhADFrjXWMZE+OK06QmzS6M8GjDms4YMDxDLo=;
	b=GpgIDdc8Y7xEGm19ZTYxMVKqHLHY1clkCpfY7Nw/SEfvTQ8rEcBZ/LVGXZ32KWzHwgvJkP
	ytVqa0N06QLwN+xv21QmPbZ3OS0TiHyRSRBumi4hnaMYcGk3yfdewwmgb9u4ze6JLumCyx
	HzNnqKCAqJasghJe3jpHO7h1ti4Cdpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776058561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLlxGWJhADFrjXWMZE+OK06QmzS6M8GjDms4YMDxDLo=;
	b=5V7erp9qWH39JGXE4IYXyevhx0rVaKAMZP3Pf45ZKHzboZviHChvaIjS9I68CGtxqbYFCG
	8AOIuvbiJ+/vsVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8A344AD0D;
	Mon, 13 Apr 2026 05:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aMZ8J8GA3GmfYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Apr 2026 05:36:01 +0000
Date: Mon, 13 Apr 2026 07:36:01 +0200
Message-ID: <87lderwhfi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Faye <faye.opensource@gmail.com>
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Acer PT316-51S headset
 mic
In-Reply-To: <20260413031259.30135-1-faye.opensource@gmail.com>
References: <20260413031259.30135-1-faye.opensource@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: GFTRSUKDTMCFCFXIBUEMWPDXXDPY7DGQ
X-Message-ID-Hash: GFTRSUKDTMCFCFXIBUEMWPDXXDPY7DGQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GFTRSUKDTMCFCFXIBUEMWPDXXDPY7DGQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 13 Apr 2026 05:12:59 +0200,
Faye wrote:
> 
> The Acer PT316-51S (PCI SSID 1025:160e) with ALC287 codec does not
> detect the headset microphone due to missing BIOS pin configuration
> for pin 0x19. Apply ALC2XX_FIXUP_HEADSET_MIC to enable it.
> 
> Signed-off-by: Faye <faye.opensource@gmail.com>

Signed-off-by tag needs to be a real name (or a known identity) as
it's a legal requirement (and preferably From tag should be same,
too).

Also...

> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index cb39054..75466f4 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6689,6 +6689,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1025, 0x1534, "Acer Predator PH315-54", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x1025, 0x1539, "Acer Nitro 5 AN515-57", ALC2XX_FIXUP_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC2XX_FIXUP_HEADSET_MIC),
> +	SND_PCI_QUIRK(0x1025, 0x160e, "Acer PT316-51S", ALC2XX_FIXUP_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1025, 0x1597, "Acer Nitro 5 AN517-55", ALC2XX_FIXUP_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
>  	SND_PCI_QUIRK(0x1025, 0x171e, "Acer Nitro ANV15-51", ALC245_FIXUP_ACER_MICMUTE_LED),

... the table is sorted in PCI SSID order.  Please put the new entry
at the right position.

Could you resubmit with the above corrections?


thanks,

Takashi
