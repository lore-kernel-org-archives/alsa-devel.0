Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D39CD4F54
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 05:22:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B61B60260;
	Wed, 27 May 2026 07:22:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B61B60260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779859344;
	bh=CyUfvyAe8/iBQxSLGVglKImb7m7yi4beB3AS35+xuFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m7+Seff7LJr9fu3nIpsDUlUs5F6I5dmY7IXkTETc9hXsr1KkHnJJaLztXyUhpfitF
	 SOwZceI0OcdYrWwZor1fE2S+SKvVLer0qoa53hkbmTKfLYPT526eKCcJy+MdflCOzf
	 ZfGaF2tl2zJMICZlqsCM6YJLHzRVhjWtvg2TxUKw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 143D8F805F7; Wed, 27 May 2026 07:21:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 25856F805F3;
	Wed, 27 May 2026 07:21:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FDC0F804FF; Wed, 27 May 2026 07:21:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3AF5DF800BD
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 07:21:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AF5DF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=neMCyChJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X8SOAumT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=neMCyChJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X8SOAumT
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 643F166D0E;
	Wed, 27 May 2026 05:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779859296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fESrUN6LeMWzm+TXX2AR1MycW2BdFQSdRjh9Uwl3E4E=;
	b=neMCyChJpEN0QmhorxqRtVsj/QArroe1xd53GwbFi/QNSX+0Cy63nTOYVe6rTJhpuOuqQg
	vXj4SciexGcNCzk2bUyO0MnuJ88vaHt7sI20XMGNpfaDvnHjq3UCVsHP1yzyrSX9dx64uA
	89P7H1ztefoPEOiLSyTxcqadiJSixHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779859296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fESrUN6LeMWzm+TXX2AR1MycW2BdFQSdRjh9Uwl3E4E=;
	b=X8SOAumTfVOQsanORH06/kVpGsGBXuPZRDi7s+Ohi22E9seKfc/1alBWFXT6Pce533qqFV
	ZBUfY1HlrrdqFqAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1779859296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fESrUN6LeMWzm+TXX2AR1MycW2BdFQSdRjh9Uwl3E4E=;
	b=neMCyChJpEN0QmhorxqRtVsj/QArroe1xd53GwbFi/QNSX+0Cy63nTOYVe6rTJhpuOuqQg
	vXj4SciexGcNCzk2bUyO0MnuJ88vaHt7sI20XMGNpfaDvnHjq3UCVsHP1yzyrSX9dx64uA
	89P7H1ztefoPEOiLSyTxcqadiJSixHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779859296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fESrUN6LeMWzm+TXX2AR1MycW2BdFQSdRjh9Uwl3E4E=;
	b=X8SOAumTfVOQsanORH06/kVpGsGBXuPZRDi7s+Ohi22E9seKfc/1alBWFXT6Pce533qqFV
	ZBUfY1HlrrdqFqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33F0B5A661;
	Wed, 27 May 2026 05:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nyQxC2B/Fmo+EgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 27 May 2026 05:21:36 +0000
Date: Wed, 27 May 2026 07:21:35 +0200
Message-ID: <87zf1lwhpc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jakub Pisarczyk <pisarz77@gmail.com>
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/cs420x: Add CS4208 fixup for iMac16,1
In-Reply-To: <20260526201830.34097-1-pisarz77@gmail.com>
References: <20260526201830.34097-1-pisarz77@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: WM4F7AMNBSH25RABQWZ4IPPBIIG5L2CU
X-Message-ID-Hash: WM4F7AMNBSH25RABQWZ4IPPBIIG5L2CU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WM4F7AMNBSH25RABQWZ4IPPBIIG5L2CU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 26 May 2026 22:18:30 +0200,
Jakub Pisarczyk wrote:
> 
> The 21.5" Retina 4K iMac (Late 2015, DMI product name "iMac16,1") ships
> with a Cirrus Logic CS4208 codec wired to an external speaker amplifier
> enabled through codec GPIO0 -- the same arrangement as the late-2013
> MacBookPro 11,x. Without a matching entry in cs4208_mac_fixup_tbl[] the
> fixup picker logs:
> 
>     snd_hda_codec_cs420x hdaudioC1D0: CS4208: picked fixup  for codec SSID 106b:0000
> 
> i.e. an empty fixup name, GPIO0 stays low, the external amp is never
> powered up, and the internal speakers are silent on a stock kernel.
> 
> The codec SSID reported by hardware is 0x106b:0x7f00. Reusing CS4208_MBP11
> (GPIO0 + SPDIF switch fixup) makes the internal speakers and S/PDIF
> output work out of the box, removing the need for users to set
> `options snd_hda_intel model=mbp11` via /etc/modprobe.d/.
> 
> Tested on iMac16,1 (kernel 6.17.0): four internal drivers
> (Left tweeter, Left woofer, Right tweeter, Right woofer, exposed as the
> 4 channels of the analog-surround-40 ALSA profile) produce audio after
> the fixup is applied.
> 
> Signed-off-by: Jakub Pisarczyk <pisarz77@gmail.com>

Applied now.  Thanks.


Takashi
