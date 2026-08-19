Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34221C5DF6D
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:00:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3197960256;
	Wed, 19 Aug 2026 15:00:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3197960256
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787144421;
	bh=PO6laIiJkFnOfAynZpz+ut6HW+JfA5VCBxCqckCvCJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=du3YAsWbBuvEiIifnpayEt4MLmekFu6EteNHVA/rXZNUoRDXysQ/wlifNk5auA6zz
	 BrztYLjhE1u3PneQvVobwOBQ76UasIYZ699L1zhs3BIumswRgz+Ciw3Oza2jRYqLZD
	 7sqNr4bgy3HEZGbZ5LB+Dzy6p3eYNURfPmLjuagE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5603EF805F4; Wed, 19 Aug 2026 14:59:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 25128F805FF;
	Wed, 19 Aug 2026 14:59:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED007F8026A; Wed, 19 Aug 2026 14:59:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787144375;
	b=C7o2JOCpjFxH28gaPEllz/Ku0ufOMGO/+2rrF9bXUg8TtFJjd6mWHp7uEyueCwttXqob
	 TnBSdz6XachgDTzJ185BgR6hAY4OXJ0FillTSaHbnlusbfWDaJFjfnAmb1x1FOEIdubKm
	 Lx2gW+v4sfm1gjb2NV6H07Xc+yynhQ6dmuOfXfYVBzbaZrhrLLbyQoBNQBmMuKcHvu0ph
	 2fQbPd1cyhJynfCPV5zFFQeSyYLcvj3RnWW0VnBJLM09NpA77bRNeEIEAMbGzwguN5afH
	 0FVJn3h4a4iaRI2bRWuWwC58YB2E2e3fkT9RKPGxKG1QAoFskiwmW68mHwIdyDM8ziw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787144375;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=PO6laIiJkFnOfAynZpz+ut6HW+JfA5VCBxCqckCvCJo=;
	b=jQ1Q17B1+Pu2aKKclLrg952lLc8oD+Ug4opMreRgnpPwoEuPmIR/CY0LCEqLdyDNTnb3
	 EBWDv9xRUqXLh+mB0H2RC1aS/tYbr79k9r5qPNdby296M0S/i+kioWJLw17lMzXJ7MQkf
	 KI1lSAs2s5aOE1os0TjN9FfGqyEFiNumcDYcxcigS/jNgngT8skRY1bsJX14gi5vWMuNc
	 ffeC6hn7PuL1LqxOi1XsHNKQ2jcxPee8GnwvAkbY+QmbFPQBFN2yfUesRktUdIpE9V71S
	 hyKcLfG6ftf1YHaZUdk4YLHBuQJaFhssNUDU3OXot240JXQ2ScLFLIRcBta7qM731iA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=z5UZVdXw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TFx2jcXc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=qQhmTms+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=yPp4kdxJ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25ED4F800AC
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2026 14:59:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25ED4F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=z5UZVdXw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TFx2jcXc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=qQhmTms+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=yPp4kdxJ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DD4F3E6F;
	Wed, 19 Aug 2026 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787144368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AYHiLf0qYBxWtm89KGNpU13uUratwQsUXsJMvLKpjg=;
	b=z5UZVdXwcKMpsfDTqYGajTSbpZ1WkQfFvflyR2aJqAzsvtfkzb/E76aSdQm36Vy0jL4q/2
	OcQOlWqczYwETQjUEdp0bnHPkTNC4y6zySolPzxzTNcVOGLWAVRliNFfXIsX61zXqm7Ac4
	hMUZ0xHR36HITJGov4MxoIEw9B38rYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787144368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AYHiLf0qYBxWtm89KGNpU13uUratwQsUXsJMvLKpjg=;
	b=TFx2jcXcz8xxYjQ3myZKchvwm63hhaManyKvSP04p0zrv8okJC99iREuy9rNqJaau1E/Tr
	s9tSuNPAnxcxuSCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787144364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AYHiLf0qYBxWtm89KGNpU13uUratwQsUXsJMvLKpjg=;
	b=qQhmTms+65iGnm/pvJ7s0yrGyF81G6hRRr8Nc3zkMXAoA0ICoOE/s1bjbKJDs2xdetEhZX
	AL1tnmPPu1bQYF7pOfYPwXjsxB2z+TJTufSJZxhhJCTFR7HqlxyMKpMYSGg8X50tGDtlCf
	zvXYuj8FhM0fyJAzf2zd6aMCUm0ayeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787144364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AYHiLf0qYBxWtm89KGNpU13uUratwQsUXsJMvLKpjg=;
	b=yPp4kdxJR6HJB6OvfE3ftyQ/c7mvMZYrO8Gcgs+uBtOUJ8p4EV0barX7856D1w4OZmhFoD
	FY3e2HV2p1Sdy0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 065402F81;
	Wed, 19 Aug 2026 12:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0rYLOKuohWp7LQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 19 Aug 2026 12:59:23 +0000
Date: Wed, 19 Aug 2026 14:59:23 +0200
Message-ID: <87fr0anu50.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?=22Habil_Eren_T=FCrker=22?= <habilerenturker@gmail.com>
Cc: perex@perex.cz,	tiwai@suse.com,	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,	Habil Eren =?ISO-8859-1?Q?T=FCrker?=
 <habilerenturker@hotmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt
In-Reply-To: <20260818133303.5102-1-habilerenturker@hotmail.com>
References: <20260818133303.5102-1-habilerenturker@hotmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,alsa-project.org,vger.kernel.org,hotmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: VVVG32DNMN7WI7JFDUHIDICSZXG5PT2U
X-Message-ID-Hash: VVVG32DNMN7WI7JFDUHIDICSZXG5PT2U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VVVG32DNMN7WI7JFDUHIDICSZXG5PT2U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 18 Aug 2026 15:32:43 +0200,
Habil Eren Türker wrote:
> 
> This patch adds a quirk for the HP Laptop 15-fd0039nt (SSID 103c:8bb6)
> to fix the micmute LED functionality.
> 
> The micmute LED is controlled via GPIO 0 with active-low polarity.
> 
> Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
> Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index b0ee9b58e..1045bb3dc 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c

The file path indicates that you've created against a very old kernel.
Please provide a patch to the latest kernel (and check whether the
patch is still needed and it works as expected).


thanks,

Takashi
