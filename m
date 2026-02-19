Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC297E9A04A
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Feb 2026 15:54:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16BAE60214;
	Thu, 19 Feb 2026 16:54:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16BAE60214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771516466;
	bh=BLZDzcTDV/pYopZvkeW+Li++lPM1psZE/hdxOdrSB7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i2iVd5IU490dqXGahNMPzzCpBcB7WgKoezMlzV2mnMKeSGWGb1HD5ChCsbT1vqe2q
	 RnjgGa5rX4U4hz45Y3cap36xyzIa+6lwmJlpQMC4pJGX0XLoFmQbcC14+vOlMv5neA
	 Q+gwtDae5ALImCtuxDto4Ddo8A3X2po7NO5vFrNg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F852F805ED; Thu, 19 Feb 2026 16:54:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EAB8EF805F3;
	Thu, 19 Feb 2026 16:53:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EAACF804F2; Thu, 19 Feb 2026 16:51:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E8FCCF80153
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2026 16:51:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8FCCF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=yAgeso2j;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=JI/RNTMn;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=yAgeso2j;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=JI/RNTMn
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3139B3E726;
	Thu, 19 Feb 2026 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1771516281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nv9shJlGCWTqBOZOiwkH+iIQxKhSQsJvZRb/sgY9Yuo=;
	b=yAgeso2jm/pkXYPVfl1Z+kVEwqkgyKJYtSisSG982BKnsPQEN7E0RqRsTZJeCKJzCvpF7D
	V60U9j1Xs4tUIwwe6sWz5GTfRdLf6/2dffhqXczgIZkXSy/UsA45t1u2t7LQU5+8JP7kfS
	1Laf8NJGMoskOilRDQLzTMrnFIqR8Kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771516281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nv9shJlGCWTqBOZOiwkH+iIQxKhSQsJvZRb/sgY9Yuo=;
	b=JI/RNTMnrLmr/e1M8Tv8dgoKdtm56W8dd3KjKP7hsRvdg9hxPfPfokczez/lYaqD50HzyR
	agOaiCj+bL1GrWAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1771516281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nv9shJlGCWTqBOZOiwkH+iIQxKhSQsJvZRb/sgY9Yuo=;
	b=yAgeso2jm/pkXYPVfl1Z+kVEwqkgyKJYtSisSG982BKnsPQEN7E0RqRsTZJeCKJzCvpF7D
	V60U9j1Xs4tUIwwe6sWz5GTfRdLf6/2dffhqXczgIZkXSy/UsA45t1u2t7LQU5+8JP7kfS
	1Laf8NJGMoskOilRDQLzTMrnFIqR8Kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771516281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nv9shJlGCWTqBOZOiwkH+iIQxKhSQsJvZRb/sgY9Yuo=;
	b=JI/RNTMnrLmr/e1M8Tv8dgoKdtm56W8dd3KjKP7hsRvdg9hxPfPfokczez/lYaqD50HzyR
	agOaiCj+bL1GrWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 012FC3EA65;
	Thu, 19 Feb 2026 15:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uBRWOngxl2l2SwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 19 Feb 2026 15:51:20 +0000
Date: Thu, 19 Feb 2026 16:51:20 +0100
Message-ID: <87342wratj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.0-rockchip-i2s-tdm
In-Reply-To: <a3a96a98d6e168c6b044ce2b5671e648@kernel.org>
References: <a3a96a98d6e168c6b044ce2b5671e648@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: JE47LK6WH3EP5YA2LUYFQJ5QZBKIJUBO
X-Message-ID-Hash: JE47LK6WH3EP5YA2LUYFQJ5QZBKIJUBO
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JE47LK6WH3EP5YA2LUYFQJ5QZBKIJUBO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 19 Feb 2026 16:45:55 +0100,
Mark Brown wrote:
> 
> The following changes since commit f8f774913b4b599169381073f6674e20976e5529:
> 
>   ASoC: SOF: ipc4-control: Set correct error code in refresh_bytes_control (2026-02-09 12:27:28 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rockchip-i2s-tdm
> 
> for you to fetch changes up to 0783052534f547f8f201dd4554b1df9f1f8615b5:
> 
>   ASoC: rockchip: i2s-tdm: Use param rate if not provided by set_sysclk (2026-02-19 11:45:49 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Additional Rockchip fix for v7.0
> 
> One more ASoC fix, for a regression with the Rockchip I2S TDM support on
> a number of platforms.

Pulled now.  Thanks.


Takashi
