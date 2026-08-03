Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1732FC55175
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:03:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F3F0601EF;
	Mon,  3 Aug 2026 09:03:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F3F0601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785740590;
	bh=sAM3aTPJiCJSxrVZFRlBRUDjzEiFCZV21XWMN5nPQdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ix6aMOCMY99SlQbXMuIbHQVAjPEW73Vke/VOLdjpex7h/SOtuYd7LGGe6djzKAjlD
	 QH2eoWYFq6MXlpRAb8oXa0yRrf+xi2fKvXCPQOD+3olapREH0A8Q7M8YmuTNQscTLi
	 DpWLhsQgkesIeTsPnFnpI+0nzHyzNkYqEUL/ajxE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 270ABF805F0; Mon,  3 Aug 2026 09:02:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 99A60F805FC;
	Mon,  3 Aug 2026 09:02:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3FB3F800B6; Mon,  3 Aug 2026 09:02:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785740542;
	b=AvpljefSwh+iiAAMqikwrvCFSor/+RBwTpv/7bYwWFZAr3ts9VgHsG8PGz8uJvKJts4u
	 EOkccayPuQDu8O1ZaZKlQ+O6uNcJa02CZf/QmY4qL1XGORZjkfRmLzGqCxLsHd9FtxjT4
	 RqQlFXlT0HqaFwHP7HcnUEb92Uf2f/ccFR+kEPhTAPzLYDAjjwqjY2GrfcLylr9jeySKj
	 R4opnxuG1Hu0vWZLDeYMH88h9+uG3I6OSQGvDaYbrG032nHs7+pl2x0k1fGbw/3ot3CKl
	 z0KHayLo4oqlO1Wzsy0dtDDZkZiqeqZQ32ib8ZtXqpHTkQ84NSscirVyRWK3WlwLGng==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785740542;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=sAM3aTPJiCJSxrVZFRlBRUDjzEiFCZV21XWMN5nPQdo=;
	b=U1lHxJFRX020GjMf5s03wG0U93DYsAnpqcYBO8eQ4Vur3yQRwPPLaeC1cD8S3W0eBDqC
	 jijqkGC9lmfAN9HgiLd1AqhH4fgBoikSVtp903H1NnKuAFlc+nYWaXOaANoSx1xufgloE
	 VVL110ERRbljHtvDfbDMnkQbLwiBX4NOmScg7Yl5J75AnL3VibqCB3uQsUA7W4wQYxFGL
	 4eFQI2vOh7HxkXgk5abc4bF3xv/81WB3V5Xva/eMQC9pnMgwFCLh5r7BpCUqsX4nH+bZc
	 cttP+eSBary1DQTBXBI3A10+jr/ftXnbsWYIe16T/134FhD3qljokiUV1Gn3VUjO3Vw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=eiEnunf7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=lplPVb4y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="O02hU/qa";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wsHTdS3j;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 830AAF800B6
	for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2026 09:02:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 830AAF800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=eiEnunf7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=lplPVb4y;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=O02hU/qa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wsHTdS3j
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D70F7403D;
	Mon,  3 Aug 2026 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785740535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nyFJX9yKOOW6hL5g/LhsRSBmK5lEZRLgYqvW7P6E9o=;
	b=eiEnunf7kaxN4DVtV6utUKXmnQcKK/P5U+ennshs4v14REdSq+ihxrtvtke5JGw7KdQK3O
	MPbrIazEYtZARe4zT/TSLVGP8uyZiy5+n8iGPo0sjN3vM6yTyonrgK2bF24MyGgeeRYFjK
	9HnIMdYEkbwtDJrOADkwpWFjlqvL8Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785740535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nyFJX9yKOOW6hL5g/LhsRSBmK5lEZRLgYqvW7P6E9o=;
	b=lplPVb4yTVU0E1VWSz6gB67xaB8UeoUpwP0lgX8poQpescC/dSgANnb+wuGU+yU/+ShGbc
	sh7pS4z+waysrDCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="O02hU/qa";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wsHTdS3j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785740530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nyFJX9yKOOW6hL5g/LhsRSBmK5lEZRLgYqvW7P6E9o=;
	b=O02hU/qayHKCRJUT8zJJEnFT97pjZ1LNWQOP888yk2sW3yIGKMO1oGrzxeNimLPRLmdJCk
	ldPBJxvOGDaaSHyYo6LrXTkHv/Wlq7uzAq5Qw8ES44c/RewRtaXJqZEf4SymJ204800LSe
	4eGV/C4layAGdOFHLpn7OJcLiWvUxwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785740530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nyFJX9yKOOW6hL5g/LhsRSBmK5lEZRLgYqvW7P6E9o=;
	b=wsHTdS3jMmZDI4d4RtPDWzEC6V5e0BR+ZRxlXur5eYCGAv7VRI7VyqesB3HVaOIkdxkKl3
	z1V3/CQHgejTTuDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B816C779A1;
	Mon,  3 Aug 2026 07:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y21fK/I8cGqDCgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 03 Aug 2026 07:02:10 +0000
