Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA1FC04A6A
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Aug 2023 13:18:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 381DF827;
	Mon,  7 Aug 2023 15:17:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 381DF827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691414325;
	bh=nQ4SW6Otfdqx9sL8dOBqeuHT4hiShY26cyklGUiR36Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AXLLlfmq4ljFH3XJnPN5a06Bp71Bw2GJ/JKgphAxoiu6MlMimCaaN7RkAujKrLO6V
	 7jZUIi424CowSRUSGFSGpeiWS3BZItEEyqhfxTdphs/sNfrjGqVmWmyT9jD2DkAfUz
	 n7HjS5gbWvbw8Sf4U+MiE/YNs8j96WVDHB3PqlCM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B92CEF8016D; Mon,  7 Aug 2023 15:17:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76B02F8016D;
	Mon,  7 Aug 2023 15:17:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CF8DF8016D; Mon,  7 Aug 2023 15:17:51 +0200 (CEST)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 972F8F8016A
	for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2023 15:17:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 972F8F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=AHViUK/A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FX+zdCyQC4fqrwzCs9Z9NLrYt/aKv0Rj29Ql81i5Bfg=; b=AH
	ViUK/ANA+r75YY8/oJVy5vwqLaEm/CyAxID8ZcWNHMyFnu8LOYfr5CkQTdB0k85TnOTXTMLne1w4M
	T9oaWzt87Rtwm1CAiBG9/2w5u9/7hpGa1sIzLjaUvvEFw23YxbG7FW9htEQ4pYmfh88sLA0GCcJIU
	ETGs1tdyjkNQhnA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qT06h-003JzP-3p; Mon, 07 Aug 2023 15:17:11 +0200
Date: Mon, 7 Aug 2023 15:17:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
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
Subject: Re: [PATCH v2 24/28] pinctrl: Add support for the Lantic PEF2256
 pinmux
Message-ID: <eb99e739-6578-4aee-a0f4-7a0c5e5e81ef@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-25-herve.codina@bootlin.com>
 <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
 <CACRpkdZebvrdGXooLXmgXhUcgdgxBczJBpdEoEyJDR39abaAqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: 
 <CACRpkdZebvrdGXooLXmgXhUcgdgxBczJBpdEoEyJDR39abaAqQ@mail.gmail.com>
Message-ID-Hash: UB2LAEXWZG65DCNEX2T3QQGCZM5N4ZDD
X-Message-ID-Hash: UB2LAEXWZG65DCNEX2T3QQGCZM5N4ZDD
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Aug 07, 2023 at 03:06:42PM +0200, Linus Walleij wrote:
> On Mon, Aug 7, 2023 at 3:05 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >
> > So it is a bridge chip? Please use that terminology since Linux
> > DRM often talks about bridges.
> 
> Replying to self: no it's not a bridge, it's a WAN thingy.
> 
> So perhaps write that this is a WAN interface adapter chip.

Hi Linus

In the E1/T1/J1 world, framer is a well understood concept. Maybe the
text needs a bit more background information to explain what this is
to somebody who does not have an old school telecoms background.

   Andrew
