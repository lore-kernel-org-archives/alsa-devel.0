Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9249EE7FF4
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Sep 2023 12:32:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EB6284C;
	Mon, 11 Sep 2023 14:32:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EB6284C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694435571;
	bh=QRpBAeUI3hitgnSMQW2yEao4wcbtSpYQNtObb57edb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vGyWekc1AFiSNERAL7q8qsPJ7Nf+ta43IQxtzozNP1qx2ErWS/V6UJmGPV08mZhDk
	 zZyGDEOffzWtPAHP3FBjMXVxRizpGKS79QZyohXqDuSAdOF1N4K0zBKoetUgCwyI/F
	 qN1uSXcwK8NwEkAqfU7DSzG6cHv/ud3DfU3Aa3KE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAA8DF80537; Mon, 11 Sep 2023 14:32:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76C1BF80425;
	Mon, 11 Sep 2023 14:32:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 206F9F80425; Mon, 11 Sep 2023 14:31:56 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 73EBFF8007C
	for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2023 14:31:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73EBFF8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NDMtglzW
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E01D6B811ED;
	Mon, 11 Sep 2023 12:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B54C433C7;
	Mon, 11 Sep 2023 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694435506;
	bh=QRpBAeUI3hitgnSMQW2yEao4wcbtSpYQNtObb57edb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDMtglzWsJ2DbsIiZrdGnYwd6+mP2wjZ02Dtk3Hglx+MAmOwc/gEQW3/UPuVhfi99
	 bpg9lHNV+D2jbHm4URzIqXXvOxKTeswLHS2AftA+xA555vRElqfWQubv6JOfUVC7N5
	 jnW2A9liKkfXz3c5IU2KtQtz4lceDvVosjoAxck/C9ruvwr/huyRC7oDHtB4t1YBOH
	 BLVoBo/7HckY7lmbYhUDo3L+Ytp8suRxpJrWZzDL7HNsZ5R/bEPRNnMDiXIhsTpmgi
	 r2rqwQvl4bcnkTDc+Wubloqer55o5Wxw0m28TDeg3QRnjkZe8Bc6h0TB0hsMpyRPXW
	 AeZ8v+243VBzA==
Date: Mon, 11 Sep 2023 13:31:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Myunguk Kim <mwkim@gaonchips.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Maxim Kochetkov <fido_max@inbox.ru>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Uw e =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Message-ID: <ZP8Irf6g+sG6Ax9j@finisterre.sirena.org.uk>
References: <20230911024023.43833-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DtMfBSD3gbWfkN9d"
Content-Disposition: inline
In-Reply-To: <20230911024023.43833-1-mwkim@gaonchips.com>
X-Cookie: Save energy:  Drive a smaller shell.
Message-ID-Hash: 7GVOEVXUXOSPORY6TZHS2APAPW4YOCUP
X-Message-ID-Hash: 7GVOEVXUXOSPORY6TZHS2APAPW4YOCUP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7GVOEVXUXOSPORY6TZHS2APAPW4YOCUP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--DtMfBSD3gbWfkN9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 11:40:23AM +0900, Myunguk Kim wrote:
> There is a SoC between dwc and DMA block (ie. PL330)
> that does not have a burst signal and supports only single.
>=20
> So write not-support-burst property on dts, it support single DMA mode.

This feels like something we ought to be discovering from the DMA API
somehow, while it's not quite a property of the DMA controller (but
rather of the SoC integration) in this case it could be a property of
some DMA controller elsewhere and the whole process of finding and
figuring out the properties of the DMA controler is handled by the DMA
API.

--DtMfBSD3gbWfkN9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT/CKcACgkQJNaLcl1U
h9Dq6wf8D1e8icWFQphCSuOBQy9bjVPvV7mJb6wbO9yIefWMNrYj/sberQ5lGM5h
1/R+G76ou+eLpYY6O1qXHwb4LK6DO9Tp9MV7zxM+RJ3LhD2qzRyswhHFbAXlPXJb
KfJuHSq7npMz7EMEAi/Exoq0wJpMvsCeL8ekSWDBdOcoceB5FYAbeKtIRIrWvg0h
/rJlufpWyGYRrDY14C+bZSNivHhFaL3FfvKmBeRYw68kjZyjSH6cmo9dbWAzhVW4
yePTL5XZ7plwQMtpmwAg0GjF3HywcFSFXecr5AqbabTuQxL3hctZSquKn8h5XMrB
D8DoHnP6I+L0B1yA9XsEcRTXudElNA==
=dtYL
-----END PGP SIGNATURE-----

--DtMfBSD3gbWfkN9d--
