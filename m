Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139DDCA5FC4
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:22:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 373656028E;
	Fri,  2 Oct 2026 14:22:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 373656028E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790943762;
	bh=XQBpefkRL1Wm5lIlLN8idM6uQn72MD5sTrjG4H/lTyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CHZi2tclFcnXqGGbh87EEjQQG65Nh7oCQoOomkg7uXyNN6tpew85wKupRMrmrBMWT
	 UX+UvTdAU/c54tjQceHyJI95ZuGlDfCs3ZWa9lbLdHogNW8b35nX0RHXw8AR26bo3W
	 f3coQeFuzB5N8ifdEHPQDk5YmtzDbFXsaxU1B/5Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FFB0F80602; Fri,  2 Oct 2026 14:22:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74E65F80602;
	Fri,  2 Oct 2026 14:22:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B83DF805BA; Fri,  2 Oct 2026 14:22:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790943716;
	b=bjUijUVmL3Sb624c5dBgHB/cnaY1LCbgFeHiUmZxnldX0fLJFFBkBLIsH/sgKz71qQfk
	 XCUw2GrBcmYie2LldpQTB47fseOYcLPa0kIqMShdevsKxR2yVFC4aIhXccSKUUbfZgdGR
	 aByHd39GZh41tnF/MgBOMjJLRfX8GNXi08lFqzT/XYcj1naRW4IG+pIJvncT2PWjqRQlk
	 jXv2SHOCrwcKXjUsTrDQM9nPwWRyVU2AJZEIUeeiznu89UqCAKDaWPWlbdzluAWXU7h6i
	 +hijQ19AhbSAuZWK4X/JUlLnfbHN+Vi2AKqG7PrI2yp1L9ak730xR6xHA7zW/uZjiPQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790943716;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=XQBpefkRL1Wm5lIlLN8idM6uQn72MD5sTrjG4H/lTyM=;
	b=ao/SoTs627PSN6jUVt2g4lD/jvp0P7V3mOWCzGaIkapOrzKqlEOJzsV69Wa81ZouVbpw
	 qK+f/4DCcvDmSeqI7BBP1ZwGsRZsK6n5P6q+z/SF83xdUJJYB+BXKLBbPXEPrtXi4ltST
	 7usZRi72/qkEnhn6vJJzES85Zrnv3ZL0dgiqNVk56Gx0j1cZaKZEQzOeYDuEiyNdZDrFw
	 ioowIdU/X735IC5dAohaINw3UjU8Yq5YsZc9r+hR0tHreleEl57KBfQP2dAZ0vDghXO48
	 NTfKYJV7H5vfot/M7ZR1WNbLYdre87uzHe7bCfTzy2xpT1JMq61Y3yeJgXPwj9cxKDw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=C8KL522C;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=kPypst8c;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Y5fdCfbY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5exSrjVy;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B7076F80424
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 14:21:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7076F80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=C8KL522C;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=kPypst8c;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Y5fdCfbY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5exSrjVy
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6CF41FE33;
	Fri,  2 Oct 2026 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790943709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXtcVmjDvcEA8z1UIIWveCvmu7R8RnEuNqbKQTEqXAw=;
	b=C8KL522CC16MqzessvAGSXQz67Uk88SMA+i/R5IHeJogf1YYoyI0kZhWFVlDpZ0RoOEWer
	pna4zLY0GVqHDChy9o1g9jGH8G31wGopwN9MF1AjYgymbWncaISExBCq1lfgL9WoZhdrzY
	gM3CQoSd4UVYqz0480LYUZ8hsURZFTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790943709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXtcVmjDvcEA8z1UIIWveCvmu7R8RnEuNqbKQTEqXAw=;
	b=kPypst8cIK3pyfVCH17nJq9toKyTG7IEzITU+978Rb3+97wB74pmcQRIwC4HRQ0LUKdixe
	r+pmcgWzXJhuO2AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790943705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXtcVmjDvcEA8z1UIIWveCvmu7R8RnEuNqbKQTEqXAw=;
	b=Y5fdCfbYKt7oqh/Nnvsg9b07CJ5+96Op9eNe4tThOaXNBelfsvqpFhNNE0/pyGIJ4wAOO4
	4BPYc0cBiju4jNEIlX8hvLMjO1URkq/niXt3f2BcgiCGA4yleBz0w1xZE5oWv01jP3QlnK
	Q0a+v6aGjOha6M7IElbh2n8VSRp7GnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790943705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXtcVmjDvcEA8z1UIIWveCvmu7R8RnEuNqbKQTEqXAw=;
	b=5exSrjVynyptSGpbeZ+WdsgWVQ7xORcWjgDSPyApisATBppJN7l9djXmdaJHRFCt3ARzTt
	mSVtHClKp+z1b2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8343213C73;
	Fri,  2 Oct 2026 12:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SdL4Ftmhv2r/NwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Oct 2026 12:21:45 +0000
Date: Fri, 02 Oct 2026 14:21:45 +0200
Message-ID: <874if41eee.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc5
In-Reply-To: <68deab21-b10e-47d5-b0f3-f533c995a87e@sirena.org.uk>
References: <20261002115438.DD6341AC57CB@finisterre.sirena.org.uk>
	<877bk01fii.wl-tiwai@suse.de>
	<68deab21-b10e-47d5-b0f3-f533c995a87e@sirena.org.uk>
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
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: OUQV3J7N2BCHITIDENTWH4LFAD57JBH3
X-Message-ID-Hash: OUQV3J7N2BCHITIDENTWH4LFAD57JBH3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OUQV3J7N2BCHITIDENTWH4LFAD57JBH3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 02 Oct 2026 14:05:02 +0200,
Mark Brown wrote:
> 
> On Fri, Oct 02, 2026 at 01:57:41PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > ASoC: Fixes for v7.4
> > 
> > This is meant for a PR for 7.3-rc6?  Or really for 7.4?
> 
> v7.3, sorry - I thinkoed when I was typing stuff and fixed up the tag
> name but not the subject.

OK, I corrected it at merging :)  Pulled now.


thanks,

Takashi
