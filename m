Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16478C636D6
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Feb 2023 20:19:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C884CFA4;
	Fri, 17 Feb 2023 21:19:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C884CFA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676665193;
	bh=lVqI8I1Q3SIjzTVVGYHbFL3YO1fxDiCRquZ+CxANmzc=;
	h=Date:From:To:Subject:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ImZZApDJvqOXG2gxEy6To9oj8KeXGp00fLvO+F7cOwQRmhkD2xbDgQ8ACmWeNgKOA
	 1YNGR+hnAlCNIMs/giCs0Uvc3QrGOkhgzdlLWL6sLHdAVfYi0KZ1leup23Ke/gQYfZ
	 0V/LnPR0NLhi/QIVDrCuZmL9Yitm+e7/2gnMqxj8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D270F800AA;
	Fri, 17 Feb 2023 21:18:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC4ECF80171; Fri, 17 Feb 2023 21:18:33 +0100 (CET)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [217.70.178.231])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9306FF800B6
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2023 21:18:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9306FF800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=obYLelZ0
Received: (Authenticated sender: herve.codina@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 337FE100005;
	Fri, 17 Feb 2023 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1676665105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8lIhLyYZrWOGH9acO3c8AQgJcBFOpPFrurmuqfB/DU=;
	b=obYLelZ0JpWaeHM6XQnuEUxoArkn0+207v2TingL+S5XYm+6rwdff8zRrzHgkYLJWrd+Ph
	fMP9ByQfat3MpOUROCd8ZI/xIlRtYV5geFdbGDqh8MtLoxR46yJPFJ9uL72EsEIp7vwUdD
	WHJe2q4dgHghfDTa3rnFerrXAS50zXfIbxGXy9LCO3avlzWJuZ0F8UvmqBdYOoJWcI1HJC
	3jF6uf4FB6X7h8dR1SQehYPUnMlCli6LiksbHXvRNgMuKPji4vkMkQk93+nZfPPeENfMxE
	8YknYacLfbmAreQ6q91HJ/heB2kN7gRA7RO29JggH1vCkXQdg1Pe5pEZAjz3wg==
Date: Fri, 17 Feb 2023 21:18:20 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 00/10] Add the PowerQUICC audio support using the QMC
Message-ID: <20230217211820.39fb47a7@bootlin.com>
In-Reply-To: <Y+/SStm9ifszrYA1@sirena.org.uk>
References: <20230216134226.1692107-1-herve.codina@bootlin.com>
	<87mt5dyxph.fsf@mpe.ellerman.id.au>
	<0606f44f-bdbb-055c-6fff-440007222ce3@csgroup.eu>
	<Y+/SStm9ifszrYA1@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: 57HLGF4G2T4QK62I6ZU3QT2YFGBYUNSV
X-Message-ID-Hash: 57HLGF4G2T4QK62I6ZU3QT2YFGBYUNSV
X-MailFrom: herve.codina@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Li Yang <leoyang.li@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Nicholas Piggin <npiggin@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/57HLGF4G2T4QK62I6ZU3QT2YFGBYUNSV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 17 Feb 2023 19:15:22 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Feb 17, 2023 at 06:32:03AM +0000, Christophe Leroy wrote:
>=20
> > Mark, is that ok for you or do you expect this series to go via soc tre=
e ?
>=20
> Sure, that sounds good to me.  I'll give it another check and
> then assuming everything is fine apply for -rc1.

Thanks a lot,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
