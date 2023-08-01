Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A2C001DF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Aug 2023 10:24:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD133823;
	Tue,  1 Aug 2023 12:23:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD133823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690885443;
	bh=HZwAThE6OkfZzSTqW8tFFft/Is2jBSZZIVnyI08x8GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TEF4/T9/nDHEBbzlFhtnL5VXruQ//lnDRrHKZOSGEfow48ea3PQVWsJ4wKtPejjOv
	 vPO2VxjoCmLYdnWsJOMVh9eY2oZ21vjXN+dYHiQwxANhZ6FX7R4iQvzen9Ju6kcXg0
	 folIGEWdapdp7vlACpRFqw55xd0n2we3r8yw+52M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 952A0F8025A; Tue,  1 Aug 2023 12:23:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2290F801D5;
	Tue,  1 Aug 2023 12:23:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2AB92F801D5; Tue,  1 Aug 2023 12:23:01 +0200 (CEST)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7F7AF80087
	for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2023 12:22:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7F7AF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=r53/NdfA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wmvKI/iPaqsWZlCgEQZAhs71pnFCVRSmegSoyV4Grnk=; b=r53/NdfAzOEMUIfF48OEW0mykR
	g+usaIxtHz8A9u36njUCXk9JmGzmp40hfi9uUny4vf9SbDeUW9Vpry2ebPhMUlp8U/4zWpIgLX0AS
	xx8+Pk52ErNmHPNSU2kJX+GCxSEkjnqPaTkHVAcEgQipd0UZufjkg6ioTrReyU0O7U6k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qQmWV-002n5y-Ik; Tue, 01 Aug 2023 12:22:39 +0200
Date: Tue, 1 Aug 2023 12:22:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 23/28] net: wan: framer: Add support for the Lantiq
 PEF2256 framer
Message-ID: <4adae593-c428-4910-882e-7247727cf501@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-24-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726150225.483464-24-herve.codina@bootlin.com>
Message-ID-Hash: C5G2H3IFL3KETOSFBRHSVKR5LNENEP6F
X-Message-ID-Hash: C5G2H3IFL3KETOSFBRHSVKR5LNENEP6F
X-MailFrom: andrew@lunn.ch
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C5G2H3IFL3KETOSFBRHSVKR5LNENEP6F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> +static inline u8 pef2256_read8(struct pef2256 *pef2256, int offset)
> +{
> +	int val;
> +
> +	regmap_read(pef2256->regmap, offset, &val);
> +	return val;
> +}
> +
> +static inline void pef2256_write8(struct pef2256 *pef2256, int offset, u8 val)
> +{
> +	regmap_write(pef2256->regmap, offset, val);
> +}

More cases of inline functions in .C files. Please let the compiler
decide.

> +static void pef2256_isr_default_handler(struct pef2256 *pef2256, u8 nbr, u8 isr)
> +{
> +	dev_warn(pef2256->dev, "ISR%u: 0x%02x not handled\n", nbr, isr);
> +}

Should this be rate limited? It is going to be very noise if it gets
called once per frame time.

       Andrew