Date: Mon, 03 Aug 2026 09:02:10 +0200
Message-ID: <878q6nbsb1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?EUC-KR?B?uvuzqrTCyLK80g==?= <safenine@gmail.com>
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for LG Gram 17ZD90R-EX79K
In-Reply-To: 
 <CAJ79ZrGy5F0LwQ=xZBmZi+MnTybiATPg2FGbS-7NaMWvb_6syQ@mail.gmail.com>
References: 
 <CAJ79ZrGy5F0LwQ=xZBmZi+MnTybiATPg2FGbS-7NaMWvb_6syQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D70F7403D
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.969];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: HKVFGCCKC75NWF4XDU3PKQ3DJEHPHPFA
X-Message-ID-Hash: HKVFGCCKC75NWF4XDU3PKQ3DJEHPHPFA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HKVFGCCKC75NWF4XDU3PKQ3DJEHPHPFA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 30 Jul 2026 06:20:09 +0200,
ºû³ª´ÂÈ²¼Ò wrote:
> 
> From: Jabong Koo <safenine@gmail.com>
> 
> The internal speakers on the LG Gram 17ZD90R-EX79K remain silent,
> while headphone output works normally.
> 
> The machine uses a Realtek ALC298 codec with PCI subsystem ID
> 1854:048b. Existing LG Gram subsystem IDs 1854:0488, 1854:0489 and
> 1854:048a use ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS, but 1854:048b is
> missing from the quirk table.
> 
> Add the matching quirk for subsystem ID 1854:048b.
> 
> Tested successfully on Ubuntu HWE kernels 6.17.0-41-generic and
> 7.0.0-28-generic.
> 
> Signed-off-by: Jabong Koo <safenine@gmail.com>
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c
> b/sound/hda/codecs/realtek/alc269.c
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -7752,6 +7752,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1854, 0x0488, "LG gram 16 (16Z90R)",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
>  	SND_PCI_QUIRK(0x1854, 0x0489, "LG gram 16 (16Z90R-A)",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
>  	SND_PCI_QUIRK(0x1854, 0x048a, "LG gram 17 (17ZD90R)",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
> +	SND_PCI_QUIRK(0x1854, 0x048b, "LG gram 17 (17ZD90R-EX79K)",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
>  	SND_PCI_QUIRK(0x1854, 0x05bf, "LG gram 17ZD90S",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
>  	SND_PCI_QUIRK(0x1854, 0x05c0, "LG gram 16Z90S",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
>  	SND_PCI_QUIRK(0x1854, 0x05c1, "LG gram 14Z90S",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),

The patch looks malformed (with wrong spaces), likely due to your
mailer, so it can't be applied cleanly via git-am.
Please fix your mailer setup, and resubmit the fix.


thanks,

Takashi
