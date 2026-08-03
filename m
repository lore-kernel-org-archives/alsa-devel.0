Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC3BC55175
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:06:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A94560200;
	Mon,  3 Aug 2026 09:06:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A94560200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785740812;
	bh=EYlFZNGn/Ox7pazaZyEHINNzVOoZAozLFE80aauTWr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZW/ahAQhoEVWE8n6U7+N4Z1L6Ztgr0mCwwZhpioSMH9uQUxZLfWmxgE5WqrqHZFo8
	 Sn6oC+Tndx+v5qi5+H1LXQ2tcFbUfnX/LyJaN4/eBs07AsCAtDMMtveohUfFzZKJA8
	 ttupPK7BYFhJq02ck+Q1EWKwCHgSgvIi95tL1hE4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCA8DF805FC; Mon,  3 Aug 2026 09:06:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E620F805F3;
	Mon,  3 Aug 2026 09:06:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3737DF805BF; Mon,  3 Aug 2026 09:06:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785740765;
	b=LkyhVncEeeikvWOoBeN8xjNn8ZvEiJSZRQIrOu5n/GpgccJxad4phJOIsd/D2PfYGKxQ
	 Lifo0kim8qnnzk5mzAM45hLov17AKt2Xb/iD6noMEUAPnX8Q7CwmTKb8xLZdP28Ucy0Oi
	 ayc9S/Dp6E6GYx8IU0QASxmaNKEaXjDDfWDeQ+whnmhzPGgC/7xKD0YrOFbHpE3uSBuZY
	 V4Nfi6cN3Mb2TJOpKu6kcBODe746UQ4Cy4cnFAcRatfYUSL8BRMpAAsLj6UUbwp62TPqU
	 AYp7ZEEf2ruklZVzEUtyxBx17t3qUs+QaxP8WaME5Y3471Ic/cUuTqhttRvrrdnl5Bg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785740765;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=EYlFZNGn/Ox7pazaZyEHINNzVOoZAozLFE80aauTWr0=;
	b=plCRmPRMevreMK31dWXsAtjK1QLo4ZlO80Fv3OIdfkfATih3KOEJcmRCHg2evQR/fhKb
	 Jgu7wAnu1I1yho8aHSOzW0OmMy1vXx8HJTnhRVh+PZ8qDONm0ncNjcntsNTZrJ3XVGzjj
	 9Bk6AXfJCyXn67pdkCnmveKqwfIQSBifqw/8ZSghSveFOInpqAqQvchWE0fGZrSyIm5wX
	 9wE9iv3AB2993F9aFv7YW8XsoOjtN+kL1WYN7pLISuCV8q7GqgEljOSwz2abgR79qFjf7
	 FYU52nXK9r1x0+jSbnlhftcd+K5En7bVDUPuqXaqKh5Lc70SYCR5nBOE+/AK2F3cizA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=djzjz6lX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=k0OPv4gR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ZKnY3sLH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=kYEP4rTB;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2FA2F800B6
	for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2026 09:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2FA2F800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=djzjz6lX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=k0OPv4gR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ZKnY3sLH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=kYEP4rTB
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C7C741B6;
	Mon,  3 Aug 2026 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785740759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuN2YQE5qCcF5Q5+zsiTbsczM8qM/sTJva6Uivh/kso=;
	b=djzjz6lXOPXtHOukVQdYMkm/yFezVh3fFQDcBDimy1Bk2Ss2g4Cn0wzYUUWNj/PhXH0X4L
	dmo/3xNEvHE1/guM9VnLcTmDDFxI0nj7v1uaoVXqwXvQgHM9tjCRVMS5F9EcfCAr6ejFHM
	Au7GceUtn3QnAJsAyKK6xRWdCpqif2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785740759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuN2YQE5qCcF5Q5+zsiTbsczM8qM/sTJva6Uivh/kso=;
	b=k0OPv4gRgW9iyO1tWSsprhQX7sSWl/JtALbiO5FhWpD+GYF+Hs76Ea8sFMQuVWJmB3MOXs
	lmAJI9gkj8N4giCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785740755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuN2YQE5qCcF5Q5+zsiTbsczM8qM/sTJva6Uivh/kso=;
	b=ZKnY3sLHVDmgYet/YGruOs2uN9bvHKPtKbyJA57vtLeTPgP3xev4NO1NxpnzNOz8SKPKEs
	Qu0HWkv0yELaqoxcpHJJLukOnQNuPx7DPKYNOImpzCNRhjZ49fu7hrWv6msBni2kQYIklO
	M27qJ3kgPwRqmF/C06unqgMsdSprD7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785740755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuN2YQE5qCcF5Q5+zsiTbsczM8qM/sTJva6Uivh/kso=;
	b=kYEP4rTB7KOaMC5tS7j0yXeqSnwhN4A+ZXH5hMiy29dIkeMyHSZRNi+sj29ICuaRcvRITr
	I7f0tkKp2uWOiqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D908C779A1;
	Mon,  3 Aug 2026 07:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gSOaM9I9cGpTDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 03 Aug 2026 07:05:54 +0000
