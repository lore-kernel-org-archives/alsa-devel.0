Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7AECD8C88
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 12:16:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44402601CE;
	Sun,  7 Jun 2026 14:16:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44402601CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780834609;
	bh=8Ed26BL0hrKtVrcrjh6HjjvNCuD9xxMr9h0ullGb3hs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TmhRqclFaYC8zrLoEnC1688t0j3JXny8qqzaZeyE9YHkOJpagQ/SSOPzEHaJXjSzM
	 9vsCIgepA/aOGn1sNp0MlnHnENmvb38EqlERGjcOJ1TdHlBauqoa0IdoPe7GctS4rs
	 1ttYuv1YKEF4SU3o83cMdcaQjV7tnms2tkhl1bfs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E856F805F7; Sun,  7 Jun 2026 14:16:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0798AF80601;
	Sun,  7 Jun 2026 14:16:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C920DF8055B; Sun,  7 Jun 2026 14:16:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780834562;
	b=Wio3A+58mDJahPyjVxMybRCi6Cwvoa3mPqPDRQKphkY8rd0dtA4b+FeX+bheX1wr59Xr
	 ok5KUeNLHEBA3GKL6kiR69OxlPRJr332/fy9rIktJpa2ZLRqkxJCuHDcHDYHeAsUd5JMS
	 3XAPxT25b7fE0R2Q0xxOw5HjiaXOlYCTc8Nqti4CqbAkKtdafylkYPH+va+IXTOWeI/UU
	 rxZoIOpfW8tUvlibg1BI34ClyXTouLOoSpsrCaEHvA/l48hpoPVcmeSjNE9FLKGkKkNhq
	 qjKelR23wwRTobnRaJ+uIfoGvnc9TFszsJYekjqQIYohHthUCiKQOIm0hzVG06e6Hmw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780834562;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=8Ed26BL0hrKtVrcrjh6HjjvNCuD9xxMr9h0ullGb3hs=;
	b=f9vAucNwcOOWG1i8C1M99j8sQkJtOVzqjQneb8YS5up+zXJ4xkKHw/I51beZYF4LUeG3
	 mmvrjWnFcUAyfBhYyL45mlIh0NKBpleen/coOM0doFH3om058YRBrQed6mA5zqa6Ltk08
	 DgZ0O9Cq+MAIn7Yni9wFeGnA/SCfAiffxG+gZhM7DlpwiTiersvEhLn2ufvTh8u3kbnEs
	 62V8pOaf9vgILrFvkD0ry74APrLvRdDOhXImmWcdT/lWQcRP7G4DcJIiGoZRhwV+RPi3n
	 RsOtXWDtNKAxEgpHtvkzcfeiWTaxz2OOI2nyYUADr3HMs3PIPGMC+FK1qiDErUPeRCg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="Im/HkcYS";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tCBBXnUT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="Im/HkcYS";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tCBBXnUT;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6F871F80087
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 14:16:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F871F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Im/HkcYS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tCBBXnUT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Im/HkcYS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tCBBXnUT
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F27D75E0C;
	Sun,  7 Jun 2026 12:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780834560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rELKWPDozz6eYYreG95e4Ys66VMPl7TnFhtbmj3u/Z4=;
	b=Im/HkcYSfZ8bvMdq/RFyzc1FK7owhXYTo5TLTcvVkIQuHYCOmsnZf/OvYRliU7qHQhh7kB
	TdE6JWQa7oQ+GeJzb/q6Ly1pP+k04l4h4VMGTFHsoRyfIEQFw2Y5CqVAcq18t/RP6HV06i
	nOZVY2b86xU15qRBRqCW/x2HzX3mwx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780834560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rELKWPDozz6eYYreG95e4Ys66VMPl7TnFhtbmj3u/Z4=;
	b=tCBBXnUT7cgBwJhfoiZNOOyX8EXr9vFlQxSZ2+FPw5B4imqT+FQny7wUraUuG96TFJ6aAw
	9I0NzEiq5sSv2bBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Im/HkcYS";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tCBBXnUT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780834560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rELKWPDozz6eYYreG95e4Ys66VMPl7TnFhtbmj3u/Z4=;
	b=Im/HkcYSfZ8bvMdq/RFyzc1FK7owhXYTo5TLTcvVkIQuHYCOmsnZf/OvYRliU7qHQhh7kB
	TdE6JWQa7oQ+GeJzb/q6Ly1pP+k04l4h4VMGTFHsoRyfIEQFw2Y5CqVAcq18t/RP6HV06i
	nOZVY2b86xU15qRBRqCW/x2HzX3mwx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780834560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rELKWPDozz6eYYreG95e4Ys66VMPl7TnFhtbmj3u/Z4=;
	b=tCBBXnUT7cgBwJhfoiZNOOyX8EXr9vFlQxSZ2+FPw5B4imqT+FQny7wUraUuG96TFJ6aAw
	9I0NzEiq5sSv2bBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EF1B779A7;
	Sun,  7 Jun 2026 12:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GLGeDQBhJWreRwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 07 Jun 2026 12:16:00 +0000
