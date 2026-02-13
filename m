Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119F5EDF166
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:25:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0984D60212;
	Fri, 13 Feb 2026 15:25:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0984D60212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770992714;
	bh=yL22VrCdbtL0JOgFFT+AtDbSBSwkpiMRoG8dF/x5QoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=loz4HQZ6HNUUDCNlonY22dp0DRb9MZunbqgJSNI8p4HuyTckqg3KSqJPBsOGGxoN5
	 1JjN5uD32RDGtEMQKFXodqHHdRnj6S8AsHKwrCtwJh8S8KaeLSgjRq3ez0mp8yOe21
	 xWtLIs1R+UMUv7gcwYA3HvyBZnCOC1SRrSV+w36g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB6A1F805E6; Fri, 13 Feb 2026 15:24:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7C6EF805EC;
	Fri, 13 Feb 2026 15:24:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FCB7F8014E; Fri, 13 Feb 2026 15:21:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1642BF8014E
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2026 15:21:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1642BF8014E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=IjXsn5E6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CI5zpZMP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=IjXsn5E6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CI5zpZMP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD1C3E74B;
	Fri, 13 Feb 2026 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1770992478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+LPEL2+Bn0iwRwvpIUPTB8lwCB4NEFiSBMvivx9L44=;
	b=IjXsn5E6eDoWcDGXUx8kPH+NNLkSxNC0naqB4mALbHBBppMwi9wVFdKX4he0uMs01NfJA8
	fnc5zotcF8X9Ws5p/hPdm0mLHZSbZ3yXmge11UOqrWde/oV3hfH/Grq/hXKdnExr0lfyxf
	i2IyGWFbUu2J3+Xx/bjQECWNthGm60E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770992478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+LPEL2+Bn0iwRwvpIUPTB8lwCB4NEFiSBMvivx9L44=;
	b=CI5zpZMPYnl+GZoqyCiYzNlmM5U/ow1Cfiy/+NDnPDktwkJ5Mm/9XEcZJTRDcRlcIil/fJ
	qOzKX4hbZsbeDLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1770992478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+LPEL2+Bn0iwRwvpIUPTB8lwCB4NEFiSBMvivx9L44=;
	b=IjXsn5E6eDoWcDGXUx8kPH+NNLkSxNC0naqB4mALbHBBppMwi9wVFdKX4he0uMs01NfJA8
	fnc5zotcF8X9Ws5p/hPdm0mLHZSbZ3yXmge11UOqrWde/oV3hfH/Grq/hXKdnExr0lfyxf
	i2IyGWFbUu2J3+Xx/bjQECWNthGm60E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770992478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+LPEL2+Bn0iwRwvpIUPTB8lwCB4NEFiSBMvivx9L44=;
	b=CI5zpZMPYnl+GZoqyCiYzNlmM5U/ow1Cfiy/+NDnPDktwkJ5Mm/9XEcZJTRDcRlcIil/fJ
	qOzKX4hbZsbeDLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C1CC3EA62;
	Fri, 13 Feb 2026 14:21:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /MkEGV4zj2nUeQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 13 Feb 2026 14:21:18 +0000
Date: Fri, 13 Feb 2026 15:21:17 +0100
Message-ID: <87o6lsu3ky.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rob Hermann <supgeek@gmail.com>
Cc: alsa-devel@alsa-project.org,
	kailang@realtek.com
Subject: Re: [PATCH] ALSA: hda/realtek: Fix speaker output on ASUS ROG Strix
 G512
In-Reply-To: <20260213141311.29199-1-supgeek@gmail.com>
References: <20260213141311.29199-1-supgeek@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: ZYNKO3KDW56ZCT66ZL7D2L73ZV4LTHHP
X-Message-ID-Hash: ZYNKO3KDW56ZCT66ZL7D2L73ZV4LTHHP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZYNKO3KDW56ZCT66ZL7D2L73ZV4LTHHP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 13 Feb 2026 15:13:11 +0100,
Rob Hermann wrote:
> 
> The ASUS ROG Strix G512LW (subsystem ID 0x10431f21) with ALC294 codec
> has no speaker output on Linux. The internal speaker amplifier requires
> specific codec coefficient writes that differ from the existing
> ALC294_FIXUP_ASUS_SPK quirk values.
> 
> The required coefficients were identified by comparing codec register
> dumps with and without working speaker output:
>   - Coefficient index 0x0f needs value 0x7778 (vs 0x7774 in existing quirk)
>   - Coefficient index 0x40 needs value 0x0800 (vs 0x8800 in existing quirk)
> 
> Without this patch, speakers are completely silent. Headphones and HDMI
> audio work correctly.
> 
> This affects at least the following models:
>   - ASUS ROG Strix G512LW (i7-10750H, RTX 2070)
>   - ASUS ROG Strix G512LV (reported on Fedora forums)
> 
> Link: https://discussion.fedoraproject.org/t/asus-rog-strix-g512lv-speakers-do-not-work-headset-works-fine/74918
> Link: https://forum.endeavouros.com/t/asus-rog-strix-g15-g512lw-no-audio-through-the-speakers-alc294/72857
> Signed-off-by: Rob Hermann <supgeek@gmail.com>

Could you resubmit to linux-sound@vger.kernel.org?  That's the right
ML for a kernel patch.  alsa-devel ML is mainly for user-space stuff.


thanks,

Takashi
