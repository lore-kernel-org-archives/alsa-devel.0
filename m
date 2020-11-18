Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD1FC5519F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 15:39:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB2B20897
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 15:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="phyYlJzI";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fVm7YQ8j";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqhBKuNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB2B20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A996416A8;
	Wed, 18 Nov 2020 16:38:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A996416A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605713963;
	bh=47cw+Dx69ulWO/0BHF/ppFpJTJCmwVY75KKpUmzGRbc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=phyYlJzIoe7MFPkTOEttWIXyzGZYrArAaFSXyY507EUfbbo9ygdfK6RPrpSiGARRS
	 4YmIqjHOWUg9KMEMLqZ7aki4TBRLbdqmpj6pRogCu5zM11CeTtyxyd5oCnaVfu97BR
	 i8Ex8EwSgTDFQU4HMTt6TvZq9thiLkDMJz7+b1Oc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 237D5F80168;
	Wed, 18 Nov 2020 16:38:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF6D7F8016C; Wed, 18 Nov 2020 16:38:29 +0100 (CET)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 575C4F80158
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 16:38:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 575C4F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="fVm7YQ8j"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="TqhBKuNe"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 79F895803C7;
 Wed, 18 Nov 2020 10:38:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 18 Nov 2020 10:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=jiFRinBhroU8gF2dg+tsxbq0jYn
 80Lj5IEmgVTmjZxQ=; b=fVm7YQ8jpspmpzPYfV/ipmzCzVB77F1xuT0tVIAL222
 sWkdad23hFwGGBOjR/DsrS4ToGE2s6dgJ4mCifZkVTC+5CxV2nRvi3Fy3PLLtiKc
 A6BxyThaixitas2h07F7QU+PWkjLLqcDXTEzXp33QLXrujnaoK2k/vPHbTWSHDkR
 sm8xpp+xDNwndRn++5soUOffme25aXRqGuwsRdaXP9112HRwyCskbf9e2o3W5XIB
 ywCxcovtVSmE6HUMVPnDeajtGBOcqNxLKUzo9/0/X9qclG8XzVft8qm6yN7MThig
 D98YndIEmJ0b3HK2Pc88jzsa2nmKaPD6zJD2Q0pTWew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jiFRin
 BhroU8gF2dg+tsxbq0jYn80Lj5IEmgVTmjZxQ=; b=TqhBKuNe1VVa182VvJuctB
 bvbOXPFd7bqpiYPdAtuNw3jtU5FKFaoD60wB40xJo6S5fFZt2k/ic02lBo8fc9CS
 rvWQVy6Po/LEFGS+QSffxfPj3rwgpUuzIbLhV4BclAa3UeyD7vJSFzeUauspxjyy
 zTd6YI1pnhcAlh0qsZJj+PA5RZjp6pI8I7chd3NWThENGapjWaX7Mx/QUlRtnQHY
 zdUVn/OnZ04ujZEFw5Qm954gLqAVY/WygagJvLSUwWMkJKzRpiNMYnw/uRQx7imo
 vk1ROKIusbKWoL8ShMFu2qpY6626xdR2OxHL+pkZoRsw2OiOhy7PxXsZKr5grdwQ
 ==
X-ME-Sender: <xms:6T-1X9wfz0ATFsiT69Z86jjV6twTOMa3DcFpNoBow8x0hXyc3YPuMA>
 <xme:6T-1X9RUlh3vWl__HvRcMzmVfs03k9tG1g8fwIEW8W37xy5xxPA07vBGZ83IBMVtA
 SNkw2RKRk35wErywpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefhedgkeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6j-1X3XuCKwZiplHgLV9KVLk3v4At6_cjC9ZZwejMMk2h0wNQ15DYg>
 <xmx:6j-1X_gRytTwq1vTnZ4xR6psO0Y6ZSBaE4VDkL5qTZccxiFUEhmwhA>
 <xmx:6j-1X_A6EgP3uS8TSoTAGp1CVbWqc-GJD4yqk4ZWfb8myXXCcII_TA>
 <xmx:6z-1Xz1e1ORmOoR_uSY6pUITh3ppBXu74DUfCP1-6yWOVjjzRihc8A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id B1AF93064AAF;
 Wed, 18 Nov 2020 10:38:17 -0500 (EST)
Date: Wed, 18 Nov 2020 16:38:16 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] ARM: sunxi: do not select COMMON_CLK to fix builds
Message-ID: <20201118153816.fctrz6dfjiph2mgl@gilmour.lan>
References: <20201117182310.73609-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x6ukipbmjbi6ayno"
Content-Disposition: inline
In-Reply-To: <20201117182310.73609-1-krzk@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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


--x6ukipbmjbi6ayno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 07:23:10PM +0100, Krzysztof Kozlowski wrote:
> COMMON_CLK is a user-selectable option with its own dependencies.  The
> most important dependency is !HAVE_LEGACY_CLK.  User-selectable drivers
> should not select COMMON_CLK because they will create a dependency cycle
> and build failures.  For example on MIPS a configuration with COMMON_CLK
> (selected by SND_SUN8I_CODEC) and HAVE_LEGACY_CLK (selected by
> SOC_RT305X) is possible:
>=20
>   WARNING: unmet direct dependencies detected for COMMON_CLK
>     Depends on [n]: !HAVE_LEGACY_CLK [=3Dy]
>     Selected by [y]:
>     - SND_SUN8I_CODEC [=3Dy] && SOUND [=3Dy] && !UML && SND [=3Dy] && SND=
_SOC [=3Dy] &&
>       (ARCH_SUNXI || COMPILE_TEST [=3Dy]) && OF [=3Dy] && (MACH_SUN8I || =
ARM64 && ARCH_SUNXI || COMPILE_TEST [=3Dy])
>=20
>     /usr/bin/mips-linux-gnu-ld: drivers/clk/clk.o: in function `clk_set_r=
ate':
>     (.text+0xaeb4): multiple definition of `clk_set_rate'; arch/mips/rali=
nk/clk.o:(.text+0x88): first defined here
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

however, I'm not sure the prefix is the one Mark would expect?

Maxime

--x6ukipbmjbi6ayno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7U/6AAKCRDj7w1vZxhR
xUOAAP48nXr96GGEF754GEu/aKJQDqP5hJ6/mTDONuk2RUglHgD/Zdrpl1dzj8xT
QlREWW9yHK4WzcLL4dqiaF1XVhXliQI=
=47Fl
-----END PGP SIGNATURE-----

--x6ukipbmjbi6ayno--
