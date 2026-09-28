Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B92CA5FA2
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:44:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1CCB601F0;
	Mon, 28 Sep 2026 14:43:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1CCB601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790599440;
	bh=U9J8QxpeE8PDQeH5k/d9GG0FsGa7738Dj0RgolaZ6Tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hHY6myMvR6KQ17dWJlu/GpyTaDQsD2F+lsBsHg+lED+++pqUfREFHePK0LT6yp5dX
	 gowwzK6iS3aL8dtsdalOYP8qg4k+wSmSdBpTwLte97IuvvBF+ackEF2ua4x7eC5sSz
	 f/vfj2l3fAFC70GV9Dawhv0WExacStsW3Qm8xeZc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1C02F80602; Mon, 28 Sep 2026 14:43:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B329AF805FC;
	Mon, 28 Sep 2026 14:43:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B25B6F80525; Mon, 28 Sep 2026 14:43:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790599399;
	b=jdsExlng7t+Jlq4GQGJZgkbjBw1rXDrDaO4tBrOPiTGiM2szUsQX5tXOBVkpSkoPlMDF
	 2wHxAseznLMAbh050/6n20RfTPV0L/JYWD5BhaY955qE1jE0FwwixEyjFsmGhV6z6NoWR
	 rk9JQhZO07UWoyshL5v6I3d3G9IWF/4t5Tcfk5KunvHTqataLA7BFo8qyvjYr+S0WVFAS
	 mXgFtvsvJ/TvKLqoH4Q5WCdVFC9qAVt51Y9u3UB9AwI7G4UpIxd5Yp3iTZVVPXApSyZ3V
	 9SJD7wgb9nHLXucC3RvkbGXlIjaVDEKWJxRkFmJxu/qIcPLpiInHOpjPFVJCHnNw2fg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790599399;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=U9J8QxpeE8PDQeH5k/d9GG0FsGa7738Dj0RgolaZ6Tw=;
	b=KQnxTnTVUDPLk+iRMtdoRzCl1J5+M8+QW6wi/P5rVaNKEeL+51A5bA/MjKThibuK3sdn
	 p777BUL/jt6KVVc6gxefb0DlClIFyUGluS9h5gkzlwCd9zIo4GqtM3KYnpRksouFE9/mZ
	 8QweG+c+eHYfU2UCaJSQz+8Cybsv2G/LAgm1Hr/6/xMIDvWCR1SoCTKNNj7ipiUGWZb35
	 iGOZ/2tjoF/kik0I9o0l7Jm7Wu1QATzzhvnersozh4dBvE/rmHDBeYg5/ZxqClC1lV5uZ
	 pBvtDkgp6QvAirgyOnZ4lKm/R6ZYb56r6NS0DSfCC9C9BHgtBEiI/o8nUB9UCohwCUw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ggOioW5R;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=02FZzmPF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ggOioW5R;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=02FZzmPF;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0BD33F80301
	for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2026 14:43:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BD33F80301
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ggOioW5R;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=02FZzmPF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ggOioW5R;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=02FZzmPF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D1DB22378;
	Mon, 28 Sep 2026 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790599397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPZ0ERH5Jb9obfecp1CFdw4dwySeaHEPlA48z+PTBuw=;
	b=ggOioW5REmh2vMK7ZMoDiTiibWCX74uprI7J/7NWw8YIEpAuwAHhtpQYYtStoP+rfOpyFq
	HVN6E/V+fzYBZbLDtfVOzoqgFNT5DvEFfjOYSf3drnGWvg0xeQ8qNvIEAYFkxeTUIUE/fi
	33iMZqWSpWp+3qQ000kkGjk+pSh8w6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790599397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPZ0ERH5Jb9obfecp1CFdw4dwySeaHEPlA48z+PTBuw=;
	b=02FZzmPFJ8Dar5oRHG1nu//xlpvrZb8gRomiN2gZIsNrAzLmppdWaqwbKxSt8BcrpsyScT
	0EAqDhLvHvYdD4BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790599397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPZ0ERH5Jb9obfecp1CFdw4dwySeaHEPlA48z+PTBuw=;
	b=ggOioW5REmh2vMK7ZMoDiTiibWCX74uprI7J/7NWw8YIEpAuwAHhtpQYYtStoP+rfOpyFq
	HVN6E/V+fzYBZbLDtfVOzoqgFNT5DvEFfjOYSf3drnGWvg0xeQ8qNvIEAYFkxeTUIUE/fi
	33iMZqWSpWp+3qQ000kkGjk+pSh8w6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790599397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPZ0ERH5Jb9obfecp1CFdw4dwySeaHEPlA48z+PTBuw=;
	b=02FZzmPFJ8Dar5oRHG1nu//xlpvrZb8gRomiN2gZIsNrAzLmppdWaqwbKxSt8BcrpsyScT
	0EAqDhLvHvYdD4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 142F7133F1;
	Mon, 28 Sep 2026 12:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4340N+RgumqRCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 12:43:17 +0000
Date: Mon, 28 Sep 2026 14:43:16 +0200
Message-ID: <877bk55yxn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	" (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
Subject: Re: Add headset mode
In-Reply-To: <3c251e40a2944ae4ae479e4c2e4e63a4@realtek.com>
References: <3c251e40a2944ae4ae479e4c2e4e63a4@realtek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: RYJOZER46QIE2PQF4ICNDQTRWXID3HXP
X-Message-ID-Hash: RYJOZER46QIE2PQF4ICNDQTRWXID3HXP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RYJOZER46QIE2PQF4ICNDQTRWXID3HXP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 21 Sep 2026 10:06:42 +0200,
Kailang wrote:
> 
> Hi Takashi,
> 
> Prior patch will lose headset Mic function, and this patch will restore it.
> 
> BR,
> Kailang

Applied now.  Thanks.


Takashi
