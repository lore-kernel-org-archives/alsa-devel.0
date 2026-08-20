Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD8C5DF86
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:57:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7048F60263;
	Thu, 20 Aug 2026 10:57:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7048F60263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787216245;
	bh=jdfPUdXETkgNA8U/SbJgsUAdEVKRxFketd7TvTHl9iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Yqx+Ct+WVo40/wk/PaSO5rTCZa5bZTacFQn/ilVWjhrBHIMxeyvxG8SgKftMFj29O
	 /RTzKZMBkmX8T8n9jtZVk1G8NgNxon1jei5cFQQFbkddlT7rjlc6gngQbORXAoHx4L
	 hs7cFpRRAtN/CTp17Rgf8F9ztvn662jsOBpPkSaE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A26EFF805F1; Thu, 20 Aug 2026 10:56:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BAA59F805FC;
	Thu, 20 Aug 2026 10:56:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C7DFF8053D; Thu, 20 Aug 2026 10:56:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787216194;
	b=OSLV759VuJdVSopwa3nhuyrxnTr/IZcOQSo4z+t/Aiw6/71M5BVHVlSwDsuCdiOrNfcN
	 NW/0V3Js2gEYByE0/wzgfvVhDK0/F6wVeAGnyz/cE/ibSezqXJQnTDVgojjFgkew95GbN
	 ro88rDWJeMWX04VAQ4wTwoLdnBYo/mlw+BBsbs0FpiCUOeDlIfXayZPfHvski9giWfsZn
	 ff+LpsUeATsjLsBMmu6mFLm3qbydH8y2E8VTWjFRN7F6Q4lq164hWwtD1GEUR5Qdl2X75
	 8PQfSPcVHl7jDSL++8JBSxW2FOrTp34GuLUdvbzUzrlJhmNxHbcymCbiovbh9QFTu0Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787216194;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=jdfPUdXETkgNA8U/SbJgsUAdEVKRxFketd7TvTHl9iM=;
	b=BwIlF6mA1DSJdwnNVGJPX0JPSPUS3m6TgWXwrk/EG1hn+/YOYdAe1KENl/FtsY8dFjLr
	 6FjyIdpey5pLNZy70wloKZuEJ8W52LJJPX0SjJieYPwdX0TVfj8XrB4ooO1ZKysMrLwFk
	 IM1rwraVwIm1TAW1olIuJ4uqxyOhYbOHCG902XFx7NY2IBFtKJub5JvZVuAT7Euj+jjx8
	 fvHi3eDXKpXCJE18k/6EJncGvnKTzkQ4Xbn1A/N+YXYN9Piie2HfTaGldJxnLcdEkTWqT
	 aQCcDTAIB++pzR7/bdpbv35RwZbNxUgPSv6w/Qe9lCAGAWZ9Uz7rFs34lLKKA0TYd6g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=sCASw5ir;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="G/zkVkMa";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=MJqTT5Ri;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TvaBaFFA;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 156C6F800BD
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2026 10:56:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 156C6F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=sCASw5ir;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=G/zkVkMa;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=MJqTT5Ri;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TvaBaFFA
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D44FF3E58;
	Thu, 20 Aug 2026 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787216188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8Atsqo+xh722xZYSpelppZyMLLViAr5o4uy363YUsk=;
	b=sCASw5ir40OkrYXCm/GtCfVo497Inc9b2Rw3/OhDAWsPwKznyWvlnaI7anNjmQdniI0yQK
	ChvX/NNEWzgf0eaFX9OYQguC8vn1geOwXwpfKaPOeOqZwFlsUFe/eqncyvMi2dKtMcJUpj
	ZfeWXguo++1oX2auELdB1wyLNL5Jco4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787216188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8Atsqo+xh722xZYSpelppZyMLLViAr5o4uy363YUsk=;
	b=G/zkVkMakIU+Z/qNEZzf/P8hYIiFI8YJfm2tm5eaOzU/vMENwHvs2dZ9yBuwUK6qFZ6TEt
	j6IeRitpSpek0ACQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787216183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8Atsqo+xh722xZYSpelppZyMLLViAr5o4uy363YUsk=;
	b=MJqTT5Riz/MeLIaGZcEqmmvdJgiQako9E3CLWrukAbRu/fcJauED81aDkkJfB+8F+nJq6F
	Ipe6ORM2B2Lo6HU3bgLEVjPeZICPzWHp8sIC1528I+/jo4uUOIqOTmOiWV5ZOR6DdgyqPh
	5FbwL0mkakI74PjHI97ZGsP6sltvkJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787216183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8Atsqo+xh722xZYSpelppZyMLLViAr5o4uy363YUsk=;
	b=TvaBaFFAW6Kgbx0aQvdYpxu+Nlaw8hNKetLL6R4EvRf7xpWmPUiJecu02rTjjzPmEPuBag
	wl9XSxPtXmMfewAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3E57351D;
	Thu, 20 Aug 2026 08:56:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ywV/JjfBhmqHKAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Aug 2026 08:56:23 +0000
Date: Thu, 20 Aug 2026 10:56:23 +0200
Message-ID: <87ik55maq0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?=22Habil_Eren_T=FCrker=22?= <habilerenturker@gmail.com>
Cc: perex@perex.cz,	tiwai@suse.com,	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,	Habil Eren =?ISO-8859-1?Q?T=FCrker?=
 <habilerenturker@hotmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt
In-Reply-To: <20260819170919.3172-1-habilerenturker@hotmail.com>
References: <20260819170919.3172-1-habilerenturker@hotmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,alsa-project.org,vger.kernel.org,hotmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: NIKWKZRF6EJCEXKUX7FMKR6YGTQEAR7E
X-Message-ID-Hash: NIKWKZRF6EJCEXKUX7FMKR6YGTQEAR7E
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NIKWKZRF6EJCEXKUX7FMKR6YGTQEAR7E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 19 Aug 2026 19:08:59 +0200,
Habil Eren Türker wrote:
> 
> This patch adds a quirk for the HP Laptop 15-fd0039nt (SSID 103c:8bb6)
> to fix the micmute LED functionality.
> 
> The micmute LED is controlled via GPIO 0 with active-low polarity.
> 
> Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
> Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>

Applied now.  Thanks.


Takashi
