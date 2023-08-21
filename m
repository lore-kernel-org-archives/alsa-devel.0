Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DEDEE49A5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Aug 2023 18:54:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F8AF836;
	Mon, 21 Aug 2023 20:53:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F8AF836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692644052;
	bh=9Yw86enLpID5U94hXBP0Cn3sQwsJbGoXb+O9UlFco2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qwiFRPz+PXoPl0bCTz5i12lm2XyRC+RcgpVg9xXOxvt0nUHWynxRXaoKeaAGfw6PK
	 wWeMdRuunxjux3I/Y+D/e5CJHD7QvBLOUKJuXjYZ6maJkyOTz1Y3nKtUUXB2QqxdZD
	 PK1kfP4dUBXyfF9yS3Esn9nfnoRAj5Cii1cOYeEM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AAAEBF80510; Mon, 21 Aug 2023 20:52:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23162F80199;
	Mon, 21 Aug 2023 20:52:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9365AF80199; Mon, 21 Aug 2023 20:52:48 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91DCFF800BF
	for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2023 20:52:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91DCFF800BF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bMGxPQ8r
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 74AF0639E1;
	Mon, 21 Aug 2023 18:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81722C433C7;
	Mon, 21 Aug 2023 18:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692643957;
	bh=9Yw86enLpID5U94hXBP0Cn3sQwsJbGoXb+O9UlFco2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bMGxPQ8rqPAL5n5G3OsOHhxVHf494arO950h0E03Bkpq/ThOfFIcvfpU40WvxVeKV
	 aHkA1HtScEGLObzbbd+6tL3CXSZMGXEvg+JaHyZ03iY1ja2ys0omgqQepmYFZrwvzi
	 mLS62DmzD4oDTyvstiobOa4nEjsduQIRNmSECOoneqWKmdGmZYcMYTFlK+5558d9oa
	 tUbzRusq5FsHISJIAMZeuhHGQP9V//IzCuACBej/v3vZbxEEz551rZL0t9ufxRFT+d
	 YnEEbAaRyNQJ6UO5v2gJol+93ylEwF5svR5zpLSwZf5dV1JL8et34ik50QG/Bu2MiQ
	 AlaGlNaOmwT8A==
Date: Mon, 21 Aug 2023 11:52:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Linus Walleij <linus.walleij@linaro.org>, Herve Codina
 <herve.codina@bootlin.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Li Yang
 <leoyang.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Nicolin Chen
 <nicoleotsuka@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
Message-ID: <20230821115234.3aa55965@kernel.org>
In-Reply-To: <fc5f1daa-58a1-fb86-65ba-c6b236051d45@csgroup.eu>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
	<5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
	<CACRpkdamyFvzqrQ1=k04CbfEJn1azOF+yP5Ls2Qa3Ux6WGq7_A@mail.gmail.com>
	<fc5f1daa-58a1-fb86-65ba-c6b236051d45@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: IYLX3ACY4F6ZZ5C3HHLLCJG76CKJXZYO
X-Message-ID-Hash: IYLX3ACY4F6ZZ5C3HHLLCJG76CKJXZYO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IYLX3ACY4F6ZZ5C3HHLLCJG76CKJXZYO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 21 Aug 2023 05:19:22 +0000 Christophe Leroy wrote:
> As I said in the cover letter, this series only fixes critical build=20
> failures that happened when CONFIG_MODULES is set. The purpose was to=20
> allow robots to perform their job up to the end. Other feedback and=20
> comments will be taken into account by Herv=C3=A9 when he is back from ho=
lidays.

I missed this too, FTR this is unacceptable.

Quoting documentation:

  **Do not** post your patches just to run them through the checks.
  You must ensure that your patches are ready by testing them locally
  before posting to the mailing list. The patchwork build bot instance
  gets overloaded very easily and netdev@vger really doesn't need more
  traffic if we can help it.
 =20
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#pa=
tchwork-checks
