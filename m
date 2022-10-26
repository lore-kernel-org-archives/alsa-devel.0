Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4959DC38A2D
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Oct 2022 12:50:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 649873B61;
	Wed, 26 Oct 2022 14:50:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 649873B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666788653;
	bh=wwcloTob6ie8tz5qopW+PLurg6OWyL6eKN6MA1+Xs6s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mF3Rp349e+oEBsimzF892zIn1V89gEP7D8uPpyAJi4Iaj4D1QAXKJPDlsQ3nzZhh0
	 nj3VgZ9H2AFozsq0jRelqjRsai8S4bCOX59wLIstBkNcPepLTqX54Yub861cXXV7jE
	 Bt6Bd2/j77OscH0WrtsOSd2vnCA89ThwHEUbsE2Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1CB5F80240;
	Wed, 26 Oct 2022 14:50:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EBE6F80271; Wed, 26 Oct 2022 14:50:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34772F800BB
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2022 14:49:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34772F800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ju/p43pK"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BB6DF61E67;
 Wed, 26 Oct 2022 12:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0473C433D6;
 Wed, 26 Oct 2022 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666788592;
 bh=wwcloTob6ie8tz5qopW+PLurg6OWyL6eKN6MA1+Xs6s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ju/p43pK7hPQJaIF7nJ1R2GsqT3DIHUa5vG3D7i5tSDDRrrG4bqAWT3Za50If1kxJ
 cvsNrSzuTmwd4sTOb6bpH74w70yTkQ3MhzXa2NdXd40HJz3Lt03FVkXPU0VKnZ8Ken
 Tp6TRHIIkb2rwnrnUqxKW+ln4wSzfPVGIM1f0M5w9UeRZx2RXXbWRWmglFLxSeJFb1
 OxGFryVcLpeG//Q7d7FHWbJXtIzkY9qQsPUAySTq0hATpDfL0LLCNLktUefh/JAxJX
 tsM3pr/sB+9sU2MxPYZgjTgpWHtdfAfBLS3rWOhViRfueOGD+ZWorJ4BxeQlMNINWE
 OReMoTgPh7qHg==
Date: Wed, 26 Oct 2022 13:49:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
Message-ID: <Y1ks6n7wCfhArza/@sirena.org.uk>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
 <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6ws0GFWnXGiIRAF8"
Content-Disposition: inline
In-Reply-To: <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
X-Cookie: Prunes give you a run for your money.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Derek Fang <derek.fang@realtek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


--6ws0GFWnXGiIRAF8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 01:12:49PM -0700, Chen-Yu Tsai wrote:
> On Mon, Oct 24, 2022 at 3:01 PM N=EDcolas F. R. A. Prado

> > The rt5682s codec can have two supplies: AVDD and MICVDD. They are

> Neither does the datasheet specify the ordering of AVDD, DBVDD, and
> LDO1_IN for power sequencing, just that three should be toggled together.

> Should we model these? Or wait until some design actually splits these?

Yes, the driver for a chip should be a driver for the chip not for some
specific board.

--6ws0GFWnXGiIRAF8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNZLOkACgkQJNaLcl1U
h9B/zgf9EephDS7CV9faIUtycitCDpOJIbYZYIhjrW6esmg6J2Kt5y00+V7/DQta
zIHGZ9GXpX1DDlleJSrm3AgC03rKRub8VV75SwGvRGwuiSA5oaslFPiRPcYbBSEX
B1TrN9NfwUYvJnaFVlXPoCxoVhrB0t2Mp4bltVVqfKFzkEoBRD+PeuCpIIM7OzSL
d4kdyDLF/5L9hW5WQVCMH33zkmf02p1z8SWT/4KHFzqtuHc4f8Md9qzCLlbl0AY7
WMv+pah7enDvFw/Uvr9adIYrWIwLEfMP4DiTZO4a8JjT03wAwgdC+A2aTeMyle9P
fPnVMh6XtsDxs0KKcKD2p5ihwKlF4w==
=Rizo
-----END PGP SIGNATURE-----

--6ws0GFWnXGiIRAF8--