Date: Mon, 03 Aug 2026 09:05:54 +0200
Message-ID: <874ihbbs4t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?EUC-KR?B?uvuzqrTCyLK80g==?= <safenine@gmail.com>
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Aaron Fan <aaronfan404@gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for LG Gram 17ZD90R-EX79K
In-Reply-To: <878q6nbsb1.wl-tiwai@suse.de>
References: 
 <CAJ79ZrGy5F0LwQ=xZBmZi+MnTybiATPg2FGbS-7NaMWvb_6syQ@mail.gmail.com>
	<878q6nbsb1.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.917];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,alsa-project.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: 7WZXKHYWQPTJ576FTMMLASBXSZVLF24V
X-Message-ID-Hash: 7WZXKHYWQPTJ576FTMMLASBXSZVLF24V
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7WZXKHYWQPTJ576FTMMLASBXSZVLF24V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 03 Aug 2026 09:02:10 +0200,
Takashi Iwai wrote:
> 
> On Thu, 30 Jul 2026 06:20:09 +0200,
> ºû³ª´ÂÈ²¼Ò wrote:
> > 
> > From: Jabong Koo <safenine@gmail.com>
> > 
> > The internal speakers on the LG Gram 17ZD90R-EX79K remain silent,
> > while headphone output works normally.
> > 
> > The machine uses a Realtek ALC298 codec with PCI subsystem ID
> > 1854:048b. Existing LG Gram subsystem IDs 1854:0488, 1854:0489 and
> > 1854:048a use ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS, but 1854:048b is
> > missing from the quirk table.
> > 
> > Add the matching quirk for subsystem ID 1854:048b.
> > 
> > Tested successfully on Ubuntu HWE kernels 6.17.0-41-generic and
> > 7.0.0-28-generic.
> > 
> > Signed-off-by: Jabong Koo <safenine@gmail.com>
> > ---
> >  sound/hda/codecs/realtek/alc269.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/hda/codecs/realtek/alc269.c
> > b/sound/hda/codecs/realtek/alc269.c
> > --- a/sound/hda/codecs/realtek/alc269.c
> > +++ b/sound/hda/codecs/realtek/alc269.c
> > @@ -7752,6 +7752,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >  	SND_PCI_QUIRK(0x1854, 0x0488, "LG gram 16 (16Z90R)",
> > ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
> >  	SND_PCI_QUIRK(0x1854, 0x0489, "LG gram 16 (16Z90R-A)",
> > ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
> >  	SND_PCI_QUIRK(0x1854, 0x048a, "LG gram 17 (17ZD90R)",
> > ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
> > +	SND_PCI_QUIRK(0x1854, 0x048b, "LG gram 17 (17ZD90R-EX79K)",
> > ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
> >  	SND_PCI_QUIRK(0x1854, 0x05bf, "LG gram 17ZD90S",
> > ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
> >  	SND_PCI_QUIRK(0x1854, 0x05c0, "LG gram 16Z90S",
> > ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
> >  	SND_PCI_QUIRK(0x1854, 0x05c1, "LG gram 14Z90S",
> > ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
> 
> The patch looks malformed (with wrong spaces), likely due to your
> mailer, so it can't be applied cleanly via git-am.
> Please fix your mailer setup, and resubmit the fix.

Never mind, I see that there was another fix submission by Aaron for
the very same device with the same quirk, and it was applied now.


thanks,

Takashi
