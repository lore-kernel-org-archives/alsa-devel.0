Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21344C83F12
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Aug 2023 06:41:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE1AE7F1;
	Tue, 29 Aug 2023 08:40:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE1AE7F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693291290;
	bh=k5Xp3dXoP9ekDEhsI7MmxYx6VE9LuZX+/YXkiq9UdZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=utEvjLFhSgp+tkuKwi1MTHiLhnFeUl/MwnG2pQqnR/ofhI/El8WEotHcCLrsk8a2U
	 Ctns7WxlZVUWuQ+AXSTONrrbFi5q3qK0NB2jU3jrUoeHIUVc1eV8PNfmat7sdsA/5E
	 6cdLAQQpp4RTEzdr+d50G82bTu+8W65QnhtVU24Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12F1BF80094; Tue, 29 Aug 2023 08:40:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D907F80158;
	Tue, 29 Aug 2023 08:40:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67765F80158; Tue, 29 Aug 2023 08:40:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AACBEF800F5
	for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2023 08:40:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AACBEF800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=yAtNfJuO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=DWLaVlT0
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E4652186E;
	Tue, 29 Aug 2023 06:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1693291203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zans4W2u/vshZZCUl2afaYb30cHtZkJc5TloAICBR3g=;
	b=yAtNfJuORRrkT+te3CLcEsni/lKivy9prKtTdrTEt1vnD12fkJoJJD9ZroKa5lSXL0rDXr
	MchoKwZTbrvG808lYdu7Naoj3XaRG6Wzn9v26Q/7rxfdLS2peBExUJSSjau4zMmBbi16hN
	kWviQnITTd9vsiO6sp0wEwSo8lSOt8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693291203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zans4W2u/vshZZCUl2afaYb30cHtZkJc5TloAICBR3g=;
	b=DWLaVlT0TZx7cVxIB6BToLIetSPaTZoGA1txJ2we5JDpoEA/OOwsejamAHVGczBGMUgC4/
	QDkiM++ydlePX+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C28C613301;
	Tue, 29 Aug 2023 06:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OJxULsKS7WTcAgAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 29 Aug 2023 06:40:02 +0000
Date: Tue, 29 Aug 2023 08:40:02 +0200
Message-ID: <877cpewdvh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Jaroslav Kysela
	<perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Maxim Kochetkov
	<fido_max@inbox.ru>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	<linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
Subject: Re: [PATCH v1] ASoC: dwc: Fix the warnnings about JH7110 ops
In-Reply-To: <20230829033658.225713-1-xingyu.wu@starfivetech.com>
References: <20230829033658.225713-1-xingyu.wu@starfivetech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: TGL7VZ43TY55NS6SCSLGWA4QLW3TSXMS
X-Message-ID-Hash: TGL7VZ43TY55NS6SCSLGWA4QLW3TSXMS
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TGL7VZ43TY55NS6SCSLGWA4QLW3TSXMS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 29 Aug 2023 05:36:58 +0200,
Xingyu Wu wrote:
> 
> Add a check of CONFIG_OF before the JH7110 ops to fix the warnings
> that the JH7110 ops are defined but not used when CONFIG_OF is disabled.
> 
> Fixes: 1a512d13837a ("Add I2S support for the StarFive JH7110 SoC")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308250433.nhzrhYEo-lkp@intel.com/
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
> Hi Mark,
> 
> This patch fixes the issue about the warning of JH7110 ops when CONFIG_OF
> is disabled. So add a check of CONFIG_OF before defining JH7110 ops.
> 
> Thanks,
> Xingyu Wu

The very same fix went already in my sound.git tree, commit
8d2a0cdf5229.


thanks,

Takashi
