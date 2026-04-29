Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F76FF8864
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2026 05:50:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 086E2601F2;
	Wed, 29 Apr 2026 07:50:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 086E2601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777441849;
	bh=pnqOEoZTlx6DK3stz6Q7dP21S8AzimFJgn8M5ImAoCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=J2qVzEkK4QMwhzk3EE9eJsSqlpfHtlXS+n0C1B7wAcv8CHFxc72d7K1elbgkjcz/i
	 64HOdE2pUtEo2RajmHt7EFlUjIiJl8TyKR0SVHPFAL4qV5DaHO7SckqMgQO9YT4eWS
	 cbhcvNmokjj4GbKioGcmtx6nVEnEnMWrllSifXlU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74208F805F8; Wed, 29 Apr 2026 07:50:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 38018F805F3;
	Wed, 29 Apr 2026 07:50:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3898F80544; Wed, 29 Apr 2026 07:50:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 261E3F80073
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2026 07:50:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 261E3F80073
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=sO9e3T+a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ZdLD0zfX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=qABY3sTR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+D7d8LFu
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAEF25BCD5;
	Wed, 29 Apr 2026 05:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1777441802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnMnxg7U3xfdjdggDzKUTjO5QVf9ef4HLtJNuTdwsLY=;
	b=sO9e3T+a3fL8s1Tu6C9vnwLHiS9kwBJUTQ3ii5dhsvwOUdP/vkTcN4YM1akM0sEY1UIEuZ
	qBj/AjMmJGBYykMZNMJ9wyuldt9eG183HRA+nMLkUuvfnZK3BIREgFcF5j5snxC8gOTiIg
	i2jP4E0CXdUMK+GIEd2hXueRPCFp3tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777441802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnMnxg7U3xfdjdggDzKUTjO5QVf9ef4HLtJNuTdwsLY=;
	b=ZdLD0zfXMig0CoDnf80fWrd0qywBEfdocLN0CLNUgxGp0eB0mbS5YF0yfW/WA18Y2mXmJB
	0If6RzssacxhSwCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qABY3sTR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+D7d8LFu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1777441801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnMnxg7U3xfdjdggDzKUTjO5QVf9ef4HLtJNuTdwsLY=;
	b=qABY3sTRBYNqMgZcw1Iyk4MOJVxBVk+TWNORZwjIZ1lyeQL7eiNs8MOgue3+Yirk6lyDJB
	/xLLAFajv93iHkdMEwgNuccjUTrYVqgnBRuQJDnwFr80bWig4uA43yBZtmdDdZzOjZTl+Z
	TjjyrDjVvTAw3Pw9EVyym9hF+9ubvUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777441801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnMnxg7U3xfdjdggDzKUTjO5QVf9ef4HLtJNuTdwsLY=;
	b=+D7d8LFuQntYUgGzIsRvTsDtosBLR4CklJX4/TNGn5ybx0x7Nvh2USO65mlTPPCmXLZG2x
	Ui9icSm6X/bly1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8239E593B0;
	Wed, 29 Apr 2026 05:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gPd6Hgmc8WnQLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Apr 2026 05:50:01 +0000
Date: Wed, 29 Apr 2026 07:50:01 +0200
Message-ID: <877bpqqprq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: tiwai@suse.com,
	bo.liu@senarytech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH v2] ALSA: hda/conexant: Fix missing error check for jack
 detection
In-Reply-To: <20260428080450.108801-1-wangdich9700@163.com>
References: <20260428080450.108801-1-wangdich9700@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kylinos.cn:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BAEF25BCD5
Message-ID-Hash: HSTMDYCZD2RGGOLMCJNCR5CT3PEALXGU
X-Message-ID-Hash: HSTMDYCZD2RGGOLMCJNCR5CT3PEALXGU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HSTMDYCZD2RGGOLMCJNCR5CT3PEALXGU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 28 Apr 2026 10:04:50 +0200,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> In cx_probe(), the return value of snd_hda_jack_detect_enable_callback()
> is ignored. This function returns a pointer, and if it fails (e.g., due
> to memory allocation failure), it returns an error pointer which must
> be checked using IS_ERR().
> 
> If the registration fails, the driver continues to probe, but the jack
> detection callback will not be registered. This can lead to a kernel
> crash later when the driver attempts to handle jack events or accesses
> the uninitialized structure.
> 
> Check the return value using IS_ERR() and propagate the error via
> PTR_ERR() to the probe caller.
> 
> Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>

Applied now.  Thanks.


Takashi
