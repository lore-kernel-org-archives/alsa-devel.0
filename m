Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA43EF371E
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:02:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECB1C6023A;
	Mon,  9 Mar 2026 10:02:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECB1C6023A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773046972;
	bh=lxsngedNTuJ2gxdr+o7pki8ATm6ddiUn0I9/Iw9jR1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YAY33KO1ilKwkAwdWA0S7xWkUq4fLbBaKa/1BuE/lm3s3JKopM+a3PGYHI4DinCZt
	 ZfVv7nalRXt8EAMN+2b/+Y+Kse4uSjl/H6fKkMBJwsBySixfbmsDEiz3vgJJ5mMUJP
	 GlaEH2WgcLR1RjmntJ1f5sKhgmRh9bVtxhVC2Ov8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5679BF805F8; Mon,  9 Mar 2026 10:02:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3488F805E8;
	Mon,  9 Mar 2026 10:02:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C37F7F80571; Mon,  9 Mar 2026 10:02:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 743BEF8001E
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2026 10:02:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 743BEF8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=wjHXkgGc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=HQcSB+v6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=0XQQeG5w;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=pBkLwdU2
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75DF75BE6D;
	Mon,  9 Mar 2026 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1773046923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06VzGyHQUpRC/vwJO3GlSm4DtVrwQk8z5oewQG32Z9A=;
	b=wjHXkgGcmDUss/w3UFCs4sXCKw5fwD+tCU0YedQs2V0OXcyR1qDr0O2olCWfdzrxH3V9rn
	8Iqjk8S5pxct81UnaMT/nDsMufDelFPzFkD2Itvyr4X+cofZW09fmwPIJyj5+wmhwb/7gZ
	ihBp94Ac1Be6RIK4bBJ2fm5CfT6SyEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773046923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06VzGyHQUpRC/vwJO3GlSm4DtVrwQk8z5oewQG32Z9A=;
	b=HQcSB+v6BduBCAQjxbhiM9AgztCNmyMF62hA3zWkoszs8iUaiIDY7bh/ZgQXoVu/kvkapP
	DxgYnRSSKFzlAJBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1773046922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06VzGyHQUpRC/vwJO3GlSm4DtVrwQk8z5oewQG32Z9A=;
	b=0XQQeG5woYfVkGeyNroyDAWbNMlL+tLVYeyiHDAqG0KjZe4y5ZSDRzH+grOJIYF5NeB1XO
	dVkOUw460IJY8JC+8lDHDXhjxoNDvTE6JgG/jJlYIiL0+AtLMRFZCyFEKm/tTlEG80zzrY
	DtW56BD9MFYzmeGe44Nuj54Q8Z8s56I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773046922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06VzGyHQUpRC/vwJO3GlSm4DtVrwQk8z5oewQG32Z9A=;
	b=pBkLwdU2jv4rpQ4rkXWNLP/rFu1uHC8rrdw2ehag98baUXPppaYa2b3jMJU0ziaok9IWAz
	j9FDjvMpbhVjjIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 498683EDFE;
	Mon,  9 Mar 2026 09:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id umawEIqMrmmGTQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Mar 2026 09:02:02 +0000
Date: Mon, 09 Mar 2026 10:02:01 +0100
Message-ID: <87ms0htlyu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Uzair Mughal <contact@uzair.is-a.dev>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add headset jack quirk for Thinkpad
 X390
In-Reply-To: <20260307012906.20093-1-contact@uzair.is-a.dev>
References: <20260307012906.20093-1-contact@uzair.is-a.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: WWXYWHTAGLBJXK3EFZ62W5TRKBBUX2SS
X-Message-ID-Hash: WWXYWHTAGLBJXK3EFZ62W5TRKBBUX2SS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WWXYWHTAGLBJXK3EFZ62W5TRKBBUX2SS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 07 Mar 2026 02:29:06 +0100,
Uzair Mughal wrote:
> 
> The Lenovo ThinkPad X390 (ALC257 codec, subsystem ID 0x17aa2288)
> does not report headset button press events. Headphone insertion is
> detected (SW_HEADPHONE_INSERT), but pressing the inline microphone
> button on a headset produces no input events.
> 
> Add a SND_PCI_QUIRK entry that maps this subsystem ID to
> ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK, which enables
> headset jack button detection through alc_fixup_headset_jack()
> and ThinkPad ACPI integration. This is the same fixup used by
> similar ThinkPad models (P1 Gen 3, X1 Extreme Gen 3).
> 
> Signed-off-by: Uzair Mughal <contact@uzair.is-a.dev>
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index XXXXXXX..XXXXXXX 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6998,6 +6998,7 @@
>  	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>  	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> +	SND_PCI_QUIRK(0x17aa, 0x2288, "Thinkpad X390", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
>  	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
>  	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
> -- 
> 2.43.0

It looks like that the patch is malformed, failing one context line,
and neither git-am nor patch can't apply it cleanly.
Since the code change is trivial, I fixed it locally now.  But at the
next time, please make sure that the patch is really applicable.


thanks,

Takashi
