Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1EFC43458
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:34:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA98460209;
	Thu,  9 Jul 2026 09:33:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA98460209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783582440;
	bh=wTLjXs0Nq8Y27Hc/+8MSmwGiya4rn1iB7UYpif8d5FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HjGKjDCeMfQxmvjhQ37orKA+4XcV8LJR4bnOEHnT9CCtacryfzgpC7j8pIhw5yIIY
	 PPkPm3pfvCaxQ/ev5QutcTzx463/XBv94Pf+fA/8xZsvBjxozCgtAWuJYNOQu3/ibC
	 Z0RrZqef0G43CNNWlMW7/S+SMDeoxe3xaO8dbVaM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E678F805F6; Thu,  9 Jul 2026 09:33:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 38449F805FF;
	Thu,  9 Jul 2026 09:33:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 293BDF80495; Thu,  9 Jul 2026 09:33:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783582393;
	b=jBYxyCFcwBAJTiPPaZJMcuBIQj9yZdT+vSaTCF1kqnlprBzSNESSGch6a8389H4Ex0sb
	 NMDl89jpLUXU2s0lvomxkVEM7qajb2Wfk0H5uvex5zQ3R6PL1hfkjCN64/V4jilFRu3LE
	 RVybTUqIx1rLlSK490HnvnWidY+Nd6KFRVhiyW4rY3OwdCUNmiAoZ0dPbDujBHOnCOEWK
	 hw1gbd4b+86t0bhxVBk0NzH1fvbepZx92kU3AuL5613V/AWrepN0BKDYZLawJdOY+rs1E
	 GxF2VbaCwcu6sEcRt+GAoo6ldIC1bOywWU4dGDLF3hRi4j1blphoWvFBdvj370c6TXw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783582393;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=wTLjXs0Nq8Y27Hc/+8MSmwGiya4rn1iB7UYpif8d5FY=;
	b=glVar+h6MBqd7TrXFLuaDfGU8rAcXJ2F4CNYnZZD71p87tvhfgmFU1J1RGwjGOmfyxk6
	 6itwv0wz6Y6xZyb3w9ZmBlFWgRaoenuH2evnMrTZsqRDC/Yt7jvQQjI0giPBVUBGCGGLe
	 Wr1aR+098lA5gJckjlN2my2XkugAVjNsKsoqqAIpl91eYznV/EqdS5kXF24d3YKxdpf7X
	 0Pa7k150YnoKkNBvZKcR9LvVBKB0qWtleSPeGf1zkTlokkjBl5JD1KSbX5xxNb/7D9uOa
	 m+c05kBJ7T0xqJgT0lyCM66MQvA+BraUFUwMDZLZBpBJ3CcCLmmQct9VfA0gnPX8ftw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=zSme6V2x;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=DzEguJED;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Y6kdwrz8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PuEAcvji;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BACD9F800C1
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 09:33:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BACD9F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=zSme6V2x;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=DzEguJED;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Y6kdwrz8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=PuEAcvji
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CADAA75D54;
	Thu,  9 Jul 2026 07:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783582392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz1L/hb9xwGVV1iOjLn7rr9iar5Ha7VOtnV+jCCHEe4=;
	b=zSme6V2xv54SKNVxgFyc9fuXq6a3YNOWr1cvOz6S1kC9EZ8ulji52YxzNWgxFM21IbDjrl
	CXpJdYxh2x6JRWBIbAVVwMop7sgGr2QJSIT9c93/m/HFCuKKOSB4gShXlem8eDQcOLt6ZE
	BngvTTE4c0v/1F8nZwZdPdMPODBJ63A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783582392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz1L/hb9xwGVV1iOjLn7rr9iar5Ha7VOtnV+jCCHEe4=;
	b=DzEguJED/4VpYAKGuUCwblzJwahGxhOX9VnfSO1bTfUGYA4TLi50crTNUcSJuJSs9K2tmL
	++BKg+jPEYEvFZCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783582390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz1L/hb9xwGVV1iOjLn7rr9iar5Ha7VOtnV+jCCHEe4=;
	b=Y6kdwrz8XaCBezVCCYQm+Ne9CeLQ2H9LT5svEbV7IbLO4gVmBV3jHnAcUYAK0W0Cb2Q5vB
	ZcZszbEgfUG7C5BXFZWFbzWM37qHNPwtYwIkEqDkk4Gioja8xCmlVLt75mKTt0EVIJyePG
	8hTX96/qlQWhKdY530ho7pR5Mzp8tGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783582390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz1L/hb9xwGVV1iOjLn7rr9iar5Ha7VOtnV+jCCHEe4=;
	b=PuEAcvjib+0LKZabgB/6aACkTwdf6nhseHErdWyGethQDKUQl09lqOyd8VE1BfYYgr/i81
	97QstGnPiSfHMLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4839779AA;
	Thu,  9 Jul 2026 07:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wqdoJrZOT2pYTQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 09 Jul 2026 07:33:10 +0000
Date: Thu, 09 Jul 2026 09:33:10 +0200
Message-ID: <87bjcg4nyh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jussi Laako <jussi@sonarnerd.net>
Cc: Salvador Blaya <tiniebla6@gmail.com>,
	alsa-devel@alsa-project.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] snd-usb-audio: commit da3a7efff64e ("ALSA:
 usb-audio: Update for native DSD support quirks") breaks DSD playback on
 Musical Fidelity M6s DAC (2772:0502), plays ~8.8% fast
In-Reply-To: <4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
References: 
 <CAOdyq+qFaqCh=tK_wNnA64hv5pQuA1Y09ANxQ=xK8yR-t4mf9Q@mail.gmail.com>
	<4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org,lists.linux.dev];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: QRTCGT3UHLSTKETJAI5OMNA72OVN2VXK
X-Message-ID-Hash: QRTCGT3UHLSTKETJAI5OMNA72OVN2VXK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QRTCGT3UHLSTKETJAI5OMNA72OVN2VXK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 09 Jul 2026 00:28:00 +0200,
Jussi Laako wrote:
> 
> Hi,
> 
> I don¢t think we currently have exclusion method for devices with buggy firmware, which claim to support native DSD, but do it incorrectly. And reverting with device specific white-listing is not a good approach for future maintenance. Having to device-specific white-list each new device appearing on the market from the manufacturer just because some old device is broken is not really a sustainable model.

While I fully agree that white-listing all needed devices won't scale,
blacklisting the broken device might work.  We can an empty quirk
entry for 2772:0502 for skipping the vendor match, something like
below, as an ad hoc fix.

Though, this blindly assumes that there aren't so many broken devices,
and there will be no firmware fix or another model that works with the
same ID.  If a model is relatively new and/or the vendor often updates
the firmware, such an entry can be risky, too.


thanks,

Takashi

-- 8< --
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2463,6 +2463,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x2772, 0x0502, /* Musical Fidelity M6s DAC */
+		   0), /* for avoiding QUIRK_FLAG_DSD_RAW with vendor match */
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. BE02T */
