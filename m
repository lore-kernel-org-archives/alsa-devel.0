Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047F606A323
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=tduUq/fp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=D6e03wxc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AuTA9ILn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=D6e03wxc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AuTA9ILn
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEFFE60213;
	Fri, 27 Nov 2026 09:07:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEFFE60213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795766830;
	bh=EhwgnhsrcSQ7XqcZoklKH62yAhwq64CezFaXLOc8cMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tduUq/fphQOCjfk+7egQg1Hyj272DMlZ9XqiGdrEYGwL1eHTompxcrw+lSwY8SQGj
	 I+GHX61Pf60fVGczYl7/FF3PAXenRRGuC9RHmv9bMO6fb7sHb/mGz3qHaitiazHhlO
	 24KM7Gsp7SUegNJKS0+uN/Qqyi+H6x6iG6OiClhc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1874CF805F8; Fri, 27 Nov 2026 09:06:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 729BEF805FF;
	Fri, 27 Nov 2026 09:06:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1F94F805A8; Fri, 27 Nov 2026 09:06:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795766784;
	b=ormKShCpYnHiLF1KAUyhzd8oaP8UWi2DC9S+DKmMNpL08iqvxvFz1VlvWcRwflvIKSGo
	 RoXLHPjAbvuPlDW09b/gI4mudY21WnO2lHmb/HIDcaTQyPRW2qYBr44AQK9n9MMsDTVFQ
	 GF6Beuo/qqcZTiIA0E8284K/9vwpARJu82R98AeXHDMVVkrIQR3pFVagEaKKjiXtXUSt4
	 CylBDDifZBG44KXmQ9roDEHeF3wks4PnXGIju9foGZFliIXIS+3B+Gavmz+qBGWpdhaRS
	 sRZF2yzy56+ezp2KF4FhCsMH/+SERunS60Df6KaI8qkHDIHXMzrCVhvsgsiTNBGdz7A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795766784;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=EhwgnhsrcSQ7XqcZoklKH62yAhwq64CezFaXLOc8cMA=;
	b=iSZImHvyVJVuoab6LgD0SK010aMf9snlr52eaB+Ujd00t4csQHV5vUN3prm7leuJzAVw
	 fak9AP3uayOgruH5ulUQJ6dNzwfecWovFaFJMdG3mIiifYbr1QKvcP5egUzLlZAy5es0B
	 nw+5+P/7Ik8CNt/rMqzk6+jFCRlArVTjA/eYlvcbJ20AIP6Tyffs5eYXhOAK4boSLgD6Z
	 IueuXFQRC8QGm/AMhTRx4ClSzeqD371M64o2MXjWMjpBABiRFDREV/4aZuPVDki51ATSE
	 MbrHaK4qdZ+4HOVOH3R7k4WK6TkQNkmwCFOANtslU6dDqcU4wa+vK8ZedJiIrZrsdmw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=D6e03wxc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=AuTA9ILn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=D6e03wxc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=AuTA9ILn;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7642DF80095
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2026 09:06:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7642DF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=D6e03wxc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=AuTA9ILn;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=D6e03wxc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=AuTA9ILn
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61EE81F7B6;
	Fri, 27 Nov 2026 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1795766779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+0RxMOMDb+hFbTJU6xh2mJjYBoewcE2nCgwfikzGlo=;
	b=D6e03wxcW2NG9JaG79KpSirBhvFhYlDljfMn1BEfEtmFBKJvbmwHl+3tSX51wtrcQWHnvc
	aImhoES3iADBuhFWPiqNih411nLos3I2/kW2Vq3Jr6+V3KMUg1BQUznQ7BxU5jCgf8p5d/
	r2zdcu4ah7t5S6mvN/G3S7xj4QFvXDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795766779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+0RxMOMDb+hFbTJU6xh2mJjYBoewcE2nCgwfikzGlo=;
	b=AuTA9ILnqyWJJlBkelpQ+Oh9L2uY0xhEycDfDNm/khrhedUcJpRdcvQhM6QJnfMXVouLBd
	wlhKsnAhr1dLxCDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D6e03wxc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AuTA9ILn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1795766779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+0RxMOMDb+hFbTJU6xh2mJjYBoewcE2nCgwfikzGlo=;
	b=D6e03wxcW2NG9JaG79KpSirBhvFhYlDljfMn1BEfEtmFBKJvbmwHl+3tSX51wtrcQWHnvc
	aImhoES3iADBuhFWPiqNih411nLos3I2/kW2Vq3Jr6+V3KMUg1BQUznQ7BxU5jCgf8p5d/
	r2zdcu4ah7t5S6mvN/G3S7xj4QFvXDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795766779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+0RxMOMDb+hFbTJU6xh2mJjYBoewcE2nCgwfikzGlo=;
	b=AuTA9ILnqyWJJlBkelpQ+Oh9L2uY0xhEycDfDNm/khrhedUcJpRdcvQhM6QJnfMXVouLBd
	wlhKsnAhr1dLxCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2010B13432;
	Fri, 27 Nov 2026 08:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MU+YOfo5CWuuRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Nov 2026 08:06:19 +0000
Date: Fri, 27 Nov 2026 09:06:18 +0100
Message-ID: <8733sm66md.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.4-rc4
In-Reply-To: <20261127024236.91DB03470DDE@traversing.sirena.org.uk>
References: <20261127024236.91DB03470DDE@traversing.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 61EE81F7B6
Message-ID-Hash: U2575R5VWBHQ7OTHQ3S25YL4LPR2ZMRX
X-Message-ID-Hash: U2575R5VWBHQ7OTHQ3S25YL4LPR2ZMRX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U2575R5VWBHQ7OTHQ3S25YL4LPR2ZMRX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Fri, 27 Nov 2026 03:41:45 +0100,
Mark Brown wrote:
> 
> The following changes since commit f66297be665c067d2e96da9ce1c5767b587e17b7:
> 
>   ASoC: tas2781: Avoid possible zero-division (2026-11-19 17:34:26 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-rc4
> 
> for you to fetch changes up to b4378764a58960a016a42506992eac86d4d4eaf9:
> 
>   ASoC: amd: yc: Add DMI quirk for HP 255R G10 (board 8D22) (2026-11-26 14:59:44 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.4
> 
> A fairly big but mostly routine pile of driver specific fixes and quirks
> for v7.4.  The new Tegra support is the biggest thing here, it's all
> data required by the newly added device, there's no real code in there
> so while it was on the edge of getting applied for v7.5 it seemed fine
> here.

Pulled now.  Thanks.


Takashi
