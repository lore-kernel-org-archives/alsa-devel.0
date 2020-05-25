Return-Path: <SRS0=YV0t=7H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E076C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 10:51:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF692073B
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 10:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="te90SIU3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6qFkw6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF692073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3827E1725;
	Mon, 25 May 2020 12:50:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3827E1725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590403860;
	bh=4bUtzG6JSuFylBCc1mR9L66Kpa12xIvpkSRiQD2Gbaw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=te90SIU3Ms37t4Lro8O39ec5Koy0Tmn5NdtAu7H7ANyiMFLWo0zIoqmQoYx/ler32
	 m3B8k17JuU3eZIidOMZYE6M0vqXR9j06wdTzO3JMLNAzhV/hcZmpBuQDdBsd/M4Knd
	 jK1xeqMdkQ+c2MmynaS68lAiAn6VO+0vg4pqLtgY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A40A6F8014E;
	Mon, 25 May 2020 12:50:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB6D3F8016F; Mon, 25 May 2020 12:50:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93201F80100
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2020 12:50:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93201F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="R6qFkw6Y"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E7CF020787;
 Mon, 25 May 2020 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590403797;
 bh=4bUtzG6JSuFylBCc1mR9L66Kpa12xIvpkSRiQD2Gbaw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R6qFkw6Yo7L6FMhdwoq65QI6lgOnQWeNhiujbHKP2aZL9HtgGwIoXSD/eSpEQNXpl
 9p/5Cz0Ipomn/+hJ2qXQ/uM/kP4LZZKLWmy4FVVHsd5DJUjzn3FhglYwP/hokgqhu+
 m34K/9VE3VVUCyufBbl1hG9Rjx9TpivJvn++ySE4=
Date: Mon, 25 May 2020 11:49:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Subject: Re: [PATCH] add I2C device and compatible ID
Message-ID: <20200525104954.GA4544@sirena.org.uk>
References: <20200525101335.29130-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20200525101335.29130-1-wtli@nuvoton.com>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, KCHSU0@nuvoton.comgit,
 CTLIN0@nuvoton.com, lgirdwood@gmail.com
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


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 06:13:34PM +0800, Seven Lee wrote:
> The nau8810 driver can also compatible with nau8812 and nau8814.
>=20
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nau8812.txt        | 16 ++++++++++++++++
>  .../devicetree/bindings/sound/nau8814.txt        | 16 ++++++++++++++++
>  sound/soc/codecs/nau8810.c                       |  4 ++++

If they're compatible you should add the additional IDs to the same
binding document rather than adding additional binding documents.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7LotEACgkQJNaLcl1U
h9AIDAf7BqVIffmDek5QQEMmuba7iJ83S6RHPA+YyoGu+RMTnAkSCCzH5b/iVwQv
qRVRQwTONktINAbOqF9ZV2ZHOzmWonW27ggpjiCjPfeP3cmwB289SRcJgetQOdEF
wOY/4ThfFRJ9YLDKjUxjXOI32IaUqIN1Eewu+h3+kBATtJwOAORaHouc9PMKKndE
scyFZyAVfxoB8mk0g5VJeiNANIGcBL3h9lPirOwgy6wg6PPtSd1ZlT8nYK1Epgm3
wMcpH+qp5r2ZdiDpV7zSjG+cehZbmuNcb5+rux1w3WO/hufvvHSk1HgTy0CkKhOA
dhUY6VF4X1+EC7oowyGGecow+1Ztnw==
=GGE7
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
