Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C42C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:40:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BA32222D
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q0S5PgIQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="APBHbryy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BA32222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1118616B0;
	Thu, 17 Sep 2020 17:39:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1118616B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600357226;
	bh=foIc7Z858N2p4XZA330YvH1DcfvYDxEcLkBk7zkfsCI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q0S5PgIQEbkYdKTVWJ2zkX4aWj5uBYWCtT0zAFTDXltqdP2DX/8pkHNSD/QitlzwZ
	 omfLi5sgGDmwGecUae9DFDvs/OIjXPNAMfVXtf2fmFeNjI0K1BIc3HIAj+uQJcbrmB
	 PYfzCL00rBI4tSQRfFhO+HnxHLyFtjbQYU0xXFS0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C2F5F801EC;
	Thu, 17 Sep 2020 17:39:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 694A8F80212; Thu, 17 Sep 2020 17:39:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4BF54F800E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 17:39:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BF54F800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="APBHbryy"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE91022208;
 Thu, 17 Sep 2020 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600357161;
 bh=foIc7Z858N2p4XZA330YvH1DcfvYDxEcLkBk7zkfsCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=APBHbryybIPEnTDquUs9mdmt/sgejwNywahLxDGrCmjMdcrkA39jjU82n5w1c+Vyq
 xlJ63C8Ct/yMGxOgqqrLjhY7KinvOqat6u7G0hBgQi91bTa+uI4XgyQfzw892sSjjw
 ZZk4z7NyHBMB+SBw6zxJ4ZwbMgsQ00viF9tRu8tE=
Date: Thu, 17 Sep 2020 16:38:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Camel Guo <camel.guo@axis.com>
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add support for configuring
 GPIO pin
Message-ID: <20200917153831.GA18737@sirena.org.uk>
References: <20200916075949.28479-1-camel.guo@axis.com>
 <20200916075949.28479-2-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20200916075949.28479-2-camel.guo@axis.com>
X-Cookie: Is death legally binding?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Camel Guo <camelg@axis.com>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 tiwai@suse.com, robh+dt@kernel.org, kernel@axis.com, dmurphy@ti.com
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


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 09:59:49AM +0200, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>=20
> Add support to configure the GPIO pin to the specific configuration.
> The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
> GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
> drive can be configured with various configuration.

This doesn't apply against current code, please check and resend.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jgvYACgkQJNaLcl1U
h9AyLwf9EH7X0DHtsQ7448LbugWVzhYsAZhE7+gdgpJHOOyKf2f6t7uhAgl6ed6u
o+rFZVGSrUzOZu2cmttfGl57bhRLmqQkClvQERhBghtlRPWOUezGXBUwUSGqat+W
UrTjwI2iewYY0dsJ45lFCYzYkcy0JaIfGLUSDSF5gWBXmN+76jFYGg2n3J4rCdUD
COUOOoyek00/nwyKAa/4K+HxAu94OgdvMWJ4dStWFfr7Fqkb2GD8nlDSW2jDo/W7
ixvN7qlrPNptfcpcQ39EczEAWEyAGKLs3usR3xoyGCea3hP8wrqxy8C2OwwAEYJt
WjgKpgEky87IzA6wUfyJsQF9ev+OOA==
=eqoB
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
