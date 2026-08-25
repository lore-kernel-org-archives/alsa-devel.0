Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0036FC61DBE
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:05:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41029602A9;
	Tue, 25 Aug 2026 13:05:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41029602A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787655921;
	bh=XAmRwKy6rqYYQtXykzmNGd8JW9mpq45ymIPfFe2oVEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=H983y7blCNTuFNPdmKOPAkEyGHh7KSgRzu/WBww+GVadbPnBnclwOgjDu2qVYvDPf
	 MtMbWpBlw3B1K6jwT8a5y/lVXN3TbGL4exDY2pW9Nxa9jfl1T2vfZufPHfZXAdo7cT
	 oSKJ+CVg7HFBtv1+vv/+JkHBfySGbW3jFuziWiEg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5936DF805F5; Tue, 25 Aug 2026 13:04:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2083F805FF;
	Tue, 25 Aug 2026 13:04:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 281ABF8027B; Tue, 25 Aug 2026 13:04:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787655871;
	b=m1QyxQj6PUxdu4ZS7LXDqgLM7HynR3kLMfUbMSsWhNqcfHsldhIE49PwyGjyr5aqoyJN
	 CI5r8ArfH0sN4Oz6KS6WLqg/ycuGS6WUMTAvKHfOQP7i7QSQi9SyLeaMvqdGZ3jR8mFNj
	 ko1I2JN07gwAavBzclDVC2mQPcFqZ9O8xOKe0AJwg6hpL6ADyUEkZBCThj0saKNCuxU3H
	 PTU1aOqXnursImNRkOMlbk3QoOEyUsGG8PKNUJWURPQITtDdi7MADbYmpMgDbFjtZRazk
	 DwQxUVSJ501716RLRI4EQ9ixfWMnHUyasnykXju9UTJu1COyFwtE2lK509HW/Lnl2ZQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787655871;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=XAmRwKy6rqYYQtXykzmNGd8JW9mpq45ymIPfFe2oVEs=;
	b=jJd/8r4/AyOb3ZWGXezW1QJ68ytXK3UMjyFfXAzfqMRQ+i61hqgbgpaNIrXCRmyjbDHp
	 Mrh01eSPBgPnCu1+E8SWUn+Ith4zvIMjIIyZFkY2mkeRcnnIVEgukxBucgG/2/yF+Pu0+
	 H2EVe4UjaoRV15adCbxxhPRQsSMH9v3DekowED7mRJCdw177gv2E9gbBZ/MBprkXtU6QT
	 fIOJ3hvgnf7OilNcLUzkROE1EpbxDy3eP103yBDBci4tImisQBAnnUalGq/3vE7P2iHRz
	 QtpToRE/XUoe1PN9igDJpeSsEyp1wkwEkHujFDKe6Oy1z6lCwXREPAZaWIUwq4X5Z0Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=doxY1tPY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=66kSnQlL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xQfY8VTl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gzM9SEEE;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 028B2F80075
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2026 13:04:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 028B2F80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=doxY1tPY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=66kSnQlL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=xQfY8VTl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gzM9SEEE
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6C771F7CB;
	Tue, 25 Aug 2026 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787655865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSSIo+D6ZbvIE/2dhkB6WSMQs/S1gZ+yCG8xQ8agXjc=;
	b=doxY1tPYv2xxmJoauQCo1iDEpnrawAGzjgpdOGUjo1B2CdIs8Vqq4Bgep2RB44+5/0QEhp
	CGr6P+32AMFNwOCpFlHa/oyGjNODG+p0O/HvMg9gCQQCJIul1y2aKsSTYVL+KdySiSzUb5
	dxowaUGRe6F51FRJFCq2h2EuQluKvv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787655865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSSIo+D6ZbvIE/2dhkB6WSMQs/S1gZ+yCG8xQ8agXjc=;
	b=66kSnQlLEbcmHgtVF/26bxRp0Wrwazjuu4MJGM1E0Elt5bWpFwJkEMZVmP2gDAb2Y9vWb9
	Vr1kImJRzfrqjyAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xQfY8VTl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gzM9SEEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787655860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSSIo+D6ZbvIE/2dhkB6WSMQs/S1gZ+yCG8xQ8agXjc=;
	b=xQfY8VTlnpCRkahFrCZskzcqAKjdEU0oSuT4ho8oE18KcrWYIh3SXhmfxlRt6PEaILL/rA
	g3vg30x6L6r6NOjNbYymchHtETXBJW+HscGjJSBg1u+DtdKFHA1yMDdo7ecx74Pkh5km2m
	4luufPKR7uoVmZrhJghqUg1dyDC8pDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787655860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSSIo+D6ZbvIE/2dhkB6WSMQs/S1gZ+yCG8xQ8agXjc=;
	b=gzM9SEEE09eMrcZl6py0XN//ZYxD4H63tmsURgAIT/eWoiTqQAFakvyyFOeN22cy+ncdCl
	IhHObht9vrohmRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC69C13332;
	Tue, 25 Aug 2026 11:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2CtxKbR2jWraKAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Aug 2026 11:04:20 +0000
Date: Tue, 25 Aug 2026 13:04:20 +0200
Message-ID: <87qzjmsbpn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?=22Habil_Eren_T=FCrker=22?= <habilerenturker@gmail.com>
Cc: perex@perex.cz,	tiwai@suse.com,	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,	Habil Eren =?ISO-8859-1?Q?T=FCrker?=
 <habilerenturker@hotmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Fix speaker mute LED for HP Laptop
 15-fd0039nt
In-Reply-To: <20260825084125.4103-1-habilerenturker@hotmail.com>
References: <20260825084125.4103-1-habilerenturker@hotmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,alsa-project.org,vger.kernel.org,hotmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C6C771F7CB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: 7LPITAL7KDVKSBU22LKF6W4UJQYSRXZJ
X-Message-ID-Hash: 7LPITAL7KDVKSBU22LKF6W4UJQYSRXZJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7LPITAL7KDVKSBU22LKF6W4UJQYSRXZJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 25 Aug 2026 10:40:14 +0200,
Habil Eren Türker wrote:
> 
> HP Laptop 15-fd0039nt (SSID 103c:8bb6) needs a quirk to control the
> speaker mute LED via VREF100 on NID 0x1a (active-high).
> 
> This patch replaces the previous ALC236_FIXUP_HP_MICMUTE_LED_ONLY
> with ALC236_FIXUP_HP_15_FD0XXX, which covers both mic mute (GPIO0)
> and speaker mute (NID 0x1a) LEDs.
> 
> Use spec->no_shutup_pins instead of a custom shutup hook, as suggested
> by Takashi Iwai.
> 
> Fixes: e711ebfadc9a ("ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt")
> Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
> Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>

Applied now.  Thanks.


Takashi
