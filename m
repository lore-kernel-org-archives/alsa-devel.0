Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D41DE77170
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:16:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F35C7210F;
	Thu,  5 Dec 2024 18:16:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F35C7210F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733418985;
	bh=iF77VdMRsgiYyVsuz8TkCnC52I8JAs32AxRcIWIj6Pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BwcG5Y/hIKKX9bEpBvOM//a3VIyjke2QHEZfwbMnP88Jmvw+NGGTQ4D2teL20CR16
	 DjAtnFP1pSOHOt+LP+bldgwMgd49A2K4hJdeiC0l+zcnUnpn5CsEWJNcsX5cknIxqL
	 raLLnv9KXVxjcgXPxo76xMiWfHHfmPJyuj+fLjFE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC126F805C6; Thu,  5 Dec 2024 18:15:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B76DF805B1;
	Thu,  5 Dec 2024 18:15:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63C56F8047C; Thu,  5 Dec 2024 18:15:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 934B9F800E9
	for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2024 18:15:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 934B9F800E9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=pThoQdMr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VhEJSsAK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=pThoQdMr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VhEJSsAK
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94C171F38C;
	Thu,  5 Dec 2024 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1733418943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u2hVCvTADCGt24nxL8PHw2SGY+2wwi+cG8xDrqShULk=;
	b=pThoQdMrp8i4VjbN2HuQdf90mTlZThSSYLSPDWJvgelGyJ7f1Di7jQQRMi6+EkIT6zNI3M
	Kt2FJm10v18dUCD/D8xLppSajTUD2yUUn9aK1eF15Bvll742quvtHH03/GijgawZNGvmAf
	IUGnsC6He5C5vTCvW3zaMbGqMW6o7X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733418943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u2hVCvTADCGt24nxL8PHw2SGY+2wwi+cG8xDrqShULk=;
	b=VhEJSsAKhjFUIP8OOQu2VUI2GEnrD23Wv+gSOAP3afasdqhrv57pER9b+RnrJtjhC8gOqN
	vK7zKXZAxU8t9kDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1733418943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u2hVCvTADCGt24nxL8PHw2SGY+2wwi+cG8xDrqShULk=;
	b=pThoQdMrp8i4VjbN2HuQdf90mTlZThSSYLSPDWJvgelGyJ7f1Di7jQQRMi6+EkIT6zNI3M
	Kt2FJm10v18dUCD/D8xLppSajTUD2yUUn9aK1eF15Bvll742quvtHH03/GijgawZNGvmAf
	IUGnsC6He5C5vTCvW3zaMbGqMW6o7X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733418943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u2hVCvTADCGt24nxL8PHw2SGY+2wwi+cG8xDrqShULk=;
	b=VhEJSsAKhjFUIP8OOQu2VUI2GEnrD23Wv+gSOAP3afasdqhrv57pER9b+RnrJtjhC8gOqN
	vK7zKXZAxU8t9kDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7359F132EB;
	Thu,  5 Dec 2024 17:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n5a8Gr/fUWdIHAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Dec 2024 17:15:43 +0000
Date: Thu, 05 Dec 2024 18:15:43 +0100
Message-ID: <878qsut5j4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v6.13-rc1
In-Reply-To: <65b45ae5dd84c05f4907ee42725639cc.broonie@kernel.org>
References: <65b45ae5dd84c05f4907ee42725639cc.broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: 4RRGBMA5IE2EPAKONMPDKQWDLFJDS6BS
X-Message-ID-Hash: 4RRGBMA5IE2EPAKONMPDKQWDLFJDS6BS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4RRGBMA5IE2EPAKONMPDKQWDLFJDS6BS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 05 Dec 2024 18:02:05 +0100,
Mark Brown wrote:
> 
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:
> 
>   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.13-rc1
> 
> for you to fetch changes up to ec16a3cdf37e507013062f9c4a2067eacdd12b62:
> 
>   ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic codec (2024-12-05 13:39:58 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v6.13
> 
> A few small fixes for v6.13, all system specific - the biggest thing is
> the fix for jack handling over suspend on some Intel laptops.

Thanks, pulled now.


Takashi
