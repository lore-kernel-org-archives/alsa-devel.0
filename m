Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB00C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Nov 2022 15:53:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C34AA1754;
	Fri, 25 Nov 2022 16:52:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C34AA1754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669391602;
	bh=qKjwfPIIzqvAxF7caQqW0PA421ro14XuNFsrH5tdtyI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XqylYvIuTti6qsjVfTlhliAO+6nAA9XPtBt9ywvU3XnDD/xA8hugJOljw57vLk2Wq
	 /GhVcoWoNsTJKXj+Tfsfbt2NWjuc4mN2oC9lKiPqsXh2qDba60roMMg+ECuY0Ly6SY
	 7hyAXRhLptTjrlro7Y45zC7efDySF+DFUAaajObE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81ABAF804C2;
	Fri, 25 Nov 2022 16:52:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8488F804DA; Fri, 25 Nov 2022 16:52:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3ADEF8014E
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2022 16:52:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3ADEF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NoX/wXZi"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4209262516;
 Fri, 25 Nov 2022 15:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71276C433C1;
 Fri, 25 Nov 2022 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669391545;
 bh=qKjwfPIIzqvAxF7caQqW0PA421ro14XuNFsrH5tdtyI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NoX/wXZiLxUwWLZEjkxHsUs2bj3GOTG3lzxA5LE9yrPeJZuCeifADWzz3b56b4GLu
 FnbqR4uo8ykjI8sJdIQT9C9jvl/N31r0KkpK9O/H1gOk90nyzsun8qyxwl7cSXHnlF
 Rj7Gm9ZgUqHGpU1wVRjiZGleXjfKVCwl3cw0T6qTZhfjF2Co1lthMM0hNTmVPVb08l
 EZ3v7Vzl8z2/biSpLRyo1nxLYarMO4/3NtJMXjvLUGTBvI0cp/6Ad/OW3TFiGdAPyj
 53GHhb4si+S6i/TkbximGdEroDWnWbVWfVQz02sEjdmW/zE085sqS4VPuwE4GrRuln
 PW5JUDYqsT//g==
Date: Fri, 25 Nov 2022 15:52:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] SX control bounds check fixups
Message-ID: <Y4DktdRZDl2sEnLk@sirena.org.uk>
References: <20221125154837.1270501-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UxxKBJ6gJg2rjmSe"
Content-Disposition: inline
In-Reply-To: <20221125154837.1270501-1-ckeepax@opensource.cirrus.com>
X-Cookie: Time and tide wait for no man.
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 guille.rodriguez@gmail.com, lgirdwood@gmail.com
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


--UxxKBJ6gJg2rjmSe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2022 at 03:48:35PM +0000, Charles Keepax wrote:
> These two SX control fixups seem to have got lost somewhere along the
> line. They were merged back in 5.18 but never seems to actually make it
> into the kernel:
>=20
> https://lore.kernel.org/all/165236477046.1016627.15470197691244479154.b4-=
ty@kernel.org/
>=20
> Apologies if resending isn't the correct course but it seemed the safest
> way to go. Note I have made a slight fixup to the second patch.

These should already be queued as fixes.

--UxxKBJ6gJg2rjmSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOA5LQACgkQJNaLcl1U
h9Bxbwf+IZT4HJvNR1xSqT19IkGr0CTWoaaCq96DrwVz7pDIk/AVIPV4i7oZKI3Q
ENM5yTjZvD0NbBIubiREYw5HP+niWzekUAkFgWxh6hkmXDGLktL456W1qO4e3JFQ
98gEMuzhY4N0ETa8cn+XwgqJL8Dyk838BTg9jbvt+7ZYUTxNwH85XI+AGPM7ZmbO
BSJLbPq0kCkzf2PBLCaz3L2rFph/I2nTepVDGFXo/QgxyKUrRQ8FAq0wnJEcXeRk
z+XwEIeyl+kZbmKhQnXkajB+sgnqHWKZRTxSzw2J8yu1J9zjjXRurCUtGTxsIcP4
M0QVgkShEJENr9uzyfvPmnWQdF8v1w==
=zkyI
-----END PGP SIGNATURE-----

--UxxKBJ6gJg2rjmSe--
