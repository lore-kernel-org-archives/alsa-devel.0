Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A557CDB47E
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Oct 2023 23:44:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F06B084A;
	Sat, 14 Oct 2023 01:43:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F06B084A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697240658;
	bh=r4IUZNE379YWHqCHxAQm/TihzJtfE6ZEd/gZZS7lJS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=A46ZrfwkS3E5LgecWMPIff6oJ1pG3DJ0spNjAIOUaIKK/t61aD8eSpRxTCkSTc/kZ
	 19yZEDE9i0FCL0yGDzAZNyJg5gY1eFpyvUxfY7UyGk/O9T8LZvvyYCpK2i/e38KfZx
	 sGDoF7I/uCDrwx8PAIudZeTrPKv3PxhyTiO1x6lI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6DD44F802E8; Sat, 14 Oct 2023 01:42:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5E4DF8019B;
	Sat, 14 Oct 2023 01:42:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4260EF802BE; Sat, 14 Oct 2023 01:42:50 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 574CBF8019B
	for <alsa-devel@alsa-project.org>; Sat, 14 Oct 2023 01:42:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 574CBF8019B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bLjWxlj+
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0CFFBB82C45;
	Fri, 13 Oct 2023 23:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B281C433C8;
	Fri, 13 Oct 2023 23:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697240560;
	bh=r4IUZNE379YWHqCHxAQm/TihzJtfE6ZEd/gZZS7lJS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bLjWxlj+Lc/b7dcG5rH3Gu4xfd6S8jL04AX81iJfqafgkHvZGp9pA/cf9DWs/48pE
	 i9o6zpaBGtfArJvY5plwB2EcprvBeyZralvRuGguiTsQC9cTeZsdqhWcz5df+6k16r
	 mmWkVo+n0nJv9ZV0d05MDUwqG5YynWRNSVcK6GO3XAFr/Ojd44GoXME8bsOz5E9Gey
	 uBcpEbxlOhk0wMo5pt9jfo3GyA+R3gch8+cT5IYJo0JlumgDnqAnS9GR5uQcaX+X47
	 OSy9epstWDE1TVLo5Ct0W4ceqSYMJV4pEOINs8mtu1VQV8yyscUPhmeKUxV75ZL7nf
	 NI4IWA8Ci0Tag==
Date: Fri, 13 Oct 2023 16:42:38 -0700
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
Subject: Re: [PATCH v8 10/30] net: wan: Add support for QMC HDLC
Message-ID: <20231013164238.4984b39e@kernel.org>
In-Reply-To: <20231011061437.64213-11-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
	<20231011061437.64213-11-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: TQJTGRIZHY5CMMHUQDXPPN4CK27USDW7
X-Message-ID-Hash: TQJTGRIZHY5CMMHUQDXPPN4CK27USDW7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TQJTGRIZHY5CMMHUQDXPPN4CK27USDW7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 11 Oct 2023 08:14:14 +0200 Herve Codina wrote:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Jakub Kicinski <kuba@kernel.org>
