Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87A4CDB47E
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Oct 2023 23:46:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF5461FE;
	Sat, 14 Oct 2023 01:45:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF5461FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697240764;
	bh=ijje59ACJtXkV0PV4ct/39uK254k7vq/jxYbdX4CDko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e3vOaI19G0MweTTl54e/uc4iqDfbdMYO791PyVhuEEOzOdq/vVrbB10WCz2W8wX42
	 Jrqj4rXdGCOGj3lF+YyS2ShVjLbyRUQjay/sR4wyv0tHo6UeT1PXiAFlGBrAragTdc
	 EMaTVoZgDvXi6Go7iF4UO1r3wrMYpDx2hUiZeqz0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60DE5F80553; Sat, 14 Oct 2023 01:44:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1454F8015B;
	Sat, 14 Oct 2023 01:44:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25BA7F80536; Sat, 14 Oct 2023 01:44:41 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 47A59F8015B
	for <alsa-devel@alsa-project.org>; Sat, 14 Oct 2023 01:44:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47A59F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Lkg3GJVL
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D46AD62218;
	Fri, 13 Oct 2023 23:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416F8C433C7;
	Fri, 13 Oct 2023 23:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697240672;
	bh=ijje59ACJtXkV0PV4ct/39uK254k7vq/jxYbdX4CDko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lkg3GJVLxAFEblDKDAbGOX3PPSz/Ohni7SKs69PJULcZqfl9siFQDYH6F9p3koTpk
	 Y8Rv/OCUkPNLJa6VlZAVE+4TCrVKJSY25ix+4pEjYDdDn1qur8kLVyUiN6M3snOiiR
	 txCLYu+RUcbqonpin8jPSXTY8E0sgJfIvxffMExnx4l64YtiqeECwQib5YLbrtnm1/
	 3Wgd3BPp+gJNUWFiqK6NReQwMAt3g0/xwkPjWja6VkTP6rK+jlEF2akKVqgzTD3x0M
	 BfDgrrBGcfku17AkV5gdT+usndxTkXyXKqrGrHlqIj6GT/LbtUeNNinKrFZGkD/n9/
	 bhRZOiWIFPxtw==
Date: Fri, 13 Oct 2023 16:44:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Simon Horman <horms@kernel.org>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 26/30] net: wan: framer: Add support for the Lantiq
 PEF2256 framer
Message-ID: <20231013164430.7a57def5@kernel.org>
In-Reply-To: <20231011061437.64213-27-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
	<20231011061437.64213-27-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 2Z3E73JMLINWBVYXSGU6JIOUTAOA5TVX
X-Message-ID-Hash: 2Z3E73JMLINWBVYXSGU6JIOUTAOA5TVX
X-MailFrom: kuba@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2Z3E73JMLINWBVYXSGU6JIOUTAOA5TVX/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 11 Oct 2023 08:14:30 +0200 Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.

Acked-by: Jakub Kicinski <kuba@kernel.org>
