Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFB0C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Mar 2022 13:43:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFF201713;
	Fri, 11 Mar 2022 14:42:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFF201713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647006193;
	bh=wI6UuXlLPmF+qv4XpIJMKmpFK9hfMx3Ab58Dr4Epttg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RTk/r6EgJtwuTN7oC1/4cscjGfcCEBbiH2j2eqBR7L9sbwBVdPi+OZMCHbWFZnyvw
	 R/AXZjHIh5zCBRwu4WNq7vXaruwBBZCY/egU8ylkcDiLWJ/XulZgAY5p0PnXRCSnnJ
	 WJw9bU83uC0s8VgXQSSrEj8LYhT89NHTDgiz2x18=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 787D0F801D8;
	Fri, 11 Mar 2022 14:42:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47DB4F80227; Fri, 11 Mar 2022 14:42:21 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAA43F8012C
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2022 14:42:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAA43F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S4HVB2ll"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1EBF8B82B6E;
 Fri, 11 Mar 2022 13:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FFEC340ED;
 Fri, 11 Mar 2022 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647006136;
 bh=wI6UuXlLPmF+qv4XpIJMKmpFK9hfMx3Ab58Dr4Epttg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S4HVB2ll2W5NBFeOEgZwnkeKASyGnhD13eZyBm68QNV3CbXV8VDbrFbHUc+9a6RXH
 Yqx3S8jap69MDRuHAAsvAvhrLwvWV6tn4OvgPyjhA7l+BIOAj+UaHbBRJ8MvDGILGM
 dMAEM7pjO5CJJkZZmFOm3PRSupbArAbI28rSFBe4A+3PYKKlrb+9nzJpoyL95OhrmU
 zPEqioWhJSiJOxLcseBuiB63MSEtG+6jFfehF4F4vhvDho/wvcbrGjHWYTD9DkTfn9
 qtuL499OHGeV7xkq/Z4uE7n8SWNIAUIChlINwbAfX99E2FjOZGXWgo0fSxtZYdZFal
 y44him4yy6XFQ==
Date: Fri, 11 Mar 2022 13:42:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Zhen Ni <nizhen@uniontech.com>
Subject: Re: [PATCH] ASoC: Intel: boards: Use temporary variable for struct
 device
Message-ID: <YitRs1YveURmYtJ/@sirena.org.uk>
References: <20220310065354.14493-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PVsnp86vmEPqoFG0"
Content-Disposition: inline
In-Reply-To: <20220310065354.14493-1-nizhen@uniontech.com>
X-Cookie: We just joined the civil hair patrol!
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com
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


--PVsnp86vmEPqoFG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 02:53:54PM +0800, Zhen Ni wrote:
> Use temporary variable for struct device to make code neater.

This doesn't apply against current code, please check and resend.

--PVsnp86vmEPqoFG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrUbIACgkQJNaLcl1U
h9CBRwf9Hq8LMCKweiAiVucGSDGqVOMiINe743Xoxg0p+QIgN85lxu2KcjAE2NRQ
hi6R66z+i4M92QZQRxoCBBKv8WsR0jMvDN/msmxdQkY1tFkqtFhiJvuwSbZJrip6
fIN4z57K5VhfhP48ze6f0AzO/caY/CWCsBgcrIDS+UFM5DkFgksWjt129FRyrEuv
cu+YwqtDsLU0eRvV/MsqXAB7209ViZV7U1yg+jvpGFtsnStHqZuYgssaw1ZH5KKN
OQD8Hh7pxRUZn2GyIpCqzRDW78hNwVPTOlJc7m9niLf0GNY+zryvKy21qi+CZDuI
EmdVaP6rjlVTiQ+0bQY0q7vtsfOjgw==
=HNGE
-----END PGP SIGNATURE-----

--PVsnp86vmEPqoFG0--
