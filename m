Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B321C44501
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:18:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC44C6023A;
	Thu,  9 Jul 2026 11:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC44C6023A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783588729;
	bh=HltVVfvEBmpNzh1SQC7hT8BzRF/gi41e90koasFLYFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OgWc/Rsuo0GnTsay+htJzfyD5BJK/VqOaG1OIP/o+FwbqLK0bQIUFi+18NUYMl/mU
	 NL0NveAa2pvHRHyUHCGmq0zNoeKjYRApHxO6U3f1YgIKQlaaupHz1+bXHL4gUXGIpy
	 OTgORe+DnLTgwU8zYJwqABJR4V7E9eEIAExWDhBU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4169BF805F5; Thu,  9 Jul 2026 11:18:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2DC5F805FF;
	Thu,  9 Jul 2026 11:18:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 731EAF80495; Thu,  9 Jul 2026 11:18:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783588686;
	b=QSPzl+vzlWHEToCTOcPJt9vuh+PFkXVnLT1Hx6ErRNEcBNpgRWIuJl6ZBi4PaEienHmj
	 tkrdV53997AHdahtrIO1b2eagJGTUsTsldY7XoPT36mC2g1YVAy6YsKdTKXvclebeQLtC
	 LjRiYIqmQAuxDOE9F3Euxlmn5bTKWMQ17jiYjb9OI8DPTWHd1Mkod4DiO7fSKlGbzDiNl
	 tl28YUuJ3/kEqRUEcRGYnCCl46sivnpjtfp/4x4wFQ38RZEptGzLm3cWIdIXJw/igwnpJ
	 IqpkV6xG1WbPrqMJzsv0JhhfxmJsoFazxq6P87zbQAGDuVIfBc3OQiqt6TZTokcx2jQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783588686;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=HltVVfvEBmpNzh1SQC7hT8BzRF/gi41e90koasFLYFM=;
	b=msMr3a9YLh41O4wvetCePqwQd8SwziaDGgxenWGZIl6+jj/VCs9WtAYiFNCgduT4WUZZ
	 +uqUcTbu+KMu+Nv+Kg0YDGiMrbmZK7ttKk8BdMLb2auKz/brt76EJbMfPL9g3l58IqplG
	 kUjRQBI0QDtFpL0nQNW7xCudwW7CMBpxpZTMjCIFBsIlC2yYZlXzAorGpQtlQfb5HoPDV
	 CvH64oRQArVqB8IiO/YFPi1ahzq+cLObSDyb3U+kZwT33JV3KKEI8w6eVOzCAL8o83IpY
	 wBSF9b6TT58D5+ZqOZtCF/BK7pbJcQGQrr9ukrgg4azAN0+A4qOe+gLVzN6fyYlsLdQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ILCXRtgL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5PDaZniA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=wP+bidRN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=bBaPS1sW;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 32B6FF800C1
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 11:18:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32B6FF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ILCXRtgL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5PDaZniA;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=wP+bidRN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=bBaPS1sW
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5279575812;
	Thu,  9 Jul 2026 09:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783588684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJYAvz27tahr5pgSq3w0/88+I1fLzs3UXnKVo7Sexpo=;
	b=ILCXRtgLlIZF18jmaQbUP0qCGU6LL3XcymOGfjhdSLjFWrmcU28ROturdzihuZpWiL7csB
	16Ysl7ti8BowOYwVL2At48O30oBmqHOUphuCqkrB0NX3BpPWQ//uXpy4r9dc5zelyiPrCW
	JucDXsk+Xfp09LIFzh4iwIy1EaKG9o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783588684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJYAvz27tahr5pgSq3w0/88+I1fLzs3UXnKVo7Sexpo=;
	b=5PDaZniA1rjvP73m/9rMfSdimBGGPqXmUdKWwh9nsMmHmPiLWRODAAjO63mT2Z7KF1Ijw0
	xU+MlSNKpMUpkSCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1783588683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJYAvz27tahr5pgSq3w0/88+I1fLzs3UXnKVo7Sexpo=;
	b=wP+bidRNXw50pUJHX2qBiyI/9fhZdNk4D+24EaxkEU0EzYM9Bpiuk5w8V0GWt7lDDz0dpx
	zo8uHQI57ES6tk3+JEn8PDbKGDX/MKBKu7los6XveUZ70W0bAznfw3fiou6I+ZGKVhi/By
	2v2caeJtOr/iDeu5kC2HAkQRi2h9sZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783588683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJYAvz27tahr5pgSq3w0/88+I1fLzs3UXnKVo7Sexpo=;
	b=bBaPS1sWKe13e9oPSwM5XY6J7Se2SabIfJPOrJ+U5XAsytjDdSpDaBzrod/4nLT6wf2OZy
	vEPGQbZATP3xJbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32100779AA;
	Thu,  9 Jul 2026 09:18:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZxTUCktnT2psNQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 09 Jul 2026 09:18:03 +0000