Date: Sun, 07 Jun 2026 14:15:59 +0200
Message-ID: <875x3usg00.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-2022-JP?B?GyRCPH4bKEJPY2Vhbg==?= <zhouoceanhy@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
In-Reply-To: 
 <CACYx1SqT5sL7MpsjnB16dPwhjyvhzjL3M0E6-ka0Rn-cSgqiqA@mail.gmail.com>
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
	<87y0h2r3g6.wl-tiwai@suse.de>
	<CACYx1SrnTfg6GKK2S1Vb13f9OWOq1x=VUDA=AFWs1CALsC_B2g@mail.gmail.com>
	<8733z7pv5e.wl-tiwai@suse.de>
	<CACYx1SobX420vGovUv-1WROW-Kh-sPvaFBj0vNfgQnVnDyOeZg@mail.gmail.com>
	<87fr32wwpv.wl-tiwai@suse.de>
	<CACYx1SqT5sL7MpsjnB16dPwhjyvhzjL3M0E6-ka0Rn-cSgqiqA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[ocean-sudo];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6F27D75E0C
Message-ID-Hash: LAHMAXZS5PHFT3KQUZP4CSLBDZHESOQD
X-Message-ID-Hash: LAHMAXZS5PHFT3KQUZP4CSLBDZHESOQD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LAHMAXZS5PHFT3KQUZP4CSLBDZHESOQD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 06 Jun 2026 16:19:26 +0200,
周Ocean wrote:
> 
> Hi Takashi,
> 
> To be honest, I'm not an expert on the low-level hardware design of
> this codec, but I can confirm that the internal microphone only works
> normally when we apply this patch.
> 
> I realized why the previous two dumps were identical: the user-space
> audio server (PipeWire) automatically restored the routing and
> switched NID 0x14 to NID 0x1e (index 3) at runtime, masking the actual
> boot defaults.
> 
> This time, I stopped PipeWire entirely, reloaded the stock driver, and
> captured the true hardware defaults. Please find the new logs
> attached:
> 
> 1. alsa-info-raw-defaults.txt.gz (Stock driver, pure hardware defaults):
> Here, NID 0x14 actually defaults to NID 0x1b (index 1, Rear Mic) on boot:
>    Connection: 4
>       0x1a 0x1b* 0x1d 0x1e
> 
> 2. alsa-info-with-patch.txt.gz (Patched driver):
> Here, the quirk forces it to NID 0x1e (index 3, Internal Mic) at initialization:
>    Connection: 4
>       0x1a 0x1b 0x1d 0x1e*
> 
> Without the patch, testing the microphone in the stock driver yields a
> loud buzzing/humming noise (typical of a floating/unconnected input
> pin on NID 0x1b) with only a very faint sound when tapping the chassis
> (due to signal crosstalk/leakage from NID 0x1e to NID 0x1b). Even if
> PipeWire switches the connection to 0x1e at runtime later, it fails to
> record normal sound.
> 
> Applying the quirk at ACT_INIT ensures NID 0x14 is correctly mapped to
> the physical internal mic pin (0x1e) from boot, resolving the floating
> pin noise and restoring mic capture to a normal level.

Looking at your alsa-info.sh outputs, it shows that the rear mic jack
is plugged:

        control.17 {
                iface CARD
                name 'Rear Mic Jack'
                value true
                comment {
                        access read
                        type BOOLEAN
                        count 1
                }
        }

so the driver makes ADC 0x14 connected to 0x1b, which is the pin
for the rear mic.

If you get a noise from it, it means that something wrong with that
route.


Takashi
