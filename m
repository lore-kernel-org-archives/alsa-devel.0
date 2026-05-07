Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06413CD343F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2026 10:50:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BF6660226;
	Thu,  7 May 2026 12:50:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BF6660226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778151048;
	bh=R/bOe6GRUw3HKwAMrMd0f6ho9ZRiHRqS0NwsI0hEn6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BPf6cNux+TY2glCO5x8eJXBOQdhF5iii0w38O3xtp/Am2L5Ma8iePt+vCVZX0b4vH
	 PCfYsinCqnl6J6m2LYYqAsW7VlVqCM6zHHUdiaFtKXDgOTcfQqcEZminqaX+Pcq3sR
	 OvsXcCzZ95FoyYlkAWwGcNUeBaqYC/X+1apUUsTU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4CC88F805F4; Thu,  7 May 2026 12:50:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0775F805EF;
	Thu,  7 May 2026 12:50:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBDDFF80518; Thu,  7 May 2026 12:50:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BBF6DF800BA
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 12:50:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBF6DF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=qsya+5FS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=JQ6rzE0S;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=DkKIlvUJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=eHbkZq26
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C965A5D65F;
	Thu,  7 May 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778151001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNJvW1ccmC/eSovonjwfDKjh+zgxNdXw6AiBXkutHh4=;
	b=qsya+5FSZGa4SqL6Vyhsqr6EdwCKB2Uep5ibLcBGEhMnCW3Z2gRPYSfCF8ydDBQKsb2PXh
	O3Bg7Hprp/O4xGIBUckMeqseUHph+5M7Zc7VuRbaBIfgGaCNlKg/vtqBWsYIo2ArsJRY4i
	W2BaIeazYeJC53RFwSOBReWipsjxvRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778151001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNJvW1ccmC/eSovonjwfDKjh+zgxNdXw6AiBXkutHh4=;
	b=JQ6rzE0SoEziPEL9zxTBmYcUJ4odyGdpDsvjql45Xw+7LtXkGP9v4K85UC4yWNgje7htAQ
	DniGBgsRxsQZkzAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DkKIlvUJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eHbkZq26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1778151000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNJvW1ccmC/eSovonjwfDKjh+zgxNdXw6AiBXkutHh4=;
	b=DkKIlvUJYzjJ5CuHe2QF/5ciCiHvGy5/FZG6s4KALjgtPFwirD39PlYfnt4Oco/BZpZ5Xs
	l1wVaC7hGLDXN96MMIsN6x4SW7DwCFtn9L2PdNr2dFxsi3OeuHs4ef2NRcMKcd1DTzbYZ2
	MdXX80sB4KEztwMOQNNsxye6ceuvMgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778151000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNJvW1ccmC/eSovonjwfDKjh+zgxNdXw6AiBXkutHh4=;
	b=eHbkZq269tBafhZYQDyEZEHhTGPzT3dJ9ijOmAm0DDPQJr4ZWxmhoS8aEkx/GoTKLXcasa
	2uDuGB/bH6UvXfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA924593A7;
	Thu,  7 May 2026 10:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iV9hKFhu/GnSVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 07 May 2026 10:50:00 +0000
Date: Thu, 07 May 2026 12:50:00 +0200
Message-ID: <878q9vqysn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?R=E1mon?= van Raaij <ramon@vanraaij.eu>
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add codec SSID quirk for Lenovo Yoga
 Pro 9 16IMH9 (17aa:38d5)
In-Reply-To: <20260506183118.patch1-ramon@vanraaij.eu>
References: <20260506183118.patch1-ramon@vanraaij.eu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C965A5D65F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Message-ID-Hash: X5XZICCB7RKOM2CUN5IA5QJJD525RQGU
X-Message-ID-Hash: X5XZICCB7RKOM2CUN5IA5QJJD525RQGU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X5XZICCB7RKOM2CUN5IA5QJJD525RQGU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 06 May 2026 20:31:18 +0200,
Rámon van Raaij wrote:
> 
> Some Lenovo Yoga Pro 9 16IMH9 units carry codec SSID 17aa:38d5 instead
> of 17aa:38d6, which was added in commit 56722cfbb78d ("ALSA: hda/realtek:
> Add codec SSID quirk for Lenovo Yoga Pro 9 16IMH9"). The corresponding
> firmware blob TAS2XXX38D5.bin already ships in linux-firmware, and the
> hardware is otherwise identical: same PCI subsystem ID 17aa:3811 shared
> with the Legion S7 15IMH05, same TI TAS2781 amplifiers behind ACPI HID
> TIAS2781, same ALC287_FIXUP_TAS2781_I2C requirement.
> 
> Add a second HDA_CODEC_QUIRK entry directly above the existing 17aa:38d6
> entry so both variants resolve to the correct fixup. Reported and
> verified on hardware by GitHub user 0xEthamin.
> 
> Link: https://github.com/ramonvanraaij/yoga9-tas2781-hda/issues/1
> Signed-off-by: Rámon van Raaij <ramon@vanraaij.eu>

Applied now.  Thanks.


Takashi
