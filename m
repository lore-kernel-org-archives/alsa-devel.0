Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01CFC6FD1C
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Mar 2023 22:43:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3AFFE8D;
	Fri, 24 Mar 2023 23:42:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3AFFE8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679697813;
	bh=mSFKufLTDCXZe4OIXeSCIbH+/iene2azn0ooIi132Gg=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZtU/B+G951o9KLar3pNShKkhBVeiiIKlqv/4WGa1oS90Up9/UEBJlOSlA+hd14tpw
	 MkGPNEoC2htcH20iNwPRXCIaUNTaSPspXocrEUVwX6h3H8PNImCFlQN4cU2aTKiA8d
	 i20Ka2GrWz8YPvVchw5cBbh5Ly9Yq2UyzTw8KLzY=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B524F802E8;
	Fri, 24 Mar 2023 23:42:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D183CF802E8; Fri, 24 Mar 2023 23:42:15 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9FE09F8024E
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2023 23:42:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FE09F8024E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XYXurxWm
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id F35FBB825FE;
	Fri, 24 Mar 2023 22:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432FFC433D2;
	Fri, 24 Mar 2023 22:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679697726;
	bh=mSFKufLTDCXZe4OIXeSCIbH+/iene2azn0ooIi132Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYXurxWmKERP/GrIVcZTkZ+HSUUcwVYj8yrEYGlZejCrPL+ByvnRlBH2gnHCEXdK2
	 wRk+23iynjUPOpVcDbJyga/EM7Q0OWwnQr57TxWmhx6oq2TBIJXsDjmKqltULUOk+o
	 orsf7jU6h9wRHPSCcVVsFcxCwfPhg/epdn0622kVnbalDL6YY85dG9FKaiX0hZzRPA
	 BPEKGxlzdXVGdvf8AxaayArG7RzURgLA82dVoEmmktqNhOKAH3mLss8IKNBpfvpKap
	 TTv7M9xxZyRUh74ApR/sJeoHXls2tP9v1K6jRXGkcdntyoZjvwEinir4ef7N6n7pKa
	 NLHgEznub4WrQ==
Date: Fri, 24 Mar 2023 22:42:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v6] ASoC: tas2781: Add tas2781 driver
Message-ID: <ZB4nO8bVqaKFE3K5@sirena.org.uk>
References: <20230324110755.27652-1-13916275206@139.com>
 <0dfd9d02-30f2-8245-430c-0d4381470606@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c2P+GJtblqhiHXkG"
Content-Disposition: inline
In-Reply-To: <0dfd9d02-30f2-8245-430c-0d4381470606@wanadoo.fr>
X-Cookie: Single tasking: Just Say No.
Message-ID-Hash: BSAVRSJBJQWWAP3KQDFKRU3P2XIPJREC
X-Message-ID-Hash: BSAVRSJBJQWWAP3KQDFKRU3P2XIPJREC
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Shenghao Ding <13916275206@139.com>, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com, shenghao-ding@ti.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, x1077012@ti.com,
 peeyush@ti.com, navada@ti.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BSAVRSJBJQWWAP3KQDFKRU3P2XIPJREC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--c2P+GJtblqhiHXkG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 06:07:32PM +0100, Christophe JAILLET wrote:
> Le 24/03/2023 =E0 12:07, Shenghao Ding a =E9crit=A0:
> > Create tas2781 driver.
> >=20
> > Signed-off-by: Shenghao Ding <13916275206@139.com>
> >=20
> > ---
> > Changes in v6:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--c2P+GJtblqhiHXkG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQeJzsACgkQJNaLcl1U
h9ClpQf/dvhWZWGdIcnyO84ZaGkFrP74RXQQjwP6QNGLiEaACgahJpnNN8RolgDZ
99YfARCWQUsyS2XlSaIrOi5D2wFFrtsoSlMJqhI4BsslcUxvVdqDfwkmt8+q643f
Vwi0j6mozIgd7B2JpVKcuM4EiCn6dqoEQh+1xOdAW0JDgFtd5IeV3TnkSyLR7D6S
nn9vJAwXXUfei35vBCwa9NrmpGiEm3ziVoyx1+lsB6LGYUtDCwtW5EDu6pAlPlap
izD4yBztdfbO59KCid3PjFmeIYi6mUlSkzfxmDH6878auwEWkNKcdLxlhiCjmUNf
kZnIgHmJUAKJx3sAJbXUYLbinfK4yA==
=6cGt
-----END PGP SIGNATURE-----

--c2P+GJtblqhiHXkG--
