Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48567CD6E4A
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:13:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39E61601D8;
	Thu,  4 Jun 2026 10:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39E61601D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780560779;
	bh=4sc9V4ueEtLCxS4NcXrTbUYeps/CN3ywa3SD0lzri2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UrVpj5BfIh4/QiSxiEsX6d3UIcavHWGfEiqn1wpo704XIvw2m36zcU4om2pq77gEk
	 utZuN+nXc2/h7D/8ignQVVpVXLHzjXnF+gBp5YH9nXvYvXfI3Ai7PN/9x4tAI/s+P+
	 QB5lH9xvGFnTUKiq6B28GMB0REXDYg63VDt/KZpg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29D52F805FC; Thu,  4 Jun 2026 10:12:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D10FF805F4;
	Thu,  4 Jun 2026 10:12:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49C17F804CC; Thu,  4 Jun 2026 10:12:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780560734;
	b=eZTFPfLg3j++NhmUTmgSEhEXRSrlNjB++g5Hr3g/TouA6gjn3EUueOgFEFnKp6Yh0WT1
	 6rZHesT23s3Xb0fQ0EHrFTE8oTq16SZkYBLEnCe+ihhTQK5Ltc6rhVnB4zNJNaLz/p4Ag
	 uynUWVUDpQgW6fFnkygbGZMJo9iDQRMhE4eldp09UQ1lAsDTRgf4YtLIXc747XrlPuE0u
	 izJg8PTEyDXkYxOCKF8Ur18KmMBAnBbElZIA93KxFpmXz/+qnQmspreIlqG+VovqmdrUq
	 xHb49W3CkVZ4hoh7g8c70HIP92ieUPHjylmDlwsq5Qsfur77sBt9EHYqc1P7VHiAJmQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780560734;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=4sc9V4ueEtLCxS4NcXrTbUYeps/CN3ywa3SD0lzri2I=;
	b=CbUmfInbLL4+MWzcyLkCry7C1I+qzGUNKqjdtOUYTJ59ON3G0ksCHymeroGif771quM0
	 26crXnfowuWeX7C8kT8WlRJaM93sa3P1S5nkhO/rTd64pYdJlBviAZPMYdgUpQlOYUG+Q
	 gnWyaptslvV72+GHxliGbM0dIVhzUYh500AMWZ/kBOPhSArVNvnKWxr//rLlW3TI+NolN
	 hXAPMnLSYBhkEXZW+VO0q6iVTgZR5dnKSdDciqVCzcWGdA52U5QkdJeWhsPNhuydjBYSI
	 1axs5J6WlYIdpMLt3ZH3qMG6vafMIx65MmVDpEJ0tiV0L20GaTe0Meys/YUxmAt9sjw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=qHUad8U6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=1FB+kS2z;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=qHUad8U6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=1FB+kS2z;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CC08FF8047D
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 10:12:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC08FF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=qHUad8U6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=1FB+kS2z;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=qHUad8U6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=1FB+kS2z
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D21B67E9C;
	Thu,  4 Jun 2026 08:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780560733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nmTmKPIzFq6psKEkJFv3lb1LitlmKjOtaiWWEMmNLI=;
	b=qHUad8U6Xabiyy5cgkE8zAkl495i9//Nh6FjNmn4s+Ea3NV2GP4fG0Kcwap8exHZCM/zjd
	jmwWSKlk+Ln+EZ3XUqmfLBkZRk1kveJkI0keCpSkAbVgrkI4NdMA2VLE9bXR7uodW3SslU
	9RltNLGv6Ocr6UgFHtKI6HnkHNHVf7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780560733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nmTmKPIzFq6psKEkJFv3lb1LitlmKjOtaiWWEMmNLI=;
	b=1FB+kS2z3b4Rj3UQmZbc8pGxPh8H8ZnGS529wgxg8sn0li4TCmzrJcnuP2hO9hcDtudeCb
	KroFHNiFAmUkfCDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1780560733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nmTmKPIzFq6psKEkJFv3lb1LitlmKjOtaiWWEMmNLI=;
	b=qHUad8U6Xabiyy5cgkE8zAkl495i9//Nh6FjNmn4s+Ea3NV2GP4fG0Kcwap8exHZCM/zjd
	jmwWSKlk+Ln+EZ3XUqmfLBkZRk1kveJkI0keCpSkAbVgrkI4NdMA2VLE9bXR7uodW3SslU
	9RltNLGv6Ocr6UgFHtKI6HnkHNHVf7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780560733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nmTmKPIzFq6psKEkJFv3lb1LitlmKjOtaiWWEMmNLI=;
	b=1FB+kS2z3b4Rj3UQmZbc8pGxPh8H8ZnGS529wgxg8sn0li4TCmzrJcnuP2hO9hcDtudeCb
	KroFHNiFAmUkfCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6F47779A8;
	Thu,  4 Jun 2026 08:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2tY2M1wzIWp9fAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Jun 2026 08:12:12 +0000
Date: Thu, 04 Jun 2026 10:12:12 +0200
Message-ID: <87fr32wwpv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-2022-JP?B?GyRCPH4bKEJPY2Vhbg==?= <zhouoceanhy@gmail.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
In-Reply-To: 
 <CACYx1SobX420vGovUv-1WROW-Kh-sPvaFBj0vNfgQnVnDyOeZg@mail.gmail.com>
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
	<87y0h2r3g6.wl-tiwai@suse.de>
	<CACYx1SrnTfg6GKK2S1Vb13f9OWOq1x=VUDA=AFWs1CALsC_B2g@mail.gmail.com>
	<8733z7pv5e.wl-tiwai@suse.de>
	<CACYx1SobX420vGovUv-1WROW-Kh-sPvaFBj0vNfgQnVnDyOeZg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[ocean-sudo];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: LKYIIF6THXPJ3H4AYLYTU5NSWYRZNEPR
X-Message-ID-Hash: LKYIIF6THXPJ3H4AYLYTU5NSWYRZNEPR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LKYIIF6THXPJ3H4AYLYTU5NSWYRZNEPR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 03 Jun 2026 17:08:04 +0200,
周Ocean wrote:
> 
> Hi Takashi,
> 
> Due to size limits on the mailing list, I've compressed the alsa-info
> outputs. Please find them attached.
> 
> 1. alsa-info-with-patch.txt.gz:
> Generated on LTS kernel (6.18.33) with the patch applied via DKMS.
> Under this state, the internal microphone works.
> 
> 2. alsa-info-without-patch.txt.gz:
> Generated on the same kernel with the DKMS patch uninstalled (stock
> driver). The internal microphone does not work in this state.

Thanks.  But I couldn't see the difference about NID 0x14: both with
and without patch show it's connecting to NID 0x1e (index #3).
What am I missing?


Takashi
