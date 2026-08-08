Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B8BC55174
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:20:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5594E6020D;
	Sat,  8 Aug 2026 17:20:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5594E6020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786202410;
	bh=K5v5XrwIn4W3vFtdK9NyZdqQ+jiFjoKDFlqC0NXKIM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DVi/wuoBl0DMW066LiA5JOzPuVrmI+QhG3chb+rYc9MU2LZ6e1vSUH+RIETZ0uex0
	 /IFBXQGUD5QlBfEtVZwx0u3zI5uUWKeBX7UIJzM/BppheSM0kNvDxweVSK8uHzSUYK
	 hIToqgpe1ixgWDlMZ6Uqn77GuoRd+rYm5nUPFlGI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEE19F805FF; Sat,  8 Aug 2026 17:19:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B4ABF80580;
	Sat,  8 Aug 2026 17:19:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68981F80571; Sat,  8 Aug 2026 17:19:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786202366;
	b=TgrvG5O4rhxZu3JA5xvhLtUS7fEhlGOVLcVl6Fis2KSH0vRXOL3Gb5ItzJj5IZoYQoVL
	 Bx3LCER0/gq6dG+oxkIDWEDFgJLhH9rPAFUucudQPe+RVrWLG11KvIueqAyEEAzgG26n9
	 Tlr8yUOscYmF7hHTPppa/tdyR3Wqb30aQo51MYNrdfAGoXpozyEe0EMGWZRl//7P++L06
	 6sW8dPaUms9/C4sbHbqizcAHEhVjLWawNpgSOpA/HNEVy9PWrGJetvPOxG2+yfRFohbIX
	 pwTTdUtIHUBqFv7BYo0OXUijbdVyPnTLuvMMhXzz5cCKsSXodIAhQErlVnyUbqSTvbQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786202366;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=K5v5XrwIn4W3vFtdK9NyZdqQ+jiFjoKDFlqC0NXKIM0=;
	b=NKL43BXYUkFQQwRM7DXoTF3TkxgXPMdFgwKe5/93jtkUbYjQznZUKsySJl4RKkQnbBY5
	 sOGPd/D1mGv79UhzFSAISEwDpXSq2B3UVdb+iWGHjwYaNnHHuF16TOSO9eHHT/dLhb+LU
	 Gc59+3274eiIWcq+Oad131J7afGrHI5gqnt4cgyDpFNNMwKan2tzBbYnw/8oFNwVs/3cs
	 fTCZs4TY/Oyk/5M9cCzFPxQGe97soYmOCaTdTpNo6VVWOzR+UDjyvx+TtubdX8Rj3NZV3
	 csvFe+8XYvCsRrMS8MGvvl7flIiXcfsR2F4wb9iMSEUKeRsYzQIHJVrBtRp2AV/m8Hw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xGVyEFcF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Khe84HKb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=XJbU3th7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="v/ImXOGY";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7892EF800BA
	for <alsa-devel@alsa-project.org>; Sat,  8 Aug 2026 17:19:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7892EF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xGVyEFcF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Khe84HKb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=XJbU3th7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=v/ImXOGY
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2CCA80F14;
	Sat,  8 Aug 2026 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786202360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J26+JKie4UnTazVV38RYEJLxvd5ZU+gphmvAP3+CegA=;
	b=xGVyEFcF+FprME6UiZpYGmfrM3IxcLjl4mtAIrisE3TwRQEGe5rxKOhcJWetuUj8evVQza
	LOt/Rm3jNYD+NtHgIn7P7KkrFZ5XCBoMpzK+ztLRiRFYvz9RjrSYocjGEMVfmw2ApAxWmy
	rtfpQEWljkDwcgbb28tfz7BZRGfsWl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786202360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J26+JKie4UnTazVV38RYEJLxvd5ZU+gphmvAP3+CegA=;
	b=Khe84HKbKfOJAgacOAYig2u1Eph4FaQuuUsyTRVg/AjAQCLqNO6NT1g7Tr0XnBpfsKJkJK
	LdzQ8E/kWYbgZHBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786202356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J26+JKie4UnTazVV38RYEJLxvd5ZU+gphmvAP3+CegA=;
	b=XJbU3th7Kpi0tUU5peHUR++6Zb+V287qf1mr0WVmyORu28RdZn/bmHWI1nufSOBj+AxocD
	X0x25pYjd7AvbnhiZFLiIOhN+JTD1P7j/tnN+fmT5dZXOYQan3cuetg5EBzlWTcksjpWAQ
	2kOtdEvsGjL2hRjm+caGl+yAvYjtWHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786202356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J26+JKie4UnTazVV38RYEJLxvd5ZU+gphmvAP3+CegA=;
	b=v/ImXOGYjGtqlaOZP9to/W1Wa+sapazfyp91jjxQ1aHs6fUckO+k50D+btbCxYSxxxCZI5
	XMTM+UTlo9mdqOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 802BF779B2;
	Sat,  8 Aug 2026 15:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMv4HfRId2q0bAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 08 Aug 2026 15:19:16 +0000
Date: Sat, 08 Aug 2026 17:19:16 +0200
Message-ID: <87qzk8abd7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang DM <jixianqiang1540@gmail.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [REGRESSION][HDA] Speaker silence on 7.2-rc6: Converter channel
 allocation misconfigured (channel=0 instead of channel=2)
In-Reply-To: 
 <CAKtWk0Yo4g19a3HwMhRsGyakzRhfnBjp3sv_DfdF_3QsWS5ybA@mail.gmail.com>
References: 
 <CAKtWk0Yo4g19a3HwMhRsGyakzRhfnBjp3sv_DfdF_3QsWS5ybA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: ONHRWE3Y2GQZT3Q2WIEG2F2JG5KZPV32
X-Message-ID-Hash: ONHRWE3Y2GQZT3Q2WIEG2F2JG5KZPV32
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ONHRWE3Y2GQZT3Q2WIEG2F2JG5KZPV32/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 08 Aug 2026 14:59:34 +0200,
Zhang DM wrote:
> 
> 
> Hardware Profile:
> 
>    Laptop: ASUS Zenbook S 16 (UM5606WA)
>    
>    Board/Model: ASUSTeK COMPUTER INC. UM5606WA (Firmware UM5606WA.321)
>    
>    Codec: Realtek ALC294 (Subsystem ID: 1043:1df3, PCI: 1022:15e3 at c4:00.6)
>    
> Regression Details:
> 
>    Good Kernel: Linux 7.1.6 / earlier releases (Onboard analog audio out/mic
>     function as expected)
>    
>    Bad Kernel: Linux 7.2.0-rc6 (7.2.0-rc6-1-cachyos-rc)
>    
>    Control Observation: External USB Audio (Moondrop Edge 2, snd-usb-audio)
>     functions without issue. The regression is isolated to the onboard
>     snd_hda_intel / Realtek ALC294 initialization chain.
>    
> Technical Analysis & Diff: Comparing the ALC294 codec state between the
> working baseline and -rc6 shows an improper converter stream mapping in -rc6.
> The active output widgets (Node 0x02 [Headphone] and Node 0x03 [Speaker]) are
> assigned an unexpected stream ID (stream=5), causing silent output or stream
> routing failure.

Hm, I couldn't find any relevant change specific to your device
through a quick glance.  At best, please do git-bisect.


thanks,

Takashi
