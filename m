Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0375FCDB474
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Oct 2023 13:18:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B34DA4B;
	Mon, 16 Oct 2023 15:17:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B34DA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697462325;
	bh=TSb9GxD5oEeI6PePIO1j8fweqhj9PYyACbhpg9yRRMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kPaFNplFxk/cemiE6PKpAB760vIY1Lyom/JbNL8c5bCmm0d5KSWcbyjodKKtzdiDU
	 5qkZwzOdjKxrCNH3jESI0akmHfcKj82I9zCrCVUddtOnmPifmKfxL3duN8uJZWXixO
	 GRmgEKYFPoXQGskWt7audm3SKaK+4/R5wpafCm50=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A6C9F80558; Mon, 16 Oct 2023 15:17:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 884DAF80563;
	Mon, 16 Oct 2023 15:17:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DEF3F8055A; Mon, 16 Oct 2023 15:17:23 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5285F80558
	for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2023 15:17:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5285F80558
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=A7fgNdSx
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 18B1FB81603;
	Mon, 16 Oct 2023 13:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DF8C433C8;
	Mon, 16 Oct 2023 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697462235;
	bh=TSb9GxD5oEeI6PePIO1j8fweqhj9PYyACbhpg9yRRMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7fgNdSxwKQ4ttsJo+HVlMcDisGXhNgNP/FcfBU30+LmCVjzYMc6peeGkKk7Zhchs
	 4kBpr71VXyksh3CTaRrfZY0B/7L08C6DOZDfMaYpZnix96I9vSm2q2M8nAipp6yJPe
	 kJGcFWjhC7QAnSuIKc6pkcEm6k0KdPhFouF6xc/8QAXvFfRupyCCPkNkbkHhlGyqgw
	 C4g7L3xPSsT0Wh3H03UYY+XlMY1KKaVvficA3P/yoFjkIHIoSUCPMxW6KyYYWvctPo
	 YDvBP9eKVA8zUgm7CzV7fCFUprNdfcoMBQEkoBL+Zryl1+0mYxy/KOHNLsKu3vLxKE
	 RaQ4ZdCPd7Kfg==
Date: Mon, 16 Oct 2023 14:17:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
	"Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: Re: [PATCH v3 1/2] ASoC: dt-bindings: sound-card-common: List
 DAPM endpoints ignoring system suspend
Message-ID: <09061842-ce15-4f24-8098-56ecbb4fb6a2@sirena.org.uk>
References: <20231011114759.1073757-1-chancel.liu@nxp.com>
 <f639c88d-371a-4c72-a906-47d643b24ca8@sirena.org.uk>
 <20231012204739.GA1706264-robh@kernel.org>
 <DB9PR04MB94987AD33756548323D8D101E3D7A@DB9PR04MB9498.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CxOpNCJuLtIFp8ru"
Content-Disposition: inline
In-Reply-To: 
 <DB9PR04MB94987AD33756548323D8D101E3D7A@DB9PR04MB9498.eurprd04.prod.outlook.com>
X-Cookie: If you're happy, you're successful.
Message-ID-Hash: JFCL42KCFEC6EXFCGHTYWLXKEM3LIDES
X-Message-ID-Hash: JFCL42KCFEC6EXFCGHTYWLXKEM3LIDES
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JFCL42KCFEC6EXFCGHTYWLXKEM3LIDES/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--CxOpNCJuLtIFp8ru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 16, 2023 at 12:08:56PM +0000, Chancel Liu wrote:

> Thanks Mark and Rob for your advice. In fact, it's common use case. We can see
> many drivers set widgets ignoring suspend. I will remove the linux specifics
> and focus on the key concept. How about the modification on the property name
> and description as following:
>   ignore-suspend-widgets:
>     description: |
>       A list of audio sound widgets which are marked ignoring system suspend.
> 	  Paths between these endpoints are still active over suspend of the main
> 	  application processor that the current operating system is running.

That's probably fine from my point of view.  There's likely a better way
of saying system suspend but I'm not immediately seeing it and it could
always be improved later.

--CxOpNCJuLtIFp8ru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUtN9MACgkQJNaLcl1U
h9AMyAf/RUOysUsrGEWQC4UlZkLrJEHxMIM6hDxLpZweAie5qQ6rOFMl5ft3BFZC
M9J42RBQwCyAqpmArKhQR1Dr5TMgf0VdaoOmFWLc0xQpMc25W88cIEafU8y+mUua
e6K/k0aIyYZdjwkP4Es88cLi8iA9nl66TBMbNNhVCPFu4ANu/cxaDwEYfisTIfAR
JYHPBdK8nZkSRUGu15z5IswGwSChMEvpWGPfbaz030xacAabehc3JcPSUv+2ogKN
xiEDDICnrN7oi4QKyUgw+Hsd1AnWhJmU3mJ6cNrh8DStFdq1XfWFD0jzbeQLCRC2
vM+z/sNri+7PeKmxVzfVXTZTJUZkrQ==
=HWHj
-----END PGP SIGNATURE-----

--CxOpNCJuLtIFp8ru--
