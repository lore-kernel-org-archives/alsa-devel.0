Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF21CA5FF0
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2026 18:40:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E0B7602AE;
	Sun,  4 Oct 2026 20:40:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E0B7602AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791139211;
	bh=twifk62AKiRcIDN5SBBJy9wGLXSvHeM8Zd4qXPEvlmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RV4TLt/fghvy5+eRsnbEhPhTNpdWGPk1WVTXKgOf5mk2I7SYWX41BrMvuDsalcSUV
	 KxUnxHYfXfiOaDTcY17MKhIkjDps9CigD2ZZbCPqIQiybaNbHcvKOpoVcKwVgfUh71
	 HTDfwlZYj8OGIouik3FSrbs0VmyIQei/Xynd3u3w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0754FF805FF; Sun,  4 Oct 2026 20:39:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F668F805FB;
	Sun,  4 Oct 2026 20:39:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C26DDF8026D; Sun,  4 Oct 2026 20:39:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791139168;
	b=FPuY8MM2rIt0K5eBFTdzmYZT9FLwVXQOJnCU3pe59qwOfMFyJ6GSmLK8VvWNcZ0Wk5zN
	 hwf3djpFR0jiGrNDFcqzpWrq1KmWOSM7bYyw3lQFj8G2DrQlZiptv0Q69cz/g0+zWOZOv
	 7waZ/GI/sYDNb8pQBNDu+HigdYa80uQt9/LYhcTR/O4BZj0ynw/8RNpTY4yXeYakSph2I
	 CcTErX0+HVVgYAbYVEzYqIeZf+UYZkpTptbVEOEEHBrFjbvnnaXXA2jsScgbLBe+ErlpX
	 TNSCZo4ceGopbM3IzbNwdB4t0l8o2enBLWZr+Cmqit9zFwXILJo7+6WaDEF0g+D+hAA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791139168;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=twifk62AKiRcIDN5SBBJy9wGLXSvHeM8Zd4qXPEvlmc=;
	b=cuKBAQuALkuhhMST4ENTPAs53KAGypJeBPDKn9IbsslyoaTSfCUFTbDSP1M1HSpSnN37
	 ZUv89di6fB4eOO9OaywXok1qlsh4rBcMTDvWccoZdWVcIx7xeF9a+sbYWsmb30wgsVlvs
	 7K4VA5L8MmIfkCPkF6uuWD8VZJREC/yfbl/nKmXibzY2BO3jMEUlVw9e1jE4T67O7GVaE
	 MsEh1R8i2mFhZXc2RX0XnCn+CFtkw0hT4vsLVxQIdJ8pcqSTl8DsbsW2ZYNLZWr11JQR6
	 Vmb7YGjg95M+VBPaVosc69U+vO2MF0HtLAbHvu5cAN2+MEnanHQhEllksrFjv/1lEng==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=opYHqjey;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=XZMoQLQf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=yGsb7mCE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="I2G/YTgG";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1A108F800E4
	for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2026 20:39:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A108F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=opYHqjey;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=XZMoQLQf;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=yGsb7mCE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=I2G/YTgG
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9365821D45;
	Sun,  4 Oct 2026 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791139161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QpKr0jpUXxdiPwnneTMP6xzMhthlKHBHL8PdoYfvQI=;
	b=opYHqjeyPkSFOoatHx0D42w0aGZBAzj2F8iK1OSDybLDCVp6QdAiWzoU3n/JtMMtc/vXLC
	ZMa/42AwcUcsYpU37mlZSrTaufRBFeAKOshqEBvdRTrQH4s5r4tw+0aUy+25nwDtkPXn8s
	rw8/l2tolsx2VOdyn0UF2zmjLMZW0WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791139161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QpKr0jpUXxdiPwnneTMP6xzMhthlKHBHL8PdoYfvQI=;
	b=XZMoQLQfPKTqKpQpRayuH1tYaYGktJ0020QjI3j73FVC4ZNtgEOviNzJp/rdMCmTUqwaq3
	DbR1RCyUT9vxIZCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791139157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QpKr0jpUXxdiPwnneTMP6xzMhthlKHBHL8PdoYfvQI=;
	b=yGsb7mCERCM/rX/8u2Uhk4rPl73fBgWAnASAXkADOcFsrW8ii5//4sXG3FH47dQ02vmA6e
	XQ6bJJ6WFeOd7XZt0vyN5AogL3l7yT7mzIPTwqEJFxsl6dA/tIjYtRXtS2cH8PFUBp0ruN
	Q7vnzvVZ5WbuGsnCPOP1Cl5n/YR5Qz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791139157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QpKr0jpUXxdiPwnneTMP6xzMhthlKHBHL8PdoYfvQI=;
	b=I2G/YTgGcK6awSxNUY9+IgWEgkTWM1g2jyRw8PH3g5FTyA4KcFblnMNywCWWiwCrBJlRZ2
	kw7CJjRSITM3LzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62BCE133CF;
	Sun,  4 Oct 2026 18:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mdqcD1WdwmomXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 04 Oct 2026 18:39:17 +0000
Date: Sun, 04 Oct 2026 20:39:02 +0200
Message-ID: <8733ulia49.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Georg Wenzel <g.wenzel@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Enable bass speakers support
In-Reply-To: <20261004071202.89116-1-g.wenzel@gmail.com>
References: <87cxtw2y8b.wl-tiwai@suse.de>
	<20261004071202.89116-1-g.wenzel@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: 5T33NROVEXSSQE7THHY2AZXQJABOB2RT
X-Message-ID-Hash: 5T33NROVEXSSQE7THHY2AZXQJABOB2RT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5T33NROVEXSSQE7THHY2AZXQJABOB2RT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 04 Oct 2026 09:12:00 +0200,
Georg Wenzel wrote:
> 
> Configure the driver to correctly initialize and enable the bass speakers
> on devices utilizing the TAS2781 amplifier. Without this change, only the
> tweeters or main speakers are active, leading to thin audio output.
> 
> Set up the required register sequences and routing to ensure the bass
> channels are properly powered and mixed into the audio stream.
> 
> Signed-off-by: Georg Wenzel <g.wenzel@gmail.com>

Applied to for-next branch.  Thanks.


Takashi