Date: Thu, 09 Jul 2026 11:18:02 +0200
Message-ID: <874ii84j3p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Michael Diesen <michael.diesen@posteo.de>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Elite Dragonfly Folio
 G3 speakers
In-Reply-To: <6b2b71bb318263aeb4f3ff67754d9978@posteo.de>
References: <6b2b71bb318263aeb4f3ff67754d9978@posteo.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: RXEDMA5A5NJ5IMXKE7MBOLU6IRIOO74P
X-Message-ID-Hash: RXEDMA5A5NJ5IMXKE7MBOLU6IRIOO74P
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RXEDMA5A5NJ5IMXKE7MBOLU6IRIOO74P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 08 Jul 2026 22:04:31 +0200,
Michael Diesen wrote:
> 
> The HP Elite Dragonfly Folio G3 (PCI SSID 103c:8a05) has 4 CS35L41
> amplifiers on SPI, identical to the non-Folio Dragonfly G3 (103c:8981).
> Without this quirk the amps are never registered and speakers stay
> silent.
> 
> I've been carrying this as a local out-of-tree patch and would like
> to get it merged. Note there is a related, recently merged quirk for
> a neighboring SSID on what appears to be a sibling board variant:
> 
>   0a10faad5ca5 ("ALSA: hda/realtek: add quirk for HP Dragonfly Folio
>   G3 2-in-1", 103c:8a06), which uses the SPI4 + GPIO LED fixup
>   variant rather than plain SPI4.
> 
> My hardware (103c:8a05, "HP Elite Dragonfly Folio G3", non-2-in-1
> SKU) works correctly with the plain ALC245_FIXUP_CS35L41_SPI_4
> fixup and does not need the GPIO LED handling. Happy to re-test
> against SPI_4_HP_GPIO_LED if you think that's actually the more
> correct fixup for this board too ― let me know.
> 
> Signed-off-by: Michael Diesen <michael.diesen@posteo.de>
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6817,6 +6817,7 @@
>       SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)",
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>       SND_PCI_QUIRK(0x103c, 0x89da, "HP Spectre x360 14t-ea100",
> ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
>       SND_PCI_QUIRK(0x103c, 0x89e7, "HP Elite x2 G9",
> ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> +     SND_PCI_QUIRK(0x103c, 0x8a05, "HP Elite Dragonfly Folio G3",
> ALC245_FIXUP_CS35L41_SPI_4),
>       SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx",
> ALC287_FIXUP_HP_GPIO_LED),
>       SND_PCI_QUIRK(0x103c, 0x8a1f, "HP Laptop 14s-dr5xxx",
> ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>       SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx",
> ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),

The patch can't be applied cleanly via git-am, unfortunately, likely
because your mailer broke the space and lines.

Please fix your mailer setup and resubmit.
At best, try to send to yourself and test whether you can apply it via
git-am before the resubmission.


thanks,

Takashi
