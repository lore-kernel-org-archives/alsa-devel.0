Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C3AC61DFD
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:43:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFE0C601F7;
	Wed,  2 Sep 2026 08:43:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFE0C601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788331427;
	bh=MSz231DhHy81l7/n2j7sF/c8jFKVC83Pf9hv0ByFq1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=u5Qs920Y7+qUIVff6P0NVrosV0OsKYsq0ehYNWy8luwfQ36f98KMK0bAEC58IClRv
	 qi909ShN+rTW5m8luELFYp4ydqOKzbZsrA3s5zH8Q3JD7WWMP85tQLytdcxR2uLbqW
	 6O8prnkgtnY1sEOm8n8SaH4QpgarxvJpFgOmYZiA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2311F805FF; Wed,  2 Sep 2026 08:43:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CC7DF805F9;
	Wed,  2 Sep 2026 08:43:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0951F80548; Wed,  2 Sep 2026 08:43:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788331380;
	b=TBxCJ2RkawcD14CY+Y4kj45jZFpGrJCkDMfu19Wm86GYxjMgyL2yJgq7ljIQJ9AjhufJ
	 9whz67aTMNAt/4dwJ0djVXIxpRZwgwzcBmCW6HalBVpCRmFrgwDLeOVsGSEY1ypMVI6kj
	 u7Iqq/ZRC/Z+ozy27zeXo/SuDl2qrbJoSlVl9FKYfB8XMAIYXBsFtY0tHT9B2h8ets7AB
	 nC9razLT2BMiGgfAW8hP1IhEUtkNcq1Kqcni6fsdBgUgNaoBHNOURgMvuJT2i60wgBiuf
	 MsHdLGGnZjRuKbs1nFu7ypZEMBa80c1qDP7q8JXSJigTfNk8Wc94ry7CdZ73U40pBWg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788331380;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=MSz231DhHy81l7/n2j7sF/c8jFKVC83Pf9hv0ByFq1M=;
	b=iaLKtX9LAC3gzWgEmBcUlze5wGllxRYMHo4Sg9Ui+Fw079x5N8gJZvhhfNyBK8imOyXn
	 300OPMls9nanCpTCzyKUjYrh1xpOPObItlYEHXa5fJkIwpZpWBZoNtX0H5lNRDXPNZ9iN
	 vXKPI13+7Ag1ZTTC/pgdaUx1veWrduLh4N50jrSjjs2G+5Rthv9I1mYcv15Wf8N5FVpkP
	 UGK2SLHhu9rqy0nM/Mgm494pYEXxWyuMCJL2QKzdohb/GkUbVTPUQmxj84DqdVYAhSxQ3
	 615xp37tYC7jsQeYrjKf9sjInT5jhlDBdlm7ACLpO5STkhQ0TeoFOaA39+lqp/Ji1HA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=avFdWkT8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=XKlCO2iD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=h7LmmhO3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SZMK4HOB;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8FF66F80071
	for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2026 08:42:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FF66F80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=avFdWkT8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=XKlCO2iD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=h7LmmhO3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SZMK4HOB
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C8671FA90;
	Wed,  2 Sep 2026 06:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788331374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PpYq0WGperJK7Y2CnbQ75TZp+1lCIKRfpX4I4D8wZBQ=;
	b=avFdWkT8WaXPpfNRMFRY+P10hXKB6DZ0+nyjUrpQzfsEkthFfwHFjQmYPfj8iUJLsAbfJj
	a0WLhkeNN64vuqK7/dB58mX3NyTXF9ndnb80N+MCUqq7tDLmsADtNbjtRnonY/VMYMzbnL
	RQ9Ncz0awl/syzRhCpAx2B/9r0ruBog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788331374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PpYq0WGperJK7Y2CnbQ75TZp+1lCIKRfpX4I4D8wZBQ=;
	b=XKlCO2iDct1GCfL0uXf2JVfQ+UAuUEY0iTZ2MAstYbUrLTF4mI6qchZSG8y9zVglb/4e31
	4SKoWtI69rF6Q9Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788331370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PpYq0WGperJK7Y2CnbQ75TZp+1lCIKRfpX4I4D8wZBQ=;
	b=h7LmmhO3uwNybJgKyC6tyEb6Gy4WyNwea9oOkWCclMeCc742jJiO8ilcWPZCHz/DcUfSC4
	+R5vWVCratxqbh9P1RUgYYodns6XDvQQaFISFsMxbN6hg3kbwaHlwxppcStqDCNvWfcOQ3
	exCWffUWwL/GLNkp1DbN7z/4Octtcsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788331370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PpYq0WGperJK7Y2CnbQ75TZp+1lCIKRfpX4I4D8wZBQ=;
	b=SZMK4HOBp5DSr/i4LQw5/oJNED6J2o9BfPyTRbHa5PH/hWSJxR4X1e9jfaWxflTK65gcD8
	28ZI+ezhUx81R0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E15F136E6;
	Wed,  2 Sep 2026 06:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e5g6DGrFl2raPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 02 Sep 2026 06:42:50 +0000
Date: Wed, 02 Sep 2026 08:42:49 +0200
Message-ID: <87jyp4b1cm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jonne Vuorela <jonne.vuorela@proton.me>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ALSA: hda/cs420x: Add CS4208 fixup for MacBookAir 7,2
In-Reply-To: 
 <Qcui5livawCaJbO1jfx_jebS64rR0f9KATkqn8May0pPyLw8U5DqPQBigmSzRxJp-GeMPqs-jAK6PCnagk3bspzmH__YPte-eyvPtFtuolo=@proton.me>
References: 
 <Qcui5livawCaJbO1jfx_jebS64rR0f9KATkqn8May0pPyLw8U5DqPQBigmSzRxJp-GeMPqs-jAK6PCnagk3bspzmH__YPte-eyvPtFtuolo=@proton.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: VRXIWK2CVJ4UCO6SGK734FPKJH5Q2UAN
X-Message-ID-Hash: VRXIWK2CVJ4UCO6SGK734FPKJH5Q2UAN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VRXIWK2CVJ4UCO6SGK734FPKJH5Q2UAN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 01 Sep 2026 20:28:27 +0200,
Jonne Vuorela wrote:
> 
> From 6aaa1f7fe990490a9b3d259a5ecde7495b60a281 Mon Sep 17 00:00:00 2001
> From: Jonne Vuorela <jonne.vuorela@proton.me>
> Date: Tue, 1 Sep 2026 16:40:10 +0300
> Subject: [PATCH] ALSA: hda/cs420x: Add CS4208 fixup for MacBookAir 7,2
> 
> The MacBookAir 7,2 HDA controller has PCI subsystem 8086:7270
> rather than Apple 0x106b, so no fixup is selected and all pins
> default to 0x400000f0. The pin wiring matches MBA6, so add the
> subsystem ID to both lookup tables pointing to CS4208_MBA6.
> 
> Tested on MacBookAir 7,2.
> 
> Signed-off-by: Jonne Vuorela <jonne.vuorela@proton.me>

Applied now.  Thanks.

(I cleaned up the patch -- some mail headers are imposed in the patch
 description, and the corrected the table entry in SSID order)


Takashi
