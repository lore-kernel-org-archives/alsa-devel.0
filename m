Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4281C43458
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:14:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11FD260239;
	Thu,  9 Jul 2026 11:14:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11FD260239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783588453;
	bh=YqK41BPiywUYJSPlCkEyrJekCOGhYn44tfraqEue+YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iqBv4CDvzox7CpIQkjnz9RWCfPnngMOG4WIAwJ+HUef3NgaJl7xZU6GzVeQjHBuVx
	 p/QIEBOaxvTaYPoskcIg5bGcOfpBBbGndelkuD7nE6qwkUjO9CBz2+832Hk21gMtmK
	 Ck7JeHrXpsXCq+q9EXV15RbcGhoeKkSE5U8jkmHw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3401BF800C1; Thu,  9 Jul 2026 11:13:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3011F805F1;
	Thu,  9 Jul 2026 11:13:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F145CF80495; Thu,  9 Jul 2026 11:13:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783588406;
	b=FecbqdzaYI0GL1cfSmv0+Ilwby8fNd0vMDg0q3jvlNVcBcb4TnB9JEilXh52ssU3YfdK
	 PK40zpAIscRowjE2z4atqMNMnAvbf6RxCxDgqHqwQJQw1Vli9+0z+tHUX7ldewCToeY6x
	 hqQwiZu6xyWXj/rVhUVR+PhrbrYD0xlb/d7+DjVry188k5xex/2iowUSBzWgjpZ6Hjyiv
	 GlT15duz77HuNxGdp0A4ZQ4a4HrVlCg0o7TVG1bZ3yKlh9IdXDLtlDdOYBxnf12Ot6HVS
	 qHx2ehQVWkqeXJ82oOCzRVJCUKIky9oBBvdlOaYtm+cMKuMih/A5xzf7vIRv+QjwTbA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783588406;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=YqK41BPiywUYJSPlCkEyrJekCOGhYn44tfraqEue+YQ=;
	b=DkKbMsb2dhRHiPDDpXcP6kcn9VIuM0/I4nkSISPd2e7rDeCFwRPGPssK8fJM4Fdo64sR
	 TGBCF71rQis3QDPYdjv+fX8/tyoomoUk0P7CslVB5lMdF5jnfXNX5cgrmtFlMiG/ufwuW
	 j7NBN4l+82M3Kkqk8zfIXeU9j37eV/Xn1dsj64NMJNm+98bTLocARiKaY3bxYQSy5Ilao
	 b6STJqlZUZxBr++2g7dSOZ1YzbaOHtzwpzqOwieS0wFafga6IZAsQarM8QCZL2ERgUwbM
	 S+X/XdfpOSgmljqAjx2birXK3y3mQI05KysPqY7rVpGct7+pRELzgwMHbCnyQhNZ9CA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=W6pQo8dD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=4B1vhMdC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=jWdxq0yw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=EXBU00Ws;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7C01F800D0
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 11:13:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7C01F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=W6pQo8dD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=4B1vhMdC;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=jWdxq0yw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=EXBU00Ws
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D596675DCF;
	Thu,  9 Jul 2026 09:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783588405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeVkEuNtfOdMvXuU2uFnmzfMgZGiGcfLadUo5CM92F0=;
	b=W6pQo8dD7cYTKP7pBzF6qZ93HIZkeTR8c7Sg/aUwkMY73N4KwPyTv0A/8gb6n5QhQ0JJW4
	QI1vBGMgGd6MbxxEbVWyjn2g3NsMEHHdK2hWx8ZA0O++Ep/su3afS094mDm9G79WaxXebv
	OqxEGamUytj46AuxPG+tW9dUPgzerZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783588405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeVkEuNtfOdMvXuU2uFnmzfMgZGiGcfLadUo5CM92F0=;
	b=4B1vhMdC0ZlWcqSyu4YQF1SrYILPQTtv3n5hPfPO5Kq74z5K4HTq0xZaY+ADuG0rjytOAX
	VycnrTesW2m0fZAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jWdxq0yw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EXBU00Ws
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783588404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeVkEuNtfOdMvXuU2uFnmzfMgZGiGcfLadUo5CM92F0=;
	b=jWdxq0ywkRyryUVlI4WpYb2p+llI0+top/B0XsqNiMP1vsUkIspsQPmuAJneP8Xj3w0N+/
	ix0Ve6r3hlQn5KbQJYKAw6KlPTP5IP9vbK0pR5X26AhnTRwotwsMhMpk9KLwibCA2mDPPD
	i1eQF7ttLKphf10rIAT4UqmvSwwDV/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783588404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeVkEuNtfOdMvXuU2uFnmzfMgZGiGcfLadUo5CM92F0=;
	b=EXBU00Ws7Dt8oSATj8V2bIgtHDh+DeyHA2Zkcv+NAikxdDv6/GQQ6MEbzf+cGAzgB1BmIG
	FLZYXZ9XDUIAmrBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9322779AA;
	Thu,  9 Jul 2026 09:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id enpbJzRmT2r/MAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 09 Jul 2026 09:13:24 +0000
Date: Thu, 09 Jul 2026 11:13:24 +0200
Message-ID: <875x2o4jbf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: Fixed Headphone noise issue for Dell QCM1255
In-Reply-To: <34b990cb56914148ba02fa8e9d176479@realtek.com>
References: <34b990cb56914148ba02fa8e9d176479@realtek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D596675DCF
Message-ID-Hash: 6JSY5NFMEN24XAG43T4BN4YHXPWLC4UO
X-Message-ID-Hash: 6JSY5NFMEN24XAG43T4BN4YHXPWLC4UO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6JSY5NFMEN24XAG43T4BN4YHXPWLC4UO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 09 Jul 2026 09:27:14 +0200,
Kailang wrote:
> 
> Hi Takashi,
> 
> This platform booted with Ubuntu 24.04 with Pipewire audio server. So, it has pop
> noise with headphone. But it's normal with Pulseaudio server.
> This patch was the workaround. Connect the headphones to DAC 0x2.
> The popping sound will disappear.
> 
> This solution was approved by Dell.
> 
> Thanks.
> Kailang

Applied now.  Thanks.


Takashi
