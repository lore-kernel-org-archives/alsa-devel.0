Return-Path: <SRS0=+0+W=NV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF7C4320A
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 12:50:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFEA60524
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 12:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EFEA60524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D9E916E0;
	Mon, 30 Aug 2021 14:49:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D9E916E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630327827;
	bh=enzFmMLYdaHFy4skvzq849/SMBJr8HO7zCGUPuCRhFs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TiYBmbJibpQ0hwffkN5N6tRQAP5HwLz4kZhGpwFarEb9nQhthxcSntggPKPFADtEX
	 bqzig3cSn7Esqp3wkrV3V329X/N1YqNKaD1AXXqkTQABcFXcqCMO7mHQ+rh0o4dDRv
	 +aZ6e1/3SbIEREvvAheBfleGUNbQpcdgKqVRj1OA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D114F8016E;
	Mon, 30 Aug 2021 14:49:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF397F80171; Mon, 30 Aug 2021 14:49:33 +0200 (CEST)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87EF4F80171
 for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2021 14:49:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87EF4F80171
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id BE6181C0B76; Mon, 30 Aug 2021 14:49:27 +0200 (CEST)
Date: Mon, 30 Aug 2021 14:49:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.13 02/12] ASoC: component: Remove misplaced
 prefix handling in pin control functions
Message-ID: <20210830124924.GA22096@duo.ucw.cz>
References: <20210817003536.83063-1-sashal@kernel.org>
 <20210817003536.83063-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20210817003536.83063-2-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Lucas Tanure <tanureal@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When the component level pin control functions were added they for some
> no longer obvious reason handled adding prefixing of widget names. This
> meant that when the lack of prefix handling in the DAPM level pin
> operations was fixed by ae4fc532244b3bb4d (ASoC: dapm: use component
> prefix when checking widget names) the one device using the component
> level API ended up with the prefix being applied twice, causing all
> lookups to fail.

AFAICT ae4fc532244b3bb4d (ASoC: dapm: use component...) is not in
5.10-stable, so this one should not go into 5.10-stable, either?

(Or alternatively, both can go in).

I hope I understand it right.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYSzT1wAKCRAw5/Bqldv6
8tYvAJ9Mqv1udqvt/eQ59aUzDFbILly8+ACgqgjWJPcLX9pQWvIxE2q6Eo9VWX8=
=xi1K
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
