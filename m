Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE3510ED659
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:51:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5D6B601F9;
	Fri, 27 Mar 2026 12:51:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5D6B601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774612312;
	bh=kzjAEUvkMjvpv78hcFUxbGThvB95gNAb/RkeSOko4es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=R0zjAIrkqRaRj6ysCAGH9X/kxpYoLrch8evLlxJ/e23nfupyz37R6zpyftFwVmjBx
	 ZpQzzJ3EziUL5gH5yugrFkcPrvpJ2C2YIdm9YA9RljrkDwgSTYwS25TSdB4hHedSId
	 omNyAp0HhJ0Urv2ErJgpB+8yeBd16PMQ/eACG6oA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BDD3F805E9; Fri, 27 Mar 2026 12:51:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 82796F804F3;
	Fri, 27 Mar 2026 12:51:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E211F804F3; Fri, 27 Mar 2026 12:51:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B8939F80212
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 12:51:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8939F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=isBTN6SS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dkEIjbP6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=isBTN6SS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dkEIjbP6
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D23DD5BDD3;
	Fri, 27 Mar 2026 11:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774612262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pu8ZrwCQBsR/S4n0BmOH3L0vRXe/z5yr9yLEn2NKKPQ=;
	b=isBTN6SSyKSLAF+ADQQW6ngtSIJQDqM890zXZSc+ZsnxsnWh2f+7oG63znSQ7iN4X+QxJU
	zlyjToiWTN1208k40euCUbrkXUwfHLOLIIxrbGToPIs7H9cWFr3Q7UTIB96+IIyWAZWrL8
	MYSVL3iihmGB26bMUenaSJdSrs4++o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774612262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pu8ZrwCQBsR/S4n0BmOH3L0vRXe/z5yr9yLEn2NKKPQ=;
	b=dkEIjbP6sALffG7SjUX2XcpLObOBT9MjM6qjKBXWQM3XeaxliExzM2AIVK9LWE5q/QiehJ
	iiX51TIW220TLxBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774612262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pu8ZrwCQBsR/S4n0BmOH3L0vRXe/z5yr9yLEn2NKKPQ=;
	b=isBTN6SSyKSLAF+ADQQW6ngtSIJQDqM890zXZSc+ZsnxsnWh2f+7oG63znSQ7iN4X+QxJU
	zlyjToiWTN1208k40euCUbrkXUwfHLOLIIxrbGToPIs7H9cWFr3Q7UTIB96+IIyWAZWrL8
	MYSVL3iihmGB26bMUenaSJdSrs4++o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774612262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pu8ZrwCQBsR/S4n0BmOH3L0vRXe/z5yr9yLEn2NKKPQ=;
	b=dkEIjbP6sALffG7SjUX2XcpLObOBT9MjM6qjKBXWQM3XeaxliExzM2AIVK9LWE5q/QiehJ
	iiX51TIW220TLxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DB754A0A2;
	Fri, 27 Mar 2026 11:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ivM0JSZvxmlYMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 11:51:02 +0000
Date: Fri, 27 Mar 2026 12:51:02 +0100
Message-ID: <87mrztqymx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Robert Viren <robviren@gmail.com>,
	<amadeuszx.slawinski@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>,
	<tiwai@suse.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: Regression =?ISO-2022-JP?B?Ni44GyRCIiobKEI2LjE3Og==?=
 snd_soc_avs claims HDA device instead of snd_hda_intel, fails on missing
 topology firmware
In-Reply-To: <f082905a-614e-4096-8408-4dc459260047@intel.com>
References: 
 <CAC5iJJZCHm8a_jP+7nQpp4aqn_EE7JmMdPJBbu83QSBjgqZ49g@mail.gmail.com>
	<40777346-28d4-456c-af4e-cb868d8b8ac5@intel.com>
	<CAC5iJJbaG4boDEO6V5wOuJYiFdZauEdS47PSg-g0Gc1CrxnC4Q@mail.gmail.com>
	<f082905a-614e-4096-8408-4dc459260047@intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,suse.com,alsa-project.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: NCPLGSX7VHGY4YBZ435CHJXEO46MU6IC
X-Message-ID-Hash: NCPLGSX7VHGY4YBZ435CHJXEO46MU6IC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NCPLGSX7VHGY4YBZ435CHJXEO46MU6IC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 24 Mar 2026 12:38:10 +0100,
Cezary Rojewski wrote:
> 
> On 2026-03-24 12:25 PM, Robert Viren wrote:
> > Found a workaround. Blacklisting snd_soc_avs restores correct
> > behaviour. Command outputs and bugzilla below.
> > 
> > cat /sys/module/snd_intel_dspcfg/parameters/dsp_driver
> > 0
> > 
> >   ls /sys/firmware/acpi/tables/ | grep NHLT
> > NHLT
> > 
> > sudo cat /sys/firmware/acpi/tables/NHLT > ~/NHLT.dat (I attached it to
> > the bugzilla. 45 bytes)
> > https://bugzilla.kernel.org/show_bug.cgi?id=221277
> 
> Thank you for opening the ticket. I've replied there. Things looks
> clearer though - looks to me like a regression caused by some recent
> changes in intel-dspcfg area. For non-DSP configurations, the first
> choice should be snd_hda_intel.

I guess it's fixed in the more recent version of kernel via the commit
161a0c617ab1 ("ALSA: hda: intel-dsp-config: Prefer legacy driver as
fallback")?

IIUC, this sort of problem surfaced because of the recent HD-audio
code restructuring.  The commit above clarifies which driver is used
for fallback, and it casually "worked" in the past.


thanks,

Takashi
